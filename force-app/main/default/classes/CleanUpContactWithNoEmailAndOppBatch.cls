public  class CleanUpContactWithNoEmailAndOppBatch implements Database.Batchable<SOBject>{
   public static Database.QueryLocator start(Database.BatchableContext bc ){
    return Database.getQueryLocator([SELECT Id,FirstName,LastName,Email FROM Contact WHERE Email=NULL AND Id NOT IN (SELECT  ContactId FROM Opportunity WHERE ContactId!=NULL)]);
   }

   public static void execute(Database.BatchableContext bc , List<SObject> conList){
    List<Contact> conListToBeDeleted=new List<Contact>();
    for(SObject con:conList){
        Contact c=(Contact)con;
        conListToBeDeleted.add(c);
    } 

    delete conListToBeDeleted;
   }

   public static void finish (Database.BatchableContext bc ){
    System.debug('Finished execuation ....');
   }
}