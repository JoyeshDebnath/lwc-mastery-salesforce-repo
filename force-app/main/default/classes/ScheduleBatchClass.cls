public  class ScheduleBatchClass implements System.Schedulable {
    public void execute (System.SchedulableContext sc ){
        ContactBatchClass batchClass=new ContactBatchClass();
        ID jobid=Database.executeBatch(batchClass);
        System.debug('JOB ID='+jobid);
    }
}