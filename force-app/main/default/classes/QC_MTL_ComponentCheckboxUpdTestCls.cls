@isTest
public class QC_MTL_ComponentCheckboxUpdTestCls {
    @isTest
    static void method1(){
        Test.startTest();
        User testuser = [select name, Id  FROM user LIMIT 1];
        List<QC_MTL_Component__c> listcompotest = New List<QC_MTL_Component__c>();
        
        system.runAs(testuser)
        {
            insert(new QCMTLComponentTrigger__c(TriggerActivate_Deactivate__c=true));
            
            insert(new Report_Reference_Number__c(MTL_Reference_Number__c=Decimal.valueOf(1),Plating_Material_Composition_RRFNumber__c=Decimal.valueOf(1),Plating_Report_Reference_Number__c=Decimal.valueOf(1) ));
            String masRec= Schema.SObjectType.QC_Access_Master__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();
            QC_Access_Master__c eachMas = new QC_Access_Master__c(RecordtypeId =masRec,Name='T8123',Raw_Material_Name__c='RM1',Testing_Type__c='Raw Material',Titan_Spec_Status__c='Active',Raw_Material_Type__c='Module Raw Material',Specification_Revision__c='T81');
            insert eachMas;
            Supplier_Grade__c eachSuplr = new Supplier_Grade__c(Name='Spr1',QC_Access_Master__c=eachMas.Id,TCL_Designation__c='TRS2');
            insert eachSuplr;
            String compRecType =Schema.SObjectType.QC_MTL_Component__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();
            QC_MTL_Component__c qcmtlobj1 = new QC_MTL_Component__c();
            qcmtlobj1.RecordTypeId=compRecType;
            qcmtlobj1.Testing_Type__c = 'Raw Material';
            qcmtlobj1.Raw_Material_Type__c ='Module Raw Material';
            qcmtlobj1.Material_Sample_Type__c = 'New';
            qcmtlobj1.Report_Reference_Number__c = 'RM/0019/19-20';
            qcmtlobj1.Record_Status__c = 'New';
            qcmtlobj1.Sample_Size_Qty__c= 1;
            qcmtlobj1.Document_Status__c = 'Draft';
            qcmtlobj1.MTL_User_Email__c = 'mtl@titan.co.in';
            qcmtlobj1.Titan_Specification_Reference__c =eachMas.Id;
            qcmtlobj1.Supplier_Grade__c=eachSuplr.Id;
            qcmtlobj1.MTL_User_Email__c='mtl@titan.co.in';
            qcmtlobj1.Sample_Received_From__c = 'sameer.ranjan@kvpcorp.com';
            List<QC_MTL_Component__c> insertData=new List<QC_MTL_Component__c>();
            insertData.add(qcmtlobj1);
            insert insertData;
            String rawMatRecType =Schema.SObjectType.QC_MTL_Test__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();
            QC_MTL_Test__c testObj = new QC_MTL_Test__c();
            testObj.RecordTypeId =rawMatRecType;
            testObj.Name='Hardness';
            testObj.Titan_Specification__c =eachMas.Id;
            testObj.Supplier_Grade__c = eachSuplr.Id;
            insert testObj;
            
            QC_Test_Questions_Value__c eachValue = new QC_Test_Questions_Value__c();
            eachValue.Name='Hardness';
            eachValue.Maximum__c=200;
            eachValue.Minimum__c=100;
            eachValue.QC_MTL_Test__c=testObj.Id;
            eachValue.Standard_Defined_Value__c='Pass';
            eachValue.Status__c ='Accept';
            insert eachValue;
            
            QC_MTL_Test__c testObj1 = new QC_MTL_Test__c();
            testObj1.RecordTypeId =rawMatRecType;
            testObj1.Name='BreakTest';
            testObj1.Titan_Specification__c =eachMas.Id;
            testObj1.Supplier_Grade__c = eachSuplr.Id;
            insert testObj1;
            
            
            QC_Test_Questions_Value__c eachValue1 = new QC_Test_Questions_Value__c();
            eachValue1.Name='BreakTest';
            eachValue1.Maximum__c=200;
            eachValue1.Minimum__c=100;
            eachValue1.QC_MTL_Test__c=testObj1.Id;
            eachValue1.Standard_Defined_Value__c='Pass';
            eachValue1.Status__c ='Accept';
            insert eachValue1;
            QC_MTL_TestResponse__c eachResp = new QC_MTL_TestResponse__c();
            List<QC_MTL_TestResponse__c> mtlRespList = new List<QC_MTL_TestResponse__c>();
            eachResp.Name = 'TestResp1';
            //eachResp.QC_MTL_Test__c='az0223232';
            eachResp.QC_MTL_Component_del__c = qcmtlobj1.Id;
            eachResp.Maximum__c=100;
            eachResp.Minimum__c=50;
            eachResp.Standard_Defined_Value__c='Pass';
            eachResp.User_Defined_Value__c='Pass';
            eachResp.Result__c='Accept';
            mtlRespList.add(eachResp);
            QC_MTL_TestResponse__c eachResp1 = new QC_MTL_TestResponse__c();
            eachResp1.Name = testObj.Name;
            eachResp1.QC_MTL_Component_del__c = qcmtlobj1.Id;
            eachResp1.Maximum__c=210;
            eachResp1.Minimum__c=190;
            eachResp1.Standard_Defined_Value__c=eachValue.Standard_Defined_Value__c;
            eachResp1.User_Defined_Value__c='';
            eachResp1.Result__c='Accept';
            eachResp1.QC_MTL_Test__c=testObj1.Id;
            eachResp1.QC_Test_Questions_Value__c=eachValue.Id;
            mtlRespList.add(eachResp1);
            QC_MTL_TestResponse__c eachResp2 = new QC_MTL_TestResponse__c();
            eachResp2.Name = testObj1.Name;
            eachResp2.QC_MTL_Component_del__c = qcmtlobj1.Id;
            eachResp2.Maximum__c=210;
            eachResp2.Minimum__c=190;
            eachResp2.Standard_Defined_Value__c=eachValue1.Standard_Defined_Value__c;
            eachResp2.User_Defined_Value__c='pass';
            eachResp2.Result__c='Accept';
            eachResp2.QC_MTL_Test__c=testObj1.Id;
            eachResp2.QC_Test_Questions_Value__c=eachValue1.Id;
            mtlRespList.add(eachResp2);
            insert mtlRespList;
            
            QC_MTL_ComponentCheckboxUpdCls.updateRespStatusCheckbox(mtlRespList);
            Test.stopTest();
        }
    }
}