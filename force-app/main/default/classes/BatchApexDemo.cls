/*

*/

public  class BatchApexDemo implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext bc ){
        return Database.getQueryLocator('SELECT Id,Name FROM Account WHERE Rating=null');
    }

    public void execute(Database.BatchableContext bc , List<Account> scope){
        //loop through the batch of accounts 
        for(Account acc:scope){
            acc.Rating='Hot';

        }
        update scope;
    }

    public void finish(Database.BatchableContext bc ){
        System.debug('Batch job has been finished !!!');
    }
}