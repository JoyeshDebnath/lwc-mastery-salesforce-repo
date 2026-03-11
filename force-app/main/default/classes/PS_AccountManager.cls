/**
 * Class Should be annotated with (urlMapping='url EX v1/Contact/*')
 * the access modifier of the class should be Global as this will be accessed and used outside 
 * 
 */
/**
 * ORG Base URL - instanece url + services/apexrest/v1/Account
 * 
 * 👩‍💻Sample URL to access my rest servcice : >>  https://gepower-a-dev-ed.develop.my.salesforce.com/services/apexrest/v1/Account/
 */
@RestResource(urlMapping='/v1/Account/*')
global class PS_AccountManager {
    //>>List all Salesforce Accounts
     @httpGet
     global static List<Account> getAllAccounts(){
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        System.debug('Request ==>\n'+JSON.serializePretty(req));
        System.debug('Response ==>\n'+JSON.serializePretty(res));

        return [SELECT Id,Name,Industry,Rating,Phone,Fax FROM Account LIMIT 20];
     }
     //Create an Account record ... 
     @httpPost
     global static String createAnAccount(String name,String rating,String phone){
         RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        System.debug('Request ==>\n'+JSON.serializePretty(req));
        System.debug('Response ==>\n'+JSON.serializePretty(res));
        Account accRecord=new Account();
        accRecord.Name=name;
        accRecord.Rating=rating;
        accRecord.Phone=phone;
        
        insert accRecord;
        return accRecord.Id;

     }
//Full update 
     @httpPut
     global static Account updateAccount(String name,String phone){
         RestRequest req=RestContext.request;
         RestResponse res=RestContext.response;
         String accountId=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);//fetch id 
         Account accRecord=[SELECT Id,Name,Phone FROM Account WHERE Id=:accountId LIMIT 1];
         accRecord.Name=name;
         accRecord.Phone=phone;
         update accRecord;
         return accRecord;
     }
//partial update 
     @httpPatch
     global static Account updateAccountUsingPatch(){
         RestRequest req=RestContext.request;
         RestResponse res=RestContext.response;
         String accountId=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
         Account accRecord=[SELECT Id,Phone,Name FROM Account WHERE Id=:accountId LIMIT 1];
         if(req.requestBody!=null){
            Map<String,Object> body=(Map<String,Object>)JSON.deserializeUntyped(req.requestBody.toString());
            if(body.containsKey('Name')){
               accRecord.Name=(String)body.get('Name');
            }
            if(body.containsKey('Phone')){
               accRecord.Phone=(String)body.get('Phone');
            }


         }
         update accRecord;
         return accRecord;

     }
}