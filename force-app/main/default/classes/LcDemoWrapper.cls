public class LcDemoWrapper {
    @AuraEnabled
    Public static List<Account> getAccount(){
        return [Select Id,Name,Industry from Account LIMIT 10];
    }
     @AuraEnabled
    Public static List<Contact> getContact(Id accId){
        return [Select Id,Name from Contact Where AccountId=:accId];
    }
    public class WrapperTest{
        @auraEnabled
        public String myString1{get;set;}
        @auraEnabled
        public Integer myInteger1{get;set;}
        
    }
}