@RestResource(urlMapping='/linkedin/callback')
global with sharing class LinkedInCallback {
   @HttpGet
   global static void handleCallback(){
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        String authCode=req.params.get('code');//get the auth code 
        String token=LinkedInTokenService.exchange(authCode);//get access token 
        LinkedInTokenManager.storeToken(token);//stores the access Token 
        res.responseBody=Blob.valueOf('Linked IN Connected Successfully !!!');

    }
}