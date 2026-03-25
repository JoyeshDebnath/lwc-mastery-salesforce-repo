trigger EventSyncTrigger on Event (after insert,after update,after delete) {
    if(GoogleCalendarSyncQueueable.isRunning){
        return;
    }

    
    if(Trigger.isInsert){
        System.enqueueJob(
            new GoogleCalendarSyncQueueable(Trigger.New,'create')
        );
    }

    if(Trigger.isUpdate){
        List<Event> changedEvents = new List<Event>();
        for(Event e : Trigger.New){
            Event old = Trigger.oldMap.get(e.Id);
            if((e.Subject != old.Subject) || (e.StartDateTime != old.StartDateTime) || (e.EndDateTime!=old.EndDateTime) || (e.Description!=old.Description) || (e.Location!=old.Location)){
               changedEvents.add(e); 
            }
        }
        if(!changedEvents.isEmpty()){
            System.enqueueJob(
                new GoogleCalendarSyncQueueable(changedEvents,'update')
            );
        }
    }

    if(Trigger.isDelete){
        System.enqueueJob(
            new GoogleCalendarSyncQueueable(Trigger.old,'delete')
        );
    }
}