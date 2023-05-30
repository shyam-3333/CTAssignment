public class VendorObjectMigrationBatchTV implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext BC){
        string query = 'SELECT Id,Vendor__c,Account_Id__c,vendor_custom__c from Taneira_View__c';
      return Database.getQueryLocator(query);
   }
    public void execute(Database.BatchableContext BC, List<Taneira_View__c> scope){
        map<id,id> accIdVenId = new map<id,id>();
        for(vendor__c acc :[select id,Account_Id_M__c from vendor__c]){
            if(acc.Account_Id_M__c != null){
                accIdVenId.put(acc.Account_Id_M__c,acc.Id);
            }
        }
     for(Taneira_View__c s : scope){
         if(s.Vendor__c != null){
             if(accIdVenId.ContainsKey(s.Vendor__c)){
                 s.vendor_custom__c = accIdVenId.get(s.Vendor__c);
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
       system.debug('Finish'+done);   }

}