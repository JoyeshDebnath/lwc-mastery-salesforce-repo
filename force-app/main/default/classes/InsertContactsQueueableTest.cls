@isTest
private class InsertContactsQueueableTest {
    @isTest
    static void testInsertContacts(){
        List<Account> accounts=new List<Account>();
        for(integer i=0;i<50;i++){
            Account acc=new Account(
                Name='Account'+' '+i,
                BillingState='CA'
            );
            accounts.add(acc);
        }
        insert accounts;

        //Create a test contact 
        Contact contact=new Contact(FirstName='Test',LastName='contat',Email='test@gmail.com');

        Test.startTest();
        ID jobID=System.enqueueJob(new InsertContactsQueueable(contact,'CA'));
        Test.stopTest();

        List<Contact> conList=[SELECT Id,AccountId FROM Contact WHERE AccountId IN :accounts];
        System.assertEquals(50, conList.size());
    }

}