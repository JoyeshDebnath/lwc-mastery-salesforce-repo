public with sharing class DynamicApexExampleCode {
    
    public static void dynamicSOQLCall(String objectApiName,String fieldName){
        String query = 'SELECT '+fieldName+' FROM  '+objectApiName;
        List<SObject> results = Database.query(query);
        for(SObject record : results){
            System.debug(record);
        }
        
    }
    
    public static void describeObjectsExample(String objectName){
        Schema.SObjectType objType=Schema.getGlobalDescribe().get(objectName);
        if(objType!=null){
            Schema.DescribeSObjectResult describe = objType.getDescribe();
            System.debug('describe = \n'+describe);
            Map<String,Schema.SObjectField> fields = describe.fields.getMap();
            System.debug('Fields = \n'+fields);
            for(String fieldname : fields.keySet()){
                System.debug('Field'+fieldName);
            }
            
        }
    }
    
    public static void dynamicCrudCreateRecord(String objectApiName,Map<String,Object> fieldValues){
        SObject record=Schema.getGlobalDescribe().get(objectApiName).newSObject();
        System.debug('Record='+record);
        for(String field : fieldValues.keySet()){
            record.put(field,fieldValues.get(field));
        }
        insert record;
    }
    
    
}