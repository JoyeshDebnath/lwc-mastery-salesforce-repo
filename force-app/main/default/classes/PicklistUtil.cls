public with sharing class PicklistUtil {
    @AuraEnabled(cacheable=true)
    public static List<Picklist> getDynamicPicklistValues(String objectApiName,String fieldName){
        List<Picklist> picklistValues = new List<Picklist>();
        
        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(objectApiName);
        Schema.DescribeSObjectResult  describeSObjectResult = objectType.getDescribe();
        Schema.DescribeFieldResult describeFieldResult = describeSObjectResult.fields.getMap().get(fieldName).getDescribe();
        
        List<Schema.PicklistEntry> picklistEntries = describeFieldResult.getPicklistValues();
        for(Schema.PicklistEntry entry : picklistEntries){
            if(entry.isActive()){
                picklistValues.add(new Picklist(entry.getLabel(),entry.getValue()));
            }
        }
        System.debug('Values of the picklist = \n'+ JSON.serialize(picklistValues));
        return  picklistValues;
        
    }
    
    
    public class Picklist{
        @AuraEnabled public String label;
        @AuraEnabled public String value;
        
        public Picklist(String Label,String Value){
            this.label=Label;
            this.value=Value;
        }
    }
}