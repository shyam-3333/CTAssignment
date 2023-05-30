/************************************************************************************************************************************************
Created By : Poornapriya YN
Description : ProductApprovalEmailForSapTeam will send an Email To SAP Team Everyday with Products and Accounts which are approved the same day
*************************************************************************************************************************************************/

global class ProductApprovalEmailForSapTeam implements Schedulable {
   
    global void execute(SchedulableContext ctx) {
        List<Messaging.Emailfileattachment> efaList = new List<Messaging.Emailfileattachment>();
        Boolean isAttachment = false;
        blob prAttachVendorAsBlob;
        integer count= 0;
        Integer numOfVendors = [SELECT count() FROM vendor__c Where Approval_Date__c = YESTERDAY];
        Integer numOfProducts = [SELECT count() FROM Product__c Where Approval_Date__c = YESTERDAY];
        if(numOfVendors > 0){
           // count++;
           isAttachment = True;
            PageReference prAttach = Page.VendorEmailAttachmentPage;  // Rendering Vendor page for email attachment
            prAttach.setRedirect(true); 
            if(Test.isRunningTest()){
                prAttachVendorAsBlob = Blob.valueOf('UNIT TEST');
            }
            else{ 
                prAttachVendorAsBlob = prAttach.getContent();
            }
            Messaging.Emailfileattachment efaAcc = new Messaging.Emailfileattachment();
            efaAcc.setBody(prAttachVendorAsBlob);
            efaAcc.setFileName('Approved Vendors '+Date.today().addDays(-1).format()+'.xls');
            efaList.add(efaAcc);
        } // end of if(numOfVendors > 0)
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        if(numOfProducts > 0){
           // count++;
            isAttachment = True;
            PageReference prAttach = Page.ProductEmailAttachmentPage;  // Rendering Product page for email attachment
            prAttach.setRedirect(true); 
            blob prAttachAsBlob;
            if(Test.isRunningTest()){
                prAttachAsBlob = Blob.valueOf('UNIT TEST');
            }
            else{ 
                prAttachAsBlob = prAttach.getContent();
            }
            Messaging.Emailfileattachment efaPro = new Messaging.Emailfileattachment();
            efaPro.setBody(prAttachAsBlob);
            efaPro.setFileName('Approved Products '+Date.today().addDays(-1).format()+'.xls');
            efaList.add(efaPro);
        } //end of if(numOfProducts > 0)
        string body;
        List<String> ToAddress = new List<String>();
        ToAddress.add('anandv@titan.co.in');   // SAP Team Email Id
        List<String> ccAddress = new List<String>();
        ccAddress.add('manjunatha@titan.co.in');  
        ccAddress.add('sivaramakrishnan@titan.co.in');
        ccAddress.add('anindita@titan.co.in'); // cc to Sap Team 
        email.setSubject('Taneira Products/Vendors Approved' );
        if(isAttachment == True){
            body = '<html><body>Hi,<br/><br/>Please find attached the list of Vendors/Products that have been approved on ' +Date.today().addDays(-1).format() +'.<br/><br/> Thanks\n</body></html>';
        }
        else{  // If there are no products/Account Approved for the day
            body = '<html><body>Hi,<br/><br/>There are no Vendors/Products that have been approved on ' +Date.today().addDays(-1).format() +'.<br/><br/> Thanks\n</body></html>';
        }
        
        email.setHTMLBody(body);
        email.setFileAttachments(efaList);
        email.setToAddresses(ToAddress);
        email.setCcAddresses(ccAddress);
        email.setSaveAsActivity(false);
        try{ 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email }); 
        }
        catch(EmailException Ex){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Ex.getMessage());
            ApexPages.addMessage(msg);
        }
    }
    
}