public  class AccountWrapperController {
    
    @AuraEnabled (cacheable=true)
    public static List<AccountWrapper> getAccountWithContactsData(){
        List<AccountWrapper> wrapperDataList=new List<AccountWrapper>();
        List<Account> accList=[SELECT Id,Name FROM Account limit 5];
        for(Account acc:accList){
            List<Contact> conList=[SELECT FirstName,LastName,Email FROM Contact WHERE AccountId=:acc.Id];
            wrapperDataList.add(new AccountWrapper(acc,conList));
        }
        return wrapperDataList;
    }
    
    
    @AuraEnabled
    public static List<SObject> fetchData(String objectApiName,Integer limitation,List<String> fieldValues  ){
        String query='SELECT '+String.join(fieldValues,', ')+' '+' LIMIT \''+limitation+'\'';
        return Database.query(query);
    }
}