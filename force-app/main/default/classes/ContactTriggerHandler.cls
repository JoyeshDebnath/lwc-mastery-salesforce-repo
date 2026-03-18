/*
		✅Scenerio 1 : there is a custom field on Account object named "number of contacts" . When a  contact is inserted / updated / deleted/undeleted 
		update the count of the associated contacts in that account field 
*/

public with sharing class ContactTriggerHandler {
    
    public static void preventDuplicateContactsControllerBeforeInsertAndUpdate(List<Contact> newRecordList){
            Set<String> emailSet=new Set<String>();
            // List<Contact> contactsToInsertList=new List<Contact>();

            for(Contact con:newRecordList){
                if(!String.isBlank(con.Email))
                        emailSet.add(con.Email);
            }
            List<Contact> filteredContactList=[SELECT Id,Email FROM Contact WHERE Email IN : emailSet];
            Map<String,Contact> emailToContactMap=new Map<String,Contact>();
            for(Contact con:filteredContactList){
                emailToContactMap.put(con.Email,con);
            }

            for(Contact contact:newRecordList){
                
                if(emailToContactMap.containsKey(contact.Email)){
                    // contactsToInsertList.add(newRecordMap.get(contactId));
                    contact.addError('Duplicate Email Found on record Id :'+emailToContactMap.get(contact.Email).Id);
                }
            }

            // if(!contactsToInsertList.isEmpty()){
            //     insert contactsToInsertList;
            // }
    }
    
    public static void updateNumberOfAccounts_insert_undelete(List<Contact> newContactList,Map<Id,Contact> oldContactMap,Boolean isDelete){
        Map<Id,Decimal> accountIdToNumberOfContactsMap=new Map<Id,Decimal>();//account ID --->> Number of Contacts 
        if(isDelete){
            for(Contact contact:oldContactMap.values()){
                if(contact.AccountId!=null){
                if(!accountIdToNumberOfContactsMap.containsKey(contact.AccountId)){
                    accountIdToNumberOfContactsMap.put(contact.AccountId,-1.0);
                }else{
                    accountIdToNumberOfContactsMap.put(contact.AccountId,accountIdToNumberOfContactsMap.get(contact.AccountId)-1.0);
                }
            }    
        }
        }
        else{
        for(Contact contact:newContactList){
            if(contact.AccountId!=null){
                if(!accountIdToNumberOfContactsMap.containsKey(contact.AccountId)){
                    accountIdToNumberOfContactsMap.put(contact.AccountId,1.0);
                }else{
                    accountIdToNumberOfContactsMap.put(contact.AccountId,accountIdToNumberOfContactsMap.get(contact.AccountId)+1.0);
                }
            }
        }
    }

        List<Account> accList=[SELECT Id,Number_Of_Contacts__c FROM Account WHERE Id IN : accountIdToNumberOfContactsMap.keySet()];
        List<Account> accListToUpdate=new List<Account>();
        for(Account acc:accList){
            Decimal prevCount=(acc.Number_Of_Contacts__c!=null)?acc.Number_Of_Contacts__c:0;
            Decimal delta=accountIdToNumberOfContactsMap.get(acc.Id);
            acc.Number_Of_Contacts__c=prevCount+delta;
            accListToUpdate.add(acc);
        }

        update accListToUpdate;
    }

    public static void updateNumberOfAccounts_update(List<Contact> newContactList,Map<Id,Contact> oldContactMap){
        Set<Id> accountIdSet=new Set<Id>();
        for(Contact newRecord:newContactList){
            Contact oldRecord=oldContactMap.get(newRecord.Id);
            if(newRecord.AccountId<>oldRecord.AccountId){
                if(newRecord.AccountId!=null)
                    accountIdSet.add(newRecord.AccountId);
                 if(oldRecord.AccountId!=null)
                    accountIdSet.add(oldRecord.AccountId);
            }
        }

        List<AggregateResult> aggregateresult_list=[SELECT COUNT(Id) totalContact,AccountId FROM Contact WHERE AccountId IN :accountIdSet GROUP BY AccountId];
        List<Account> accListToUpdate=new List<Account>();
        for(AggregateResult agr:aggregateresult_list){
            Integer totalContact=(Integer)agr.get('totalContact');
            String AccountID=(String)agr.get('AccountId');
            Account acc=new Account();
            acc.Id=AccountID;
            acc.Number_Of_Contacts__c=totalContact;
            accountIdSet.remove(AccountID);
            accListToUpdate.add(acc);
        }

        if(accountIdSet.size()>0){
            for(Id accSet:accountIdSet){
                
                Account acc=new Account();
                acc.Number_Of_Contacts__c=0.0;
                acc.Id=accSet;
                accListToUpdate.add(acc);
            
        }
        }

        update as user accListToUpdate;
    }
}