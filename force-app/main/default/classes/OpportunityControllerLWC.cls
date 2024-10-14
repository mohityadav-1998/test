public with sharing class OpportunityControllerLWC {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> oppListData(){
   return [Select id,Name,StageName From Opportunity Limit 10];
    }
}