global class AccountUpdateBatchJob implements Database.batchable<Sobject>,Database.AllowsCallouts,Database.Stateful
{
    global Integer count;
    global  AccountUpdateBatchJob(){
        count=0;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        string query='Select Id,Name, Phone, Website From Account Where CreatedDate=Today';
      return Database.getQueryLocator(query);
   }

   public void execute(Database.BatchableContext bc, List<Account> AccList){
       System.debug('AccList----'+AccList);
       count=count+1;
       System.debug('count'+count);
       String AccObjString = json.serialize(AccList);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('PATCH');
        request.setEndpoint('callout:SalesforceAppNc/services/apexrest/Account');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(AccObjString);
        HttpResponse response = http.send(request);
 
        System.debug(response.getBody());
     
    }

   public void finish(Database.BatchableContext bc){
       AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedBy.Email
      FROM AsyncApexJob WHERE Id =
      :bc.getJobId()];
   // Send an email to the Apex job's submitter notifying of job completion.
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   String[] toAddresses = new String[] {a.CreatedBy.Email};
   mail.setToAddresses(toAddresses);
   mail.setSubject('Apex Sharing Recalculation ' + a.Status);
   mail.setPlainTextBody
   ('The batch Apex job processed ' + a.TotalJobItems +
   ' batches with '+ a.NumberOfErrors + ' failures.');
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }
}