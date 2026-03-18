public with sharing class ContactController2 {
   @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
            return [
                SELECT Id,FirstName,LastName,Email,
                Phone,Picture__c,Title 
                FROM Contact
                WHERE Picture__c!=null
                WITH USER_MODE
                LIMIT 10
            ];
   }

   @AuraEnabled(cacheable=true)
   public static List<Contact> findContacts(String searchKey){
        String key='%'+searchKey+'%';
        return [
            SELECT Id,FirstName,LastName,Name,Email,
            Phone,Title,Picture__c 
            FROM Contact 
            WHERE Name LIKE:key 
            AND 
            Picture__c!=null 
            WITH USER_MODE 
            LIMIT 10
        ];

   }
}