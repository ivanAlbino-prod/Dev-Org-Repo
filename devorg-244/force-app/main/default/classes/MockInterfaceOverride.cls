public class MockInterfaceOverride extends MockInterface{
    final List<Account_Ext__x> objectList;

    public MockInterfaceOverride(List<Account_Ext__x> mockRecords){
        this.objectList = mockRecords;
    }

    public override List<Account_Ext__x> passThrough(List<Account_Ext__x> records){
        return objectList; 
    }
}