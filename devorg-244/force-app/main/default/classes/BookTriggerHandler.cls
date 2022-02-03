public class BookTriggerHandler extends TriggerHandler{

    public override void afterUpdate(){
        Set<String> bookNames = new Set<String>();
        Map<String,Book__c> bookMap = new Map<String,Book__c>();
        for(Book__c book : (List<Book__c>)Trigger.new){
            bookNames.add(book.Name);
            bookMap.put(book.Name, book);
        }
        List<Book_Ext__x> extBookList = [SELECT Id, Name__c FROM Book_Ext__x WHERE Name__c IN : bookNames];
        
        for(Book_Ext__x book : extBookList){
            String bookId = book.Id;
            
        }
    }
}