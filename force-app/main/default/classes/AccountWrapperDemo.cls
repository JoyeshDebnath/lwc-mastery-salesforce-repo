/**
* @File Name : AccountWrapperDemo.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : March 11, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | March 11, 2025 |   | Initial Version
**/

public with sharing class AccountWrapperDemo {
	@AuraEnabled(cacheable=true)
	public static List<AccountWrapper> getAccountWithContacts(){
		List<AccountWrapper> wrapList=new List<AccountWrapper>();
		List<Account> accList =[SELECT Id,Name, (SELECT Id,FirstName,LastName,Email,Phone FROM Contacts) FROM Account LIMIT 10];

		for(Account acc:accList){
			wrapList.add(new AccountWrapper(acc,acc.Contacts));
		}
		System.debug('Wrapper List Result :'+wrapList);
		return wrapList;

	}

	public class AccountWrapper{
		@AuraEnabled public Account accRecord {get;set;}
		@AuraEnabled public List<Contact> contactList{get;set;} 

		public AccountWrapper(Account accRecord,List<Contact> contactList){
			this.accRecord=accRecord;
			this.contactList=contactList;
		}
	}
}