public class ProductApprovalClass {
    public list<productWrraper> wrraperList{get;set;}
    public string selectedVMng{get;set;}
    public string selectedVendor{get;set;}
    public list<selectoption>VendorMng{get;set;}
    public List<SelectOption> vendorSelectList{ get; set; }
    Map<id,user> userMap = new Map<id,User>();
    public boolean isReject{get;set;}
    public boolean isClrf{get;set;}
    Id productRecordType;
    
    public ProductApprovalClass(){
        isReject = true;
        isClrf = true; 
        wrraperList = new List<productWrraper>();
        //getting product id of taneira record type
        productRecordType = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        if(apexpages.currentpage().getparameters().get('vendor') != '' && apexpages.currentpage().getparameters().get('vendor') != null){
                selectedVMng = apexpages.currentpage().getparameters().get('vendor');  
            system.debug('---selectedVMng---'+selectedVMng);
            
        }
        ValueforVendorMng();
        getVendorsList();        
    }
    
     //method to get list of vendor managers
    public void ValueforVendorMng(){        
        VendorMng =  new List<SelectOption>();
        String[] vendorMgrProfile = Label.Taneira_Vendor_Manager_Profile.split(',');
        set<string> profileSet = new set<string>();
        for(String pro : vendorMgrProfile){
          profileSet.add(pro.trim());    
        }
        profileSet.add(Label.Taneira_Approver_Profile);
        userMap =new Map<id,user>( [Select id,Name,Email from user where Profile.Name IN: profileSet and IsActive =: true Order By Name]);
        VendorMng.add(new SelectOption('','--None--'));
        for (User ur : userMap.values()){
            VendorMng.add(new SelectOption(ur.id,ur.name));
        }      
    } 
    //method to get list of vendors
    public void getVendorsList(){
        vendorSelectList = new List<SelectOption>();
        List<vendor__c> vendorList = new List<vendor__c>();
       // Id vendorRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        //if vendor mng is selected 
        if(selectedVMng != null){
            vendorList = [SELECT Id,Name FROM vendor__c WHERE OwnerId =: selectedVMng Order By Name];     
        }
        //if vendor mng is not selected 
        else{
            vendorList = [SELECT Id,Name FROM vendor__c Order By Name];        
        }
        vendorSelectList.add(new SelectOption('','--None--'));
        for (vendor__c acc : vendorList){
            vendorSelectList.add(new SelectOption(acc.id,acc.name));
        }
        getProductList();
    }
    
    //method to get list of pending for approval product
    public void getProductList(){
        List<product__c> productList = new List<product__c>();
               
        //if mangaer and vendor is selected 
        if(selectedVMng != null && selectedVendor != null){
            productList = [Select id,Name,vendor_custom__r.Name,Product_Category_Taneira__c,SKU_Code__c,Cost__c,Quantity__c,Photo__c,Approval_Status__c,Reject_Need_Clarification_Comment__c,ownerId
                           from product__c where (Approval_Status__c =: 'Submitted for Approval' OR Approval_Status__c =: 'Need Clarification') and ownerId =: selectedVMng and vendor_custom__c =: selectedVendor and RecordTypeId =: productRecordType order by Approval_Submitted_Date__c];    
        }
        //only vendor manager selected
        else if(selectedVMng != null && selectedVendor == null){
            productList = [Select id,Name,vendor_custom__r.Name,Product_Category_Taneira__c,SKU_Code__c,Cost__c,Quantity__c,Photo__c,Approval_Status__c,Reject_Need_Clarification_Comment__c,ownerId
                           from product__c where (Approval_Status__c =: 'Submitted for Approval' OR Approval_Status__c =: 'Need Clarification') and ownerId =: selectedVMng and vendor_custom__c !=: null and RecordTypeId =: productRecordType order by Approval_Submitted_Date__c];        
            system.debug('--productList1--'+productList);
        }
        //only vendor selected
        else if(selectedVMng == null && selectedVendor != null){
            productList = [Select id,Name,vendor_custom__r.Name,Product_Category_Taneira__c,SKU_Code__c,Cost__c,Quantity__c,Photo__c,Approval_Status__c,Reject_Need_Clarification_Comment__c,ownerId
                           from product__c where (Approval_Status__c =: 'Submitted for Approval' OR Approval_Status__c =: 'Need Clarification') and vendor_custom__c =: selectedVendor and RecordTypeId =: productRecordType order by Approval_Submitted_Date__c];        
        }
        //if no filter selected
        else{
            productList = [Select id,Name,vendor_custom__r.Name,Product_Category_Taneira__c,SKU_Code__c,Cost__c,Quantity__c,Photo__c,Approval_Status__c,Reject_Need_Clarification_Comment__c,ownerId
                           from product__c where (Approval_Status__c =: 'Submitted for Approval' OR Approval_Status__c =: 'Need Clarification')and vendor_custom__c !=: null and RecordTypeId =: productRecordType order by Approval_Submitted_Date__c];  
            system.debug('--productList--'+productList);
        }
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
    //code to approve product
    public void approveProduct(){
        Map<id,List<product__c>> ownerProductMap = new Map<id,List<Product__c>>();
        List<product__C> tempList = new List<product__c>();
        List<product__C> proListToApprove = new List<product__c>();
        boolean isApprove = false;
        integer slectCount = 0;
        boolean noOtherProduct = true;
        for(productWrraper proWr : wrraperList){
            if(proWr.isSelected == true){
                slectCount++;
                if(proWr.productRec.SKU_Code__c.contains('XXX')){
                  noOtherProduct = false;
                    break;
                }
                else{
                  proListToApprove.add(proWr.productRec);    
                }
            }
    }
        if(noOtherProduct == true){
      for(product__c pro : proListToApprove){
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setComments('Approving request');
        req.setAction('Approve');
        Id workItemId = getWorkItemId(pro.id);
        if(workItemId == null){
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Error Occured in Approval Process '));
          return;
        }
        else{
          req.setWorkitemId(workItemId);
          // Submit the request for approval
          Approval.ProcessResult result =  Approval.process(req);
          tempList = new List<product__c>();
          if(ownerProductMap.containsKey(pro.ownerId)){
            tempList.addAll(ownerProductMap.get(pro.ownerId));     
          }
          tempList.add(pro);
          ownerProductMap.put(pro.ownerId, tempList);
          isApprove = true;
        }
      }
    }
    else{
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Products that have \'XXX\' in SKU Code cannot be approved.Please deselect those products and continue.'));  
            return;
    }    
   
