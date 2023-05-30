/****
 Created By : Shweta kumari
 Description : class to override new product button to redirect to diffrent page based on record type 
*****/
public class ProductNewButtonOverride {
    Public string strRecTypeName {get; set; }
    public string source{get;set;}
    
    public ProductNewButtonOverride(ApexPages.StandardController controller){
        id strRecTypeid = apexpages.currentpage().getparameters().get('RecordType');
        if(strRecTypeid !=  null){
            Schema.DescribeSObjectResult d = Schema.SObjectType.Product__c; 
            Map<Id,Schema.RecordTypeInfo> rtMapById = d.getRecordTypeInfosById();
            strRecTypeName = rtMapById.get(strRecTypeid).getName();
        }    
    }
}