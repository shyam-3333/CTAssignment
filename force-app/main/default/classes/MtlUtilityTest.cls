@isTest
public class MtlUtilityTest {

   
    @testSetup
    public static void createData(){
      
        Id recordTypeId=Schema.SObjectType.QC_Access_Master__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();

        QC_Access_Master__c each = new QC_Access_Master__c(RecordTypeId=recordTypeId,Name='TestMethod1714',Testing_Type__c='Raw Material',Raw_Material_Name__c='Test Raw Material2734',Raw_Material_Type__c='Module Raw Material',Titan_Spec_Status__c='Active',Specification_Revision__c='Test1901');
            insert each;
        Supplier_Grade__c supName = new Supplier_Grade__c(Name='SPLR11',QC_Access_Master__c=each.Id,TCL_Designation__c='SP1aa');
        insert supName;
        Id testRecId=Schema.SObjectType.QC_MTL_Test__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();
        QC_MTL_Test__c mtlTest = new QC_MTL_Test__c(RecordTypeId=testRecId,Name='TestClass1',Supplier_Grade__c=supName.Id,Titan_Specification__c=each.Id);
        insert mtlTest;
        QC_Test_Questions_Value__c qstnVal = new QC_Test_Questions_Value__c(Name='TestClass1',QC_MTL_Test__c= mtlTest.Id,Standard_Defined_Value__c='TestPass',Status__c='Accept');
        insert qstnVal;
        Id compRecId =Schema.SObjectType.QC_MTL_Component__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();
        QC_MTL_Component__c mtlComp = new QC_MTL_Component__c(RecordTypeId=compRecId,Report_Reference_Number__c = 'RM/12561/18-19',Material_Sample_Type__c='New',Raw_Material_Name__c='Test Raw Material2734',RM_Size__c='2',Raw_Material_Type__c='Module Raw Material',Sample_Size_Qty__c=2,Sample_Received_From__c='rahul.mukherji@kvpcorp.com',MTL_User_Email__c='mtluser@titan.co.in',IRR_No__c='ABC',Final_Verdict__c='Accept',Titan_Specification_Reference__c=each.Id,Supplier_Grade__c=supName.Id,Document_Status__c='Draft',Heat_No_Grade__c='HG1',Invoice_Dc_No__c='In1',General_Observation__c='Gen1');
        insert mtlComp;
        QC_MTL_TestResponse__c testResponse=new QC_MTL_TestResponse__c(QC_MTL_Component_del__c=mtlComp.Id,Name='TestClass1',QC_Test_Questions_Value__c=qstnVal.Id,QC_MTL_Test__c=mtlTest.Id);
        insert testResponse;
        
        //Plating Data below::
        
        //Id platingRecId =Schema.SObjectType.QC_MTL_Component__c.getRecordTypeInfosByName().get('Plating Testing').getRecordTypeId();
        QC_MTL_Component__c mtlPlatingComp = new QC_MTL_Component__c(Testing_Type__c='Plating',Report_Reference_Number__c = 'PL/Customer Assurance/1917/18-19',Department__c='Customer Assurance',Material_Sample_Type__c='New',Sample_Received_From__c='rahul.mukherji@kvpcorp.com',Chemical_Composition_ElementsObservation__c='',Chemical_Composition_ElementsObser1__c='',Chemical_Composition_ElementsObser2__c='',Chemical_Composition_ElementsObser3__c='',MTL_User_Email__c='mtluser@titan.co.in',Chemical_Composition_ElementsObser4__c='',Final_Verdict__c='Accept',Chemical_Composition_ElementsResult__c='',Chemical_Composition_ElementsResult1__c='',Document_Status__c='Draft',Chemical_Composition_ElementsResult2__c='',Chemical_Composition_ElementsResult3__c='',General_Observation__c='Gen1',Chemical_Composition_ElementsResult4__c='');
        insert mtlPlatingComp;
                //Id platingCompRecId =Schema.SObjectType.QC_MTL_Component__c.getRecordTypeInfosByName().get('Plating & Material Composition Testing').getRecordTypeId();
                Id PlatigTesrecordTypeId=Schema.SObjectType.QC_Access_Master__c.getRecordTypeInfosByName().get('Plating Testing').getRecordTypeId();
                QC_Access_Master__c platingEach = new QC_Access_Master__c(RecordTypeId=PlatigTesrecordTypeId,Name='PlatingTestMethod1714',Testing_Type__c='Plating',Titan_Spec_Status__c='Active',Specification_Revision__c='TestPlating1901');
                insert platingEach;
                        //QC_MTL_Component__c mtlPlatingCompstn = new QC_MTL_Component__c();
                String record='{"Document_Status__c":"Draft","Testing_Type__c":"Plating","Final_Verdict__c":"Accept","Chemical_Composition_ElementsObservation__c":" ","Chemical_Composition_ElementsObser1__c":" ","Chemical_Composition_ElementsObser2__c":" ","Chemical_Composition_ElementsObser3__c":" ","Chemical_Composition_ElementsObser4__c":" ","Chemical_Composition_ElementsResult__c":" ","Chemical_Composition_ElementsResult1__c":" ","Chemical_Composition_ElementsResult2__c":" ","Chemical_Composition_ElementsResult3__c":" ","Chemical_Composition_ElementsResult4__c":" "}';
                QC_MTL_Component__c recordInfo=(QC_MTL_Component__c)JSON.deserialize(record, QC_MTL_Component__c.class);
                insert recordInfo;
                //Plating Test here.
                //Id platingTestingRecId=Schema.SObjectType.QC_MTL_Test__c.getRecordTypeInfosByName().get('Plating Testing').getRecordTypeId();
                QC_MTL_Test__c mtlPlatingTest = new QC_MTL_Test__c(Name='PlatingBlahTest1',Titan_Specification__c=platingEach.Id);
                insert mtlPlatingTest;
                QC_Test_Questions_Value__c platQstnVal = new QC_Test_Questions_Value__c(Name='PlatingBlahTest1',QC_MTL_Test__c=mtlPlatingTest.Id,Standard_Defined_Value__c='Pass',Status__c='Accept');
                insert platQstnVal;
                QC_MTL_TestResponse__c mtlPlatingResp = new QC_MTL_TestResponse__c(Name='PlatingBlahTest1',QC_MTL_Component_del__c=recordInfo.Id,Plating_Testing_Type__c='Regular',Result__c='Accept',Standard_Defined_Value__c='Pass');
                insert mtlPlatingResp;
        
    }
}