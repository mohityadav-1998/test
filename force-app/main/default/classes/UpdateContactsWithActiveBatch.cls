public class UpdateContactsWithActiveBatch implements Database.Batchable<Sobject>,Database.stateful {
    
    public integer count=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        string query='Select Id,Description,Account.Active__c From Contact Where Account.Active__c=\'Yes\'';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc,List<Contact> conList){
        System.debug('Conlist===>'+conList);
        count+=conList.size();
        System.debug('Count===>'+count);
        List<Contact> updatedConList=New List<Contact>();
        For(Contact ct:conList){
            ct.Description=ct.Account.Active__c;
            updatedConList.add(ct);
        }
        //if(!updatedConList.isEmpty())
        //update updatedConList;
        String msg=callCustommethod();
        System.debug('custom'+msg);
    }
    public string callCustommethod(){
        return 'mohit';
    }
    public void finish(Database.BatchableContext bc){
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
                          TotalJobItems, CreatedBy.Email
                          FROM AsyncApexJob WHERE Id =
                          :bc.getJobId()];
        System.debug('result===>'+a);
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