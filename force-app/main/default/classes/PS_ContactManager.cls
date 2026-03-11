/**
 * 
 *  target url : https://https://gepower-a-dev-ed.develop.my.salesforce.com/services/apexrest/v1/PS_ContactManager/
 */

@RestResource(urlMapping='/v1/PS_ContactManager/*')
global class PS_ContactManager {
    @httpGet
    global static List<Contact> getContactsList(){
        return [SELECT Id,FirstName,LastName,Email,Phone FROM Contact LIMIT 20];
    }
    
    @httpPost
    global static ResponseWrapper processData(InputWrapper input){
        System.debug(System.LoggingLevel.DEBUG,JSON.serializePretty(input));
        // System.debug(System.LoggingLevel.DEBUG,contactRecord);
        List<Contact> existingContacts=[SELECT Id FROM Contact WHERE Email=:input.email];
        ResponseWrapper wrapper=new ResponseWrapper();

        if(existingContacts?.size()>0){
            //do Nothing 
            // wrapper.accountRecord=accountRecord;
            wrapper.contactRecord=existingContacts.get(0);
            wrapper.status='EXISTING';
            wrapper.message='Contact Already Exisitng in the System !!!';
            return wrapper;

        }else{
            Account accountRecord=new Account(Name=input.accountName);
            insert accountRecord;
            Contact contactRecord=new Contact(
                FirstName=input.firstname,
                LastName=input.lastname,
                Email=input.email,
                AccountId=accountRecord.Id

                );
            
            insert contactRecord;
            wrapper.accountRecord=accountRecord;
            wrapper.contactRecord=contactRecord;
            wrapper.status='NEW';
            wrapper.message='New Record Created With Account ID : '+accountRecord.Id+'  AND Contact ID :  '+contactRecord.Id;
          
        }
        return  wrapper;
    }
    
    // @httpPost
    // global static ResponseWrapper processData(Account accountRecord,Contact contactRecord) {
    //     System.debug(System.LoggingLevel.DEBUG,accountRecord);
    //     System.debug(System.LoggingLevel.DEBUG,contactRecord);
    //     List<Contact> existingContacts=[SELECT Id FROM Contact WHERE Email=:contactRecord.Email];
    //     ResponseWrapper wrapper=new ResponseWrapper();

    //     if(existingContacts?.size()>0){
    //         //do Nothing 
    //         wrapper.accountRecord=accountRecord;
    //         wrapper.contactRecord=contactRecord;
    //         wrapper.status='EXISTING';
    //         wrapper.message='Contact Already Exisitng in the System !!!';
    //         return wrapper;

    //     }else{
    //         insert accountRecord;
    //         contactRecord.AccountId=accountRecord.Id;
    //         insert contactRecord;`

    //         wrapper.accountRecord=accountRecord;
    //         wrapper.contactRecord=contactRecord;
    //         wrapper.status='NEW';
    //         wrapper.message='New Record Created With Account ID : '+accountRecord.Id+'  AND Contact ID :  '+contactRecord.Id;
          
    //     }
    //     return  wrapper;


    // }

    global class ResponseWrapper{
        global Account accountRecord;
        global Contact contactRecord;
        global String status;
        global String message;
    }

    global class InputWrapper{
        global String accountName;
        global String firstname;
        global String lastname;
        global String email;
    }
}