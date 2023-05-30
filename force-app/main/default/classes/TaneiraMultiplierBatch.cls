public class TaneiraMultiplierBatch implements Database.Batchable<sObject> {
    List<Product__c> dataToOProcess = new List<Product__c>();
    public TaneiraMultiplierBatch(List<Product__c> dataToOProcess){
        this.dataToOProcess = dataToOProcess;
    }
    public Iterable<sObject> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return dataToOProcess;
    }
    public void execute(Database.BatchableContext bc, List<sObject> records){
        // process each batch of records
        new NewTaneiraMultiplier().getSuggestedMRP(records);
    }    
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }  
}