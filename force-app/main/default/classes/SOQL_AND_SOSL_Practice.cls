public class SOQL_AND_SOSL_Practice {
    
    // SOSL : Search Accounts By name 
    public static List<Account> searchAccountsByName(String searchKey){
        List<List<sObject>> results=[FIND :searchKey IN ALL FIELDS RETURNING Account(Id,Name)];
        return (List<Account>)results[0];
    }

    //SOSL : Search contacts by Email Domain
    public static List<Contact> searchContactsByEmailDomain(String emailDomain){
        List<List<sObject>> results=[FIND :emailDomain RETURNING Contact(Id,Email)];
        return (List<Contact>)results[0];

    }

    //SOSL : search leads by phone number 
    public static List<Lead> searchLeadsByPhone(String phonePattern){
        List<List<sObject>> results=[FIND :phonePattern  RETURNING Lead(Id,Name,Phone)];
        return (List<Lead>)results[0]; 
    }

    //serach opportunities by keyword 
    public static List<Opportunity> searchOpportunitiesByKeyword(String keyword){
        List<List<sObject>> results=[FIND :keyword RETURNING Opportunity(Id,Name,StageName)];
        return (List<Opportunity>)results[0];
    }

    //SOSL : Search cases By Subject 
    public static List<Case> searchCasesBySubject(String subject){
        List<List<sObject>> results=[FIND :subject RETURNING Case(Id,Subject,Status)];
        return (List<Case>)results[0];

    }

    //SOSL : serach across all standard objects 
    public static Map<String,List<SObject>> searchAllObjects(String keyword){
        List<List<SObject>> results=[FIND :keyword RETURNING Account(Id,Name),Contact(Id,Name),Lead(Id,Name),Opportunity(Id,Name)];
        return new Map<String,List<SObject>> {
            'Account'=>results[0],
            'Contact'=>results[1],
            'Lead'=>results[2],
            'Opportunity'=>results[3]
        };

    }
}