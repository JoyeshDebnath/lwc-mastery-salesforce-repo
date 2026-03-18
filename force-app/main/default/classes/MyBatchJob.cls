public class MyBatchJob implements Database.Batchable<sObject> , Database.Stateful {
    public integer summary ; 

    public MyBatchJob(String q){
        Summary=0;
    }

    public Database.QueryLocator start(Database.BatchableContext bc  ){
        return Database.getQueryLocator('SELECT Id,Name FROM Account');
    }

    public void execute (Database.BatchableContext bc , List<sObject> scope){

        for(sObject s:scope){
            summary++;
        }
    }

    public void finish(Database.BatchableContext bc ){
        System.debug('Summary count :'+summary);
    }

}