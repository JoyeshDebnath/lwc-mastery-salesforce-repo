public with sharing class SecondQueueableJob implements System.Queueable {
    private Set<Id> accountIds;
    
    public SecondQueueableJob(List<Account> accList){
        this.accountIds = new Set<Id>();
        for(Account acc:accList){
            this.accountIds.add(acc.Id);
        }
    }
    
    public void execute (System.QueueableContext context){
        List<Contact> contactList = [SELECT FirstName,LastName,Email,AccountId 
                                    FROM Contact 
                                    WHERE AccountId IN : accountIds];
        for(Contact con : contactList){
            con.Description = 'Updated By the SecondQueueableJob';
        }
        update contactList;
        //chaining the 3rd Queuebale Job
        System.enqueueJob(new ThirdQueueableJob(accountIds));
        
    }
}