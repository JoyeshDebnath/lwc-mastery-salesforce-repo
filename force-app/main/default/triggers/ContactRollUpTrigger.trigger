//Roll up Summary - Write a trigger To Update the Total_Amount__c on Account Object whenever the Amount__c is changed in Contact object 
trigger ContactRollUpTrigger on Contact (after insert,after update,after delete,after undelete) {
    //Step 1 : colllect the Parent IDs 
    Set<Id> accIds=new Set<Id>();
    if(Trigger.isAfter  && (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete)){
        for(Contact con : Trigger.New){
            if(con.AccountId != null){
                accIds.add(con.AccountId);
            }
        }
    }
    
    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isDelete)){
        for(Contact con : Trigger.Old){
            if(con.AccountId != null){
                accIds.add(con.AccountId);
            }
        }
    }
    
    if(!accIds.isEmpty()){
        List<Account> accToUpdate = new List<Account>();
        List<AggregateResult> aggregateConListRes=[SELECT AccountId,SUM(Amount__c) totalAmount FROM Contact 
                                           WHERE AccountId IN : accIds 
                                           GROUP BY AccountId] ;
        
        Map<Id,Decimal> accIdToTotalMap = new Map<Id,Decimal>();
        
        for(AggregateResult res : aggregateConListRes){
            accIdToTotalMap.put((Id)res.get('AccountId'),(Decimal)res.get('totalAmount'));
            
        }
        
        for(Id accountId : accIds){
            Account  acc=new Account();
            acc.Id=accountId;
            acc.Total_Amount__c= accIdToTotalMap.containsKey(accountId) ? accIdToTotalMap.get(accountId) : 0 ;
            accToUpdate.add(acc);
        }
        
        if(!accToUpdate.isEmpty()){
            try{
                UPDATE accToUpdate;
            }catch(Exception  e ){
                System.debug('Error While Updating '+e.getMessage());
            }
        }
    }
    
}