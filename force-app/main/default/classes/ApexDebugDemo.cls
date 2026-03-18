public class ApexDebugDemo {
    public static void dynamicSOQL(){
        String name = '%Updated using%';
        List<sObject> sObjectList=Database.query('SELECT Id,Name,Industry FROM Account WHERE Name LIKE : name ');
        System.debug('SOBJECT LIST:'+sObjectList);
    }
}