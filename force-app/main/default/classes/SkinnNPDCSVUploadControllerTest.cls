@isTest
public class SkinnNPDCSVUploadControllerTest {
public static Blob csvFileBody;
public static String [] fileLines;
    public static testmethod void validateCsvUpload(){
        Skinn_NPD_Template__c skinnTemplObj = new Skinn_NPD_Template__c();
        skinnTemplObj.Name='Test Project Template1';
        skinnTemplObj.Active__c =true;
        insert skinnTemplObj;
        
        Skinn_Model_Item__c eachSkinn1 = new Skinn_Model_Item__c();
        eachSkinn1.Item_Name__c = 'Release of project brief by Marketing';
        eachSkinn1.Serial_No__c='IN0601';
        eachSkinn1.Approval_required__c=false;
        eachSkinn1.Type__c ='Stage';
        eachSkinn1.Assigned_Team__c='Marketing User';
        eachSkinn1.TemplateType__c=skinnTemplObj.Name;
        //eachSkinn1.Parent_Id__c =;
        eachSkinn1.Order_No__c=1;
        eachSkinn1.User_Email__c='testUser1@npdskinn.com';
        insert eachSkinn1;
        
        Skinn_Model_Item__c eachSkinn2 = new Skinn_Model_Item__c();
        eachSkinn2.Item_Name__c = 'Brief to Fragrance house';
        eachSkinn2.Serial_No__c='IN0602';
        eachSkinn2.Approval_required__c=false;
        eachSkinn2.Type__c ='Sub-Stage';
        eachSkinn2.Assigned_Team__c='Fragrance Expert';
        eachSkinn2.TemplateType__c=skinnTemplObj.Name;
        eachSkinn2.Parent_Id__c =eachSkinn1.Id;
        eachSkinn2.Order_No__c=2;
        eachSkinn2.User_Email__c='testUser2@npdskinn.com';
        insert eachSkinn2;
        
        Skinn_Model_Item__c eachSkinn3 = new Skinn_Model_Item__c();
        eachSkinn3.Item_Name__c = 'Instore';
        eachSkinn3.Serial_No__c='IN0603';
        eachSkinn3.Approval_required__c=false;
        eachSkinn3.Type__c ='Activity';
        eachSkinn3.Assigned_Team__c='Sourcing';
        eachSkinn3.TemplateType__c=skinnTemplObj.Name;
        eachSkinn3.Parent_Id__c = eachSkinn2.Id;
        eachSkinn3.Order_No__c=3;
        eachSkinn3.User_Email__c='testUser3@npdskinn.com';
        insert eachSkinn3;
        
        Skinn_Model_Item__c eachSkinn4 = new Skinn_Model_Item__c();
        eachSkinn4.Item_Name__c = 'Instore,Outstore';
        eachSkinn4.Serial_No__c='IN0604';
        eachSkinn4.Approval_required__c=true;
        eachSkinn4.Type__c ='Activity';
        eachSkinn4.Assigned_Team__c='Marketing User';
        eachSkinn4.TemplateType__c=skinnTemplObj.Name;
        eachSkinn4.Parent_Id__c = eachSkinn3.Id;
        eachSkinn4.Order_No__c=4;
        eachSkinn4.User_Email__c='testUser4@npdskinn.com';
        insert eachSkinn4;
        
        SkinnNPDCsvUploadController1 skinnContrlrObj = new SkinnNPDCsvUploadController1();
        String blobBody='a2V2C000000XhXb,   1,  AR01,   Release of project brief by Marketing,  Stage,      Marketing User, 195,    Marketing Temp New,     ,FALSE'+'\n'+
'a2V2C000000XhY0,   2,  AR0101  Brief to Fragrance house,   Sub-Stage,  1,  Fragrance Expert,   97, Marketing Temp New,     ,FALSE,'+'\n'+
'a2V2C000000XhY5    ,3  ,AR0102 ,Brief to design house/ Agency for packaging material designs   ,Sub-Stage  ,1  ,Marketing User ,188    ,Marketing Temp New,        ,FALSE';
      skinnContrlrObj.SaveAsExcel();
        SkinnNPDCsvUploadController1.isValidTeam('Sourcing');
        String blobFile1=eachSkinn2.Id+'2,IN0602,Brief to Fragrance house,Sub-Stage,1,Fragrance Expert,199,Test Project Template1,testUser2@npdskinn.com,FALSE';
        String blobFile2=eachSkinn3.Id+'3,IN0603,Instore,Activity,1,Marketing User,88,Test Project Template1,testUser3@npdskinn.comFALSE';
        String blobFile3= 'a185B0000011YzF,1,IN0601,Release of project brief by Marketing,Stage,0,Marketing User,195,Test Project Template1,testUser1@npdskinn.com,FALSE'+'\n'+ 'a185B0000011YzF,1,IN0601,Release of project brief by Marketing,Stage,0,Marketing User,195,Test Project Template1,testUser1@npdskinn.com,FALSE'+'\n' +blobFile1+'\n'+blobFile2;
        csvFileBody = Blob.valueOf(blobFile3);
        skinnContrlrObj.contentFile =csvFileBody;
        skinnContrlrObj.recordSepr=csvFileBody.toString().split('\n');
        System.debug('csvFileBody.toString() :: '+csvFileBody.toString().split('\n'));
        skinnContrlrObj.UploadDataFromCsv();
        skinnContrlrObj.incr();
    }
}