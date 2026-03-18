trigger AccountTrigger on Account (before insert,before update,before delete,after update,after insert,after delete,after undelete) {
   AccountTriggerDispatcher.dispatch(Trigger.operationType);
}