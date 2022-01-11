@isTest
public class ExternalAccountsRESTTest {
    
    @isTest static void getAccountsTest(){
        Test.setMock(HttpCalloutMock.class, new MockHTTPExternalAccountsREST());
        String responseBody = ExternalAccountsREST.getAccounts(1);
        List<Account> accList = (List<Account>)JSON.deserialize(responseBody, List<Account>.class);
        System.assert(!accList.isEmpty());
    }
    
    @isTest static void getRecordsTest(){
        List<Account> accList = new List<Account>();
        List<String> accNames = new List<String>();
 
        for(integer i = 0; i < 100; i++){
            Account acc = new Account();
        	acc.Name = 'Account ' + i;
        	acc.AccountNumber = '00'+i;
            accList.add(acc);
            accNames.add(acc.Name);
        }
        
        insert accList;
        List<Account> recordList = ExternalAccountsREST.getRecords(accNames);
        System.assert(!recordList.isEmpty());
    }
}