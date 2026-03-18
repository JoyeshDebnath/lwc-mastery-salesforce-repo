trigger LeadTrigger on Lead (after insert,after update , after delete , after undelete,before insert , before update , before delete) {
    // if(Trigger.isAfter && Trigger.isInsert){
    //     for(Lead lead:Trigger.New){
    //         FutureApex1.sendLeadData(lead.Id,lead.Email);
    //     }
    // }
    LeadTriggerDispatcher.dispatch(Trigger.OperationType);
}