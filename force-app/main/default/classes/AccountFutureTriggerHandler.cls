public class AccountFutureTriggerHandler{
  @future
    public static void processAccountData(String jsonString){
        
        //deserialize the JSON to the Account List
        
        List<Account> accountList = (List<Account>)Json.deserialize(jsonString,List<Account>.class);
        List<Account> accListUpdate = new List<Account>();
        For(Account acc: accountList){
            acc.Description = 'This is updated by Trigger Future';
            accListUpdate.add(acc);
        }
        update accListUpdate;
        //Printing the Account List
        System.debug('---Account List---'+accountList);
        
    }

}