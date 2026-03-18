//Class to practice Email message Sending
public class EmailManager{
    
    public void sendEmail(String address,String body,String subject){
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{address});
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        
        inspectResults(results);
    }
    public void inspectResults(Messaging.SendEmailResult[] results){
        
        for(Messaging.SendEmailResult res : results){
            if(res.isSuccess()){
                System.debug('Email sent successfully');
            }else{
                System.debug('Error occurred :'+res.getErrors());
            }
        }
    }
}