public with sharing class AccountwebService {
 
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
 
    public class NewAccountRequestWrapper {
        public String name {get; set;}
        public String phone {get; set;}
    }
 
    public static void getAccount(Id accId) {
 
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:SalesforceAppNc/services/apexrest/Account/' + accId);
        response = http.send(request); 
        String jsonstring=response.getBody();
        Account acc=(Account)JSON.deserialize(jsonstring, Account.class);
        System.debug(acc.Name);
         System.debug(acc);
        System.debug(response.getBody());
    }
    
    
    public static void addAccount(NewAccountRequestWrapper newAccount) {
 
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:SalesforceAppNc/services/apexrest/Account');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(newAccount));
 
        response = http.send(request); 
 
        System.debug(response.getBody());
    }
}