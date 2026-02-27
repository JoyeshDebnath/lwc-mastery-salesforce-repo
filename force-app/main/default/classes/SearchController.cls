/**
 * 
 * 
 */

public  class SearchController {
   @AuraEnabled
   public static List<sObject> search(String objectName,List<String> fields,String searchTerm){
        String searchKeyword=searchTerm+'*';
        String returningQuery='';
        returningQuery=objectName+' '
   }
}