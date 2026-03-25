public  class GoogleCalendarSyncQueueable implements Queueable,Database.AllowsCallouts {
    
    public static Boolean isRunning=false;

    private List<Event> events;
    private String operation;//         create | update | delete
    public  GoogleCalendarSyncQueueable(List<Event> events,String operation){
        this.events=events;
        this.operation=operation;
    }

    public void execute (QueueableContext qc){
        isRunning=true;

        List<Event> eventsToUpdate = new List<Event>();
        for(Event ev : this.events){
            try{
                //   Write | Add Code heere for all the three scenerios of google Calenders ie Create Event + Update Event + Delete Event 

                
            }catch(Exception e){
                System.debug('Error Ocurred ===> '+ev.Id+'  Operation==> '+this.operation+' | '+e.getMessage() );
            }
        }
        if(!eventsToUpdate.isEmpty()){
            update eventsToUpdate;
        }


        isRunning=false;
    }
}