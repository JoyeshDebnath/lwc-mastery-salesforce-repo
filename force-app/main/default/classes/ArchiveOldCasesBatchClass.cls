/**
📦 Scenario 2: Archive Old Cases
📝 Use Case
Mark cases older than 1 year as archived (custom field Is_Archived__c = true).
 */
public class ArchiveOldCasesBatchClass implements Database.Batchable<SObject>{
    public  Database.QueryLocator start(Database.BatchableContext bc ){
        return Database.getQueryLocator([SELECT Id,ISArchived__c,CreatedDate FROM Case WHERE CreatedDate<:System.today().addYears(-1)]);
    }

    public  void execute (Database.BatchableContext bc , List<SObject> caseList){
        List<Case> casesToUpdate = new List<Case>();
        for(SObject c:caseList){
            Case cs=(Case) c;
            cs.ISArchived__c='TRUE';
            casesToUpdate.add(cs);
        }
        update casesToUpdate;
    }

    public  void finish(Database.BatchableContext bc ){
        System.debug('Finished the updation of all the cases is archived status ');
    }
}