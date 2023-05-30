/****
 Created By : Shweta kumari
 Modified By : Poornapriya YN
 Description : class to override new Account button to redirect to diffrent page based on record type 
*****/
public class AccountNewOverride {
  Public string strRecTypeName {get; set; }
   // public string source{get;set;}
    public id strRecTypeid{get;set;}
    public string RecordType{get;set;}
    public AccountNewOverride(ApexPages.StandardController controller){
    if(apexpages.currentpage().getparameters().get('RecordType')==null){
    Schema.DescribeSObjectResult describeAccount = Schema.SObjectType.Account;
        List<Schema.RecordTypeInfo> rtInfos = describeAccount.getRecordTypeInfos();
        for(Schema.RecordTypeInfo rtInfo : rtInfos) {
            // walk through the map to determine the correct record type, this is done with the isAvailable() function
            if(rtInfo.getName()!='Master' && rtInfo.isAvailable()) {
                 system.debug('---RecName---'+rtInfo.getName());
                ApexPages.currentPage().getParameters().put('RecordType', rtInfo.getRecordTypeId());
            }
        }
    }
        strRecTypeid = apexpages.currentpage().getparameters().get('RecordType');
        system.debug('---strRecTypeid---'+strRecTypeid );
        if(strRecTypeid !=  null){
            system.debug('---INSIDE IF---'+strRecTypeid );
            Schema.DescribeSObjectResult d = Schema.SObjectType.Account; 
            Map<Id,Schema.RecordTypeInfo> rtMapById = d.getRecordTypeInfosById();
            strRecTypeName = rtMapById.get(strRecTypeid).getName();
            system.debug('---strRecTypeName---'+strRecTypeName );
        } 
          
    }
      public pageReference redirect(){
          
         PageReference pr;
         if(strRecTypeName != 'Vendor') {
             pr = new pageReference('/001/e?RecordType='+strRecTypeid+'&nooverride=1');
             pr.setRedirect(true);
             return pr;
         } 
         else{
             pr = new pageReference('/apex/VendorCreatePage?retURL=%2F001%2Fo&RecordType='+ strRecTypeid+'&ent=Account&save_new=1&sfdc.override=1');
             pr.setRedirect(true);
             return pr;
             
         } 
         return null;
      } 

}