@isTest
public class UpdateLeadSourceOdOppBatchTest {
    @isTest
    private static void updateOpportunity(){
        List<Opportunity> oppList=New List<Opportunity>();
        For(Integer i=0;i<200;i++){
            oppList.add(new Opportunity(Name='test'+i,closeDate=System.today(),StageName='Prospecting'));
        }
        If(!oppList.isEmpty()){
            insert oppList;
        }
        Test.startTest();
        UpdateLeadSourceOdOppBatch m= new UpdateLeadSourceOdOppBatch();
        Id jobid= Database.executeBatch(m);
        Test.stopTest();
    }

}