@isTest
global class MockHTTPExternalAccountsREST implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        List<Account> accList = new List<Account>();
        for(integer i = 0; i < 100; i++){
            Account acc = new Account();
        	acc.Name = 'Account ' + i;
        	acc.AccountNumber = '00'+i;
            accList.add(acc);
        }
        
        String jsonBody = JSON.serialize(accList);
        System.debug(jsonBody);
        HttpResponse res = new HttpResponse();
        res.setBody(jsonBody);
        res.setStatusCode(200);
        return res;
    }
}