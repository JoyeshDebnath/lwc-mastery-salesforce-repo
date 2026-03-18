public  class IntegrationDemo {
    
    public IntegrationDemo() {

    }//constructor
    public static void basicAuthDemo(){
        Http http=new Http();
        
        HttpRequest request = new HttpRequest();
        String endPointUri=' https://open.er-api.com/v6/latest/USD';
        request.setHeader('Content-Type','application/json');
        request.setHeader('Accept','application/json');
        request.setEndPoint(endPointUri);
        request.setMethod('GET');
        try{
            HttpResponse response=http.send(request);
            Integer statusCode=response.getStatusCode();
            System.debug('Status  CoDe=>\n'+statusCode);
            System.debug('Status =>\n'+response.getStatus());
            System.debug('Reponse Returned =>\n'+response.getBody());
        }catch(Exception.CalloutException ex){
            System.debug('Error=>\n'+ex.getMessage());
        }
        catch(Exception ex){
            System.debug(ex.getMessage());
        }
        
    }
    //forward geocoding using opencage Api 
    //Authentication using api key in url 
    //opencageURL
    //
    public static void forwardGeoCodingDemo(String accountId){
        //query 
            Account acc=[SELECT Id,Location__Latitude__s,Location__Longitude__s,BillingAddress from 
                                    Account WHERE Id=:accountId limit 1];
            String queryParams=acc.Location__Latitude__s+','+acc.Location__Longitude__s;
            

            String baseURI=System.Label.opencageURL+'json?q='+queryParams+'&key=713fa0a84feb4952b72783d6c303bc73&pretty=1';
            Http http=new Http();
            HttpRequest req=new HttpRequest();
            req.setEndPoint(baseURI);
            req.setMethod('GET');
            req.setHeader('Accept','application/json');
            req.setHeader('Content-Type','application/json');
           try{
                HttpResponse response=http.send(req);
                String statusMsg=response.getStatus();
                Integer statusCode=response.getStatusCode();
                if(statusCode==200){
                    GeoCodingResponseWrapper wrapper=new GeoCodingResponseWrapper();
                    wrapper=(GeoCodingResponseWrapper)System.JSON.deserialize(response.getBody(),GeoCodingResponseWrapper.class);
                    if(wrapper?.results?.size()>0){
                        GeoCodingResponseWrapper.results res=wrapper.results.get(0);
                        System.debug('City name='+res?.components?.city);
                        System.debug('Road = '+res?.components?.road);

                    }

                }else{

                }
           }catch(Exception e){
                 System.debug(e.getMessage());
           }

            

    }//

    public static void randomUserIntegration(){
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndPoint('https://randomuser.me/api/');
        request.setMethod('GET');
        request.setHeader('Content-Type','application/json');
        request.setHeader('Accept','application/json');
        HttpResponse response=http.send(request);
        String statusMsg=response.getStatus();
        Integer statusCode=response.getStatusCode();
        if(statusCode==200){
  			System.debug(response.getBody());
            RandomUserWrapper wrapper=new RandomUserWrapper();
            wrapper=(RandomUserWrapper)System.JSON.deserialize(response.getBody(),RandomUserWrapper.class);
            if(wrapper?.results?.size()>0){
                RandomUserWrapper.results res=wrapper.results.get(0);
                System.debug('Persons Name=>'+res?.name?.title+' '+res?.name?.first+' '+res?.name?.last);
                System.debug('Date and dob'+res?.dob?.dte+'   '+res?.dob?.age);

            }
        }
        else{
            System.debug('something went wrong !!!');
        }
    }

}