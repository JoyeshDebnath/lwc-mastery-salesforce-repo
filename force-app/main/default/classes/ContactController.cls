public with sharing class ContactController {
   @AuraEnabled(cacheable=true)
   public static List<Contact> getContacts(){
    return [SELECT Id,AccountId,Email,Phone,Title,FirstName,LastName FROM Contact LIMIT 20];
   }
}