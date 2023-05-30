@isTest
public class QCMTLPDFReportControllerTest {

    public static testmethod void createData(){
         Report_Reference_Number__c refCustomObj = new Report_Reference_Number__c();
            refCustomObj.MTL_Reference_Number__c=1;
            refCustomObj.Plating_Material_Composition_RRFNumber__c=1;
            refCustomObj.Plating_Report_Reference_Number__c=1;
            insert refCustomObj;
            Sample_Size_Custom_Setting__c samplCustomObj = new Sample_Size_Custom_Setting__c();
            samplCustomObj.Name='PL-Case IQF-Full Test-6';
            insert samplCustomObj;
            QC_MTL_Component__c qcmtlobj = new QC_MTL_Component__c();
            //qcmtlobj.RecordTypeId =Schema.SObjectType.QC_MTL_Component__c.getRecordTypeInfosByName().get('Raw Material').getRecordTypeId();
            qcmtlobj.Testing_Type__c = 'Raw Material';
            qcmtlobj.MTL_User_Email__c='mtl@titan.co.in';
            qcmtlobj.Raw_Material_Type__c='Module Raw Material';
            qcmtlobj.Heat_No_Grade__c='31M2160';
            //qcmtlobj.Department__c='IDI';
            qcmtlobj.Material_Sample_Type__c = 'New';
            //qcmtlobj.Report_Reference_Number__c = 'PL/IDI/0019/19-20';
            qcmtlobj.Record_Status__c = 'Active';
            qcmtlobj.Sample_Size_Qty__c= 4;
           // qcmtlobj.Document_Status__c = 'Submitted for Approval';
            qcmtlobj.Sample_Received_From__c = 'sameer.ranjan@kvpcorp.com';
            insert qcmtlobj;
        system.debug('------qcmtlobj------------'+qcmtlobj.Id);
            Id mastId = Schema.SObjectType.QC_Access_Master__c.getRecordTypeInfosByName().get('Plating').getRecordTypeId();
            QC_Access_Master__c eachMas = new QC_Access_Master__c(RecordTypeId=mastId,Name='Mast18901',Titan_Spec_Status__c='Active',Testing_Type__c='Plating',Plating_Type__c='Bi Color - Black (CrCN)',Material__c = 'Brass');
            insert eachMas;
            Supplier_Grade__c eachSuplr = new Supplier_Grade__c(Name='SUP11Mas',QC_Access_Master__c=eachMas.Id,TCL_Designation__c='MSSup11');
            insert eachSuplr;
            Id testRec = Schema.SObjectType.QC_MTL_Test__c.getRecordTypeInfosByName().get('Plating').getRecordTypeId();
            QC_MTL_Test__c testObj = new QC_MTL_Test__c(RecordTypeId = testRec,Name='MasTest11', Supplier_Grade__c=eachSuplr.Id,Titan_Specification__c=eachMas.Id);
            insert testObj;
            QC_Test_Questions_Value__c testValObj = new QC_Test_Questions_Value__c(Name='MasTest11',Standard_Defined_Value__c='Pass',Status__c='Accept',QC_MTL_Test__c=testObj.Id);
            insert testValObj;
            QC_MTL_TestResponse__c testResp = new QC_MTL_TestResponse__c(Name='MasTest11',QC_MTL_Test__c=testObj.Id,QC_MTL_Component_del__c=qcmtlObj.Id,QC_Test_Questions_Value__c=testValObj.Id,User_Defined_Value__c='Pass');
            insert testResp;
                PageReference pageRef = Page.QCMTLRawMaterialPDFReportPDF;
                Test.setCurrentPageReference(pageRef);  
                ApexPages.currentPage().getParameters().put('compId',qcmtlobj.id);
                QCMTLPDFReportController obj = new QCMTLPDFReportController();
                //obj.FetchRecord();
                new QCMTLPDFReportController().FetchRecord();
    }
}