public with sharing class PS_CurrencyAPIService {
    public static void getExchangeRate(){
        /* -Callouts  
            - Prepare the Request 
        */
        HttpRequest httpReq=new HttpRequest();
        // Step 1.1 - set the Endpoint 
        httpReq.setEndPoint('https://open.er-api.com/v6/latest/USD');
        // Step-1.2 set the headers 
        httpReq.setHeader('Content-Type','application/json');
        httpReq.setHeader('Accept','application/json');//JSON.XML.TEXT,HTML
        // Set the request method 
        httpReq.setMethod('GET');//GET POST PUT PATCH DELETE 
        // send the request 
        Http http=new Http();
        HttpResponse httpRes=http.send(httpReq);
        // Print the  information
        /*
                - getStatus()
                -getStatusCode
                -getBody()

                -getXMLStreamReader()- SOAP API 
                -getBodyAsBlob();
        */ 

        String responseBody = httpRes.getBody();// response from the request 
        Integer statusCode = httpRes.getStatusCode();//Status code in form of integer
        String status = httpRes.getStatus();//SUCCESS FAIL 

        System.System.debug('The Response From Currency API - '+ responseBody);
        System.System.debug('The Response From Currency API - '+ statusCode);
        System.System.debug('The Response From Currency API - '+ status);
        

    }
}