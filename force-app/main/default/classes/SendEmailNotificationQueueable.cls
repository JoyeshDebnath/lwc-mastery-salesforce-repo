public class SendEmailNotificationQueueable implements Queueable{

	private List<Id> accountIds;    
    
    public SendEmailNotificationQueueable(List<Id> accIds){
        this.accountIds=accIds;
    }
    
    public void execute(QueueableContext context){
    	    List<Account> accounts=[SELECT Id,Name, Owner.Email FROM Account WHERE Id IN : accountIds];
        	List<Messaging.SingleEmailMessage> emailList=new List<Messaging.SingleEmailMessage>();
        
        for(Account  acc: accounts){
            Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[]{acc.Owner.Email});
            email.setSubject('Account Name has been Updated');
            email.setPlainTextBody('Your Account :'+ acc.Name +'  Has been updated ..');
            emailList.add(email);
        }
        
        Messaging.sendEmail(emailList);
    }
}