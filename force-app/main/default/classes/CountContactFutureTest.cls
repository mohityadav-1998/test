@isTest
public class CountContactFutureTest {
    @isTest
    private static void countNumberOfContactTest(){
      List<Account> accList = New  List<Account> ();
        For(Integer i=0;i<250;i++){
            accList.add(new Account(Name='Test'+i));
        }
        If(!accList.isEmpty()){
            insert accList;
        }
        List<Contact> conList = New  List<Contact> ();
        Set<Id> accIds= New Set<Id>();
        For(Account acc:accList){
          conList.add(new Contact(LastName=acc.Name,AccountId=acc.Id)) ; 
            accIds.add(acc.Id);
        }
        If(!conList.isEmpty()){
            insert conList;
        }
        Test.startTest();
        CountContactFuture.countNumberOfContact(accIds);
        Test.stopTest();

    }
    
}