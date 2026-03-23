public class GoogleOAuthHandler {
    //reads credentials from Custom Metadata 
    private static 	Google_API_Setting__mdt getConfig(){
        return [SELECT Client_ID__c,Client_Secret__c,Refresh_Token__c,
                Token_Expiry__c,Access_Token__c,Redirect_URI__c 
                FROM Google_API_Setting__mdt 
                WHERE DeveloperName='Default' LIMIT 1];
    }
/**
 * https://accounts.google.com/o/oauth2/v2/auth
  ?client_id=1083060233026-5cotut5cts1lshinsaleeab9tfa92ra3.apps.googleusercontent.com
  &redirect_uri=https://oauth.pstmn.io/v1/callback
  &response_type=code
  &scope=https://www.googleapis.com/auth/calendar
  &access_type=offline
  &prompt=consent
 * 
 */
    //Build the URL that takes User to the Googles Login Page .. 
    public static String getAuthUrl(){
        Google_API_Setting__mdt config=getConfig();
        
        String authUrl = 'https://accounts.google.com/o/oauth2/v2/auth'
                         +'?client_id='+ EncodingUtil.urlEncode(config.Client_ID__c,'UTF-8')
                         +'&redirect_uri='+EncodingUtil.urlEncode(config.Redirect_URI__c,'UTF-8')
                         +'&response_type=code'
                         +'&scope='+ EncodingUtil.urlEncode('https://www.googleapis.com/auth/calender','UTF-8')
                         +'&access_type=offline'
                         +'&prompt=consent';
        if(String.isNotBlank(authUrl)){
                return authUrl;
        }else{
            return '';
        }
    }
    //get the access Token | Refresh Token Info using the Code 
    public static void exchangeCodeForTokens(String authCode){
        Google_API_Setting__mdt config=getConfig();
        HttpRequest req=new HttpRequest();
        req.setEndpoint('https://oauth2.googleapis.com/token');
        req.setMethod('POST');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setBody(
            'code='  + EncodingUtil.urlEncode(authCode,'UTF-8')
            +'&client_id=' + EncodingUtil.urlEncode(config.Client_ID__c,'UTF-8')
            +'&client_secret='+EncodingUtil.urlEncode(config.Client_Secret__c,'UTF-8')
            +'&redirect_uri='+EncodingUtil.urlEncode(config.Redirect_URI__c,'UTF-8')
            +'&grant_type=authorization_code'
        );
        HttpResponse response=new Http().send(req);
        if(response.getStatusCode()==200){
            Map<String,Object> tokenData=(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            //save the token information in custom metadata 👇
            saveTokenData(
                (String)tokenData.get('access_token'),
                (String)tokenData.get('refresh_token'),
                (Integer)tokenData.get('expires_in')
            );
        }else{
            throw new AuraHandledException('Token Exchange Failed !!'+response.getBody());
        }
    }

    //Save the Token Info in the Custom metadata .... 

    public static void saveTokenData(String accessToken,String refreshToken,Integer expiresIn){
        Metadata.CustomMetadata md = new Metadata.CustomMetadata();
        md.fullname='Google_API_Setting.Default';
        md.label='Default';

        Metadata.CustomMetadataValue v1 = new Metadata.CustomMetadataValue();
        v1.field='Access_Token__c';
        v1.value=accessToken;
        md.values.add(v1);

        Metadata.CustomMetadataValue v2 = new Metadata.CustomMetadataValue();
        v2.field='Refresh_Token__c';
        v2.value=refreshToken;
        md.values.add(v2);

        Metadata.CustomMetadataValue v3 = new Metadata.CustomMetadataValue();
        v3.field='Token_Expiry__c';
        v3.value=expiresIn;

        md.values.add(v3);

        Metadata.DeployContainer container = new Metadata.DeployContainer();
        container.addMetadata(md);
        Metadata.Operations.enqueueDeployment(container,null);

    }


    //refresh access Token when it expires .. (Every 30  min )
    public static String getValidAccessToken(){
        Google_API_Setting__mdt config=getConfig();
        if(config.Token_Expiry__c!=null && config.Token_Expiry__c > DateTime.now().addMinutes(5)){
            return config.Access_Token__c;//still Valid Token 
        }
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://oauth2.googleapis.com/token');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setBody(
            'refresh_token='+EncodingUtil.urlEncode(config.Refresh_Token__c,'UTF-8')
            +'&client_id='+EncodingUtil.urlEncode(config.Client_ID__c,'UTF-8')
            +'&client_secret='+EncodingUtil.urlEncode(config.Client_Secret__c,'UTF-8')
            +'&grant_type=refresh_token'
        );

        HttpResponse response=new Http().send(request);
        if(response.getStatusCode() == 200){
            Map<String,Object> tokenData=(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
             saveTokenData(
                (String)tokenData.get('access_token'),
                (String)tokenData.get('refresh_token'),
                (Integer)tokenData.get('expires_in')
            );
            return (String)tokenData.get('access_token');//new Token 
        }else{
            throw new AuraHandledException('Token Refresh Failed !!'+response.getBody());
        }

        }
    
}