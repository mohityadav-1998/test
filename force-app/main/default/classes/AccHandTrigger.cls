public class AccHandTrigger {

   public static void updateContactsPhoneAsAccountsPhone(List<Account> accList, Map<Id,Account> oldMap){
       Set<id> setOfAccId= New Set<id>();
       List<Contact> updatedConList= New List<Contact>();
        System.debug('inside method===>');
     // adding a comment to test the git configuration
       /* Map<Id,Account> accMap = new Map<Id,Account>();

        if(!Trigger.new.isEmpty())

        {

            for(Account acc : accList){

                if(oldMap.get(acc.Id).Phone  == acc.Phone) //WE WANT TO CHECK OLD VALUE OF RECORD//Trigger.oldMap.get(acc.Id).Phone

                {

                    accMap.put(acc.Id, acc);

                }

            }

        }

        List<Contact> conList = [SELECT Id, AccountId, Phone from Contact WHERE AccountId IN: accMap.keySet()]; 

        List<Contact> ListToUpdateContacts = new List<Contact>();

        if(!oldMap.isEmpty())

        {

            for(Contact con : conList)

            {

                con.Phone = accMap.get(con.AccountId).Phone;

            }

        }

        if(!ListToUpdateContacts.isEmpty())

        {

            update ListToUpdateContacts;

        }*/
       for(Account ac:accList){
           if(oldMap!=null && ac.Phone!= oldMap.get(ac.Id).Phone){
               setOfAccId.add(ac.Id);
           }
       }
       if(setOfAccId.size()>0){
           for(Contact ct:[select Id,Phone,Account.Phone from Contact Where AccountId IN:setOfAccId]){
               ct.Phone=ct.Account.Phone;
               updatedConList.add(ct);
           }
       }
       if(updatedConList.size()>0){
           update updatedConList;
       }

    }
    public static void updateContactDescription(List<Account> accList, Map<Id,Account> oldMap){
        Map<Id,Account> mapOfAcc = new Map<Id,Account>();
        for(Account acc: accList){
            if(acc.Description != null && acc.Description != oldmap.get(acc.Id).Description){
               mapOfAcc.put(acc.Id,acc); 
            }
        }
        List<Contact> updatedConList= new List<Contact>();
        if(mapOfAcc.size()>0){
            for(Contact ct:[Select Id,Description,AccountId From Contact Where AccountId IN: mapOfAcc.keyset()]){
                ct.Description=mapOfAcc.get(ct.AccountId).Description;
                updatedConList.add(ct);
            }
            if(!updatedConList.isEmpty()){
                update updatedConList;
            }
        }
    }
}