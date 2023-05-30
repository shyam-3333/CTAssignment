public class TaneiraAttributionPendingRecordEmail {
    public List<Taneira_View__c> listTaneira{get;set;}
    Public List<Taneira_View__c> TaneiraList5To7{get;set;}
    Public List<Taneira_View__c> TaneiraList7Plus{get;set;}
    public TaneiraAttributionPendingRecordEmail(){
        TaneiraList5To7 = new List<Taneira_View__c>();
        TaneiraList7Plus = new List<Taneira_View__c>();
        listTaneira = [SELECT Id, Vendor_custom__r.Name, CreatedDate,Pending_Days__c,Page_Control__c From Taneira_View__c where Pending_Days__c > 5 AND Page_Control__c = 'Attribution'];
        for(Taneira_View__c TV : listTaneira){
            if(TV.Pending_Days__c < 7){
                TaneiraList5To7.add(TV);
            } else {
                TaneiraList7Plus.add(TV);
            }
        }
    }
}