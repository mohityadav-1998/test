public class CountContactFuture {
    @future
    public static void countNumberOfContact(Set<Id> recordIds){
        List<Account> accList=[Select Id,Name,Number_of_Contacts__c,(Select Id,Name FROM Contacts) 
                               FROM ACCOUNT WHERE ID IN:recordIds];
        For(Account acc:accList){
            acc.Number_of_Contacts__c=acc.Contacts.size();
        }
        IF(!accList.isEmpty()){
            update accList;
            System.debug('Updated List'+accList);
        }
    }
    
    class myOuterClass {
   // Additional myOuterClass code here
   
}
    class myInnerClass {
     // myInnerClass code here
   }

}