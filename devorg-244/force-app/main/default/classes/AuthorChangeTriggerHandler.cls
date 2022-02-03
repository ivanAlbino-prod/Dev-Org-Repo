public class AuthorChangeTriggerHandler extends TriggerHandler {
    public override void afterInsert(){
        Set<String> fieldSet = new Set<String>();
        Set<Id> recordIds = new Set<Id>();
        for(Author__ChangeEvent event : (List<Author__ChangeEvent>)Trigger.new){
            EventBus.ChangeEventHeader header = event.ChangeEventHeader;
            List<String> fieldList = String.valueOf(header.changedfields).split(',');
            System.debug(header.recordids);
            for(String s : fieldList){
                fieldSet.add(s);
            }
            for(Id rec : header.recordids){
                recordIds.add(rec);
            }
        }
        try{        
            List<String> fieldList = new List<String>(fieldSet);
            String fields = String.join(fieldList, ',');
            System.debug('fields ' + fields);
            fields = fields.substring(1, fields.length()-1);
            String query = 'SELECT Id, Name,  ' + fields + ' FROM Author__c WHERE Id IN : recordIds';
            System.debug('query -> ' + query);
            List<Book__c> books = Database.query(query);
            String jsonBody = JSON.serialize(books);
            ExternalAuthorObjectREST.authorCallout(jsonBody,fields);
        }catch(Exception e){
            System.debug(e.getLineNumber());
            System.debug(e.getMessage());
        }
    }
}