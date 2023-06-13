Global class runPartProduct Implements schedulable{
    global void execute(schedulableContext sc){
        updatingPartProductBatch_Handler run= new updatingPartProductBatch_Handler();//This will call Batch Class.
        database.executeBatch(run,100);
        System.debug('This is Schedulable Class.');
        
    }
    
}