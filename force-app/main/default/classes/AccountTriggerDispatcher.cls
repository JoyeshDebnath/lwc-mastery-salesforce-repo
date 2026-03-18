public with sharing class AccountTriggerDispatcher {
   
    public static void dispatch(System.TriggerOperation opsType){

        switch on opsType{
            when AFTER_INSERT{
                AccountTriggerHandler.createTask(Trigger.New);
               
            }
            when AFTER_UPDATE{
                AccountTriggerHandler.handleChangeOfActiveStatusInOpportunityAndContacts((Map<Id,Account>)Trigger.oldMap,Trigger.New);
                AccountTriggerHandler.updateOwnerIdOfRelatedContactsAndOpportunities((Map<Id,Account>)Trigger.oldMap,Trigger.New);
            }
            when AFTER_DELETE{

            }
            when AFTER_UNDELETE{
				 AccountTriggerHandler.preventDuplicate_AccountNameAndRating_InsertAndUpdateUndelete(Trigger.New,false);
            }
            when BEFORE_INSERT{
				 AccountTriggerHandler.preventDuplicate_AccountNameAndRating_InsertAndUpdateUndelete(Trigger.New,false);
            }
            when BEFORE_UPDATE{
				 AccountTriggerHandler.preventDuplicate_AccountNameAndRating_InsertAndUpdateUndelete(Trigger.New,true);
            }
            when BEFORE_DELETE{

            }
        }
    }
}