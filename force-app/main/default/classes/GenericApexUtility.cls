public  class GenericApexUtility {
    
   /**
    * "
    Suppose you are building a recruiter dashboard in Salesforce. 
    The recruiter can select filters like Candidate Name, Position, Status, and Experience. 
    Not all filters are mandatory. 
    How would you design a solution so that the query dynamically adjusts based on the recruiter’s input?
    "
     */ 

     public static List<Job_Application__c> searchApplicationsFunc(String candidateName,String position , String status,Integer experience ){
        String baseQuery  = 'SELECT Id,candidate_name__c,Experience__c,position__c,Status__c FROM Job_Application__c WHERE Id!=null';
        if(candidateName!=null){
            baseQuery += ' AND candidate_name__c LIKE \'%' + String.escapeSingleQuotes(candidateName) + '%\''; 
        }
        if (position!=null){
            baseQuery += ' AND position__c=\''+String.escapeSingleQuotes(position)+'\'';
        }
        if(status!=null){
            baseQuery+=' AND Status__c=\''+String.escapeSingleQuotes(status)+'\'';
        }
        if(experience!=null){
            baseQuery+=' AND Experience__c >= '+experience;
        }
        System.debug('Query Formed => '+baseQuery);
        return Database.query(baseQuery);
     }
}