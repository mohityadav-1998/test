public class MixedDMLWithFuture {
   //When we call mixedDMLDemo() method we will get below error
    //System.DmlException: Insert failed. First exception on row 0; first error: MIXED_DML_OPERATION, DML operation on setup object is not permitted after you have updated a non-setup object (or vice versa): User, original object: Account: []
  
    public static void mixedDMLDemo(){
        Account acc= New Account(Name='Mohit Yadav');
        insert acc;
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
UserRole r = [SELECT Id FROM UserRole WHERE Name='CEO'];
User usr = new User(alias = 'testGeek', email='test@geek.com',
emailencodingkey='UTF-8', lastname='Geek',
languagelocalekey='en_US',
localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
timezonesidkey='America/Los_Angeles',
username='test@geek.com');
insert usr;
    }
    /*-----------------------------------------------------*/
    //In this method setup and not setup object dml is happening in different transaction because of future
    public static void mixedDMLDemoWithFuture(){
        Account acc= New Account(Name='Mohit Yadav');
        insert acc;
        UtilFutureDemo.insertUser();
    }
    
  /*-------------------------------------------------------------------------------*/
    
    @future
    public static void processAccountData(String jsonString){
        
        //deserialize the JSON to the Account List
        system.debug('jsonString----'+jsonString);
        List<Account> accountList = (List<Account>)Json.deserialize(jsonString,List<Account>.class);
        system.debug('accountList----'+accountList);
        List<Account> accListUpdate = new List<Account>();
        For(Account acc: accountList){
            acc.Description = 'This is updated by Trigger Future';
            accListUpdate.add(acc);
        }
        update accListUpdate;
        //Printing the Account List
        System.debug('---accListUpdate List---'+accListUpdate);
        
    }
    @future(callout=true)
    public static void callExternalAPI(Id accId) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('callout:SalesforceAppNc/services/apexrest/Account/' + accId);
    request.setMethod('GET'); 
    HttpResponse response = http.send(request);
        String jsonstring=response.getBody();
        Account acc=(Account)JSON.deserialize(jsonstring, Account.class);
        System.debug(acc.Name);
         System.debug(acc);
        System.debug(response.getBody());
    // Parse response and handle data
}
    
    
    @future(callout=true)
    public static void callpostmethod(String jsonString) {
        List<Account> accountList = (List<Account>)Json.deserialize(jsonString,List<Account>.class);
        List<account> newAccList= [Select Id,Name,Phone,Website From Account Where Id IN:accountList];
        String AccObjString = json.serialize(newAccList);
        Http http = new Http();
       HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:SalesforceAppNc/services/apexrest/Account');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(AccObjString);
        HttpResponse response = http.send(request);
 
        System.debug(response.getBody());
    }
    

}