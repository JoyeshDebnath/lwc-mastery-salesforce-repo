public with sharing class ContactListController {
    @AuraEnabled
    public static List<Contact> getTenContacts(String accId){
        return  [SELECT Id,FirstName,LastName,Email,Phone FROM Contact WHERE Email!=null AND AccountId=:accId LIMIT 10];
    }

    @AuraEnabled
    public static Contact createContactRecord(Contact contact,Id accountId){
        
        try{
                 System.debug(accountId);
                contact.AccountId=accountId;
            
                insert contact;
                System.debug('The Contact:'+contact.Id);

        }catch(Exception e){
            System.debug('Error ocurred while creating contact :'+e.getMessage());
        }

        return contact;
    } 
}