@IsTest
public class QCMTLDetailInformationComponentClassTest {
    
    @isTest static  void validate(){
        QCMTLDetailInformationComponentClass.WrapperClass wrapClsObj = new QCMTLDetailInformationComponentClass.WrapperClass();
        MtlUtilityTest.createData();
        //String record='{"Name":"MTL-0722","Document_Status__c":"Draft","Report_Reference_Number__c":"PL/Customer Assurance/0017/19-20","Testing_Type__c":"Plating","Final_Verdict__c":"Accept","Chemical_Composition_ElementsObservation__c":" ","Chemical_Composition_ElementsObser1__c":" ","Chemical_Composition_ElementsObser2__c":" ","Chemical_Composition_ElementsObser3__c":" ","Chemical_Composition_ElementsObser4__c":" ","Chemical_Composition_ElementsResult__c":" ","Chemical_Composition_ElementsResult1__c":" ","Chemical_Composition_ElementsResult2__c":" ","Chemical_Composition_ElementsResult3__c":" ","Chemical_Composition_ElementsResult4__c":" "}';
        //String sand='[{"Document_Status__c":"Draft","Name":"Thickness","Result__c":"Accept","User_Defined_Value__c":"10","Standard_Defined_Value__c":"Au - 1.55","QC_Test_Questions_Value__c":"a2KM00000011gJAMAY","QC_MTL_Test__c":"a2JM00000002fduMAA","QC_Test_Questions_Value__r":{"Standard_Defined_Value__c":"Au - 1.55","Id":"a2KM00000011gJAMAY"},"QC_MTL_Test__r":{"IsMandatory__c":true}},{"Name":"Thickness","Result__c":"Accept","User_Defined_Value__c":"29","Standard_Defined_Value__c":"TiN - 0.88","QC_Test_Questions_Value__c":"a2KM00000011gJFMAY","QC_MTL_Test__c":"a2JM00000002fduMAA","QC_Test_Questions_Value__r":{"Standard_Defined_Value__c":"TiN - 0.88","Id":"a2KM00000011gJFMAY"},"QC_MTL_Test__r":{"IsMandatory__c":true,"Id":"a2JM00000002fduMAA"}},{"Id":"a2IM0000000r8TKMAY","Name":"Dummy","Result__c":"Accept","User_Defined_Value__c":"29","Standard_Defined_Value__c":"29","QC_Test_Questions_Value__c":"a2KM00000011gL6MAI","QC_MTL_Test__c":"a2JM00000002fhcMAA","QC_Test_Questions_Value__r":{"Standard_Defined_Value__c":"29","Id":"a2KM00000011gL6MAI"},"QC_MTL_Test__r":{"IsMandatory__c":false,"Id":"a2JM00000002fhcMAA"}}]';
        QC_MTL_Component__c platOb=[SELECT ID,Name,Batch_Quantity__c,Brand__c,Chemical_Composition_ElementsObser1__c,Chemical_Composition_ElementsObser2__c,Chemical_Composition_ElementsObser3__c,
                                    Chemical_Composition_ElementsObser4__c,Chemical_Composition_ElementsObservation__c,Chemical_Composition_ElementsResult1__c,Chemical_Composition_ElementsResult2__c,Chemical_Composition_ElementsResult3__c,
                                    Chemical_Composition_ElementsResult4__c,Chemical_Composition_ElementsResult__c,Chemical_Composition_Elements_2__c,Chemical_Composition_Elements_3__c,Chemical_Composition_Elements_4__c,Chemical_Composition_Elements_5__c,Chemical_Composition_Elements__c,Component_Name__c,Department_PMC__c,Department__c,Docket_Number__c,Document_Status__c,Final_Verdict__c,
                                    General_Observation__c,Plating_Type__c,QC_MTL_Reference_Component__c,Record_Status__c,Regular_Test__c,Report_Reference_Number__c,Required_test_PMC__c,Required_Test__c,Sample_Received_Date__c,Sample_Received_From__c,Sample_Size_Plating__c,SKU_Reference__c,Source__c,Specification_revision__c,Testing_Type__c,Titan_Specification_Reference__c FROM QC_MTL_Component__c WHERE Report_Reference_Number__c ='PL/Customer Assurance/1917/18-19'];
        
        QC_MTL_Test__c platTestOb = [SELECT ID,Name FROM QC_MTL_Test__c WHERE Name ='PlatingBlahTest1'][0];
        QC_Test_Questions_Value__c platValOb =[SELECT Id,Name,Status__c,Standard_Defined_Value__c,QC_MTL_Test__c FROM QC_Test_Questions_Value__c WHERE QC_MTL_Test__c =:platTestOb.Id][0];
        List<QC_MTL_TestResponse__c> platRespOb =[SELECT Id,Name,Plating_Testing_Type__c,QC_MTL_Component_del__c,QC_MTL_Test__c,QC_Test_Questions_Value__c,Standard_Defined_Value__c,User_Defined_Value__c,Result__c FROM QC_MTL_TestResponse__c WHERE Name='PlatingBlahTest1'];
        String platRecId =platOb.Id;String platName=platOb.Name;
        String recrdData='{"Id":"'+platRecId+'", "Name":"'+platName+'","Document_Status__c":"Draft","Report_Reference_Number__c":"'+platOb.Report_Reference_Number__c+'","Testing_Type__c":"Plating","Final_Verdict__c":"Accept","Chemical_Composition_ElementsObservation__c":" ","Chemical_Composition_ElementsObser1__c":" ","Chemical_Composition_ElementsObser2__c":" ","Chemical_Composition_ElementsObser3__c":" ","Chemical_Composition_ElementsObser4__c":" ","Chemical_Composition_ElementsResult__c":" ","Chemical_Composition_ElementsResult1__c":" ","Chemical_Composition_ElementsResult2__c":" ","Chemical_Composition_ElementsResult3__c":" ","Chemical_Composition_ElementsResult4__c":" "}';
        String sandData='[{"Id":"'+platRespOb[0].Id+'","Name":"PlatingBlahTest1","Plating_Testing_Type__c":"Regular","QC_MTL_Component_del__c":"'+platRespOb[0].QC_MTL_Component_del__c+'","Standard_Defined_Value__c":"Pass","Result__c":"Accept"}]';
        system.debug('recrdData'+recrdData);
        system.debug('sandData'+sandData);
            //'[{"Id":platRespOb.Id,"Document_Status__c":"Draft","Name":"Thickness","Result__c":"Accept","User_Defined_Value__c":"10","Standard_Defined_Value__c":"Au - 1.55","QC_Test_Questions_Value__c":"","QC_MTL_Test__c":"","QC_Test_Questions_Value__r":{"Standard_Defined_Value__c":"Au - 1.55","Id":"a2KM00000011gJAMAY"},"QC_MTL_Test__r":{"IsMandatory__c":true}},{"Name":"Thickness","Result__c":"Accept","User_Defined_Value__c":"29","Standard_Defined_Value__c":"TiN - 0.88","QC_Test_Questions_Value__c":"a2KM00000011gJFMAY","QC_MTL_Test__c":"a2JM00000002fduMAA","QC_Test_Questions_Value__r":{"Standard_Defined_Value__c":"TiN - 0.88","Id":"a2KM00000011gJFMAY"},"QC_MTL_Test__r":{"IsMandatory__c":true,"Id":"a2JM00000002fduMAA"}},{"Id":"a2IM0000000r8TKMAY","Name":"Dummy","Result__c":"Accept","User_Defined_Value__c":"29","Standard_Defined_Value__c":"29","QC_Test_Questions_Value__c":"a2KM00000011gL6MAI","QC_MTL_Test__c":"a2JM00000002fhcMAA","QC_Test_Questions_Value__r":{"Standard_Defined_Value__c":"29","Id":"a2KM00000011gL6MAI"},"QC_MTL_Test__r":{"IsMandatory__c":false,"Id":"a2JM00000002fhcMAA"}}]';
        wrapClsObj=QCMTLDetailInformationComponentClass.savaRecord(recrdData,sandData);
        system.debug('dsdj'+[SELECT Id FROM QC_MTL_Component__c]);
        //QCMTLDetailInformationComponentClass.WrapperClass ob=new QCMTLDetailInformationComponentClass.WrapperClass();
        //ob=  QCMTLDetailInformationComponentClass.getQCMTLComponentRecord('a2HM0000000Bb7hMAC');
        QC_MTL_Component__c mtlComp= [Select Id FROM QC_MTL_Component__c WHERE Raw_Material_Name__c='Test Raw Material2734'];
        System.debug('::mtlComp::'+mtlComp);
        /*Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
        app.setObjectId('a2HM0000000Bb7hMAC');
        Approval.ProcessResult result = Approval.process(app);*/
        
        
        /*  if([select count() from ProcessInstance where targetobjectid=:mtlComp.Id] < 1)
        {       
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Approve.');
            req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            req.setObjectId(mtlComp.Id);
            
            //Submit the approval request
            Approval.ProcessResult result = Approval.process(req);
            
        }*/ 
        QCMTLDetailInformationComponentClass.isRecordSubmitForApproval(platOb.Id);
        QCMTLDetailInformationComponentClass.getApprovalData(platOb.Id);
       QCMTLDetailInformationComponentClass.submitForAppProcess(platOb.Id);
        QCMTLDetailInformationComponentClass.getQCMTLComponentRecord(platOb.Id);
       
    }
}