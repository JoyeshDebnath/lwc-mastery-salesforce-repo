/**
* SObject demo
**/

public class DynamicSObjectPractice {
	
	public static SObject createRecord ( String objectname,Map<String,Object> fieldValues){
			Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectname);
			if(objType==null){
				throw new IllegalArgumentException('Invalid Objectname '+objectname);

			}
			//create new instance 
			SObject record=objType.newSObject(); 
			for(String fieldname : fieldValues.keySet()){
					if(record.getSObjectType().getDescribe().fields.getMap().containsKey(fieldname)){
						record.put(fieldname,fieldValues.get(fieldname));
					}else{
						System.debug('Field name not found ......'+fieldname);

					}
			}
			return record ; 
	}
}