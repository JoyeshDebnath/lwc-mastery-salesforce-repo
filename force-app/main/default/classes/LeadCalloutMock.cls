@isTest
global  class LeadCalloutMock implements HttpCalloutMock{
    global HTTPResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse ();
        response.setHeader('Content-Type','application/json');
        response.setBody('{"status":"success"}');
        response.setStatusCode(200);
        return response;
    }
}