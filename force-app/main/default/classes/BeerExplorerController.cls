public with sharing class BeerExplorerController {
    @AuraEnabled
    public static List<sObject> getBeerByName(String  searchParam){
        String likeParam='%'+searchParam+'%';
        String query='';
        if(searchParam!=null){
            query='SELECT Id,brewery_id__c,Alcohol__c,brewery_Name__c,Name,Price__c,Tags__c,Total_Quantity__c,Image__c FROM Beer__c WHERE Name LIKE : likeParam LIMIT 10';
        }else{
            query='SELECT Id,brewery_id__c,Alcohol__c,brewery_Name__c,Name,Price__c,Tags__c,Total_Quantity__c,Image__c FROM Beer__c LIMIT 10';
        }
        try{
                System.debug('Query Made'+query);
                List<sObject> sObjectList=Database.query(query);
                System.debug(sObjectList);
                return sObjectList;
        }catch(Exception e){
            System.debug(e.getMessage());
            return new List<sObject>();
        }
    }
}