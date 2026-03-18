public with sharing class DynamicCRUDUtilityClass {
    
    public static List<SObject> dynamicReadOperation(String objectName,List<String> fieldNames,String whereClause){
        String query='SELECT '+String.join(fieldNames,', ')+' FROM '+objectName;
        if(whereClause!=null){
            query+=' '+whereClause;
        }
        return Database.query(query);
    }
    
    public static void updateRecordDynamically(String objectApiName,String recordID,Map<String,Object> fieldValues){
        SObject record = Database.query('SELECT Id FROM '+objectApiName+' WHERE Id= \''+recordID+ '\'');
        for(String field : fieldValues.keySet()){
            record.put(field,fieldValues.get(field));
        }
        update record;
    }
    
    public static void dynamicallyDelete(String objectApiName,String recordID){
        SObject record = Database.query('SELECT Id FROM '+objectApiName+' WHERE Id=\''+recordID+'\'');
        delete record;
    }
    
    public static void insertDynamically(String objectApiName,Map<String,Object> fieldValues){
        SObject record = Schema.getGlobalDescribe().get(objectApiName).newSObject();
        
        for(String field : fieldValues.keySet()){
            record.put(field,fieldValues.get(field));
        }
        
        insert record;
    }
    
    
}