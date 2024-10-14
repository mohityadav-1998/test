public with sharing class AccountClass {
    @AuraEnabled (cacheable=true)
    public static List<account> accountclass() {
        List<Account> acc=[select Id,Name,Website,Phone,(Select Id,Name from Contacts) from Account Limit 20 ];
        
        return acc;
    }
    @AuraEnabled (cacheable=true)
    public static account createAcc(string name) {
        Account acc= new Account(Name=name);
        insert acc;
        return acc;
    }
    @AuraEnabled
    public static List<Contact> contactclass(string accId) {
        System.debug('accId---'+accId);
        List<Contact> con=[select id,Name,Phone,AccountId,FirstName,LastName from Contact Where AccountId=:accId ];
        System.debug('ContactList----'+con);
        return con;
    }
    @AuraEnabled (cacheable=true)
    public static Map<Id,List<Contact>> contactWithAccId(){
    //test 
        Map<Id,List<Contact>> accountContactsMap= New Map<Id,List<Contact>>();
        for (Contact c : [SELECT AccountId,Id,FirstName,LastName,Email,Account.Name,Account.Phone,Account.Website FROM Contact where AccountId!=null]) {
         if (!accountContactsMap.containsKey(c.AccountId)) {
    accountContactsMap.put(c.AccountId, new List<Contact>{c});
  } else {
    accountContactsMap.get(c.AccountId).add(c);
  }   
    }
    return accountContactsMap;
}
@AuraEnabled
    public static List<Contact> contactWithAccIdf(){
        List<Contact> conlst =  [SELECT AccountId,Id,FirstName,LastName,Account.Name,Account.Phone,Account.Website FROM Contact where AccountId!=null];
        return conlst;
}
@AuraEnabled(cacheable=true)

    public Static List<AccountrelContact> GetAcc() {

        List<AccountrelContact> accWrapperList = new List<AccountrelContact>();

        List<Account> accList = [Select Name, Id, Phone, (Select Name, Phone from Contacts) from Account ] ;

        if(!accList.isEmpty()){

            for(Account acc : accList){

                AccountrelContact accWrapper = new AccountrelContact();

                accWrapper.accRecord = acc;

                accWrapper.contactList = acc.Contacts;

                accWrapper.isBool = false;

                accWrapperList.add(accWrapper);

            }

        }

        return accWrapperList;

 

    }
    @AuraEnabled
public Static AccountrelContact accountWrapper(AccountrelContact wrp){
        System.debug('Wrapper----'+wrp);
        wrp.isBool=true;
        System.debug('update Wrapper----'+wrp);
        return wrp;
        
    }

 

    public class AccountrelContact{

        @AuraEnabled

        public Account accRecord{get;set;}

        @AuraEnabled

        public List<Contact> contactList{get;set;}

        @AuraEnabled

        public Boolean isBool{get;set;}

    }

    @AuraEnabled
    public static List<sObject> getObject(string objName,string fname) {
        
        String querys='select id,Name,Phone,CreatedDate from ' +objName+' Where CreatedDate= '+fname ;
        System.debug('querys--------'+querys);
        List<sObject> objRecord=Database.query(querys);
        System.debug('ContactList----'+objRecord);
        return objRecord;
    }
}