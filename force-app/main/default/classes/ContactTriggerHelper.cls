public class ContactTriggerHelper {
    
    /*Count the total Contacts under Related Account .... */
    public static void countRelatedContactsOnAccount(Map<Id,Contact> oldContactMap,List<Contact> newContactsList){
    Set<Id> accIds=new Set<Id>();
    //insert - update - undelete 
    if(newContactsList!=null){
        for(Contact con:newContactsList){
            if(con.AccountId!=null){
                accIds.add(con.AccountId);
            }
        }
    }
    // update -- delete 
    if(oldContactMap!=null){
        for(Contact con:(List<Contact>)oldContactMap.values()){
                if(con.AccountId!=null){
                    accIds.add(con.AccountId);
                }
        }
    }

    if(accIds.isEmpty()){
        return ;
    }

    List<AggregateResult> agr=[SELECT AccountId,COUNT(Id) totalContacts FROM Contact WHERE AccountId IN : accIds GROUP BY AccountId];
    Map<Id,Integer>  totalContactsMap=new Map<Id,Integer>();
    for(AggregateResult ag: agr){
        Id accountId=(Id)ag.get('AccountId');
        Integer totalContactsCount=(Integer)ag.get('totalContacts');
        totalContactsMap.put(accountId,totalContactsCount);
    }
        List<Account> accountListToUpdate=new List<Account>();
    for(Id accId:accIds){
        Account acc=new Account();
        acc.Id=accId;
        acc.Number_Of_Contacts__c=totalContactsMap.containsKey(accId)?totalContactsMap.get(accId):0;
        accountListToUpdate.add(acc);
    }

    if(!accountListToUpdate.isEmpty()){
        update accountListToUpdate;
    }
}

    public static void countContactsAfterUpdate(Map<Id,Contact> oldMap,Map<Id,Contact> newMap){
            Set<Id> accountIdSet=new Set<Id>();
            for(Contact newContact : newMap.values()){
                if(newContact.AccountId != oldMap.get(newContact.Id).AccountId ){
                    accountIdSet.add(newContact.AccountId);
                    accountIdSet.add(oldMap.get(newContact.Id).AccountId);
                }
            }

            List<AggregateResult> aggrs=[SELECT COUNT(Id),AccountId FROM Contact WHERE AccountId IN : accountIdSet GROUP BY AccountId];
            List<Account> accountsList=new List<Account>();

            for(AggregateResult agg: aggrs){
                Id accountId = (Id)agg.get('AccountId');
            Integer contactCount = (Integer)agg.get('expr0');

            Account acc=new Account(Id=accountId,Number_Of_Contacts__c=contactCount);
            accountsList.add(acc);
            }

            update  accountsList;
    }

    public static void countContacts(List<Contact> contactList){
        Set<Id> accountIds = new Set<Id>();
        Map<Id,Account> accIdToAccMap=new Map<Id,Account>();
        for(Contact contact : contactList){
            if(contact.AccountId!=null){
                // accountIds.add(contact.AccountId);
                accIdToAccMap.put(contact.AccountId,new Account(Id=contact.AccountId,Number_Of_Contacts__c=0));
            }
        }

        List<AggregateResult> aggList=[SELECT COUNT(Id),AccountId FROM Contact WHERE accountId IN : accIdToAccMap.keySet()  GROUP BY accountId];
        // Map<Id,Account> accountMap=new Map<Id,Account>();

        for(AggregateResult agg : aggList){
            Id accountId = (Id)agg.get('AccountId');
            Integer contactCount = (Integer)agg.get('expr0');

            // Account acc=new Account(Id=accountId,Number_Of_Contacts__c=contactCount);
            Account acc = accIdToAccMap.get(accountId);
            acc.Number_Of_Contacts__c=contactCount;
            accIdToAccMap.put(accountId, acc);


        }
        update accIdToAccMap.values();
    }



}