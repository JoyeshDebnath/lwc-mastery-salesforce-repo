public with sharing class FutureApex1 {
    @future(callout=true)
    public static void sendLeadData(String leadID,String email){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://example.com/api/leads');
        req.setHeader('Content-Type','application/json');
        req.setBody('{"id":"' + leadID + '", "email":"' + email + '"}');
        HttpResponse response=http.send(req);
        if(response.getStatusCode()==200){
            System.debug('Lead Data sent successfully ....');
        }else{
            System.debug('Something went wrong !!!!');
        }
    }
}