         //validate if no check box is selected
        if(slectCount <= 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please select atleast one product '));  
            return;    
        }
    system.debug('---isApprove---'+isApprove);
        if(isApprove == true){
            List<Messaging.SingleEmailMessage> newemailslist = new List<Messaging.SingleEmailMessage> ();
            String subjectStr = 'Product Approved';
            List<String> sendTo = new List<String>();
            String mailbody = '';
      List<String> ccToUser = new List<String>();
      ccToUser.add('anandv@titan.co.in');
            ccToUser.add('manjunatha@titan.co.in');
            for(String userId : ownerProductMap.keySet()){
                if(UserMap.containsKey(userId) && UserMap.get(userId) != null) {
                    sendTo.add(UserMap.get(userId).email);       
                    mailbody = 'Hello '+UserMap.get(userId).Name+', \n\n A few of your products have been Approved.Please find the name of the approved products below:\n';
                    for(Product__c pro: ownerProductMap.get(userId))
                        mailbody = mailbody + pro.Name+': '+pro.SKU_Code__c+',';
                    Messaging.SingleEmailMessage emailmsg = sendEmailMsg(mailbody,sendTo,subjectStr,ccToUser);
                    newemailslist.add(emailmsg);
                }
            }
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(newemailslist);
        }
        getProductList();
    }
    //code to reject product
    public void rejectProduct(){
        List<product__c> productToReject = new List<product__c>();
        isReject = true;
        boolean rejectSusses = true;
        integer slectCount = 0;
        Map<id,List<product__c>> ownerProductMap = new Map<id,List<Product__c>>();
        List<product__C> tempList = new List<product__c>();        
        for(productWrraper proWr : wrraperList){
            if(proWr.isSelected == true){
                slectCount++;
                if(proWr.productRec.Reject_Need_Clarification_Comment__c == null || string.isBlank(proWr.productRec.Reject_Need_Clarification_Comment__c)){
                    proWr.isError = true;
                    isReject = false;
                }
                
                else{
                    proWr.isEditable = true;
                    productToReject.add(proWr.productRec);                    
                }
            } 
        }
        //validate if atlest on check box is selected
        if(slectCount <= 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please select atleast one product '));  
            return;    
        }
        if(isReject == true){
            
            for(product__c pro : productToReject){
                Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
                req.setComments('Reject request');
                req.setAction('Reject');
                Id workItemId = getWorkItemId(pro.id);
                if(workItemId == null){
                    rejectSusses = false;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Error Occured in Approval Process '));
                    return;
                }
                else{
                    req.setWorkitemId(workItemId);
                    // Submit the request for approval
                    Approval.ProcessResult result =  Approval.process(req);
                    pro.Approval_Status__c = 'Rejected';
                } 
                tempList = new List<product__c>();
                if(ownerProductMap.containsKey(pro.ownerId)){
                    tempList.addAll(ownerProductMap.get(pro.ownerId));      
                }
                tempList.add(pro);
                ownerProductMap.put(pro.ownerId, tempList);
            }
            if(rejectSusses == true){
                List<Messaging.SingleEmailMessage> newemailslist = new List<Messaging.SingleEmailMessage> ();
                String subjectStr = 'Product Rejected';
                List<String> sendTo = new List<String>();
        List<String> ccTo = new List<String>();
                String mailbody = '';
                string proDec = '';
                for(String userId : ownerProductMap.keySet()){
                    if(UserMap.containsKey(userId) && UserMap.get(userId) != null){ 
                        sendTo.add(UserMap.get(userId).email);       
                        mailbody = 'Hello '+UserMap.get(userId).Name+', \n\n A few of your products have been rejected.Please find the name of the rejected products below:\n';
                        for(Product__c pro: ownerProductMap.get(userId)){
                        if(proDec == '')
                            proDec = proDec + pro.Name +' : '+pro.Reject_Need_Clarification_Comment__c;
                        else
                            proDec = proDec +',\n'+ pro.Name +' : '+pro.Reject_Need_Clarification_Comment__c;                        
                        }
                        mailbody = mailbody + proDec;
                        Messaging.SingleEmailMessage emailmsg = sendEmailMsg(mailbody,sendTo,subjectStr,ccTo);
                        newemailslist.add(emailmsg);
                    }
                }
                Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(newemailslist);
                Update productToReject;
            }
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please provide reject comment for one or more product'));
            return;
        }
        getProductList();
    }
    //code for need clarification
    public void needClarification(){
        List<Product__c> productToNeedClf = new List<product__c>();
        isClrf = true;
        Map<id,List<product__c>> ownerProductMap = new Map<id,List<Product__c>>();
        List<product__C> tempList = new List<product__c>(); 
        integer slectCount = 0;
        for(productWrraper proWr : wrraperList){
            if(proWr.isSelected == true){
                slectCount++;
                if(proWr.productRec.Reject_Need_Clarification_Comment__c == null || string.isBlank(proWr.productRec.Reject_Need_Clarification_Comment__c)){
                    proWr.isError = true;
                    isClrf = false;
                }
                
                else{
                    proWr.isEditable = true;
                    productToNeedClf.add(proWr.productRec);                   
                }
            } 
        } 
         //validate if atlest on check box is selected
        if(slectCount <= 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please select atleast one product '));  
            return;    
        }
        if(isClrf == true){
            for(product__c pro : productToNeedClf){                
                pro.Approval_Status__c = 'Need Clarification';
                tempList = new List<product__c>();
                if(ownerProductMap.containsKey(pro.ownerId)){
                    tempList.addAll(ownerProductMap.get(pro.ownerId));      
                }
                tempList.add(pro);
                ownerProductMap.put(pro.ownerId, tempList);
            }
            List<Messaging.SingleEmailMessage> newemailslist = new List<Messaging.SingleEmailMessage> ();
            List<String> sendTo = new List<String>();
      List<String> ccTo = new List<String>();
            String mailbody = '';
            string proDec = '';
            String subjectStr = 'Product Need Clarification';
            for(String userId : ownerProductMap.keySet()){
                if(UserMap.containsKey(userId) && UserMap.get(userId) != null) {
                    sendTo.add(UserMap.get(userId).email);       
                    mailbody = 'Hello '+UserMap.get(userId).Name+', \n\n A few of your products need clarification .Please find the product details below: \n';
                    for(Product__c pro: ownerProductMap.get(userId)){
                        if(proDec == '')
                            proDec = proDec + pro.Name +' : '+pro.Reject_Need_Clarification_Comment__c;
                        else
                            proDec = proDec +',\n'+ pro.Name +' : '+pro.Reject_Need_Clarification_Comment__c;                        
                    }
                    mailbody = mailbody + proDec;
                    Messaging.SingleEmailMessage emailmsg = sendEmailMsg(mailbody,sendTo,subjectStr,ccTo);
                    newemailslist.add(emailmsg);
                }
            }
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(newemailslist);            
            Update productToNeedClf;    
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please provide need clarification comment for one or more product'));
            return;
        }
        getProductList();
    }
    public Id getWorkItemId(Id targetObjectId){
        Id retVal = null;
        
        for(ProcessInstanceWorkitem workItem  : [Select p.Id from ProcessInstanceWorkitem p where p.ProcessInstance.TargetObjectId =: targetObjectId])
        {
            retVal  =  workItem.Id;
        }
        
        return retVal;
    }
    public Messaging.SingleEmailMessage sendEmailMsg(string emailBody,String[] sendTo,String subj,String[] ccTo){
        Messaging.SingleEmailMessage newemail = new Messaging.SingleEmailMessage ();
        newemail.setPlainTextBody(emailBody);
        newemail.setSubject(subj);
        newemail.setToAddresses(sendTo);  
    newemail.setCCAddresses(ccTo);
        return newemail;
    }
    //class to cancle the reject and need approval process
    public void CancelProcess(){
        isClrf = true;
        isReject = true;
        for(productWrraper proWr : wrraperList){
            if(proWr.isSelected == true){
               proWr.isError = false;    
            } 
        } 
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