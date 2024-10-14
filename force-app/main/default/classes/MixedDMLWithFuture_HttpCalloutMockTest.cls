public class MixedDMLWithFuture_HttpCalloutMockTest implements HttpCalloutMock {
   
    public HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json;charset=UTF-8');
        res.setBody('Account updated successfully: [{\"attributes\":{\"type\":\"Account\",\"url\":\"/services/data/v60.0/sobjects/Account/0015g00001fS9MWAA0\"},\"Id\":\"0015g00001fS9MWAA0\",\"Name\":\"Date 31st march\",\"Phone\":\"0987654321\",\"Website\":\"sjdhkjhkd\",\"External_Id__c\":\"0012w000028v1QMAAY\"}]');
        res.setStatusCode(200);
        return res;
    }

}