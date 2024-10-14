public class UpdateContactAddressQueueable implements Queueable {
    private List<contact> conList;
    public UpdateContactAddressQueueable(List<Contact> conList){
        this.conList=conList;
    }
    
    public void execute(QueueableContext QC){
        for(Contact ct:conList){
            ct.MailingStreet=ct.Account.BillingStreet;
            ct.MailingState=ct.Account.BillingState;
            ct.MailingCity=ct.Account.BillingCity;
            ct.MailingPostalCode=ct.Account.BillingPostalCode;
            
        }
        update conList;
        System.debug('ConList-------'+conList);
        
    }

}