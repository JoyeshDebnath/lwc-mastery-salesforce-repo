public with sharing class Integration_Zendesk {
    /**
                     * 
                Integration_Zendesk.TicketWrapper wrapper=new Integration_Zendesk.TicketWrapper();
                wrapper.body='Dynamic body Testing ...';
                wrapper.priority='urgent';
                wrapper.name='Dilip Singh ';
                wrapper.email='Dillip45@gmail.com';
                wrapper.subject='Testing Apex Dynamic val passing';

                Integration_Zendesk.createTicket(wrapper);
     */
    
    public class TicketWrapper{
        public String body;
        public String subject;
        public String priority;
        public String name;
        public String email;
    }


//return zendesk id as a string on success 
   public static String createTicket(TicketWrapper wrapper){
        String ticketId='';
        String header='itsmejoyeshdebnath26@gmail.com'+'/token:'+System.Label.ZENDESK_API_TOKEN;
        String requestBody=		'{'+
		'  "ticket": {'+
		'    "comment": {'+
		'      "body": "'+wrapper.body+'"'+
		'    },'+
		'    "priority": "'+wrapper.priority+'",'+
		'    "subject": "'+wrapper.subject+'",'+
		'     "requester": { "locale_id": 8, "name": "'+wrapper.name+'", "email": "'+wrapper.email+'" }'+
		'  }'+
		'}';
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(System.Label.ZENDESK_BASE_URL+'/api/v2/tickets');
        request.setHeader('Content-Type','application/json');
        request.setHeader('Accept','application/json');
        request.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(header)));
        request.setBody(requestBody); //String ---> [ XML / JSON ] 
        try{
                HttpResponse response=http.send(request);
                if(response.getStatusCode()==201){
                    System.debug('SUCCESS \n'+response.getBody());
                    String jsonZendeskResponse=response.getBody();//String json response 
                    Map<String,Object> parsedResponse=(Map<String,Object>)JSON.deserializeUntyped(jsonZendeskResponse); 
                    Map<String,Object> ticketResponse=(Map<String,Object>)parsedResponse.get('ticket');
                    ticketId=String.valueOf(ticketResponse.get('id'));

                }
        }catch (System.CalloutException ex){
            System.debug(ex.getMessage());
        }
        catch(System.Exception ex){
            System.debug('The error ocurred ....\n'+ex.getMessage());
           
        }
        
        System.debug('Ticket id ='+ticketId);
        return ticketId;
   }
}