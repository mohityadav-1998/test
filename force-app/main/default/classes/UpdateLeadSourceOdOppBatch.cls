public class UpdateLeadSourceOdOppBatch implements Database.Batchable<sObject> {
    public static Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,Name,LeadSource From Opportunity]);
    }
    public void execute(Database.BatchableContext bc,List<Opportunity> opps){
        for(Opportunity opp:opps){
            opp.LeadSource='Web';
        }
        update opps;
        doSomething();
    }
    public void finish(Database.BatchableContext bc){
        
    }
    public void doSomething(){
        System.debug('Line 16');
    }
    
}