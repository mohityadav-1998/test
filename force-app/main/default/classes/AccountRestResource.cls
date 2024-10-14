@RestResource(urlMapping='/Account/*')
global class AccountRestResource {
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //When we are expecting the parameters from the url than this way we can get the parameters in our apex class from the third party
        
        Map<String,String> mapOfParams= req.params;
        System.debug('mapOfParams===>'+mapOfParams);
        String accountId = mapOfParams.get('sfId');
        
        Account result = [SELECT Id, Name, Phone, Website FROM Account Where Id=: accountId];
        return result;
    }
    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }

}