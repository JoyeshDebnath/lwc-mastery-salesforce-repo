public  class LinkedInController {
   
    


    //fetches the linked in profile infor to display in UI 
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> fetchProfile(){
        try{
            LinkedInService.LinkedInProfile profile = LinkedInService.getProfile();
            String email = LinkedInService.getEmail();
            Map<String,Object> result=new Map<String,Object>{
                'firstName'=>profile.firstName,
                'lastName'=>profile.lastName,
                'headline'=>profile.headLine,
                'email'=>email,
                'profilePictureUrl'=>profile.profilePictureUrl,
                'linkedInId'=>profile.linkedInId
            };
            return result;

        }catch(LinkedInService.LinkedInAuthException e ){
                throw new AuraHandledException(e.getMessage());
        }
        catch(Exception e){
            throw new AuraHandledException('Linked In Fetch Failed : '+e.getMessage());
        }
    }

    //Enriches the Contact Record : called from UI 
    //Save to Contact 
    @AuraEnabled 
    public static Map<String,Object> enrichContact(Id contactId){
        try{
            LinkedInService.EnrichResult r= LinkedInService.enrichContact(contactId);
             return new Map<String,Object>{
                'success'   => r.isSuccess,
                'firstName' => r.profile.firstName,
                'lastName'  => r.profile.lastName,
                'headline'  => r.profile.headline
            };
        
        }catch(LinkedInService.LinkedInAuthException e ){
            throw new AuraHandledException(e.getMessage());
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}