public class VendorDetailPageController{
     id accId ;
     public boolean isLocked{get;set;}
     public boolean isAccLocked{get;set;}
     public string message {get;set;}
      public boolean isAllProd{get;set;}
    public vendor__c account {get;set;}
 //   public string ownerName {get;set;}
    public List<Product__c> prodListAll {get;set;}
     public VendorDetailPageController(ApexPages.StandardController controller){
         accId = apexpages.currentpage().getparameters().get('Id');
       //  ownerName = UserInfo.getName();
         account = [SELECT Id, Name, Vendor_Code__c,Type__c,Category__c,Pricing_Type__c,OwnerId,Owner.Name,Approval_date__c,Approval_Status__c,Title__c,Name_1__c,Name_2__c,Mobile_Phone__c,Country__c,Postal_code__c,
                    PAN_Number__c,Email_Id_Vendor__c ,TIN_CST_Number__c,Payment_Terms__c,Payment_Methods__c,CurrencyIsoCode,Incoterms__c,Name__c,IFSC__c,Account_Number__c,Mail_ID__c,
                    Phone_No__c, (SELECT Id,name,Photo__c,Design_Story__c ,Product_Category_Taneira__c,Comments__c,Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,
                     colour__c,Zari_Type__c,Cluster__c,vendor_custom__c,vendor_custom__r.name,Vendor_Name__c,Cost__c,Quantity__c,Taneira_Material_Weft__c,
                     Saree_Dimensions__c,SKU_Code__c,Blouse_Dimensions__c,Material_Wrap__c,Article_Number__c,Design_Type__c From Products__r LIMIT 5) FROM vendor__c WHERE Id = : accId];
         isLocked = false;
         isAllProd = false;
         system.debug('***Product11**'+account.Products__r.size());
        isAccLocked = Approval.isLocked(accId);
        system.debug('***isAccLocked **'+isAccLocked );
          if(account.Products__r.size()>0){
         system.debug('***Product**'+account.Products__r.size());
             isAllProd = true;
          
        }
         
     }
     public pageReference editAcc(){
         if(Approval.isLocked(accId)){
              isLocked = true; 
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Record Is Locked'));
              return null;
           }
         pageReference pr = new pageReference('/apex/VendorCreatePage?id='+accId);
         pr.setRedirect(True);
         return pr;
     }
   /*  public pagereference deleteAccount(){
         system.debug('***Approval.isLocked(accId)**'+Approval.isLocked(accId));
         Account accToDelete = [Select Id From account where Id =: accId];
         try{
             if(Approval.isLocked(accId)){
              isLocked = true; 
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Record Is Locked'));
              return null;
           }
         else{
             delete Account;
             PageReference pr = new PageReference('/001/o');
             pr.setRedirect(True);
             return pr;
         }
             
         }
         catch(Exception ex){
             System.debug('Exception On delete=== '+ex);
         }
         return null;
         
     } */
     public void viewAllProducts(){
         prodListAll = [Select Id,name,Photo__c,Design_Story__c ,Product_Category_Taneira__c,Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,
                         colour__c,Zari_Type__c,Cluster__c,vendor_custom__c,vendor_custom__r.name,Vendor_Name__c,Comments__c,Cost__c,Quantity__c,Taneira_Material_Weft__c,
                         Saree_Dimensions__c,SKU_Code__c,Blouse_Dimensions__c,Material_Wrap__c,Article_Number__c,Design_Type__c,Product_Type__c From Product__c where vendor_custom__c =: accId LIMIT 49999];
     }
     public void submitAndProcessApprovalRequest(){
         try{
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
         //   req1.setComments('Submitting request for approval.');
            req1.setObjectId(accId);
            
            // Submit on behalf of a specific submitter
            req1.setSubmitterId(account.OwnerId); 
            
            // Submit the record to specific process and skip the criteria evaluation
            req1.setProcessDefinitionNameOrId('Vendor_process');
            req1.setSkipEntryCriteria(false);
            
            // Submit the approval request for the account
            Approval.ProcessResult result = Approval.process(req1); 
            Approval.isLocked(accId);
            isLocked = true; 
            system.debug('===result==='+result);
        }
        catch(DMLException ex){
            message = ex.getDmlMessage(0);
            System.debug('Exception'+ex);
        }
     
     }
     public pageReference redirectToCreate(){
         PageReference pr = new PageReference('/apex/ProductCategorySelectPage?source=New&AccontId='+accId);
         pr.setRedirect(true);
         return pr;
     }
     
     
}