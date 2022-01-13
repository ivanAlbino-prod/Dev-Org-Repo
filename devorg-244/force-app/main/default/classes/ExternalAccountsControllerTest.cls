@isTest
public with sharing class ExternalAccountsControllerTest {
    
    @testSetup static void setup(){
        List<Account> accList = new List<Account>();

        for(integer i = 0; i < 100; i++){
            Account acc = new Account();
            acc.Name = 'Account ' + i;
            acc.AccountNumber = '00'+i;
            accList.add(acc);
        }

        insert accList;

    }
    @isTest static void getAccountsTest(){
        List<Account> accList = ExternalAccountsController.getAccounts();
        System.assert(!accList.isEmpty());
    }

    @isTest static void getExternalAccountsTest(){

        List<Account_Ext__x> extAccList = new List<Account_Ext__x>();
         for(integer i = 0; i < 100; i++){
            Account_Ext__x exAcc = new Account_Ext__x();
            exAcc.Name__c = 'EXT Account ' + i;
            exAcc.AccountNumber__c = '00'+i;
            extAccList.add(exAcc); 
        }
		
        System.debug('extAccList ' + extAccList);
        ObjectManager.setMock(new MockInterfaceOverride(extAccList)); 
        Test.startTest();
        List<Account_Ext__x> extRecordsList =  ObjectManager.records(ExternalAccountsController.getExtAccounts());
        System.debug('extRecordsList ' + extRecordsList);
        System.assert(!extRecordsList.isEmpty());
        Test.stopTest();
    } 
}