public with sharing class AccountContactService {

    public static void updateActiveContacts(Set<Id> accountIds){
        Map<Id, Account> accountsToUpdate = new Map<Id, Account>();
        List<AggregateResult> result = [SELECT AccountId, Count(Id) totalContacts 
                                        FROM Contact 
                                        WHERE Active__c = true AND AccountId IN: accountIds           
                                        GROUP BY AccountId];
        for(AggregateResult results : result){
            String accountId = String.valueOf(results.get('AccountId'));
            Integer totalCount = Integer.valueOf(results.get('totalContacts'));

            Account acc = new Account(Id=accountId, Active_Contacts__c=totalCount);
            accountsToUpdate.put(accountId, acc);
        }
        for(Id accId : accountIds){
            if (!accountsToUpdate.containsKey(accId)) {
                accountsToUpdate.put(accId, new Account(Id=accId, Active_Contacts__c=0));
            }
        }
        update accountsToUpdate.values();
    }
}