public with sharing class Integration_CurrencyAPIService {
    public static void getExchangeRate(){
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://quotes15.p.rapidapi.com/quotes/random/?language_code=en');
        request.setMethod('GET');
        request.setHeader('Content-Type','application/json');//return type is json 
        request.setHeader('Accept','application/json');//  accept - > JSON format 
        HttpResponse response=http.send(request);
        Integer statusCode = response.getStatusCode();//200
        String status=response.getStatus();//SUCCESS
        String responseBody= response.getBody();//response 
        System.debug('The Response from API \n'+ status +'   '+statusCode+'   '+responseBody);

    }
}