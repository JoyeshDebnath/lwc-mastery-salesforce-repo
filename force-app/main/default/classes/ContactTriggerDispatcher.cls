public with sharing class ContactTriggerDispatcher {
   public static void dispatch(System.TriggerOperation  opsType){
    switch on opsType{
        when AFTER_INSERT{
				ContactTriggerHandler.updateNumberOfAccounts_insert_undelete(Trigger.New,null,false);
        }
        when AFTER_UPDATE{
				// ContactTriggerHandler.handleAfterUpdateScenerio((Map<Id,Contact> )Trigger.oldMap,Trigger.New);
        ContactTriggerHandler.updateNumberOfAccounts_update(Trigger.New,(Map<Id,Contact>)Trigger.oldMap);
        }
        when AFTER_DELETE{
          ContactTriggerHandler.updateNumberOfAccounts_insert_undelete(Trigger.New,(Map<Id,Contact>)Trigger.oldMap,true);
        }
        when  AFTER_UNDELETE{
          ContactTriggerHandler.updateNumberOfAccounts_insert_undelete(Trigger.New,null,false);
        }
        when BEFORE_INSERT{
            ContactTriggerHandler.preventDuplicateContactsControllerBeforeInsertAndUpdate((List<Contact>)Trigger.new);
        }
        when BEFORE_UPDATE{

        }
        when BEFORE_DELETE{

        }
        
    }
   }
}