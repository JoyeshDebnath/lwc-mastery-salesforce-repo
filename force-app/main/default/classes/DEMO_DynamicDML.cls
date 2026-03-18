public with sharing class DEMO_DynamicDML {
    public static void createRecordDynamically(){
        SObject accRecord =Schema.getGlobalDescribe().get('Account').newSObject();
        accRecord.put('Name','Sample Account Name');
        insert accRecord;
    }

    public static void updateRecordDynamically(){
        SObject contact=[SELECT Id,FirstName,LastName FROM Contact LIMIT 1];
        contact.put('FirstName','UpdatedName2');
        update contact;
    }

    public static void readFieldValuesDynamically(){
        SObject Contact=[SELECT Id,FirstName,LastName,Email FROM Contact LIMIT 1];
        String firstname=(String)Contact.get('FirstName');
        String lastname=(String)Contact.get('LastName');
        String email=(String)Contact.get('Email');

        System.debug('Information retrievd : '+firstname+' '+lastname+'  '+email);
    }


    public static void genericInsertRecordUtilityFunction(String objectname,Map<String,Object> fieldValues){
        SObject record=Schema.getGlobalDescribe().get(objectname).newSObject();
        if(record==null){
            throw new IllegalArgumentException('Invalid Object name ='+objectname);
        }
        for(String fieldname:fieldValues.keySet()){
            record.put(fieldname,fieldValues.get(fieldname));
        }

        insert record;
    }

    //Describe Metadata [ Schema Programming ]
    public static void schemaProgrammingDemo(){
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType accType=gd.get('Account');
        Schema.DescribeSObjectResult accDescribe = accType.getDescribe();
        System.debug(accDescribe);
        System.debug('LABEL:'+accDescribe.getLabel());
        System.debug('FIELDS :'+accDescribe.fields.getMap().keySet());
    }

    //dynamic field eexplorer 
    public static void dynamicFieldExplorer(String objectname){
        Schema.SObjectType objType=Schema.getGlobalDescribe().get(objectname);
        Schema.DescribeSObjectResult objDescribe =objType.getDescribe();
        Map<String,Schema.SObjectField> fieldMap=objDescribe.fields.getMap();
        System.debug('fieldmap='+fieldMap);
        for(String fieldname: fieldMap.keySet()){
            Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldname).getDescribe();
            System.debug('Field :'+fieldname+' , Label : '+fieldDescribe.getLabel()+', Type : '+fieldDescribe.getType());
        }
    }
}