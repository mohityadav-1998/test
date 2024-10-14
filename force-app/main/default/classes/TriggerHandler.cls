public class TriggerHandler {
    //1-create a number field count of contact on account and create a trigger on account 
    //which create number of contact on the basis of account field value.
    // We should take care insert, update case.
    public static void createContacts(List<Account> accList){
        List <contact> conList = New List <contact>();
        Set<Id> setOfIds = New Set<Id> ();
           For(Account acc:accList){
               If(acc.Id!=Null&&acc.Number__c!=Null){
                   setOfIds.add(acc.Id);}
           }
        if(setOfIds.size()>0){
           For(Account act:[Select Name,id,Number__c,(Select Id,Name From Contacts) From Account 
                            Where Id IN :setOfIds]){
                   System.debug('act.Contacts.size '+act.Contacts.size());
                                System.debug('act.Number__c '+act.Number__c);
                   Decimal num=act.Contacts.size()-act.Number__c;
                    Integer Num1= num.intValue();
                                System.debug('Num1 '+Num1);
                     if(num>0){
                      List<Contact> dltconList=[Select Id,AccountId From Contact Where 
                                                          AccountId=:act.Id  LIMIT:Num1];
                   if(dltconList.size()>0){
                       delete dltconList;
                       System.debug('dltconList '+dltconList);
                   }
                     }
           if(num<0){
                   for(Integer i=0;i<act.Number__c-act.Contacts.size();i++){
                                Contact con= New Contact(LastName=act.Name+ ' '+i,AccountId=act.Id);
                                conList.add(con);
                             }
                               if(!conList.isEmpty()){
                                 insert conList;
                                   System.debug('conList'+conList);
                                }
                  }

                  }
        }
}
    
    //3-create a trigger which convert the lead automatically if rating is hot.
  public static void leadConversion(List<Lead> leads){
        List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
    for(Lead l:leads){
        if(!l.isConverted && l.rating=='Hot' ){
            Database.LeadConvert lc= New Database.LeadConvert();
            lc.setLeadId(l.Id);
            lc.convertedStatus='Closed - Converted';
            leadConverts.add(lc);
        }
    }
    if (!leadConverts.isEmpty()) {
List<Database.LeadConvertResult> lcr = Database.convertLead(leadConverts);
        System.debug('Results=='+lcr);
}
    }
    
    public static void sumOfOppAmount(Set<Id> acctIds){ 
    List<Account> accList=New List<Account>();
        System.debug('acctIds===>'+acctIds);
    for(AggregateResult agr:[SELECT AccountId, SUM(Amount)totalAmount FROM Opportunity WHERE AccountId IN :acctIds GROUP BY AccountId]){
       
        Account acc=New Account(Id=(Id)agr.get('AccountId'),Ammount__c=(Decimal)agr.get('totalAmount'));
        accList.add(acc);
    }
    if(!accList.isEmpty()){
        update accList;
        System.debug('accList==>'+accList);
    }
    } /*
        Map<Id,AggregateResult> mapOfIdwithAmt= new Map<Id,AggregateResult>([SELECT AccountId, SUM(Amount)totalAmount FROM Opportunity WHERE AccountId IN :acctIds GROUP BY AccountId]);
        for(Account ac:[Select Id,Ammount__c From Account where Id IN:acctIds]){
            ac.Ammount__c=(Decimal)mapOfIdwithAmt.get(ac.Id).get('totalAmount');
            accList.add(ac);
        }
        if(!accList.isEmpty()){
        update accList;
        System.debug('accList==>'+accList);
    }*/
    }