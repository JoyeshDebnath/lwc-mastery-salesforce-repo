public with sharing class OpenCageGeoCoderService {
    public static void reverseGeoCoding(String accountId){
        Account accRecord  = [SELECT Id,Location__Latitude__s,Location__Longitude__s 
                        FROM Account 
                        WHERE 
                        Id=:accountId
                        AND Location__Latitude__s!=null 
                        AND Location__Longitude__s!=null
                        LIMIT 1

                ];

        String queryParams = accRecord.Location__Latitude__s+','+accRecord.Location__Longitude__s;
        
        HttpRequest httpReq=new HttpRequest();
        httpReq.setEndpoint(System.Label.OPENCAGE_API_URL+'?key='+System.Label.OPENCAGE_API_KEY+'&q='+queryParams+'&pretty=1');
        httpReq.setHeader('Content-Type','application/json');
        httpReq.setHeader('Accept', 'application/json');
        httpReq.setMethod('GET');
        Http http=new Http();
        try{
            HttpResponse httpRes=http.send(httpReq);
                        String responseBody = httpRes.getBody();// response from the request 
                        Integer statusCode = httpRes.getStatusCode();//Status code in form of integer
                        String status = httpRes.getStatus();//SUCCESS FAIL 
                        
                        if(statusCode == 200){
                                //success logic 
                                OpenCageReverseResponseWrapper wrapper = (OpenCageReverseResponseWrapper)System.JSON.deserialize( responseBody , OpenCageReverseResponseWrapper.class);

                                if(wrapper?.results?.size()>0){
                                    OpenCageReverseResponseWrapper.results rslt = wrapper.results.get(0);
                                    accRecord.BillingStreet= rslt?.components?.road;
                                    accRecord.BillingCity=rslt?.components?.city;
                                    accRecord.BillingCountry=rslt?.components?.country;
                                    accRecord.BillingState=rslt?.components?.state;
                                    accRecord.BillingPostalCode=rslt?.components?.postcode;
                                    System.debug(rslt?.components?.state+'   '+accRecord.BillingCountry);
                                    update accRecord;


                                }

                        }else{

                        }
        }
        catch(System.CalloutException calloutEx){
            System.debug('Callout Exception..... '+calloutEx.getStackTraceString());
            if(String.valueOf(calloutEx).startsWith('System.CalloutException: Unauthorized endpoint')){
                //Remote Site Setting Error 
                System.debug('Callout eception ');
            }
        }
        
    }

}