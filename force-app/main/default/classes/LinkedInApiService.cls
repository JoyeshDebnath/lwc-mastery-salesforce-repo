public  class LinkedInApiService {
    
    public static HttpResponse send(String method,String body,String path){
        LinkedIn_Config__mdt config= LinkedINConfigService.get();
        HttpRequest req=new HttpRequest();
        req.setMethod(method);
        req.setEndpoint(config.API_Base_URL__c+path);//https:api/linkedin.com/v2   /userinfo
        req.setHeader('Authorization','Bearer '+LinkedInTokenManager.getToken());
        req.setHeader('Content-Type','application/json');
        if(body!=null){
            req.setBody(body);
           
        }
        return  new Http().send(req);
    }

    public static HttpResponse get(String path){
        return send('GET',null,path);
    }

    public static HttpResponse post(String path,String body){
        return send('POST',body,path);
    }

}