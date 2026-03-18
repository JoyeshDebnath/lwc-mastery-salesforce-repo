/*
-Basic Syntax : 

        public class QueueableApexClass implements Queueable{
        public void execute (QueueuableContext context ){
                //  async code goes here ......
        }

}

*/


/*
	example 1: Update Account Active__c to no if its null using queueable apex 

*/
public class QueueableApexDemoClass implements Queueable {
	private List<Id> accountIds;
	
    public QueueableApexDemoClass(List<Id> accIds){
        this.accountIds=accIds;
    }
    
    public void execute(QueueableContext context){
        accountActiveStatusUpdate();
    }
    
    /*
		--> anonyous code to execute the below logic : 

		List<Id> accountIds=new List<Id>();
            for(Account acc : [SELECT Id,Name FROM  Account WHERE CreatedDate = LAST_N_DAYS:7]){
                accountIds.add(acc.Id);
            }
            Id jobID = System.enqueueJob(new QueueableApexDemoClass(accountIds));
            System.debug(jobID);
	*/


    public void accountActiveStatusUpdate(){
        List<Account> accList=[SELECT Id,Name,Active__c FROM Account WHERE (Active__c=null AND Id IN : accountIds )];
        for(Account acc:accList){
            acc.Active__c='No';
        }
		update accList;
    }
}