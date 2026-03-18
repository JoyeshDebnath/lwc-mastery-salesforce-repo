public class LeadTriggerHelper {
    
    public static void sendEmails(Map<Id,Lead> newRecordMap){
        List<Messaging.SingleEmailMessage> emailsList=new List<Messaging.SingleEmailMessage>();
        
        for(Lead lead : newRecordMap.values()){
            if( String.isBlank(lead.Phone) || String.isBlank(lead.Email)){
                Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
                email.setSubject('Important Information is missing for the lead :'+ lead.FirstName ?? ' ' + ' '+lead.LastName);
                String baseURL=System.URL.getOrgDomainUrl().toExternalForm();//get the org domain  url
                baseURL+='/lightning/r/Lead/'+lead.Id+'/view';

                String emailBody='Hi User , <br/><br/> Important Information of lead phone or lead email are missing . <br><br/> ';
                emailBody+='<a href="'+baseURL+'" target="_blank">Click here </a> to visit lead ';
                emailBody+='Please take proper action ASAP  <br/><br/> Thanks & Regards , <br/> <br/>';
                email.setHtmlBody(emailBody);
                List<String> toAddress=new List<String>();
                toAddress.add(lead.OwnerId);
                email.setToAddresses(toAddress);
                email.setBccAddresses(new List<String>{lead.OwnerId,'joyeshdebnath52@gmail.com'});
                email.setSenderDisplayName('no-reply@yahoo.com');

                emailsList.add(email);
            }

            List<Messaging.SendEmailResult> emailresult = Messaging.sendEmail(emailsList,true);

            //check for emails result 
        

        }
    }

    public static void sendEmailIfPhoneOrEmailBlank(List<Lead> newLeadsList){
        
        List<Messaging.SingleEmailMessage> emailMessagesList=new List<Messaging.SingleEmailMessage>();
        for(Lead lead:newLeadsList){
            if(String.isBlank(lead.Email) || String.isBlank(lead.Phone)){
                Messaging.SingleEmailMessage emailService=new Messaging.SingleEmailMessage();
                String baseUrl=System.URL.getOrgDomainURL().toExternalForm();
                baseUrl+='/lightning/r/Lead/'+lead.Id+'/view';
                emailService.setCcAddresses(new List<String>{lead.OwnerId});
                emailService.setSubject('Lead Email OR Phone number OR both are missing for '+lead.FirstName??' '+lead.LastName);
                emailService.setBccAddresses(new List<String>{lead.OwnerId,'itsmejoyeshdebnath26@gmail.com'});
                String emailbody='Hi User , <br/><br/> Important Information of lead phone or lead email are missing . <br><br/>';
                emailBody+='<a href="'+baseUrl+'" target="_blank">Click here</a>';
                emailService.setHtmlBody(emailBody);
                emailMessagesList.add(emailService);
                
            }
        }
        if(!emailMessagesList.isEmpty()){
            Messaging.SendEmailResult[] emailResult=Messaging.sendEmail(emailMessagesList);

        }
    }
}