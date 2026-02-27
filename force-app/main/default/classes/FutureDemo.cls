public  class FutureDemo {
    
    // Scenerio 1 - callout to external API (Send accout data to External api )
    @future(callout=true)
    public static void sendAccountData(String accountId){
        Account acc=[SELECT Id,Name FROM Account WHERE Id=:accountId LIMIT 1];
       
        HttpRequest req=new HttpRequest();
        req.setEndpoint('https://example.com/api/accounts');
        req.setMethod('POST');
        req.setBody('{"id":"'+acc.Id+'","name":"'+acc.Name+'"}');

        Http http=new Http();
        HttpResponse response=http.send(req);
        System.debug('Response : =>'+response.getStatusCode());


    }

    //Scenerio -2 : After inserting opportunities you want to Recalculate Forcasts . Use Future method to process calculations without blocking the user 
    @future
    public static void performCalculationOnForcast(List<Id> oppIds){
        List<Opportunity> oppList=[SELECT Id,Name,Amount FROM Opportunity WHERE Id IN : oppIds];
        for(Opportunity opp : oppList){
            opp.Description = 'Forcast Recalculated at : '+System.now();

        }
        update oppList;

    }

}