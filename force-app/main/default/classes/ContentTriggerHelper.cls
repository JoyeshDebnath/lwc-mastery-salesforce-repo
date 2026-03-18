public with sharing class ContentTriggerHelper {
    public static void handle(Map<Id,ContentDocumentLink> newRecordMap){
        Set<Id> taskIdSet=new Set<Id>();
        Set<Id> eventIdSet=new Set<Id>();
        Set<Id> caseIdSet=new Set<Id>();
        
        for(ContentDocumentLink link : newRecordMap.values()){
            //check if the linkedentity id is linked to Case , Event or Task 
            if(link.LinkedEntityId.getSObjectType() == Task.getSObjectType()){
                    taskIdSet.add(link.LinkedEntityId);

            }else if(link.LinkedEntityId.getSObjectType() == Event.getSObjectType()){
                    eventIdSet.add(link.LinkedEntityId);
            }
            else if(link.LinkedEntityId.getSObjectType() == Case.getSObjectType()){
                caseIdSet.add(link.LinkedEntityId);
            }
        }
    
        //SOQL query on task object 
        if(taskIdSet?.size() > 0 ){
            List<Task> taskList=[SELECT Id,WhatId FROM Task WHERE Id IN : taskIdSet AND What.Type='Account' ];
            if(taskList?.size() > 0){
                List<ContentDocumentLink> linksToInsert=new List<ContentDocumentLink>();
                for(ContentDocumentLink link : newRecordMap.values()){
                    for(Task t: taskList){
                        if(t.Id == link.LinkedEntityId){
                                ContentDocumentLink newLink=new ContentDocumentLink();
                                newLink.ContentDocumentId=link.ContentDocumentId;
                                newLink.LinkedEntityId=t.WhatId;
                                linksToInsert.add(newLink);
                        }
                    }
                }

                insert linksToInsert;
            }
        }
        if(eventIdSet?.size() > 0){
            Map<String,String> eventIdToAccountMap=new Map<String,String>();
            for(Event evt : [SELECT Id,WhatId FROM Event WHERE Id IN : eventIdSet AND What.Type='Account']){
                    eventIdToAccountMap.put(evt.Id,evt.WhatId);
            }
            List<ContentDocumentLink> linksToInsert=new List<ContentDocumentLink>();

            for(ContentDocumentLink link : newRecordMap.values()){
                if( eventIdToAccountMap.containsKey(link.LinkedEntityId )){
                    ContentDocumentLink newLink=new ContentDocumentLink();
                    newLink.ContentDocumentId = link.LinkedEntityId;
                    newLink.LinkedEntityId = eventIdToAccountMap.get(link.LinkedEntityId);
                    linksToInsert.add(newLink);
                }
            }

            insert linksToInsert;
            
        }

            if(caseIdSet?.size() > 0){
            Map<String,String> caseIdToAccountMap=new Map<String,String>();
            for(Case cse : [SELECT Id,AccountId FROM Case WHERE Id IN : caseIdSet AND AccountId!=null]){
                    caseIdToAccountMap.put(cse.Id,cse.AccountId);
            }
            List<ContentDocumentLink> linksToInsert=new List<ContentDocumentLink>();

            for(ContentDocumentLink link : newRecordMap.values()){
                if( caseIdToAccountMap.containsKey(link.LinkedEntityId )){
                    ContentDocumentLink newLink=new ContentDocumentLink();
                    newLink.ContentDocumentId = link.LinkedEntityId;
                    newLink.LinkedEntityId = caseIdToAccountMap.get(link.LinkedEntityId);
                    linksToInsert.add(newLink);
                }
            }

            insert linksToInsert;
            
        
        }
    }
}



/*

			In content Document if we insert a file lets say in task and copy ity in related object like Account and Delete it from task then the Account file also gets deleted . If we want to prevent such scenario We have to go with the Content Version Object . 

The Field -->   "FirstPunblishLocationId"  tells about the location where the  ContentVersion was inserted ie Account , Contact , Task , Case etc . 
 
Sequence of file insert : 
Document --> version --> documentLink 

Inserting a Content Version : 

ContentVersion version=new ContentVersion();
version.Title='SampleText.txt';
version.PathOnClient='SampleText.txt';
version.VersionData=Blob.valueOf('This is a Sample Text file ');
version.FirstPublishLocationId='00TJ200000RQoduMAD';//Id of the Record Object We want to insert the file into 

insert version ; 


In ContentDocument Link triggers allows files to be deletd from both places that is both from record and related record . 

If We have a Requirement that says if the File is deleted from the Task it should nt get deletd from  the Related Account or Records page then we have to go with the Content Version approach . We need to copy the Whole content and the whole content can be retrieved from the Content Version Object . 

In Content Version we have a field FirstContentLocationId which tells the information of the first object or record the file has been published to . It gives the information  Parent object its related to ie Task , Event or Case . Query on the  Parent and find related Account and Copy the file to the related Account object from the Parent Task or case . 


ContentDistribution object  is used whenever we want to distribute or share the file externally outside Salesforce that includes public as well as protected files protected with password and usernames . 








*/