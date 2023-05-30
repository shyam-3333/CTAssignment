public class VendorObjectMigrationBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext BC){
        string query = 'SELECT Id,account__c,vendor_custom__c from product__c';
      return Database.getQueryLocator(query);
   }
    public void execute(Database.BatchableContext BC, List<product__c> scope){
        system.debug('in the town');
       
        map<id,id> accIdVenId = new map<id,id>();
        for(vendor__c acc :[select id,Account_Id_M__c from vendor__c]){
            if(acc.Account_Id_M__c != null){
                accIdVenId.put(acc.Account_Id_M__c,acc.Id);
            }
        }
     for(product__c s : scope){
         if(s.account__c != null){
             if(accIdVenId.ContainsKey(s.account__c)){
                 s.vendor_custom__c = accIdVenId.get(s.account__c);
             }
         }
     }
        try {
           update scope;
         
        } catch(Exception e) {
            System.debug('Exception==>'+e);
        }
     
    }
 
   public void finish(Database.BatchableContext BC){
       string done = 'update completed';
       done = done + 'You check errors in error logs';
       system.debug('Finish'+done);
   }

}