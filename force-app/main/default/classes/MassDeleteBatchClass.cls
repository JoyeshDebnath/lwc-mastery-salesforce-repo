public class MassDeleteBatchClass implements  Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // Modify WHERE clause to target specific records if needed
        return Database.getQueryLocator([
            SELECT Id FROM Contact 
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        try {
            delete scope;
        } catch (Exception e) {
            System.debug('Error deleting contacts: ' + e.getMessage());
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch deletion completed.');
    }

}