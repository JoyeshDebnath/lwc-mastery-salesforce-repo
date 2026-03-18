public with sharing class DynamicApexExample {
    public  static void dynamicDemoMethodOne(){
        //Token for the Contact Object
        Schema.SObjectType sObjectToken = Contact.sObjectType;
        System.debug('SOBJECT_TOKEN=>'+sObjectToken);
        
        Schema.DescribeSObjectResult sObjectResult = Contact.sObjectType.getDescribe();
        System.debug('SObjectResult = '+sObjectResult);
        
        Schema.DescribeFieldResult contactNameResult = Schema.sObjectType.Contact.fields.Name;
        System.debug('Sobjectresult => '+contactNameResult);
        
        
        
    }
}