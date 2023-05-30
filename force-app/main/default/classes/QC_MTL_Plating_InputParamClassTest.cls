@isTest
public class QC_MTL_Plating_InputParamClassTest {
 
    public static testmethod void coverTest(){
        MtlUtilityTest.createData();
       
         QC_MTL_Component__c platOb=[SELECT ID,Name,Batch_Quantity__c,Brand__c,Chemical_Composition_ElementsObser1__c,Chemical_Composition_ElementsObser2__c,Chemical_Composition_ElementsObser3__c,
                                    Chemical_Composition_ElementsObser4__c,Plater_Name__c,Chemical_Composition_ElementsObservation__c,Chemical_Composition_ElementsResult1__c,Chemical_Composition_ElementsResult2__c,Chemical_Composition_ElementsResult3__c,
                                    Chemical_Composition_ElementsResult4__c,Chemical_Composition_ElementsResult__c,Chemical_Composition_Elements_2__c,Chemical_Composition_Elements_3__c,Chemical_Composition_Elements_4__c,Chemical_Composition_Elements_5__c,Chemical_Composition_Elements__c,Component_Name__c,Department_PMC__c,Department__c,Docket_Number__c,Document_Status__c,Final_Verdict__c,
                                    General_Observation__c,Plating_Type__c,QC_MTL_Reference_Component__c,Record_Status__c,Regular_Test__c,Report_Reference_Number__c,Required_test_PMC__c,Required_Test__c,Sample_Received_Date__c,Sample_Received_From__c,Sample_Size_Plating__c,SKU_Reference__c,Source__c,Specification_revision__c,Testing_Type__c,Titan_Specification_Reference__c FROM QC_MTL_Component__c WHERE Report_Reference_Number__c ='PL/Customer Assurance/1917/18-19'];
        
        List<QC_MTL_Test__c> platTestOb = [SELECT Id,Name FROM QC_MTL_Test__c WHERE Name ='PlatingBlahTest1'];
        //for(QC_MTL_Test__c each: platTestOb){
        //    each.id=null;
        //}
        //QC_Test_Questions_Value__c platValOb =[SELECT Id,Name,Status__c,Standard_Defined_Value__c,QC_MTL_Test__c FROM QC_Test_Questions_Value__c WHERE QC_MTL_Test__c =:platTestOb.Id];
        List<QC_MTL_TestResponse__c> platRespOb =[SELECT Id,Name,Plating_Testing_Type__c,QC_MTL_Component_del__c,QC_MTL_Test__c,QC_Test_Questions_Value__c,Standard_Defined_Value__c,User_Defined_Value__c,Result__c FROM QC_MTL_TestResponse__c WHERE Name='PlatingBlahTest1'];
        for(QC_MTL_TestResponse__c each:platRespOb){
            each.id=null;
        }
        String platRecId =platOb.Id;String platName=platOb.Name;
        String recrd = '{"Id":"'+platRecId+'", "Name":"'+platName+'","Document_Status__c":"Draft","Report_Reference_Number__c":"'+platOb.Report_Reference_Number__c+'","Testing_Type__c":"Plating","Final_Verdict__c":"Accept","Chemical_Composition_ElementsObservation__c":" ","Chemical_Composition_ElementsObser1__c":" ","Chemical_Composition_ElementsObser2__c":" ","Chemical_Composition_ElementsObser3__c":" ","Chemical_Composition_ElementsObser4__c":" ","Chemical_Composition_ElementsResult__c":" ","Chemical_Composition_ElementsResult1__c":" ","Chemical_Composition_ElementsResult2__c":" ","Chemical_Composition_ElementsResult3__c":" ","Chemical_Composition_ElementsResult4__c":" "}';
        
        QC_Mtl_Plating_InputParamClass.recordInfo recWrap = new QC_Mtl_Plating_InputParamClass.recordInfo();
        QC_Mtl_Plating_InputParamClass.ReturnWrapperClass retrObj = new QC_Mtl_Plating_InputParamClass.ReturnWrapperClass();
       QC_Mtl_Plating_InputParamClass.getDependentOptionsImplements('QC_MTL_Component__c','Department__c','Required_Test__c');
        //QC_MTL_InputForm_Class.getDependentOptionsImplements();
        Sample_Size_Custom_Setting__c eachCustom = new Sample_Size_Custom_Setting__c(Name='PL-Case IQF-Full Test-6');
        insert eachCustom;
        QC_Mtl_Plating_InputParamClass.getCustomSetting();
        QC_Mtl_Plating_InputParamClass.getSchemaValue();
        QC_Mtl_Plating_InputParamClass.getOptionTestValues();
        
        QC_Mtl_Plating_InputParamClass.getOptionalTestValues();
        QC_Mtl_Plating_InputParamClass.getRegularTestCSValues();
       // String record='{"Id":"a2HM0000000BX4j","Name":"MTL-0722","Document_Status__c":"Draft","Report_Reference_Number__c":"PL/Customer Assurance/0017/19-20","Testing_Type__c":"Plating","Final_Verdict__c":"Accept","Chemical_Composition_ElementsObservation__c":" ","Chemical_Composition_ElementsObser1__c":" ","Chemical_Composition_ElementsObser2__c":" ","Chemical_Composition_ElementsObser3__c":" ","Chemical_Composition_ElementsObser4__c":" ","Chemical_Composition_ElementsResult__c":" ","Chemical_Composition_ElementsResult1__c":" ","Chemical_Composition_ElementsResult2__c":" ","Chemical_Composition_ElementsResult3__c":" ","Chemical_Composition_ElementsResult4__c":" ","Optional_Test__c":"Thickness,Porosity,Perspiration,Wear"}';
       sObject recObj =(sObject)JSON.deserialize(recrd, QC_MTL_Component__c.class);
       // recObj.id=null;
       // insert recObj;
        update recObj;
       // sObject sObj = (sObject)recObj;
         recWrap= QC_Mtl_Plating_InputParamClass.fetchRecordInfo(recObj);
        String dataString=JSON.serialize(platOb);
        system.debug('dataString'+dataString);
        String data=recrd;
        //QC_MTL_Component__c recordInfo = (QC_MTL_Component__c)JSON.deserialize(data, QC_MTL_Component__c.class);
        //update recordInfo;
        
        //String mandTest ='[{"sObject":"QC_MTL_TestResponse__c","QC_Test_Questions_Value__c":"","User_Defined_Value__c":"ergeg","Result__c":"Accept","QC_MTL_Test__c":"a2JM00000002i8aMAA","Name":"Test1","QC_MTL_Component_del__c":"a2HM0000000BriyMAC","Standard_Defined_Value__c":"demo"},{"sObject":"QC_MTL_TestResponse__c","QC_Test_Questions_Value__c":"a2KM00000011jpIMAQ","User_Defined_Value__c":"erg","Result__c":"Accept","QC_MTL_Test__c":"a2JM00000002i8fMAA","Name":"Test2","QC_MTL_Component_del__c":"a2HM0000000BriyMAC","Standard_Defined_Value__c":"cdee"}]';
       // List<QC_MTL_TestResponse__c> mandList = (List<QC_MTL_TestResponse__c>)JSON.deserialize(platRespOb, List<QC_MTL_TestResponse__c>.class);
        
        String newTest ='[{"qcMTLQuestionRecordId":"","userInput":"ege","testVerdict":"Accept","testRecordId":"","standardDefinedValue":"egrer","testName":"eger"},{"qcMTLQuestionRecordId":"","userInput":"wgeg","testVerdict":"Reject","testRecordId":"","standardDefinedValue":"wgeweg","testName":"wefwr"}]';
        String optionaltest='[{"userInput":"hgyu","testVerdict":"Accept","testName":"Wear","testRecordId":"","standardDefinedValue":"Accept","PlatingTestType":"Optional"}]';
        String regularTest ='[{"userInput":"muyggu","testVerdict":"Accept","testName":"Porosity","testRecordId":"","standardDefinedValue":"Accept","PlatingTestType":"Regular"},{"userInput":"reg","testVerdict":"Accept","testName":"Perspiration","testRecordId":"","standardDefinedValue":"Accept","PlatingTestType":"Regular"},{"userInput":"eger","testVerdict":"Accept","testName":"TST","testRecordId":"","standardDefinedValue":"Accept","PlatingTestType":"Regular"}]';
             QC_Mtl_Plating_InputParamClass.ReturnWrapperClass returnObject=new QC_Mtl_Plating_InputParamClass.ReturnWrapperClass();
        returnObject=QC_Mtl_Plating_InputParamClass.saveRecordMethod(platOb,platRespOb,newTest,optionaltest,regularTest);
        String getUpdateRecord=JSON.serialize(returnObject.TestLists);
        List<QC_MTL_TestResponse__c> platRespOb1 =[SELECT Id,Name,Plating_Testing_Type__c,QC_MTL_Component_del__c,QC_MTL_Test__c,QC_Test_Questions_Value__c,Standard_Defined_Value__c,User_Defined_Value__c,Result__c FROM QC_MTL_TestResponse__c WHERE Name='PlatingBlahTest1'];
        List<String> deletePreviousResponse = new List<String>{};
        newTest=json.serialize(returnObject.TestLists);
        optionaltest=json.serialize(returnObject.optionalTests);
        regularTest=json.serialize(returnObject.regularTestLists);
        retrObj = QC_Mtl_Plating_InputParamClass.updateTestParameter(platOb,getUpdateRecord,newTest,optionaltest,regularTest,deletePreviousResponse);
        QC_Mtl_Plating_InputParamClass.getPickListValue('QC_MTL_Component__c','Material__c');
        //String getUpdatedRec='[{"IsmandatoryTest":true,"QCMTLTestResponseId":"a2IM0000000rA4oMAE","standardDefinedValue":"demo","testName":"Test1","testVerdict":"Accept","userInput":"ergeg"},{"IsmandatoryTest":true,"QCMTLTestResponseId":"a2IM0000000rA4pMAE","standardDefinedValue":"cdee","testName":"Test2","testVerdict":"Accept","userInput":"erg"},{"IsmandatoryTest":false,"QCMTLTestResponseId":"a2IM0000000rA4qMAE","standardDefinedValue":"egrer","testName":"eger","testVerdict":"Accept","userInput":"ege"},{"IsmandatoryTest":false,"QCMTLTestResponseId":"a2IM0000000rA4rMAE","standardDefinedValue":"wgeweg","testName":"wefwr","testVerdict":"Reject","userInput":"wgeg"},{"IsmandatoryTest":false,"QCMTLTestResponseId":"a2IM0000000rA4yMAE","standardDefinedValue":"wgewg","testName":"sdge","testVerdict":"Accept","userInput":"egwg"},{"IsmandatoryTest":false,"QCMTLTestResponseId":"a2IM0000000rA4zMAE","standardDefinedValue":"wge","testName":"wge","testVerdict":"Accept","userInput":"wge"},{"IsmandatoryTest":false,"QCMTLTestResponseId":"a2IM0000000rA50MAE","standardDefinedValue":"weg","testName":"weg","testVerdict":"Accept","userInput":"wge"}]';

       /* newTest='[{"qcMTLQuestionRecordId":"","userInput":"erer","testVerdict":"Accept","testRecordId":"","standardDefinedValue":"erfe","testName":"efer","addNewTestValueList":"a2HM0000000BriyMAC"},{"qcMTLQuestionRecordId":"","userInput":"refer","testVerdict":"Accept","testRecordId":"","standardDefinedValue":"erer","testName":"eref","addNewTestValueList":"a2HM0000000BriyMAC"},{"qcMTLQuestionRecordId":"","userInput":"ere","testVerdict":"Reject","testRecordId":"","standardDefinedValue":"erer","testName":"erer","addNewTestValueList":"a2HM0000000BriyMAC"}]';
        optionaltest='[{"IsmandatoryTest":false,"PlatingTestType":"Optional","QCMTLTestResponseId":"a2IM0000000rA4sMAE","standardDefinedValue":"Accept","testName":"Wear","testVerdict":"Accept","userInput":"hgyu"}]';
        regularTest='[{"IsmandatoryTest":false,"PlatingTestType":"Regular","QCMTLTestResponseId":"a2IM0000000rA4tMAE","standardDefinedValue":"Accept","testName":"Porosity","testVerdict":"Accept","userInput":"`muyggu"},{"IsmandatoryTest":false,"PlatingTestType":"Regular","QCMTLTestResponseId":"a2IM0000000rA4uMAE","standardDefinedValue":"Accept","testName":"Perspiration","testVerdict":"Accept","userInput":"reg"},{"IsmandatoryTest":false,"PlatingTestType":"Regular","QCMTLTestResponseId":"a2IM0000000rA4vMAE","standardDefinedValue":"Accept","testName":"TST","testVerdict":"Accept","userInput":"eger"}]';
        List<String> deletePreviousResponse = new List<String>{};*/
        //QC_Mtl_Plating_InputParamClass.getTestParameter(titanspecNumber, QCMtlComponentId);
       }
    
}