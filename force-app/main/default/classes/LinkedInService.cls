public with sharing class LinkedInService {
    public class LinkedInAuthException extends Exception{}

    //wrapper classes 
    public class LinkedInProfile{
        public String LinkedInId;
        public String firstName;
        public String lastName;
        public String headLine;
        public String profilePictureUrl;
    }
    public class EnrichResult {
        public LinkedInprofile profile;
        public String email;
        public Id contactId;
        public Boolean isSuccess;
    }

    //parser 
    private static LinkedInProfile parsedProfile(String jsonStr){
        Map<String,Object> body=(Map<String,Object>)JSON.deserializeUntyped(jsonStr);
        LinkedInProfile profile=new LinkedInProfile();
        profile.LinkedInId=String.valueof(body.get('id'));
        profile.firstName=String.valueof(body.get('localizedFirstName'));
        profile.lastName=String.valueof(body.get('localizedLastName'));
        profile.headLine=String.valueof(body.get('localizedHeadline'));
        try {
            Map<String,Object> pic =
                (Map<String,Object>) body.get('profilePicture');
            Map<String,Object> disp =
                (Map<String,Object>) pic.get('displayImage~');
            List<Object> els =
                (List<Object>) disp.get('elements');
            Map<String,Object> el =
                (Map<String,Object>) els[els.size()-1];
            List<Object> ids =
                (List<Object>) el.get('identifiers');
            Map<String,Object> id0 =
                (Map<String,Object>) ids[0];
            profile.profilePictureUrl = (String) id0.get('identifier');
        } catch (Exception e) {
            profile.profilePictureUrl = null;
        }
        return profile;
    }

    

   //get /v2/me
   public static LinkedInProfile getProfile(){
     HttpRequest req = new HttpRequest();
     req.setEndpoint('callout:LinkedIn_API/v2/me'
                    +'?projection=(id,localizedFirstName,localizedLastName,localizedHeadline,'
                    +'profilePicture(displayImage~:playableStreams))'
     );
        req.setMethod('GET');
        req.setHeader('Accept','application/json');
        req.setHeader('LinkedIn-Version','202401');
        req.setTimeout(100000);
        HttpResponse res=new Http().send(req);
        Integer statusCode=res.getStatusCode();
        if(statusCode==200){
            return parsedProfile(res.getBody());
        }
        else if(statusCode==401){
            throw new LinkedInAuthException('LinkedIn Token expired or revoked .Please ReConnect your Account');
        }else if(statusCode==403){
            throw new CalloutException('Insufficient LinkedIn scopes'+
                                        'Ensure r_liteprofile is approved !');
        }
        else {
            throw new CalloutException('LinkedIn API error : '+statusCode+'  '+res.getBody());
        }

   }
/**
 * {
  "elements": [
    {
      "handle": "urn:li:emailAddress:123456",
      "handle~": {
        "emailAddress": "user@example.com"
      }
    }
  ]
}
 */
   //GET :   /v2/emailAddress
   public static String getEmail(){
    HttpRequest req=new HttpRequest();
    req.setEndpoint('callout:LinkedIn_API/v2/emailAddress'
                    +'?q=members&projection=(elements*(handle~))'
    );
    req.setMethod('GET');
    req.setHeader('Accept','application/json');
    req.setHeader('LinkedIn-Version','202401');
    HttpResponse res=new Http().send(req);
    Integer statusCode=res.getStatusCode();
    if(statusCode==200){
        Map<String,Object> body=(Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        List<Object> elements=(List<Object>)body.get('elements');
        if(elements != null && !elements.isEmpty()){
            Map<String,Object> el=(Map<String,Object>)elements[0];
            Map<String,Object> handle=(Map<String,Object>)el.get('handle~');
            if(handle!=null){
                return String.valueof(handle.get('emailAddress'));
            }
        }
    }
    return null;
   }

   //Enrich a Contact With fetcehed linked in data 
   //fetched profile info and email infor from linked in and updates conmytact fields 
   public static EnrichResult enrichContact(Id contactId){
         LinkedInProfile profile=getProfile();
         String emailAddress=getEmail();

         Contact con=[SELECT Id,FirstName,LastName,Email,Title,
                        LinkedIn_Headline__c,LinkedIn_Synced__c,LinkedIn_Profile_URL__c 
                        FROM Contact LIMIT 1];
        con.FirstName=profile.firstName;
        con.LastName=profile.lastName;
        con.Title=profile.headLine;
        con.LinkedIn_Headline__c=profile.headLine;
        con.LinkedIn_Synced__c=DateTime.now();
        if(String.isBlank(con.Email) && String.isNotBlank(emailAddress)){
            con.Email=emailAddress;
        }
        update con;

        EnrichResult res=new EnrichResult();
        res.profile=profile;
        res.email=emailAddress;
        res.contactId=con.Id;
        res.isSuccess=true;
        
        return res;

   }
}