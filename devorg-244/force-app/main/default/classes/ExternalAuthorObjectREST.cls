public without sharing class ExternalAuthorObjectREST {
	@Future(callout=true)
    public static void authorCallout(String jsonBody, String fields){
        System.debug('Json Body' + jsonBody);
        HTTP http = new HTTP();
        HttpRequest request = new HttpRequest();
        request.setMethod('PUT');
        request.setBody(jsonBody);
        request.setEndpoint('callout:X2f1/services/apexrest/Author__c/');
        request.setHeader('fields', fields);
        HTTPResponse response = http.send(request);
        System.debug(response.getStatusCode());
    }
    
    @AuraEnabled(cacheable = true)
    public static String getAuthor(Integer size){
        HTTP http = new HTTP();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:X2f1/services/apexrest/Author__c/' + size);
        HTTPResponse response = http.send(request); 
        
        if(response.getStatusCode() != 200){
            throw new CalloutException('Error status code is: ' + response.getStatusCode());
        }
     
        return response.getBody();
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Author__c> getRecords(List<String> names){
        return [SELECT Id, Name FROM Author__c WHERE NAME IN: names ORDER BY Name];
    }
}