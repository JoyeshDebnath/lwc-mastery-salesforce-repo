public  class CreateUpdateMetadataUtils implements Metadata.DeployCallback {
    
    public  void handleResult(Metadata.DeployResult result,Metadata.DeployCallbackContext context){
            if(result.status == Metadata.DeployStatus.Succeeded){
                System.debug('Success ==> '+result);
            }else{
                System.debug('Fail --->'+result);
            }
    }

    //Map <String,Object> fieldWithValuesMap is a map that has key as fieldapi name of the customm metadata and respective Values as the values of the customm metadata . . 
    public static void  updateCreateMetadata(String fullname,String label,Map<String,Object> fieldWithValuesMap){
        Metadata.CustomMetadata customMetadata=new Metadata.CustomMetadata();
        customMetadata.fullName=fullname;//API name of the Custom metadata record ==>  "Salesforce_Config.PS_SalesforceToken"
        customMetadata.label=label;//Label of the custom metadata record  | 
        for(String key : fieldWithValuesMap.keySet()){
            Metadata.CustomMetadataValue customField=new Metadata.CustomMetadataValue();
            customField.field=key;
            customField.value=fieldWithValuesMap.get(key);
            customMetadata.values.add(customField);
        }

        Metadata.DeployContainer mdContainer=new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        CreateUpdateMetadataUtils callback=new CreateUpdateMetadataUtils();

        Id jobID=Metadata.Operations.enqueueDeployment(mdContainer,callback);


    }
    
}