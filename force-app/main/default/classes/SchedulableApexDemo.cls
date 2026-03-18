/**
 * 1> Delete All Opportunities closed 60 Days ago 
 */

/**
 * Syntax to schedule 
 *  
 */

public  class SchedulableApexDemo {
    
    public void execute(SchedulableContext sc){
        deleteOppClosedSixtyDaysAgo();
    }

    public void deleteOppClosedSixtyDaysAgo(){
        List<Opportunity> opps=[SELECT Id,CloseDate FROM Opportunity WHERE IsClosed=True AND CloseDate<=LAST_N_MONTHS:2 LIMIT 2];
        try{
            delete opps;
        }catch(Exception e){
            System.debug('Error Ocuured While Deleting opps..'+e.getMessage());
        }
    }
}