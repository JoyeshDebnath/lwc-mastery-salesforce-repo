public with sharing class AccountTriggerHandler {
    public static void createTask(List<Account> newAccountList){
         List<Task> tasklistToInsert=new List<Task>();
                
                for(Account account : newAccountList){
                    Task task=new Task();
                    task.Subject='Created FROM AccountTrigger';
                    task.Description='Created FROM AccountTrigger';
                    task.Priority='High';
                    task.Status='Not Started';
                    task.ActivityDate=System.today().addDays(7);
                    task.OwnerId=account.OwnerId;//Related TO ?
                    task.WhatId=account.Id;//Assigned TO ? 
                    
                    tasklistToInsert.add(task);
                }
                
                try{
                    insert tasklistToInsert;
                }catch(Exception e){
                    System.debug(e.getMessage());
                 }
    }

    public static void handleChangeOfActiveStatusInOpportunityAndContacts(Map<Id,Account> oldAccountMap,List<Account> accountList){
        Map<Id,String> accountIdToActiveStatusMap=new Map<Id,String>();
        for(Account acc:accountList){
            if(acc.Active__c!=oldAccountMap.get(acc.Id).Active__c){
                accountIdToActiveStatusMap.put(acc.Id,acc.Active__c);
            }
        }
        List<Contact> contactList=[SELECT Id,Active__c,AccountId FROM Contact WHERE AccountId IN: accountIdToActiveStatusMap.keySet()];
        List<Opportunity> oppList=[SELECT Id,Active__c,AccountId FROM Opportunity WHERE AccountId IN: accountIdToActiveStatusMap.keySet() ];
        List<Contact> conListToUpdate=new List<Contact>();
        List<Opportunity> oppListToUpdate=new List<Opportunity>(); 
        for(Contact con : contactList){
            con.Active__c=accountIdToActiveStatusMap.get(con.AccountId);
            conListToUpdate.add(con);
        }

        for(Opportunity opp:oppList){
            opp.Active__c=accountIdToActiveStatusMap.get(opp.AccountId);
            oppListToUpdate.add(opp);
        }

        try{
            update conListToUpdate;
            update oppListToUpdate;
        }catch(Exception  e){
            System.debug(e.getMessage());
        }
    }

    public static void updateOwnerIdOfRelatedContactsAndOpportunities(Map<Id,Account> oldAccMap,List<Account> newAccList){
        Map<Id,Id> accountIdToOwnerIdMap=new Map<Id,Id>();
        for(Account acc:newAccList){
            if(acc.OwnerId!=oldAccMap.get(acc.Id).OwnerId){
                accountIdToOwnerIdMap.put(acc.Id,acc.OwnerId);
            }
        }

        List<Contact> relatedConList=[SELECT Id,AccountId,OwnerId FROM Contact WHERE AccountId IN :accountIdToOwnerIdMap.keySet()];
        List<Opportunity> relatedOpportunityList=[SELECT Id,AccountId,OwnerId FROM Opportunity WHERE AccountId IN : accountIdToOwnerIdMap.keySet()];
        List<Contact> conListToUpdate=new List<Contact>();
        List<Opportunity> oppListToUpdate=new List<Opportunity>();

        for(Contact con : relatedConList){
            con.OwnerId=accountIdToOwnerIdMap.get(con.AccountId);
            conListToUpdate.add(con);
        }

        for(Opportunity opp : relatedOpportunityList){
            opp.OwnerId=accountIdToOwnerIdMap.get(opp.AccountId);
            oppListToUpdate.add(opp);
        }

        try{
            update conListToUpdate;
            update oppListToUpdate;
        }catch(System.Exception e){
            System.debug(e.getMessage());
        }

    }
    
   public static void preventDuplicate_AccountNameAndRating_InsertAndUpdateUndelete(List<Account> newAccList,Boolean isUpdate){
        Set<String> nameSet=new Set<String>();
        Set<String> ratingSet=new Set<String>();
        for(Account acc:newAccList){
            nameSet.add(acc.Name);
            ratingSet.add(acc.Rating);

        }

        List<Account> existingAccountList=[SELECT Id,Rating,Name FROM Account WHERE Name IN : nameSet AND Rating IN:ratingSet];
        Map<String,Id> nameRatingKeyToAccountIDMap=new Map<String,Id>();
        for(Account acc:existingAccountList){
            String name=acc.Name!=null?acc.Name.trim().toLowerCase():'';
            String rating=acc.Rating!=null?acc.Rating.trim().toLowerCase():'';
            String key=name+'|'+rating;
            nameRatingKeyToAccountIDMap.put(key,acc.Id);
        }

        for(Account acc:newAccList){
            String name=acc.Name!=null?acc.Name.trim().toLowerCase():'';
            String rating=acc.Rating!=null?acc.Rating.trim().toLowerCase():'';
            String key=name+'|'+rating;
            if(nameRatingKeyToAccountIDMap.containsKey(key)){
                if(isUpdate && (acc.Id==nameRatingKeyToAccountIDMap.get(key))){
                    continue;
                }else{
                    acc.addError('Another Account with same name and rating already exists in DB .... ');
                }
            }
        }
}
    
}