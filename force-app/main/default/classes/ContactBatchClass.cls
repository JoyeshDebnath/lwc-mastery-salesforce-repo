public with sharing class ContactBatchClass implements Database.Batchable<sObject>,Database.Stateful{
    private Integer successRecords=0;
    private Integer failedRecords=0;
    private Integer totalRecords=0;
    
    public Database.QueryLocator start (Database.BatchableContext batchContext){
        System.debug('Started the execution .');
        return Database.getQueryLocator([SELECT Id,FirstName,LastName,Email,AccountId,Phone,Department FROM Contact]);
        
    }
    
    
    public void execute (Database.BatchableContext batchContext,List<Contact> contactRecords){
        totalRecords+=contactRecords.size();
        System.debug('Total Records :'+totalRecords);
        for(Contact contact:contactRecords){
            contact.Department='Education';
        }
        List<Database.SaveResult> results =  Database.update(contactRecords,false);
        for(Database.SaveResult result:results){
            if(result.isSuccess()){
                successRecords++;
            }else{
                failedRecords++;
            }
        }
    }
    
    public void finish(Database.BatchableContext batchContext){
        System.debug('Finished the execution ...');
        
        System.debug('Total Records = '+totalRecords);
        System.debug('Success Records = '+successRecords);
        System.debug('Failed Records = '+failedRecords);
    }
}