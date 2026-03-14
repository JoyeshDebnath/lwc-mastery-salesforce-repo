public  class LinkedInTokenService {
    public static String exchange(String code){
        LinkedIn_Config__mdt config=LinkedINConfigService.get();
        HttpRequest req=new HttpRequest();
        req.setEndpoint(config.Token_URL__c);
        req.setMethod('POST');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        String body =
            'grant_type=authorization_code'
            + '&code=' + code
            + '&redirect_uri=' + config.Redirect_URI__c
            + '&client_id=' + config.Client_Id__c
            + '&client_secret=' + config.Client_Secret__c;
        req.setBody(body);
        HttpResponse response=new Http().send(req) ;
           Map<String,Object> res=(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
           String accessToken=(String)res.get('access_token');
           return accessToken;

            
    }
}