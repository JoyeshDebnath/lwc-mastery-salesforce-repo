public  class LookupUtility {
    //Search SObjects field 
    @AuraEnabled(cacheable=true)
    public static List<sObject> searchRecords(String objectApiName,String fieldApiName,String searchKey){
        //Validation 
        if (String.isBlank(objectApiName) || String.isBlank(fieldApiName) || String.isBlank(searchKey)){
            return new List<sObject>();
        }
        String query='SELECT Id,Name,'+fieldApiName+' FROM '+objectApiName + ' WHERE '+fieldApiName+'  LIKE \'%'+searchKey+'%\'';
        return Database.query(query);
    }


}