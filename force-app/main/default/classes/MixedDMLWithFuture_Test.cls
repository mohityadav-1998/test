@IsTest
public class MixedDMLWithFuture_Test {
    
    
    public class MixedDMLWithFuture_HttpCalloutMockForFuture implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req){
        if (req.getMethod()=='GET') {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"attributes":{"type":"Account","url":"/services/data/v58.0/sobjects/Account/0015g00001fS9MWAA0"},"Id":"0015g00001fS9MWAA0","Name":"Date 31st march","Phone":"0987654321","Website":"sjdhkjhkd"}');
                res.setStatusCode(200);
                return res;
        }else{
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json;charset=UTF-8');
        res.setBody('[{"attributes":{"type":"Account","url":"/services/data/v58.0/sobjects/Account/0015g00001fSC1AAAW"},"Name":"Date 31st march 2","Phone":"75875976567","External_Id__c":"0012w000028v2NJAAY","Website":"abc.com","Id":"0015g00001fSC1AAAW"}]');
        res.setStatusCode(200);
        return res;
        }
    }
    }

   /* @testSetup public static void setup() {
        // Create common test accounts
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts; 
    }*/
    @isTest
    public static void callExternalAPITest(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MixedDMLWithFuture_HttpCalloutMockForFuture());
        MixedDMLWithFuture.callExternalAPI('0015g00001fS9MWAA0');
        Test.stopTest();
    }
    @isTest
    public static void callpostmethodTest(){
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts; 
        List<Account> lstAcc=[Select Id,Name,Phone,Website From Account Where Name Like:'TestAcct%'];
        String AccObjString = json.serialize(lstAcc);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MixedDMLWithFuture_HttpCalloutMockForFuture());
        MixedDMLWithFuture.callpostmethod(AccObjString);
        Test.stopTest();
    }
    @istest
    public static void callBatchApex(){
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MixedDMLWithFuture_HttpCalloutMockTest());
        Database.executeBatch(new AccountUpdateBatchJob());
        Test.stopTest();
    }

}