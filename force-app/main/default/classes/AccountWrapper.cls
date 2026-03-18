public  class AccountWrapper {
    
    @AuraEnabled public  Account account {get ; set ;}
    @AuraEnabled public List<Contact> contacts {get;set;}
    @AuraEnabled public Boolean isSelected {get;set;}
    
    public AccountWrapper (Account account ,List<Contact> contacts){
        this.account=account;
        this.contacts=contacts;
        this.isSelected = false;
    }
}