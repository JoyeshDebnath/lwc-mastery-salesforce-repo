public with sharing class AsyncContactManager implements System.Queueable{
    private List<Contact> contactList;
    public AsyncContactManager(List<Contact> contactList){
        this.contactList = contactList;
    }
    
    public void execute(System.QueueableContext context){
        Id jobId=context?.getJobId();
        List<AsyncApexJob> jobDetails=[SELECT Id,JobType,MethodName,ParentJobId,
                                                TotalJobItems,Status,ApexClass.Name 
                                                FROM AsyncApexJob 
                                                WHERE Id=:jobId];
        if(jobDetails?.size()>0){
            System.debug('SKIP');
        }else{
            System.debug('No Job Details Found .....');
        }
        
        // ContactManager.createUser(null);//future1
        // ContactManager.dummyMethod();//future 2
        
        processLogic();
    }
    public  void processLogic(){
        System.debug('Logic is Processing ....');
        Id jobID1=System.enqueueJob(new AsyncAccountManager());
        System.debug('Job Id returned '+jobID1);
    }
}