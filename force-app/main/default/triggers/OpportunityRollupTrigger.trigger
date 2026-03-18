trigger OpportunityRollupTrigger on Opportunity (before insert,before update,before delete,
                                                        after insert,after update,after delete,after undelete) {
                       //recursion guard 
    if(TriggerRecursionHandler.isExecuting)
        return;
    TriggerRecursionHandler.isExecuting=true;
                    
    Set<Id> accountIds=new Set<Id>();

    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
                   for(Opportunity opp : Trigger.New){
                        if(opp.AccountId!=null){
                            accountIds.add(opp.AccountId);
                        }
                    }

    }

    if(Trigger.isUpdate || Trigger.isDelete){
        for(Opportunity opp : Trigger.Old){
            if(opp.AccountId!=null){
                accountIds.add(opp.AccountId);
            }
        }
    }
    if(!accountIds.isEmpty()){
        OpportunityRollUpService.updateAccountRevenue(accountIds);
    }

    TriggerRecursionHandler.isExecuting=false;

}