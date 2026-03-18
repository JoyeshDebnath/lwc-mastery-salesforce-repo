public class LocationTriggerHandler {
   
    public static void updateAccountNumberOfLocation_insert_delete_undelete(List<Location> newLocationList){
        // // Set<Id> accIdSet=new Set<Id>();//account ids set 
        // Map<Id,Integer> accountIdToNumberOfLocationMap=new Map<Id,Integer>();
        // List<Account> accountMapToUpdateList=new List<Account>();

        // for(Location location:newLocationList){
        //     if(location.AccountId__c!=null){
        //         // accIdSet.add(location.AccountId);
        //         if(!accountIdToNumberOfLocationMap.containsKey(location.AccountId__c)){
        //             accountIdToNumberOfLocationMap.put(location.AccountId__c,1);
        //         }else{
        //             accountIdToNumberOfLocationMap.put(location.AccountId,accountIdToNumberOfLocationMap.get(location.AccountId__c)+1);
        //         }
        //     }
        // }
        
        // //Query 
        // List<Account> existingAccountList=[SELECT Id,NumberofLocations__c FROM Account WHERE Id IN : accountIdToNumberOfLocationMap.keySet()];
        // for(Account acc: existingAccountList){
        //     Integer previousNumOfLocationCount=acc.NumberofLocations__c;
        //     Integer deltaNumberOfLocationCount=accountIdToNumberOfLocationMap.get(acc.Id);
        //     acc.NumberofLocations__c=previousNumOfLocationCount+deltaNumberOfLocationCount;
        //     accountMapToUpdateList.add(acc);
        // }

        // update accountMapToUpdateList;
    }
}