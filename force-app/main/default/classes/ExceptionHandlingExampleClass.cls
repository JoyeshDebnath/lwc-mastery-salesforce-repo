public with sharing class ExceptionHandlingExampleClass {
    public void dmlExceptionDemo (){
        //dml1 exception
        try{
            Contact contact=new Contact ();
            insert contact;
            
        }catch(DmlException e){
            System.debug('The following Exception has occurred :'+e.getMessage());
        }
        
    }
    public void listExceptionDemo(){
        try{
            List<Integer> li=new List<Integer>();
            li.add(123);
            li.add(636);
            Integer i0=li[0];
            Integer i2=li[2];
        }catch(ListException e){
            System.debug('The following exception has occurred :'+e.getMessage());
        }
    }
    
    public void soqlQueryExceptionDemo(){
        try{
            List<Contact> contactList=[SELECT Id,FirstName,LastName,Email,Phone FROM Contact WHERE Name='WWW'];
            System.debug('Contact Records Size = '+contactList.size());
            
            Contact con=[SELECT Id,FirstName,LastName,Email,Phone FROM Contact WHERE Name='WWW' LIMIT 1];
        }catch(Exception e){
            System.debug('EXCEPTION CAUSE ='+e.getCause());
            System.debug('EXCEPTION LINE NUMBER ='+e.getLineNumber());
            System.debug('EXCEPTION MESSAGE ='+e.getMessage());
            System.debug('EXCEPTION STACK TRACE STRING ='+e.getStackTraceString());
            System.debug('EXCEPTION CAUSE ='+e.getCause());
            System.debug('EXCEPTION TYPE ='+e.getTypeName());
        }
    }
    
    public void sObjectExceptionDemo(){
        try{
            Account acc=new Account(
                Name='demo Acc'
                );
            insert acc;
            Account  account=[SELECT Name FROM Account WHERE Id=:acc.Id] ;
            String Rating=acc.Rating;
            
            
        }catch(SObjectException e ){
            System.debug('The exception occurred : '+e.getMEssage());
        }
    }
}