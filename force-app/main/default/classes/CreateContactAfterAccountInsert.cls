public with Sharing class  CreateContactAfterAccountInsert {
    public static void createContact(List<Account> lstAcc){
        List<Contact> lstCon=new List<Contact>();
        for(Account acc:lstAcc){
            Contact ct= new Contact();
            ct.LastName=acc.Name;
            ct.AccountId=acc.Id;
            lstCon.add(ct);
        }
        //insert lstCon;
        /*if(Schema.SobjectType.Contact.iscreateable()){
            insert lstCon;
            System.debug('User has permission to create contact Records');
        }
        else{
            System.debug('User has no permission to create contact Records');
        }*/
        SObjectAccessDecision decision = Security.stripInaccessible(
            AccessType.CREATABLE,
            lstCon);
        try{
            // get field where user has access to insert
            insert decision.getRecords();
        }catch(NoAccessException e){
            system.debug(e.getMessage());
        }
        
    }
}