@isTest
public  class FutureDemoTest {
    
    @isTest
    private static void test_performCalculationOnForcast(){
        Opportunity opp=new Opportunity(
            Name='Test Opp',
            StageName='Prospecting',
            CloseDate=Date.today().addDays(30),
            Amount=450
        );
        insert opp;

        Test.startTest();
            FutureDemo.performCalculationOnForcast(new List<Id>{opp.Id});
        Test.stopTest();
        Opportunity oppCheck=[SELECT Id,Name,Description FROM Opportunity WHERE Id=:opp.Id ];
        System.assert(oppCheck.Description.contains('Forcast Recalculated at :'));
    }

}