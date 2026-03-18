public with sharing class ZendeskIntegrationUtil {
    public ZendeskIntegrationUtil() {

    }
    public class TicketWrapper{
        public String body;
        public String subject;
        public String priority;
    }//inner class 

    public static void ZendeskTicketCreationDemo(TicketWrapper ticket_wrapper){
        String endpointURI=System.Label.ZENDESK_BASE_URL+'/api/v2/tickets';
        String header=System.Label.ZENDESK_USER_NAME+'/token:'+System.Label.ZENDESK_API_TOKEN;
        Blob headerValue=Blob.valueOf(header);
        String encodedAuthStr=EncodingUtil.base64Encode(headerValue);
        String jsonStr=		'{'+
		'    "ticket": {'+
		'        "comment": {'+
		'            "body": "'+ticket_wrapper.body+'"'+
		'        },'+
		'        "priority": "'+ticket_wrapper.priority+'",'+
		'        "subject": "'+ticket_wrapper.subject+'"'+
		'    }'+
		'}';
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndpoint(endpointURI);
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept','application/json'); 
        req.setHeader('Authorization','Basic '+encodedAuthStr);//pass the username/token:apiKey   as encoded form > of base64 encode 
        req.setMethod('POST');
        
        req.setBody(jsonStr);
            try{
                HttpResponse response=http.send(req);
                if(response.getStatusCode()==201){
                    System.debug('Response returned =>\n'+response.getBody());
                }else{
                    //error 
                    System.debug('Error =>\n'+response.getBody());
                }

            }catch(System.CalloutException e){
                System.debug('Callout exception >>\n'+e.getMessage());
            }
            catch(System.Exception e){
                System.debug('Something Went Wrong >>'+e.getMessage());
            }
    }
}