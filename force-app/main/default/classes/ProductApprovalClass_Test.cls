/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/8/2019    TO1    Fixing test class issue
*/
@istest

public class ProductApprovalClass_Test {
    
    static testMethod void TestProductVendor(){
        TriggerExecutionController__c tt1 = new TriggerExecutionController__c();
        tt1.Name = 'QRcodeAPI';
        tt1.TriggerIsActive__c = false;
        insert tt1;
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
       // Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        String[] vendorMgrProfile = Label.Taneira_Vendor_Manager_Profile.split(',');
        set<string> profileSet = new set<string>();
        for(String pro : vendorMgrProfile){
            profileSet.add(pro.trim());    
        }
        Profile Vendorprofile = [Select Id From Profile Where Name IN: vendorMgrProfile Limit 1];                
        Id p = [select id from profile where name='System Administrator'].id;
        User user2 = new User(  firstname = 'Poornapriya',
                              lastName = 'YN',
                              email = 'poorna@kvpcorp.com',
                              Username = 'poorna11@kvpcorp.com',
                              EmailEncodingKey = 'ISO-8859-1',
                              Alias = 'pyn',
                              TimeZoneSidKey = 'America/Los_Angeles',
                              LocaleSidKey = 'en_US',
                              LanguageLocaleKey = 'en_US',
                              ProfileId = Vendorprofile.id);
        insert user2;
        vendor__c acc;
        User approverUser = [Select id,Name from user where Name =: Label.Taneira_Approver_Name];
        system.runAs(user2){
            acc = new vendor__c();
            acc.Name = 'TestAccount';
           // acc.RecordTypeId = recordTypeIdAcc;
            //acc.OwnerId = user2.Id;
            acc.Phone_No__c = '1234567';
            insert acc;
            
            Product__c pro = new Product__c();
            //pro.OwnerId = user2.Id;
            pro.Name = 'TestTan';
            pro.vendor_custom__c = acc.id;
            pro.RecordTypeId = recordTypeId;
            pro.cost__c = 123;
            pro.Suggested_MRP__c= 123;
            pro.Quantity__c= 123;
            pro.Colour__c = 'Red';
            pro.Workmanship__c = 'Ajrak';
            pro.Design_Story__c = 'Shikargah';
            pro.Loom__c ='Handloom';
            pro.Taneira_Material_Weft__c ='Silk';
            pro.Material_Wrap__c='Silk';
            pro.Nature__c ='Handmade product of India';
            pro.Occasion__c = 'Wedding';
            pro.Cluster__c ='Assam';
            pro.Product_Category_Taneira__c ='Saree';
            pro.Route__c ='Colourway';
            pro.Zari_Type__c = 'NIL';
            pro.Proc_Type__c ='Trading';
            
           
            
            //pro.Approval_Status__c = 'Submitted for Approval';
            
                insert pro;
            Attachment attach = new Attachment();
            attach.Name = 'TestAttach.png'; 
            attach.body =  blob.valueOf('Test1');         
            attach.OwnerId = user2.id;
            attach.ParentId = pro.id; 
            attach.IsPrivate = true;
            
            insert attach;
            pro.Reject_Need_Clarification_Comment__c = 'Test';
            pro.Photo__c =  '<img src="https://cs14.salesforce.com/servlet/servlet.FileDownload?file='+attach.id+'" width="500" height="281"></img>';
            update pro;            
            ProductApprovalVendorMng prodCont1 = new ProductApprovalVendorMng();
            for(ProductApprovalVendorMng.productWrraper wrap : prodCont1.wrraperList){
                wrap.isSelected = true;
            }
            prodCont1.SubmitForApproval();
            //pro.Approval_Status__c = 'Submitted for Approval';
            //update pro;
        }
            //
        system.runAs(approverUser){   
            PageReference pageRef = Page.ProductApproval; 
            pageRef.getParameters().put('Vendor', user2.id);
            Test.setCurrentPage(pageRef);
            
            ProductApprovalClass prodCont = new ProductApprovalClass();
            //ProductApprovalVendorMng.productWrraper wrap = new  ProductApprovalVendorMng.productWrraper();
            prodCont.selectedVendor = acc.Id;
            prodCont.isClrf = true;
            try{
                prodCont.rejectProduct();
            }
            catch(exception ex){
                
            }       
            for(ProductApprovalClass.productWrraper wrap : prodCont.wrraperList){
                wrap.isSelected = true;
            }
            prodCont.rejectProduct();
        }
    }
    static testMethod void TestProductVendor2(){
        TriggerExecutionController__c tt1 = new TriggerExecutionController__c();
        tt1.Name = 'QRcodeAPI';
        tt1.TriggerIsActive__c = false;
        insert tt1;
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
       // Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        String[] vendorMgrProfile = Label.Taneira_Vendor_Manager_Profile.split(',');
        set<string> profileSet = new set<string>();
        for(String pro : vendorMgrProfile){
            profileSet.add(pro.trim());    
        }
        Profile Vendorprofile = [Select Id From Profile Where Name IN: vendorMgrProfile Limit 1];                
        Id p = [select id from profile where name='System Administrator'].id;
        User user2 = new User(  firstname = 'Poornapriya',
                              lastName = 'YN',
                              email = 'poorna@kvpcorp.com',
                              Username = 'poorna221@kvpcorp.com',
                              EmailEncodingKey = 'ISO-8859-1',
                              Alias = 'pyn',
                              TimeZoneSidKey = 'America/Los_Angeles',
                              LocaleSidKey = 'en_US',
                              LanguageLocaleKey = 'en_US',
                              ProfileId = Vendorprofile.id);
        insert user2;
		vendor__c acc;
        User approverUser = [Select id,Name from user where Name =: Label.Taneira_Approver_Name];
        system.runAs(user2){
            acc = new vendor__c();
            acc.Name = 'TestAccount';
         //   acc.RecordTypeId = recordTypeIdAcc;
            //acc.OwnerId = user2.Id;
            acc.Phone_No__c = '1234567';
            acc.Vendor_Code__c='122333';
            insert acc;
            
            Product__c pro = new Product__c();
            //pro.OwnerId = user2.Id;
            pro.Name = 'TestTan1';
            pro.vendor_custom__c = acc.id;
            pro.RecordTypeId = recordTypeId;
            pro.cost__c = 123;
            pro.Suggested_MRP__c= 123;
            pro.Quantity__c= 123;
            pro.Colour__c = 'Red';
            pro.Workmanship__c = 'Ajrak';
            pro.Design_Story__c = 'Shikargah';
            pro.Loom__c ='Handloom';
            pro.Taneira_Material_Weft__c ='Silk';
            pro.Material_Wrap__c='Silk';
            pro.Nature__c ='Handmade product of India';
            pro.Occasion__c = 'Wedding';
            pro.Cluster__c ='Assam';
            pro.Body_Pattern__c ='NIL';
            pro.Border_Pattern__c='qwer';
            pro.Pallu_Pattern__c='qwer';
            pro.Base_Colour__c='Black';
            pro.RE_ORDER__c =false;
            pro.SKU_Code__c ='12321';
            pro.Product_Category_Taneira__c ='Saree';
            pro.Route__c ='Colourway';
            pro.Zari_Type__c = 'NIL';
            pro.Proc_Type__c ='Trading';
            
            insert pro;
            Attachment attach = new Attachment();
            attach.Name = 'TestAttach.png'; 
            attach.body =  blob.valueOf('Test1');         
            attach.OwnerId = user2.id;
            attach.ParentId = pro.id; 
            attach.IsPrivate = true;
            
            insert attach;
            pro.Reject_Need_Clarification_Comment__c = 'Test';
            pro.Photo__c =  '<img src="https://cs14.salesforce.com/servlet/servlet.FileDownload?file='+attach.id+'" width="500" height="281"></img>';
            pro.Approval_Status__c = 'Submitted for Approval';//T01
            update pro;
            
           
            
            
            ProductApprovalVendorMng prodCont1 = new ProductApprovalVendorMng();
            for(ProductApprovalVendorMng.productWrraper wrap : prodCont1.wrraperList){
                wrap.isSelected = true;
            }
            prodCont1.SubmitForApproval();
		}
           // pro.Approval_Status__c = 'Submitted for Approval';
           // update pro;
		system.runAs(approverUser){
            PageReference pageRef = Page.ProductApproval; 
            pageRef.getParameters().put('Vendor', user2.id);
            Test.setCurrentPage(pageRef);
            ProductApprovalClass prodCont = new ProductApprovalClass();
            //ProductApprovalVendorMng.productWrraper wrap = new  ProductApprovalVendorMng.productWrraper();
            prodCont.selectedVendor = acc.Id;
            prodCont.isClrf = true;
            try{
                prodCont.needClarification();
            }
            catch(exception ex){
                
            }       
            system.debug('----prodCont.wrraperList---'+prodCont.wrraperList);
            for(ProductApprovalClass.productWrraper wrap : prodCont.wrraperList){
                wrap.isSelected = true;
            }
            prodCont.needClarification();
            prodCont.CancelProcess();
        }
        //prodCont.approveProduct();
    }
    static testMethod void TestProductVendor3(){
        TriggerExecutionController__c tt1 = new TriggerExecutionController__c();
        tt1.Name = 'QRcodeAPI';
        tt1.TriggerIsActive__c = false;
        insert tt1;
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
       // Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        String[] vendorMgrProfile = Label.Taneira_Vendor_Manager_Profile.split(',');
        set<string> profileSet = new set<string>();
        for(String pro : vendorMgrProfile){
            profileSet.add(pro.trim());    
        }
        Profile Vendorprofile = [Select Id From Profile Where Name IN: vendorMgrProfile Limit 1];                
        Id p = [select id from profile where name='System Administrator'].id;
        User user2 = new User(  firstname = 'Poornapriya',
                              lastName = 'YN',
                              email = 'poorna@kvpcorp.com',
                              Username = 'poorna331@kvpcorp.com',
                              EmailEncodingKey = 'ISO-8859-1',
                              Alias = 'pyn',
                              TimeZoneSidKey = 'America/Los_Angeles',
                              LocaleSidKey = 'en_US',
                              LanguageLocaleKey = 'en_US',
                              ProfileId = Vendorprofile.id);
        insert user2;
		vendor__c acc;
        User approverUser = [Select id,Name from user where Name =: Label.Taneira_Approver_Name];
        system.runAs(user2){
            acc = new vendor__c();
            acc.Name = 'TestAccount';
           // acc.RecordTypeId = recordTypeIdAcc;
            //acc.OwnerId = user2.Id;
            acc.Phone_No__c = '1234567';
            insert acc;
            
            Product__c pro = new Product__c();
            //pro.OwnerId = user2.Id;
            pro.Name = 'TestTan2';
            pro.vendor_custom__c = acc.id;
            pro.RecordTypeId = recordTypeId;
            pro.cost__c = 123;
            pro.Suggested_MRP__c= 123;
            pro.Quantity__c= 123;
            pro.Colour__c = 'Red';
            pro.Workmanship__c = 'Ajrak';
            pro.Design_Story__c = 'Shikargah';
            pro.Loom__c ='Handloom';
            pro.Taneira_Material_Weft__c ='Silk';
            pro.Material_Wrap__c='Silk';
            pro.Nature__c ='Handmade product of India';
            pro.Occasion__c = 'Wedding';
            pro.Cluster__c ='Assam';
            pro.Body_Pattern__c ='NIL';
            pro.Border_Pattern__c='qwer';
            pro.Pallu_Pattern__c='qwer';
            pro.Base_Colour__c='Black';
            pro.RE_ORDER__c =false;
            pro.SKU_Code__c ='12321';
            pro.Product_Category_Taneira__c ='Saree';
            pro.Route__c ='Colourway';
            pro.Zari_Type__c = 'NIL';
            pro.Proc_Type__c ='Trading';
           // pro.Approval_Status__c = 'Submitted for Approval';
            
            insert pro;
            Attachment attach = new Attachment();
            attach.Name = 'TestAttach.png'; 
            attach.body =  blob.valueOf('Test1');         
            attach.OwnerId = user2.id;
            attach.ParentId = pro.id; 
            attach.IsPrivate = true;
            
            insert attach;
            pro.Reject_Need_Clarification_Comment__c = 'Test';
            pro.Photo__c =  '<img src="https://cs14.salesforce.com/servlet/servlet.FileDownload?file='+attach.id+'" width="500" height="281"></img>';
            pro.SKU_Code__c = 'SSBAAPJALXRNA01';
            update pro;
            
           
            
            
            ProductApprovalVendorMng prodCont1 = new ProductApprovalVendorMng();
            for(ProductApprovalVendorMng.productWrraper wrap : prodCont1.wrraperList){
                wrap.isSelected = true;
            }
            prodCont1.SubmitForApproval();
		}
		system.runAs(approverUser){
			PageReference pageRef = Page.ProductApproval; 
            pageRef.getParameters().put('Vendor', user2.id);
            Test.setCurrentPage(pageRef);
            ProductApprovalClass prodCont = new ProductApprovalClass();
            //ProductApprovalVendorMng.productWrraper wrap = new  ProductApprovalVendorMng.productWrraper();
            prodCont.selectedVendor = acc.Id;
            prodCont.isClrf = true;
            try{
                prodCont.approveProduct();
            }
            catch(exception ex){
                
            }       
            system.debug('----prodCont.wrraperList---'+prodCont.wrraperList);
            for(ProductApprovalClass.productWrraper wrap : prodCont.wrraperList){
                wrap.isSelected = true;
            }
            prodCont.approveProduct();
            List<String> sendTo = new List<String>();
            sendTo.add('Shweta.kumari@kvpcorp.com');
            String mailbody = 'Hello ';
            String subjectStr = 'Product Approved';
            List<string> ccToUse = new List<string>(); 
            prodCont.sendEmailMsg(mailbody,sendTo,subjectStr,ccToUse);
        }
    }
    
}