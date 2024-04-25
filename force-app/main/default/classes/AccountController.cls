public class AccountController {
    public static List<Account> insertAccounts(List<Account> accountToInsert){
        insert accountToInsert;
        return accountToInsert;
    }
    
    public static Account insertSingleAccount(Account accountToInsert){
        insert accountToInsert;
        return accountToInsert;
    }
    
    public static List<Account> getAllAccounts(){
        List<Account> accounts  = [SELECT Name, Id, Phone FROM Account];
        return accounts;
    }
    
    public static void printAllAccounts(){
        List <Account> accounts = getAllAccounts();
        for(Account account: accounts){
            System.debug('Account Name is'+account.Name+' Account Phone is'+account.Phone);
        }
    }
    
    public static Integer getAccountSize(){
        List <Account> accounts = getAllAccounts();
        return accounts.size();
    }

    public static void updateAvgCaseResolutionDays(List<Id> accountIds){
        Map<Id, Integer> accountTotalCaseMap = new Map<Id, Integer>();
        Map<Id, Integer> accountTotalCaseDaysMap = new Map<Id, Integer>();
        // retrive all the cases for this account
        // get resolution days for each account (ClosedDate - CreatedDate)
        for(Case caseObj : [SELECT Id, CreatedDate, ClosedDate, AccountId
                             FROM Case
                             WHERE IsClosed=true
                            	AND AccountId IN : accountIds]){
            // increase number of cases
            if(!accountTotalCaseMap.containsKey(caseObj.AccountId)){
                      accountTotalCaseMap.put(caseObj.AccountId, 0); 
                	  accountTotalCaseDaysMap.put(caseObj.AccountId, 0);
            }
            Integer totalCases = accountTotalCaseMap.get(caseObj.AccountId);
            totalCases++;
            accountTotalCaseMap.put(caseObj.AccountId, totalCases); 
            Integer totalDays = accountTotalCaseDaysMap.get(caseObj.AccountId);
			totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
			accountTotalCaseDaysMap.put(caseObj.AccountId, totalDays); 
           
        }
        List<Account> accToUpdate = new List<Account>();
        for(Id accountId:accountTotalCaseMap.keySet()){
			Decimal resolutionDays = accountTotalCaseDaysMap.get(accountId)/accountTotalCaseMap.get(accountId);    
            accToUpdate.add(new Account(Id=accountId, Avg_Case_Resolution_Days__c = resolutionDays));
        }
       
        
        update accToUpdate;
    }
}