public without sharing class ExternalAccountsREST {
    
    @AuraEnabled(cacheable=true)
    public static String getAccounts(Integer size) {
        HTTP http = new HTTP();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:X2f1/services/apexrest/Account/' + size);
        HTTPResponse response = http.send(request); 
        
        if(response.getStatusCode() != 200){
            throw new CalloutException('Error status code is: ' + response.getStatusCode());
        }
     
        return response.getBody();
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getRecords(List<String> names){
        return [SELECT Id, Name, Type, AccountNumber FROM Account WHERE NAME IN: names ORDER BY Name];
    }

}