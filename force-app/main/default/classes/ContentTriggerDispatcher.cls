public with sharing class ContentTriggerDispatcher {
    public static void dispatch(System.TriggerOperation opsType){
        switch on opsType{
            when AFTER_INSERT{
                ContentTriggerHelper.handle((Map<Id,ContentDocumentLink>)Trigger.newMap);
            }
        }
    }
}