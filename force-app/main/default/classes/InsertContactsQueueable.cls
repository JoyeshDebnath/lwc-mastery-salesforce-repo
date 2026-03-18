/**
 * Insert Contacts For each Account in a specific state 
 * 
 */

public  class InsertContactsQueueable implements Queueable {
    private Contact contact;
    private String state;

    public InsertContactsQueueable(Contact contact,String state){
        this.contact=contact;
        this.state=state;
    }

    public void execute(QueueableContext context){
        List<Account> accounts=[SELECT Id FROM Account WHERE BillingState=:state LIMIT 100];
        List<Contact> contacts=new List<Contact>();

        for(Account acc:accounts){
            Contact newContact=contact.clone(false,false,false,false);
            newContact.AccountId=acc.Id;
            contacts.add(newContact);
        }

        if(contacts.size()>0){
            insert contacts;
        }
    }

}