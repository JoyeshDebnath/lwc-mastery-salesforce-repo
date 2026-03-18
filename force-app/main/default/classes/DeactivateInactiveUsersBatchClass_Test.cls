@isTest
private class DeactivateInactiveUsersBatchClass_Test {
    @TestSetup
    static void setUpUserData(){
           List<User> users = new List<User>();
        for (Integer i = 0; i < 10; i++) {
            users.add(new User(
                Username = 'testuser' + i + '@example.com',
                Alias = 'tuser' + i,
                Email = 'testuser' + i + '@example.com',
                ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                IsActive = true
            ));
        }
        insert users;
    }

    static testMethod void testBatch() {
        Test.startTest();
        Database.executeBatch(new DeactivateInactiveUsersBatchClass(), 5);
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM User WHERE IsActive = false];
        System.assertEquals(10, count);
    }
}