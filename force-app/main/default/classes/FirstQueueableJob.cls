//First Job to update the Account Description

public with sharing class FirstQueueableJob implements System.Queueable {
    public void execute (System.QueueableContext context){
        List<Account> accList=[SELECT Id,Name,Phone,Description FROM Account  WHERE Industry='Technology' LIMIT 100];
        for(Account acc:accList){
            acc.Description='Update By the FirstQueueableJob class ';
        }
        update accList;
        //chain the second job (Updating the Contact Description )
        System.enqueueJob(new SecondQueueableJob(accList));
        
    }
}