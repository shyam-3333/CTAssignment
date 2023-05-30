@isTest
public class QC_MTL_Component_pdf_TestClass {
    
    static testMethod void fetchRecords(){
        
        User testuser = [select name, Id  FROM user LIMIT 1];
        
        system.runAs(testuser){
            Test.StartTest();  
            
            String compId=Apexpages.currentpage().getParameters().get('compId');
            QC_Access_Master__c eachMas = new QC_Access_Master__c(Name='T8123',Raw_Material_Name__c='RM1',Testing_Type__c='Raw Material',Titan_Spec_Status__c='Active',Raw_Material_Type__c='Module Raw Material',Specification_Revision__c='Robert Cu Sn 6');
            insert eachMas;
            
            List<QC_MTL_Component__c> listcompotest = new List<QC_MTL_Component__c>();
            QC_MTL_Component__c qcmtlobj = new QC_MTL_Component__c();
            qcmtlobj.Testing_Type__c = 'Raw Material';
            qcmtlobj.Material_Sample_Type__c = 'New';
            qcmtlobj.Report_Reference_Number__c = 'RM/0019/19-20';
            qcmtlobj.Record_Status__c = 'New';
            qcmtlobj.Sample_Size_Qty__c= 4;
            qcmtlobj.Document_Status__c = 'Draft';
            qcmtlobj.Sample_Received_From__c = 'sameer.ranjan@kvpcorp.com';
            listcompotest.add(qcmtlobj);
            insert qcmtlobj;
            System.debug('New record:' +qcmtlobj.Id +qcmtlobj.Testing_Type__c +qcmtlobj.Material_Sample_Type__c +qcmtlobj.Report_Reference_Number__c);
            
            Supplier_Grade__c eachSuplr = new Supplier_Grade__c(Name='Spr1',QC_Access_Master__c=eachMas.Id,TCL_Designation__c='TRS2');
            insert eachSuplr;
            
            QC_MTL_Test__c eachmtltest = new QC_MTL_Test__c(Name='TT4',Titan_Specification__c = eachMas.Id,Supplier_Grade__c = eachSuplr.Id);
            insert eachmtltest;
            
            QC_Test_Questions_Value__c tetQues = new QC_Test_Questions_Value__c(Name = 'Test 1245',QC_MTL_Test__c =eachmtltest.Id,Standard_Defined_Value__c = '10');
            insert tetQues;
            
            List<QC_MTL_TestResponse__c> qcTestResList = new List<QC_MTL_TestResponse__c>();
            QC_MTL_TestResponse__c eachtestresponse = new QC_MTL_TestResponse__c(Name='TT1',Result__c = 'Accept',QC_MTL_Test__c = eachmtltest.Id,QC_Test_Questions_Value__c =tetQues.Id,QC_MTL_Component_del__c = qcmtlobj.Id);
            qcTestResList.add(eachtestresponse);
            insert qcTestResList;
            
            
            Messaging.SingleEmailMessage Message = new Messaging.SingleEmailMessage();
            message.setSaveAsActivity(false);
            message.setSubject('dear diary');
            message.setPlainTextBody('he who controls the spice');
            message.setToAddresses(new List<String>{'anindwita.raj@kvpcorp.com'});
            Messaging.sendEmail(new List<Messaging.Email>{Message});
            
            //ProcessInstance prcinst = new ProcessInstance();
            //prcinst.NodeStatus = 'Approved';
            //prcinst.LastActorId = userinfo.getuserid();
            //insert prcinst;
            
            QC_MTL_Component_pdfCntlr mtlcomp = new QC_MTL_Component_pdfCntlr();
            mtlcomp.firstApprover = testuser.id;
            mtlcomp.secondApprover = testuser.id;
            mtlcomp.compId = qcmtlobj.id;
            Apexpages.currentpage().getParameters().put('compId',qcmtlobj.id);
            
            
             mtlcomp.getqcMtlComp();
            
            
            Approval.ProcessSubmitRequest [] requestList = new Approval.ProcessSubmitRequest []{};
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setComments('Submitting request for approval.');
            req1.setObjectId(qcmtlobj.Id);
            req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            Approval.ProcessResult result = Approval.process(req1);
            
            List<Id> newWorkItemIds = result.getNewWorkitemIds();
        /*Approval.ProcessWorkitemRequest req2 =
            new Approval.ProcessWorkitemRequest();
        req2.setComments('Approving request.');
        req2.setAction('Approved');
        req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        req2.setWorkitemId(newWorkItemIds.get(0));
        Approval.ProcessResult result2 =  Approval.process(req2);*/

            
            
           
            
            test.StopTest();
        }
    }
    
}