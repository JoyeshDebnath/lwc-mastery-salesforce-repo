public class AccountBatchJobScheduled implements Schedulable {
    public  void execute (SchedulableContext sc ){
        AccountUpdateBatchJob b=new AccountUpdateBatchJob();
        Database.executeBatch(b);

    }
}