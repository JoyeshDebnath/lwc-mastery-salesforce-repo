/**
 Scenerio 1 : Deactivate Inactive Users . Deactivate users who haven’t logged in for the past 180 days.

 */

public class DeactivateInactiveUsersBatchClass implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc ){
        return Database.getQueryLocator([SELECT Id,	IsActive,LastLoginDate FROM User WHERE IsActive=true AND LastLoginDate<:System.today().addDays(-180)]);
    }

    public static void execute(Database.BatchableContext bc,List<SObject> usersList ){
        List<User> usersListToUpdate=new List<User>();

        for(SObject user:usersList){
            User u=(User) user;
            u.IsActive=false;//decativating 
            usersListToUpdate.add(u);
        }
        if(!usersListToUpdate.isEmpty())
                update usersListToUpdate;
    }

    public static void finish(Database.BatchableContext bc ){
        System.debug('Finished the execution of decativitaing all the Inactive users in Salesforce . ');

    }
}