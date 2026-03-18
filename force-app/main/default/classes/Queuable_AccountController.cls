public with sharing class Queuable_AccountController implements System.Queueable {

    public void execute(System.QueueableContext context) {
        //query the Account 
        List<Account> accList=[SELECT Id,Name,Phone,OwnerId FROM Account WHERE Phone=null ];
        List<Task> tasksList=new List<Task>();
        for(Account acc : accList) {
            Task task=new Task();
            task.Subject='Follow Up to update the Account Phone number ';
            task.Priority='High';
            task.OwnerId=acc.OwnerId;
            task.Status='Not Started';
            task.WhatId=acc.Id;

            tasksList.add(task);
        }

        try{
            insert tasksList;
        }catch(Exception e){
            System.debug('Error While creating tasks :'+tasksList);
        }
    }
    
}