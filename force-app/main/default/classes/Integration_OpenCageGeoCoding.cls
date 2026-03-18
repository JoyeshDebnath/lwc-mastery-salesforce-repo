public with sharing class Integration_OpenCageGeoCoding {
    public static void reverseGeoCoding(String latitude,String longitude){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        String queryparams=latitude+','+longitude;
        String endpointurl=System.Label.opencageAPI+'?key='+System.Label.opencageAPIKEY+'&q='+queryparams+'&pretty=1';
        req.setEndpoint(endpointurl);
        req.setMethod('GET');
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept','application/json');//JSON 
       
        try{
             HttpResponse response=http.send(req);
             String responseBody=response.getBody();
             Integer statusCode=response.getStatusCode();
             String status = response.getStatus();
            //  System.debug('The response from Open cage API '+responseBody);
            //  System.debug('The status code  '+statusCode);
            //  System.debug('The status '+status);
            if(statusCode==200){
               Integration_ForwardResponseWrapper wrapper=(Integration_ForwardResponseWrapper)JSON.deserialize(responseBody,Integration_ForwardResponseWrapper.class);//convert the type to specific type and store in the object 
               if(wrapper?.results?.size()>0){
                   Integration_ForwardResponseWrapper.results res=wrapper.results.get(0);
                   System.debug(res?.components?.city);
                   System.debug(res?.components?.country);
               }

            }


        }catch(System.Exception e){
            System.debug(e.getMessage());
        }
    } 
}