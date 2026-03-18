public  class OpportunityTriggerHandler {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            when  AFTER_UPDATE{
                OpportunityTriggerHelper.calculateAndUpdateTotalAmountOnAccount((Map<Id,Opportunity>)Trigger.oldMap,Trigger.New);
            }
            when AFTER_DELETE{
				 OpportunityTriggerHelper.calculateAndUpdateTotalAmountOnAccount((Map<Id,Opportunity>)Trigger.oldMap,null);
            }
            when AFTER_UNDELETE{
				 OpportunityTriggerHelper.calculateAndUpdateTotalAmountOnAccount(null,Trigger.New);
            }
            when AFTER_INSERT{
                //OpportunityTriggerHelper.createTaskUnderOpportunityWhenAccountIsBlank(Trigger.New);
                OpportunityTriggerHelper.calculateAndUpdateTotalAmountOnAccount(null,Trigger.New);
            }
            when BEFORE_INSERT{

            }
            when BEFORE_UPDATE{

            }
            when BEFORE_DELETE{

            }
            
        }
    }
}