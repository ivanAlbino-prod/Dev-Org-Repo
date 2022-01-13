public class ObjectManager {
    static MockInterface instance = new MockInterface();	
    public static List<Account_Ext__x> records(List<Account_Ext__x> records){
       	return instance.passThrough(records);     
    }
    
    @TestVisible static void setMock(MockInterface mock){ 
        instance = mock;
    }  
}