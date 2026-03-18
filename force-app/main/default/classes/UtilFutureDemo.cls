public  class UtilFutureDemo {
    @future
    public static void insertUserMethod(){
        Profile p=[SELECT Id,Name FROM Profile WHERE Name='Standard Platform User'];
        UserRole r=[SELECT Id,Name FROM UserRole WHERE Name='CEO'];

        User user=new User(
            Alias='apexes',
            Email='apex@apexhours.com',
            EmailEncodingKey='UTF-8',
            LastName='Hours',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            ProfileId=p.Id,
            UserRoleId=r.Id,
            TimeZoneSidKey='America/Los_Angeles',
            Username='apex@apexhours.com'
        );

        insert user;
    }
}