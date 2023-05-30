public class AccountViewOverideController{
      public id accId{get;set;}
      public string strRecTypeName{get;set;}
      public AccountViewOverideController(ApexPages.StandardController controller){
          accId = apexpages.currentpage().getparameters().get('Id');
          String accRecType = [SELECT RecordTypeId From Account where id=: accId].RecordTypeId;
          if(accRecType !=  null){
            Schema.DescribeSObjectResult d = Schema.SObjectType.Account; 
            Map<Id,Schema.RecordTypeInfo> rtMapById = d.getRecordTypeInfosById();
            strRecTypeName = rtMapById.get(accRecType).getName();
        }
      }
      public pageReference redirect(){
          
         PageReference pr;
         if(strRecTypeName != 'Vendor') {
             pr = new pageReference('/'+accId+'?nooverride=1');
             pr.setRedirect(true);
             return pr;
         } 
         else{
             pr = new pageReference('/apex/VendorDetailPage?id='+accId);
             pr.setRedirect(true);
             return pr;
             
         } 
         return null;
      }
     
}