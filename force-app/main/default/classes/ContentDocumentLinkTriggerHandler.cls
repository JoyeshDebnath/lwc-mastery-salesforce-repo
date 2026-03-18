public class ContentDocumentLinkTriggerHandler {
    public static void copyFileToAccount(List<ContentDocumentLink> newLinkRecords){
       Set<Id> taskIdSet=new Set<Id>();
            Map<Id,ContentDocumentLink> linkedEntityIdToContentDocumentLinkMap=new Map<Id,ContentDocumentLink>();
            List<ContentDocumentLink> newContentDocumentLinkListToInsert=new List<ContentDocumentLink>();
        for(ContentDocumentLink link : newLinkRecords){
            //return type for getSObjectType()  ==>> Schema.SObjectType 
            

            if(link.LinkedEntityId.getSObjectType() == Case.getSObjectType()){
                   linkedEntityIdToContentDocumentLinkMap.put(link.LinkedEntityId,link);
            }else if (link.LinkedEntityId.getSObjectType() == Event.getSObjectType()){
                linkedEntityIdToContentDocumentLinkMap.put(link.LinkedEntityId,link);
            }else if (link.LinkedEntityId.getSObjectType() == Task.getSObjectType()){
                System.debug('Executed');
                 taskIdSet.add(link.LinkedEntityId);
                 linkedEntityIdToContentDocumentLinkMap.put(link.LinkedEntityId,link);
            }
        }

        System.debug('Map printed :'+linkedEntityIdToContentDocumentLinkMap);

        if(!taskIdSet.isEmpty()){
            List<Task> taskList=[SELECT Id,WhatId FROM Task WHERE Id IN : taskIdSet AND What.Type='Account'];
            if(!taskList.isEmpty()){
                System.debug('Executed 2 ');
                for(Task t:taskList){
                    ContentDocumentLink newLink=new ContentDocumentLink();
                    newLink.ContentDocumentId=linkedEntityIdToContentDocumentLinkMap.get(t.Id).ContentDocumentId;
                    newLink.LinkedEntityId=t.WhatId;
                    newContentDocumentLinkListToInsert.add(newLink);
                }
            }
        }
        insert newContentDocumentLinkListToInsert;

    } 
}