public class OpportunityTriggerHelper {
   
    /*
            Q1 > when a opportunity related to an Account gets created ,Updated or Deleted .. calculate the sum of all Opportunity Amounts for that Account and store it in a custom field Total_Opportunity_Amount__c on Account.
            •  Trigger on Opportunity (after insert, after update, after delete, after undelete). 
            •  Collect all affected Account IDs. 
            •  Query all Opportunities for those Accounts. 
            •  Aggregate the sum and update the Account. 
            

*/
    public static void calculateAndUpdateTotalAmountOnAccount(Map<Id,Opportunity> oldOpsMap,List<Opportunity> newOpsList){
    //in case of insert - update - undelete 
    Set<Id> accIds=new Set<Id>();
        if(newOpsList!=null){
                for(Opportunity op:newOpsList){
                    if(op.AccountId!=null ){
                        accIds.add(op.AccountId);
                    }
                }
        }
    //for old record map --> update | delete 
        if(oldOpsMap!=null){
                for(Opportunity op : (List<Opportunity>)oldOpsMap.values()){
                    if(op.AccountId!=null){
                        accIds.add(op.AccountId);
                    }
                }
       }
      
        if(accIds.isEmpty()){
            return;
        }
    //Aggregate SOQL 
    List<AggregateResult> agr=[SELECT AccountId,SUM(Amount) totalAmt FROM Opportunity WHERE AccountId IN : accIds GROUP BY AccountId];
    Map<Id,Decimal> totalsMap=new Map<Id,Decimal>();
    List<Account> accntsToUpdate=new List<Account>();
    for(AggregateResult ag:agr){
        totalsMap.put((Id)ag.get('AccountId'),(Decimal)ag.get('totalAmt'));
    }

    //update the total Amount on exisiting account in Salesforce .. 
    for(Id accId:accIds){
        Account acc=new Account();
        acc.Id=accId;
        acc.Total_Amount__c=totalsMap.containsKey(accId)? totalsMap.get(accId):0;
        
        accntsToUpdate.add(acc);
    }

    if(!accntsToUpdate.isEmpty()){
        update accntsToUpdate;
    }


}
    /**
     * Scenario

        When the opportunity is updated to closed won, we have to send the mail to its account owner informing them about the opportunity details.
     */
    public static void sendMailToAccOwnerAfterUpdate(Map<Id,Opportunity> newOppRecords,Map<Id,Opportunity> oldOppRecords){
            Set<Id> oppsId=new Set<Id>();

            for(Opportunity opp : newOppRecords.values()){
                if(opp.StageName=='Closed Won' && oldOppRecords.get(opp.Id).StageName!='Closed Won'){
                    oppsId.add(opp.Id);
                
                }
            }

            sendMailToAccOwnerAfterUpdate_util(oppsId);
    }

    @future 
    public static void sendMailToAccOwnerAfterUpdate_util(Set<Id> oppsIds){
        List<Messaging.SingleEmailMessage> emailList=new List<Messaging.SingleEmailMessage>();

        for(Opportunity opp : [SELECT Id,AccountId,Account.Name,Name,Account.OwnerId,Account.Owner.Name,Account.Owner.Email  
                                                FROM Opportunity WHERE Id IN : oppsIds]){
            
            List<String> toAddress=new List<String>();
            toAddress.add(opp.Account.Owner.Email);
            Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddress);
            mail.setSubject('Opportunity is Updated To Closed Won');
            mail.setHtmlBody('Dear '+ opp.Account.Owner.Name+',' +'<br>'+'<br>'+
                                'The Opportunity ' +opp.Name +' which is linked to '+ opp.Account.Name+' is closed won '+'<br>'+'<br>');

            emailList.add(mail);
        }

        try{
                Messaging.sendEmail(emailList);
        }catch(Exception e){
            System.debug('Error Ocurred While Sending Email '+e.getMessage());
            System.debug('Error ocurred at line number : '+e.getLineNumber());
        }
    }

    /**
        *  Develop an Apex Trigger so that when an opportunity is created and the account is blank,
         create a task under Opportunity. 
        ● Subject- Opportunity is created without Account
        ● Description- Opportunity is created without Account, Please assign the Correct
        account to Opportunity.
        ● DueDate-Todays Date + 7
        ● Status- Not Started
        ● Priority- High
        ● Related To (What)- Opportunity Id
        ● Assigned To (OwnerId)- Opportunity Owner Id
     */
    public static void createTaskUnderOpportunityWhenAccountIsBlank(List<Opportunity> oppList){
        List<Task> taskListToInsert = new List<Task>();

        for(Opportunity opp : oppList){
            if(opp.AccountId==null){
                Task task=new Task();
                task.Subject='Opportunity is Created Without Account';
                task.Priority='High';
                task.Description='Opportunity is created without Account, Please assign the Correct account to Opportunity.';
                task.Status='Not Started';
                task.ActivityDate=System.today().addDays(7);
                task.WhatId=opp.Id; 
                task.OwnerId=opp.OwnerId;//asigned to 
                taskListToInsert.add(task);
            }

        }

        if(!taskListToInsert.isEmpty()){
            insert taskListToInsert;
        }
    }

    
}