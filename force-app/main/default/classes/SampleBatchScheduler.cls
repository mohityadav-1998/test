global class SampleBatchScheduler implements Schedulable {
    
    // Execute at regular intervals
    global void execute(SchedulableContext ctx){
     
      AccountUpdateBatchJob batch = new AccountUpdateBatchJob();
      Database.executebatch(batch);
    }
}