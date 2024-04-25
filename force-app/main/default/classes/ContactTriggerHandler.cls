public with sharing class ContactTriggerHandler {
    
    public static void afterInsertOperation(List<Contact> newContacts){
        Set<Id> accountIds = new Set<Id>();
        for (Contact con : newContacts) {
            if (String.isNotBlank(con.AccountId)) {
                accountIds.add(con.AccountId);
            }
        }
        AccountContactService.updateActiveContacts(accountIds);
    }

    public static void afterUpdateOperation(List<Contact> newContacts, Map<Id, Contact> oldContactRecordsMap){
        Set<Id> accountIds = new Set<Id>();
        for (Contact con : newContacts) {
            if (String.isNotBlank(con.AccountId) && oldContactRecordsMap.get(con.Id).Active__c != con.Active__c) {
                accountIds.add(con.AccountId);
            }else if(oldContactRecordsMap.get(con.Id).AccountId != con.AccountId){
                accountIds.add(con.AccountId);
                accountIds.add(oldContactRecordsMap.get(con.Id).AccountId);
            }
        }
        AccountContactService.updateActiveContacts(accountIds);
    }

    public static void afterDeteleOperation(List<Contact> oldContacts){
        Set<Id> accountIds = new Set<Id>();
        for (Contact con : oldContacts) {
            if (String.isNotBlank(con.AccountId)) {
                accountIds.add(con.AccountId);
            }
        }
        AccountContactService.updateActiveContacts(accountIds);
    }

    public static void afterUndeleteOperation(List<Contact> oldContacts){
        Set<Id> accountIds = new Set<Id>();
        for (Contact con : oldContacts) {
            if (String.isNotBlank(con.AccountId)) {
                accountIds.add(con.AccountId);
            }
        }
        AccountContactService.updateActiveContacts(accountIds);
    }
}