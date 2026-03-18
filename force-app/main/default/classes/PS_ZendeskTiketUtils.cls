public with sharing class PS_ZendeskTiketUtils {

    public static void createTicket(TicketWrapper wrapper){

        String header=System.Label.Zendesk_Username+':'+System.Label.Zendesk_Token;

        String requestBody='{'+
		'    "ticket": {'+
		'        "comment": {'+
		'            "body": "'+wrapper.body+'"'+
		'        },'+
		'        "priority": "'+wrapper.priority+'",'+
		'        "subject": "'+wrapper.subject+'",'+
		'        "requester": {'+
		'            "locale_id": 8,'+
		'            "name": "'+wrapper.name+'",'+
		'            "email": "'+wrapper.email+'"'+
		'        }'+
		'    }'+
		'}';
        Blob headerValue=Blob.valueOf(header);

        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://gejoyesh.zendesk.com/api/v2/tickets');
        request.setMethod('POST');
        request.setBody(requestBody);//string >> XML/JSON 
        request.setHeader('Content-Type','application/json');
        request.setHeader('Accept','application/json');
        request.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(headerValue));

        Http http=new Http();

        try{
                HttpResponse response=http.send(request);
                if(response.getStatusCode()==201){
                        //success
                        System.debug('SUCCESS \n'+response.getBody());
                        String responseStr=response.getBody();//string 
                        Map<String,Object> parsedJson=(Map<String,Object>) JSON.deserializeUntyped(responseStr);
                        // System.debug('Parsed JSON : \n'+parsedJson);
                        Map<String,Object> ticket=(Map<String,Object>)parsedJson.get('ticket');
                        Integer ticketID=(Integer) ticket.get('id');

                }else{
                    //error 
                    System.debug('ERROR \n '+response.getBody());
                }
        }catch(System.CalloutException e){
            System.debug('Calllout exception \n'+e.getMessage());
        }
        catch(System.Exception e){
            System.debug('Exception occurred : '+e.getMessage()); 
        }
    }

    public class TicketWrapper{
        public String body;
        public String subject;
        public String priority;
        public String  name;
        public String email;
    }
}