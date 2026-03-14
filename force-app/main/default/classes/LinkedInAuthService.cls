public  class LinkedInAuthService {
    public static String getAuthUrl(){
        LinkedIn_Config__mdt config=LinkedINConfigService.get();//returns the metadata configuration 
        String authURI=config.Auth_URL__c+'?response_type=code&client_id='+config.Client_Id__c+'&redirect_uri='+config.Redirect_URI__c+'&state=foobar&scope='+config.Scopes__c;

        return authURI;
    }
}