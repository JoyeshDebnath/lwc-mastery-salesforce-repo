public with sharing class ThirdQueueableJob implements System.Queueable {
    private Set<Id> accIds;
    public ThirdQueueableJob (Set<Id> accIds){
        this.accIds = accIds;
    }
    public void execute (System.QueueableContext context){
        List<Account> accList=[SELECT Id,Name FROM Account WHERE Id IN : accIds];
        String accountNames='';
        for(Account acc:accList){
            accountNames+=acc.Name+', ';
        }
        
        accountNames=accountNames.removeEnd(', ');
        
        String[] toAddresses=new String[] {'joyeshdebnath52@gmail.com','itsmejoyeshdebnath26@gmail.com'};
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setToAddresses(toAddresses);
        mail.setSubject('Queueable Jobs Completed ');
        mail.setPlainTextBody('The following accounts wewe processed ..'+accountNames);
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
        
        System.debug('Email sent for the processed accounts : '+accountNames);
        
    }
}