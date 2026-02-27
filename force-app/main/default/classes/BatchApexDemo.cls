public  class BatchApexDemo implements Database.Batchable<SObject> {
    

    // Scenerio 1 : Mass Update Accounts Missing Phone Number 
    public Database.QueryLocator start(Database.BatchableContext bc ){
        Date cuttOff=Date.today().addYears(-2);
        String query='SELECT Id,Name,CloseDate,StageName,IsClosed FROM Opportunity WHERE CloseDate < :cuttOff AND IsClosed = False';
        // String query='SELECT Id,Name, Phone FROM Account WHERE Phone=NULL ';
        return  Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc , List<Opportunity> oppList){
        for(Opportunity opp:oppList){
            opp.StageName='Closed Lost';
            // opp.IsClosed=true;
        }
        update oppList;
    }

    public void finish (Database.BatchableContext bc ){
        System.debug('Batch Completed : Opprotunity  Updated .....');
    }
}