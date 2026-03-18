@isTest
private class LeadCalloutHandlerTest {
    @isTest
    static void testSendLeadData(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class,new LeadCalloutMock());
        Lead testLead=new Lead(FirstName='Test',LastName='Lead',Company='TestCompany',Email='test@example.com');
        insert testLead;
        FutureApex1.sendLeadData(testLead.Id, testLead.Email);

        Test.stopTest();

    }
}