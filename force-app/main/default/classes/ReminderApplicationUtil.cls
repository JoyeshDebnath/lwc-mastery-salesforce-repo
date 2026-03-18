public with sharing class ReminderApplicationUtil {
    
    public static UserWrapper getUserInfo(){
        String userid=UserInfo.getUserId();
        String username=UserInfo.getName();
        String userEmail = UserInfo.getUserEmail();
        UserWrapper userInfo=new UserWrapper(userid,username,userEmail);
        
        
        return userInfo;
        
    }
    
    @AuraEnabled
    public static void createTodoItem(String taskStr){
        try{
            Task taskRecord = (Task) JSON.deserialize(taskStr, Task.class);
            insert taskRecord;
        }catch(Exception e ){
            throw new AuraHandledException(e.getMEssage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchTodos(){
        try{
            return [SELECT Id,Subject,Status,Priority,ActivityDate,Description FROM Task WHERE OwnerId=:UserInfo.getUserId() AND ActivityDate!=null];
        }catch(Exception e){
            throw new AuraHandledException (e.getMessage());
        }
    }
    
    public class UserWrapper{
        @AuraEnabled public String userId{get;set;}
        @AuraEnabled public String userName{get; set;}
        @AuraEnabled public String userEmail{get;set;}
        
        public UserWrapper(String userId,String userName,String userEmail){
            this.userId=userId;
            this.userName=userName;
            this.userEmail=userEmail;
        }
    }
}