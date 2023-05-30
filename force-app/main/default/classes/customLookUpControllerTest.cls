@isTest
public class customLookUpControllerTest {

    public static testmethod void createData(){
         // QC_MTL_Component_pdfComponentCntlr cntrlrObj = new QC_MTL_Component_pdfComponentCntlr();
          Report_Reference_Number__c refCustomObj = new Report_Reference_Number__c();
          refCustomObj.MTL_Reference_Number__c=1;
          refCustomObj.Plating_Material_Composition_RRFNumber__c=1;
          refCustomObj.Plating_Report_Reference_Number__c=1;
          insert refCustomObj;
          Sample_Size_Custom_Setting__c samplCustomObj = new Sample_Size_Custom_Setting__c();
          samplCustomObj.Name='PL-Case IQF-Full Test-6';
          insert samplCustomObj;
            QC_MTL_Component__c qcmtlobj = new QC_MTL_Component__c();
          qcmtlobj.RecordTypeId =Schema.SObjectType.QC_MTL_Component__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();
          qcmtlobj.Testing_Type__c = 'Raw Material';
          qcmtlobj.Raw_Material_Type__c='Module Raw Material';
            qcmtlobj.Material_Sample_Type__c = 'New';
            qcmtlobj.Report_Reference_Number__c = 'RM/0019/19-20';
            qcmtlobj.Record_Status__c = 'Active';
            qcmtlobj.Sample_Size_Qty__c= 4;
            qcmtlobj.Document_Status__c = 'Submitted for Approval';
            qcmtlobj.Sample_Received_From__c = 'sameer.ranjan@kvpcorp.com';
            insert qcmtlobj;
            Id mastId = Schema.SObjectType.QC_Access_Master__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();
            QC_Access_Master__c eachMas = new QC_Access_Master__c(RecordTypeId=mastId,Name='Mast18901',Raw_Material_Name__c='MastRow',Raw_Material_Type__c='Module Raw Material',Specification_Revision__c='Mastab131a',Titan_Spec_Status__c='Active',Testing_Type__c='Raw Material');
            insert eachMas;
            Supplier_Grade__c eachSuplr = new Supplier_Grade__c(Name='SUP11Mas',QC_Access_Master__c=eachMas.Id,TCL_Designation__c='MSSup11');
            insert eachSuplr;
            Id testRec = Schema.SObjectType.QC_MTL_Test__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();
            QC_MTL_Test__c testObj = new QC_MTL_Test__c(RecordTypeId = testRec,Name='MasTest11', Supplier_Grade__c=eachSuplr.Id,Titan_Specification__c=eachMas.Id);
            insert testObj;
            QC_Test_Questions_Value__c testValObj = new QC_Test_Questions_Value__c(Name='MasTest11',Standard_Defined_Value__c='Pass',Status__c='Accept',QC_MTL_Test__c=testObj.Id);
            insert testValObj;
            QC_MTL_TestResponse__c testResp = new QC_MTL_TestResponse__c(Name='MasTest11',QC_MTL_Test__c=testObj.Id,QC_MTL_Component_del__c=qcmtlObj.Id,QC_Test_Questions_Value__c=testValObj.Id,User_Defined_Value__c='Pass');
            insert testResp;
        	String name=qcmtlobj.Name;
        	String objName='QC_MTL_Component__c';
        	String whereCond ='Testing_Type__c=\'Raw Material\'';
        	String reportRefNo=qcmtlobj.Report_Reference_Number__c + '%';
        customLookUpController.fetchLookUpValues(name,objName,whereCond);
        
    }
}