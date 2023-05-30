public class fetchlineitem {


List<Quote_Items__c> Q=new list<Quote_Items__c>();

    public fetchlineitem(ApexPages.StandardController controller) {
    
      }
    

    public list<Quote_Items__c> getQLineItem(){

     Q=[select Part_No__c,Part_Description__c,Raw_Material_Grade__c,Raw_Material_Specification__c,EAU_in_no_s__c,SYS_Unit_Price_For_Bulk_new__c,
      Remarks__c,Material_Cost_Pc_new__c,BOI_Cost_Pc_new__c,Spl_Process_Cost_Pc_new__c,Processing_Cost_Pc_new__c,Batch_Quantity__c,Total_value_new__c,FAI_Cost_Pc_new__c,
      One_Time_Dev_Cost_NRE_new__c
       from Quote_Items__c where Quote__c=:ApexPages.CurrentPage().getParameters().get('id')];

    return Q;
    
    }

}