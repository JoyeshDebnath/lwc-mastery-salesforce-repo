public class UpdateAccountNamesQueueable implements Queueable {
	private List<Id> accountIds;
    
    public UpdateAccountNamesQueueable(List<Id> accIds){
        this.accountIds=accIds;
    }
    /*
		List<Account> accounts=[SELECT Id FROM Account WHERE CreatedDate=LAST_N_DAYS:3];
            List<Id> accIds=new List<Id>();
            for(Account acc:accounts){
                accIds.add(acc.Id);
            }

			Id jobID=System.enqueueJob(new UpdateAccountNamesQueueable(accIds));

		*/
    public void execute(QueueableContext context){
        List<Account> accounts=[SELECT Id,Name FROM Account WHERE Id IN : accountIds];
        for(Account acc: accounts){
            acc.Name=acc.Name+' - Updated using Queuebale concept ';
        }
        
        update accounts;
        
        //Chain the Next Job To Send Email  
        System.enqueueJob(new SendEmailNotificationQueueable(accountIds));
    }
}