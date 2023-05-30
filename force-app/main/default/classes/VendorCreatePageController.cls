public class VendorCreatePageController{
    public vendor__c acc;
    Public string strRecTypeName {get; set;}
    public string ownerName {get;set;}
    public id strRecTypeid;
    public id accId;
    //Id recordTypeIdAcc;
    public boolean profVisb {get;set;}
     public VendorCreatePageController(ApexPages.StandardController controller){
      //  strRecTypeid = apexpages.currentpage().getparameters().get('RecordType');
        accId = apexpages.currentpage().getparameters().get('id');
        ownerName = UserInfo.getName();
       
       /* if(strRecTypeid !=  null){
            Schema.DescribeSObjectResult d = Schema.SObjectType.Account; 
            Map<Id,Schema.RecordTypeInfo> rtMapById = d.getRecordTypeInfosById();
            strRecTypeName = rtMapById.get(strRecTypeid).getName();
        } */
         //recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
         acc = (vendor__c)controller.getRecord();
     }
     public pagereference doSave(){
         PageReference pr;
         try{
             //acc.RecordTypeId = recordTypeIdAcc;
             upsert acc;
             if(acc.id != null){
                pr = new PageReference('/'+acc.id);
                pr.setRedirect(true);
                return pr;
             }
           
         }
         catch(DMLException ex){
             system.debug('===Exception==='+ex);
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,ex.getDmlMessage(0)));
           
         }
         return null;
         
     }
      public pageReference doCancel(){
          string save = 'new record';
        save = 'new record'+'created';
        PageReference pr;
        if(accId != null){
            pr = new PageReference('/'+accId);
            pr.setRedirect(true);
            return pr;
         }
        else{
            pr = new PageReference('/001/o');
            pr.setRedirect(true);
            return pr;
        }
        return null;
               
    }
    public PageReference doSaveNew(){
     string save = 'new record';
        save = 'new record'+'created';
        try{
             //acc.RecordTypeId = recordTypeIdAcc;
             upsert acc;
             PageReference pr = new PageReference('/apex/VendorCreatePage');
             pr.setRedirect(true);
            return pr;
         }
         catch(DMLException ex){
             system.debug('===Exception==='+ex);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,ex.getDmlMessage(0)));
         }
         return null;
       
    }
}