public without sharing class ExternalBookObjectREST {
    
    @Future(callout=true)
    public static void bookCallout(String jsonBody, String fields){
        System.debug('Json Body' + jsonBody);
        HTTP http = new HTTP();
        HttpRequest request = new HttpRequest();
        request.setMethod('PUT');
        request.setBody(jsonBody);
        request.setEndpoint('callout:X2f1/services/apexrest/Book__c/');
        request.setHeader('fields', fields);
        HTTPResponse response = http.send(request);
        System.debug(response.getStatusCode());
    }
    
    @AuraEnabled(cacheable = true)
    public static String getBooks(Integer size){
        HTTP http = new HTTP();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:X2f1/services/apexrest/Book__c/' + size);
        HTTPResponse response = http.send(request); 
        
        if(response.getStatusCode() != 200){
            throw new CalloutException('Error status code is: ' + response.getStatusCode());
        }
     
        return response.getBody();
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Book__c> getRecords(List<String> names){
        return [SELECT Id, Name, Description__c FROM Book__c WHERE NAME IN: names ORDER BY Name];
    }
}