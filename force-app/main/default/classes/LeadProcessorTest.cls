@isTest
public class LeadProcessorTest {
    @testSetup
    static void setup() {
        List<Lead> accounts = new List<Lead>();
       
        // insert 10 accounts
        for (Integer i=0;i<200;i++) {
            accounts.add(new Lead(LastName='Lead '+i,Company='Lead '+i,	Status='Open - Not Contacted'));
        }
        insert accounts;
    }
    @isTest static void test() {
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
    }

}