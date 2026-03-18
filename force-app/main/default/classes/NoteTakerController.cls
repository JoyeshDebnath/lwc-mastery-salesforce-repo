public without sharing class NoteTakerController {
    public NoteTakerController() {

    }
    //cretae a new note 
    @AuraEnabled
    public static Boolean createNoteRecord(String title,String description){
        try{
             if(!String.isBlank(title)){
                My_Notes__c note=new My_Notes__c(
                    Name=title,
                    Note_Description__c=description
                );
                insert note;
                return true;
             }   
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        return false;
    }
    //Fetch notes 
    @AuraEnabled(cacheable=true)
    public static List<My_Notes__c>  fetchNotes(){
        try {
            List<My_Notes__c> notes=[SELECT Id,Name, Note_Description__c,LastModifiedDate FROM My_Notes__c ORDER BY LastModifiedDate desc];
            return notes;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    //update note 
    @AuraEnabled
    public static Boolean updateNote(String recordId,String name,String description ){
        try {
            My_Notes__c note=[SELECT Id,Name,Note_Description__c FROM My_Notes__c WHERE Id=:recordId];
            note.Name=name;
            note.Note_Description__c=description;
            update note;
            return true;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        // return false;
    }

    //delete note 
    @AuraEnabled
    public static Boolean  deleteNote(String recordId){
        try {
            My_Notes__c note=[SELECT Id FROM My_Notes__c WHERE Id=:recordId];
            delete note;
            return true;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}