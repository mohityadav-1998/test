public class UpdateContactAddressSchedulable implements Schedulable {
    public void execute(SchedulableContext cxt){
        List<Contact> conlist=[Select id,MailingCity,MailingStreet,MailingPostalCode,MailingState,
                              AccountId,Account.BillingCity,Account.BillingStreet,Account.BillingPostalCode,
                               Account.BillingState
                              From Contact Where Account.BillingCountry='USA'];
        if(!conlist.isEmpty()){
            Id jobId=System.enqueueJob(new UpdateContactAddressQueueable(conlist));
            System.debug('jobId-----'+jobId);
        }
    }
}