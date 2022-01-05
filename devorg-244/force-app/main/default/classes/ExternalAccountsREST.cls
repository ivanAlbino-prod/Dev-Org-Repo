public without sharing class ExternalAccountsREST {
    
    @AuraEnabled(cacheable=true)
    public static String getAccounts(Integer size) {
        X2f1Integration__mdt integration = [SELECT MasterLabel, Label, Endpoint__c, Method__c 
                                        FROM X2f1Integration__mdt WHERE Label = 'getAccounts'];
        HTTP http = new HTTP();
        HttpRequest request = new HttpRequest();
        request.setMethod(integration.Method__c);
        request.setEndpoint(integration.Endpoint__c + size);
        HTTPResponse response = http.send(request); 
        
        return response.getBody();
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getRecords(List<String> names){
        return [SELECT Id, Name, Type, AccountNumber FROM Account WHERE NAME IN: names ORDER BY Name];
    }

}