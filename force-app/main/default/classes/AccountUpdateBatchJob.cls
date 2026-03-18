global class AccountUpdateBatchJob implements 
                                Database.Batchable<sObject>
                                {
    
    
    global Database.QueryLocator start (Database.BatchableContext bc ){
            
        String query='SELECT Id,Name FROM Account';
        return Database.getQueryLocator(query);
    }

    global void execute (Database.BatchableContext bc , List<Account> acclist ){
            for(Account acc:acclist){
                acc.Name=acc.Name+' minor updateusing batch job';
            }
            update acclist;
    }

    global void finish (Database.BatchableContext bc ){
        System.debug('FINISHED EXECUTION ');

    }
}