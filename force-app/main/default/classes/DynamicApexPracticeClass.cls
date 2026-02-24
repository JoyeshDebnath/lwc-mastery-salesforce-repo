public class DynamicApexPracticeClass {
    
    public static void function_demoOne(){
        sObject s=new Account();
        System.assert(s.getsObjectType()==Account.sObjectType);//verigy if the generic SObject is an Account sObject 
        Schema.DescribeSObjectResult dsr = Account.sObjectType.getDescribe();
        Schema.DescribeFieldResult dfr = Schema.sObjectType.Account.fields.Name;
        System.assert(dfr.getSObjectField()==Account.Name);


    }

    public static void demofunction2(){
        //Returns a Token 
        //way1  
        Schema.sObjectType s=Account.sObjectType;
        //Way 2 
        Account acc=new Account();
        Schema.sObjectType t=acc.getSObjectType();
        System.debug('Tokens Returnd= '+s+'   '+t);
        //------- ----------------------------------------------------
        SObject s2=Database.query('SELECT Id FROM Contact LIMIT 1');
        System.assertEquals(Contact.sObjectType,s2.getSObjectType());
//-------------------------------------------------------------------------
        List<sObject> sObjectList=new Account[]{};
        System.assertEquals(sObjectList.getSObjectType(),Account.sObjectType);

        Schema.DescribeSObjectResult dsr1 = Account.sObjectType.getDescribe();
        Schema.DescribeSObjectResult dsr2 = Schema.SObjectType.Account;
        System.debug('dsr1=>'+dsr1+'  dsr2=>'+dsr2);
        

    }
}