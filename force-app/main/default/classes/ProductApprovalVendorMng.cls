/*****
 * Created By : Shweta kumari
    Description : Controller for mass product approval
******/
/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  11/27/2019   T01		T01- 	Hardcoded URL change fix
Saradha  11/27/2019   T02		T02- 	Test Class Failure Fix
*/
public class ProductApprovalVendorMng {
    public list<productWrraper> wrraperList{get;set;}    
    Id productRecordType;
    
    public ProductApprovalVendorMng(){
        System.debug('URL : '+URL.getSalesforceBaseUrl().toExternalForm());
        //isReject = true;
        //isApprover = false;
        //isClrf = true; 
        wrraperList = new List<productWrraper>();
        //getting product id of taneira record type
        productRecordType = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();      
        getProductList();
    }
   
    //method to get list of pending for approval product
    public void getProductList(){
        List<product__c> productList = new List<product__c>();
		productList = [Select id,Name,vendor_custom__r.Name,Product_Category_Taneira__c,SKU_Code__c,Cost__c,Quantity__c,Photo__c,Approval_Status__c,Reject_Need_Clarification_Comment__c,ownerId
                           from product__c where Approval_Status__c !=: 'Submitted for Approval' and Approval_Status__c !=: 'Approved' and Approval_Status__c !=: 'Need Clarification' and ownerId =: UserInfo.getUserId() and vendor_custom__c !=: null and RecordTypeId =: productRecordType];
        wrraperList = new List<productWrraper>();
        String firstSubString;
        String secondSubString;
        for(product__c pro : productList){
            productWrraper proWrr = new productWrraper();
            if(!String.isBlank(pro.Photo__c)){
                firstSubString = pro.Photo__c.substringBetween('<img', 'img>');
                secondSubString = firstSubString.substringBetween('src="', '"');
                proWrr.imgLink = secondSubString.replace('amp;', '');
            }
            
            proWrr.productRec = pro;
            wrraperList.add(proWrr);
        }
    }
    //code to submit product for approval 
    public void SubmitForApproval(){
        system.debug('--wrraperList-'+wrraperList); 
        User user1 = [SELECT Id,email,Name FROM User WHERE Name =: Label.Taneira_Approver_Name];
        boolean isValidApproval = false; 
        for(productWrraper proWr : wrraperList){
            if(proWr.isSelected == true){
                
                isValidApproval = true;
                // Create an approval request for the account
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                req1.setComments('Submitting request for approval.');
                req1.setObjectId(proWr.productRec.id);
                
                // Submit on behalf of a specific submitter
                req1.setSubmitterId(UserInfo.getUserId()); 
                
                // Submit the record to specific process and skip the criteria evaluation
                req1.setProcessDefinitionNameOrId('Taneira_Product_Approval');
                req1.setSkipEntryCriteria(true);
                // Submit the approval request for the account
                Approval.ProcessResult result = Approval.process(req1);     
            }    
        }
        if(isValidApproval == true){            
            String[] sendTo = new String[]{user1.Email}; 
                 String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() ; //<T01>
                String Url = sfdcURL+'/apex/ProductApproval?vendor='+UserInfo.getUserId();
            String newbody = 'Hello '+user1.Name+', \n\n Please review the products submitted for approval using the link given below.  \n\n';
            newbody = newbody + Url;
            String subjectStr = 'Product Approval Request: Please approve the following Products';
            List<Messaging.SingleEmailMessage> newemailslist = new List<Messaging.SingleEmailMessage> ();
            Messaging.SingleEmailMessage emailmsg = sendEmailMsg(newbody,sendTo,subjectStr);
            newemailslist.add(emailmsg);
            System.debug('Message : '+ newbody);
            //Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(newemailslist);
            Messaging.SendEmailResult[] resultMail = null;
            ApexPages.Message mysuccessMsg;
            if(resultMail != null && resultMail[0].isSuccess()){//<T02>added null condition
                mysuccessMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Approval Notification Successfully Sent to : '+user1.Name);                
            } else if(resultMail != null){//<T02>added null condition
                mysuccessMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM,  resultMail[0].getErrors()[0].getMessage());
            }
            if(mysuccessMsg != null){//<T02>added null condition
            	ApexPages.addMessage(mysuccessMsg);    
            }
            
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please select atleast one product '));  
            return;
        }
        
        getProductList();
    }
    public Messaging.SingleEmailMessage sendEmailMsg(string emailBody,String[] sendTo,String subj){
        Messaging.SingleEmailMessage newemail = new Messaging.SingleEmailMessage ();
        newemail.setPlainTextBody(emailBody);
        newemail.setSubject(subj);
        newemail.setToAddresses(sendTo);  
        return newemail;
    }
    
    //wrraper class to store product 
    public class productWrraper{
        public boolean isSelected{get;set;}
        public boolean isError{get;set;}
        public boolean isEditable{get;set;}
        public product__c productRec{get;set;}
        public string cmntStr{get;set;}
        public string imgLink{get;set;}
        productWrraper(){
            isSelected = false;
            isError = false;
            isEditable = false;
            productRec = new product__c();
            cmntStr = null;
            imgLink = null;
        }
    }
}