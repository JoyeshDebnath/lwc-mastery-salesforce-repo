public with sharing class AccountBatchClass implements Database.Batchable<sObject>{
    public Database.QueryLocator start (Database.BatchableContext batchContext){
        System.debug('AccountBatchClass : Start method ');
        
        return Database.getQueryLocator([SELECT Id,Name,Rating FROM Account ]);
    }
    public void execute (Database.BatchableContext batchContext , List<Account> accList){
        for(Account  acc : accList){
            acc.Rating='Hot';
        }
        update accList;
    }
    
    public void finish (Database.BatchableContext batchContext){
        Database.executeBatch(new ContactBatchClass());
        System.debug('Finished execution ');
    }
}