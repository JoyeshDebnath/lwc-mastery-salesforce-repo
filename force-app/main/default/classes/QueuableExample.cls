public  class QueuableExample implements Queueable  {
    private Id accountId;

    public QueuableExample(Id accountId) {
        this.accountId=accountId;
    }

    public void execute (QueueableContext  context){
        Account acc=[SELECT Id,Name FROM Account WHERE Id=:accountId];
        acc.Description='Processed By Queuable Apex at '+System.now();
        update acc;
    }
    
}
/**
 *  System.enqueuJob(new QueubleExample(acc.Id))
 * 
 * 
 */