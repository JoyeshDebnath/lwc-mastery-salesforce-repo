public  class LinkedInTokenManager {
    public static void storeToken(String token){
        LinkedIN_Token__c tokenRec=new LinkedIN_Token__c();
        tokenRec.Access_Token__c=token;
        tokenRec.User__c=UserInfo.getUserId();
        tokenRec.Expires_At__c=System.now().addDays(14);

        upsert tokenRec;
    }

    public static String getToken(){
        return ([SELECT Id,Access_Token__c,Expires_At__c,User__c FROM LinkedIN_Token__c  
                        WHERE User__c=:UserInfo.getUserId() 
                        LIMIT 1]).Access_Token__c;
    }
}