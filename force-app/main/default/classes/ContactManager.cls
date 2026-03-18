public with sharing class ContactManager {
        @future
        public static void createUser(Set<Id> newRecordsId){
                List<Contact> newRecords=[SELECT  FirstName,LastName,Email,Phone FROM Contact WHERE Id IN : newRecordsId];
                List<User> userlist=new List<User>();
                Profile p=[SELECT Id FROM Profile WHERE NAme = 'Standard Platform User' LIMIT 1];
                UserRole role=[SELECT Id FROM UserRole WHERE Name='Eastern Sales Team' LIMIT 1];
                
                for(Contact con : newRecords){
                        String orgID=UserInfo.getOrganizationId();
                        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
                        Integer randomInt=Integer.valueOf(math.rint(math.random()*1000000));
                        String uniqueName=orgID + dateString + randomInt;
                        
                        User tempUser=new User(
                                FirstName=con.FirstName,
                        LastName=con.LastName,
                        email=con.Email,
                        UserName=uniqueName+'@sfdc'+orgID+'.org',
                        EmailEncodingKey='ISO-8859-1',
                        Alias=uniqueName.substring(18,23),
                        TimeZoneSidKey='America/Los_Angeles',
                        LocaleSidKey='en_US',
                        LanguageLocaleKey='en_US',
                        ProfileId=p.Id
                                );
                        
                        tempUser.UserRoleId=role.Id;
                        
                        
                        userlist.add(tempUser);
                }
                insert userlist;
        }
        
        @future
        public static void dummyMethod(){
                System.debug('Its a dyummy Future Method....');
        }
}