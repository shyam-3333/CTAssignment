/*
*******************************************************************************************************************************************
ModifiedBy            Date         Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)	  Nov-28-2019	T01		Test Class Failure Fix Validation rule failure
*/
@isTest
public class SkinnNPDGanttChartVFPageControllerTest {
    
    public static testmethod void ganttChartData(){
        //<T01>created 5 users
        List<User> userslst = new List<User>();
        userslst = TestDataFactory.getUsers();
        List<Skinn_Model_Item__c> skinnModelRecords=new List<Skinn_Model_Item__c>();
        //Marketing Template
        Skinn_Model_Item__c skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Release of project brief by Marketing';
        skinnmodelRed.Type__c='Stage';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=195;
        skinnmodelRed.Order_No__c=1;
        skinnmodelRed.Serial_No__c='AR01';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Brief to Fragrance house';
        skinnmodelRed.Type__c='Sub-Stage';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=97;
        skinnmodelRed.Order_No__c=2;
        skinnmodelRed.Serial_No__c='AR0101';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Brief to design house/ Agency for packaging material designs';
        skinnmodelRed.Type__c='Sub-Stage';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=188;
        skinnmodelRed.Order_No__c=3;
        skinnmodelRed.Serial_No__c='AR0102';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Receipt of rendered image options for bottle & cap';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=90;
        skinnmodelRed.Order_No__c=4;
        skinnmodelRed.Serial_No__c='AR010101';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Receipt of Fragrance samples- options';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=5;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=6;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=7;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=8;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=9;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Finalization of Bottle and cap design option';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=7;
        skinnmodelRed.Order_No__c=10;
        skinnmodelRed.Serial_No__c='AR010102';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        //Project Template
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Sharing rendered images of bottle & cap with respective vendors';
        skinnmodelRed.Type__c='Stage';
        skinnmodelRed.Assigned_Team__c='NPD Packaging';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=202;
        skinnmodelRed.Order_No__c=11;
        skinnmodelRed.Serial_No__c='AR02';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Recepit of bottle dwg';
        skinnmodelRed.Type__c='Sub-Stage';
        skinnmodelRed.Assigned_Team__c='NPD Packaging';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=195;
        skinnmodelRed.Order_No__c=12;
        skinnmodelRed.Serial_No__c='AR0201';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='QA approval on bottle drawing';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='QA';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=188;
        skinnmodelRed.Order_No__c=13;
        skinnmodelRed.Serial_No__c='AR020101';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Artwork development for printing on bottle (both text & color pantone)';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=90;
        skinnmodelRed.Order_No__c=14;
        skinnmodelRed.Serial_No__c='AR020102';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed); 
        
        insert skinnModelRecords;
        Skinn_NPD_Template__c templateRecord=new Skinn_NPD_Template__c(Name='Marketing Temp',Active__c=true);
        Skinn_NPD_Template__c templateRecord2=new Skinn_NPD_Template__c(Name='Project Temp',Active__c=true);
        insert templateRecord;
        insert templateRecord2;
        List<Skinn_NPD_Template_Item__c> listJunctionRecords=new List<Skinn_NPD_Template_Item__c>();
        integer i=0;
        for(Skinn_Model_Item__c each:skinnModelRecords ){
            if(i<10){
                listJunctionRecords.add(new Skinn_NPD_Template_Item__c(Active__c=true,Order_No__c=each.Order_No__c,Planned_Lead_Time__c=each.Planned_Lead_Time__c,Skinn_Model_Item__c=each.Id,Skinn_NPD_Template__c=templateRecord.Id));   
            }else{
                listJunctionRecords.add(new Skinn_NPD_Template_Item__c(Active__c=true,Order_No__c=each.Order_No__c,Planned_Lead_Time__c=each.Planned_Lead_Time__c,Skinn_Model_Item__c=each.Id,Skinn_NPD_Template__c=templateRecord2.Id));  
            }
            i++;
        }
        insert listJunctionRecords;
        
        listJunctionRecords[1].Parent_Id__c=listJunctionRecords[0].Id;
        listJunctionRecords[2].Parent_Id__c=listJunctionRecords[0].Id;
        listJunctionRecords[3].Parent_Id__c=listJunctionRecords[1].Id;
        listJunctionRecords[4].Parent_Id__c=listJunctionRecords[3].Id;
        listJunctionRecords[5].Parent_Id__c=listJunctionRecords[2].Id;
        listJunctionRecords[6].Parent_Id__c=listJunctionRecords[5].Id;
        listJunctionRecords[7].Parent_Id__c=listJunctionRecords[6].Id;
        listJunctionRecords[8].Parent_Id__c=listJunctionRecords[7].Id;
        listJunctionRecords[9].Parent_Id__c=listJunctionRecords[8].Id;
        listJunctionRecords[10].Parent_Id__c=listJunctionRecords[0].Id;
        update listJunctionRecords;
        
        List<Common_User__c> Users=new List<Common_User__c>();
        Users.add(new Common_User__c(Name='Marketing User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='Marketing User',Team__c=userslst.get(0).Id));
        Users.add(new Common_User__c(Name='Fragrance User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='Fragrance Expert',Team__c=userslst.get(1).Id));
        Users.add(new Common_User__c(Name='NPD User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='NPD Packaging',Team__c=userslst.get(2).Id));
        Users.add(new Common_User__c(Name='QA User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='QA',Team__c=userslst.get(3).Id));
        Users.add(new Common_User__c(Name='Sourcing User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='Sourcing',Team__c=userslst.get(4).Id));
        insert Users;
        
        List<Skinn_Collection__c> collectionRecords=new List<Skinn_Collection__c>();
        Skinn_Collection__c ColleactionRecord1=new Skinn_Collection__c(Name='CollectionName',Collection_Status__c='Open',Market__c='Test',Marketing_User__c=Users[0].Id,Fragrance_User__c=Users[1].Id,NPD_Packaging_User__c=Users[2].Id,QA_User__c=Users[3].Id,Sourcing_User__c=Users[4].Id);
        Skinn_Collection__c ColleactionRecord2=new Skinn_Collection__c(Name='CollectionName1',Collection_Status__c='Open',Market__c='Test',Marketing_User__c=Users[0].Id,Fragrance_User__c=Users[1].Id,NPD_Packaging_User__c=Users[2].Id,QA_User__c=Users[3].Id,Sourcing_User__c=Users[4].Id);
        ColleactionRecord1.Marketing_Template__c=templateRecord.Id;
        ColleactionRecord1.Project_Template__c=templateRecord2.Id;
        ColleactionRecord1.Marketing_User__c=Users[0].Id;
        ColleactionRecord1.Fragrance_User__c=Users[1].Id;
        ColleactionRecord1.NPD_Packaging_User__c=Users[2].Id;
        ColleactionRecord1.QA_User__c=Users[3].Id;
        ColleactionRecord1.Sourcing_User__c=Users[4].Id;
        ColleactionRecord1.Project_Lead__c=Users[2].Id;
        collectionRecords.add(ColleactionRecord1);
        //collectionRecords.add(ColleactionRecord2);
        insert collectionRecords;
        Skinn_Model__c sknMdl = new Skinn_Model__c(Name='TestModel1',Skinn_Collection__c =collectionRecords[0].Id);
        insert sknMdl;
        //String jsonFile ='{"Planned_Lead_Time__c":10.0,"Responsibly__c":"","Skinn_Collection__c":"","Item_Names__c":"","Template_Name__c":"","Order_Number__c":1.0,"Active__c":true,"Approval_Required__c":false,"Skinn_Model__c":"","Type__c":"Stage","Skinn_NPD_Template_Item__c":"","Actual_End_date__c":"","Actual_start_date__c":"2019-05-02","Actual_Lead_Time__c":"","Comments_Remarks__c":"","planned_End_Date__c":"2019-05-11","planned_Start_Date__c":"2019-05-02","R1_End_Date__c":"","R1_Start_Date__c":"","R1_Status__c":"Not Started","R2_End_Date__c":"","R2_Start_Date__c":"","R2_Status__c":"Not Started","R3_End_Date__c":"","R3_Start_Date__c":"","R3_Status__c":"Not Started","R4_End_Date__c":"","R4_Start_Date__c":"","R4_Status__c":"Not Started","R5_End_Date__c":"","R5_Start_Date__c":"","R5_Status__c":"Not Started","Revision_status__c":"","Status__c":"In Progress","Approval_Status__c":"","Item_Name__c":"Release of project brief by Marketing","Stage_Completed_First_Time__c":false,"Approval_Count__c":"","IsRevisionInProgress__c":false,"R1Approved__c":"","R2Approved__c":"","R3Approved__c":"","R4Approved__c":"","R5Approved__c":""}';
        //Skinn_Collection_Template__c obj1 =(Skinn_Collection_Template__c)JSON.deserializeStrict(jsonFile, Skinn_Collection_Template__c.class) ;
        //System.debug('obj1 :: '+obj1);
        Skinn_Collection_Template__c obj1 = new Skinn_Collection_Template__c(Planned_Lead_Time__c=10.0,Hierarchy__c='->null',Responsibly__c=users[0].Id,Skinn_Collection__c=collectionRecords[0].Id,Item_Names__c=skinnModelRecords[0].Id,Template_Name__c=templateRecord.Id,Order_Number__c=1.0,Active__c=true,Approval_Required__c=false,Skinn_Model__c=sknMdl.Id,Type__c='Stage',Skinn_NPD_Template_Item__c =listJunctionRecords[0].Id ,   Actual_End_date__c = null,   Actual_start_date__c = Date.valueOf('2019-05-02'),  Comments_Remarks__c = null,   planned_End_Date__c =Date.valueOf('2019-05-11'),   planned_Start_Date__c = Date.valueOf('2019-05-02'),   R1_End_Date__c = null,   R1_Start_Date__c = null,   R1_Status__c = 'Not Started',   R2_End_Date__c = null,   R2_Start_Date__c = null,   R2_Status__c = 'Not Started',   R3_End_Date__c = null,   R3_Start_Date__c = null,   R3_Status__c = 'Not Started',   R4_End_Date__c = null,   R4_Start_Date__c = null,   R4_Status__c = 'Not Started',   R5_End_Date__c = null,   R5_Start_Date__c = null,   R5_Status__c = 'Not Started',   Revision_status__c = null,   Status__c = 'In Progress',   Approval_Status__c = null,   Item_Name__c = 'Release of project brief by Marketing',   Approval_Count__c = null,  R1Approved__c = null,   R2Approved__c = null,   R3Approved__c = null,   R4Approved__c = null,   R5Approved__c = null);
        insert obj1;
        List<SkinnNPDGanttChartVFPageController.WrapperClassSubStage> wrpSbList = new List<SkinnNPDGanttChartVFPageController.WrapperClassSubStage>();
        List<SkinnNPDGanttChartVFPageController.WrapperClassStage> wrpStgList = new List<SkinnNPDGanttChartVFPageController.WrapperClassStage>(); 
        Skinn_Collection__c collecObj = new Skinn_Collection__c(Name='Test CollectionData1',Tentative_Launch_Date__c=Date.valueOf('2019-04-30'),Volume__c=50.0,Market__c='Marketing',Project_Status__c='On Going',Collection_Status__c='Open',Project_Lead__c=Users[2].Id,Marketing_Template__c=templateRecord.Id,Project_Template__c=templateRecord2.Id,User_Email_del__c='sameer.ranjan@kvpcorp.com',Marketing_User__c=Users[0].Id,Sourcing_User__c=Users[4].Id,NPD_Packaging_User__c=Users[3].Id,Fragrance_User__c=Users[1].Id,QA_User__c=Users[2].Id,Project_Lead_Email_Id__c='sameer.ranjan@kvpcorp.com');
        SkinnNPDGanttChartVFPageController.WrapperClassSubStage wrpSubStageObj = new SkinnNPDGanttChartVFPageController.WrapperClassSubStage();
        wrpSubStageObj.Name='CollectionData1';
        wrpSubStageObj.OrderNumber =0;
        wrpSubStageObj.firstSpanForPlan = 0;
        wrpSubStageObj.strPlanStartDate =String.valueOf(10);
        wrpSubStageObj.secondSpanForPlan = 0;
        wrpSubStageObj.thirdSpanForPlan =0;
        wrpSubStageObj.strPlanLeadTime = String.valueOf(20);
        wrpSubStageObj.strPlanEndDate = String.valueof((System.today()+20).day()) +'/'+String.valueOf(System.today().month()+1);
        wrpSubStageObj.strPlanStartDate = '';
        wrpSubStageObj.planEndDate = Date.valueOf(System.today());
        wrpSubStageObj.planhighlighted = '#003399';
        wrpSubStageObj.marginleft = String.valueOf(System.today());
        wrpSubStageObj.firstSpanForActual = Integer.valueOf('10');
        wrpSubStageObj.strActualStartDate = '';
        wrpSubStageObj.secondSpanForActual = Integer.valueOf('20');
        wrpSubStageObj.actualhighlighted = '#A52A2A';
        wrpSubStageObj.thirdSpanForActual = Integer.valueOf('30');
        wrpSubStageObj.strActualLeadTime = '';
        wrpSubStageObj.strActualEndDate ='' ;
        wrpSbList.add(wrpSubStageObj);
        
        SkinnNPDGanttChartVFPageController.WrapperClassStage wrpStgObj = new SkinnNPDGanttChartVFPageController.WrapperClassStage();
        wrpStgObj.Name='TestStage1';
        wrpStgObj.OrderNumber =0;
        wrpStgObj.firstSpanForPlan = 0;
        wrpStgObj.strPlanStartDate =String.valueOf(10);
        wrpStgObj.secondSpanForPlan = 0;
        wrpStgObj.thirdSpanForPlan =0;
        wrpStgObj.strPlanLeadTime = String.valueOf(20);
        wrpStgObj.strPlanEndDate = String.valueof((System.today()+20).day()) +'/'+String.valueOf(System.today().month()+1);
        wrpStgObj.strPlanStartDate = '';
        wrpStgObj.planEndDate = Date.valueOf(System.today());
        wrpStgObj.planhighlighted = '#003399';
        wrpStgObj.marginleft = String.valueOf(System.today());
        wrpStgObj.firstSpanForActual = Integer.valueOf('10');
        wrpStgObj.strActualStartDate = '';
        wrpStgObj.secondSpanForActual = Integer.valueOf('20');
        wrpStgObj.actualhighlighted = '#A52A2A';
        wrpStgObj.thirdSpanForActual = Integer.valueOf('30');
        wrpStgObj.strActualLeadTime = '';
        wrpStgObj.strActualEndDate ='' ;
        wrpStgObj.skinnSubStageRecords=wrpSbList;
        wrpStgList.add(wrpStgObj);
        SkinnNPDGanttChartVFPageController.WrapperClassNPDGanttChart wrpClsObj = new SkinnNPDGanttChartVFPageController.WrapperClassNPDGanttChart();
        List<SkinnNPDGanttChartVFPageController.WrapperClassNPDGanttChart> wrpGntList = new List<SkinnNPDGanttChartVFPageController.WrapperClassNPDGanttChart>();
        wrpClsObj.skinnModelName =sknMdl.Name;
        wrpClsObj.skinnStageRecords=wrpStgList;
        wrpGntList.add(wrpClsObj);
        
        Set<Id> mdlIdSet = new Set<Id>{sknMdl.Id};                          
            SkinnNPDGanttChartVFPageController skinnNPDGntObj = new SkinnNPDGanttChartVFPageController();
        skinnNPDGntObj.queryModels();
        skinnNPDGntObj.queryData();
        skinnNPDGntObj.queryCollections();
        skinnNPDGntObj.queryStages();
        skinnNPDGntObj.calculateMonths();
        skinnNPDGntObj.calcStartDate(obj1.Name,sknMdl.Name);
        skinnNPDGntObj.calculateDays();
        skinnNPDGntObj.buildMonthMap();
        skinnNPDGntObj.calcDefaultMonthts();
        skinnNPDGntObj.calculatePlanSpan(obj1);
        skinnNPDGntObj.fetchAllRecord(String.valueOf(collectionRecords[0].Id), mdlIdSet);
        obj1.Status__c='Completed';
        obj1.Actual_start_date__c=system.today();
        obj1.Actual_End_date__c=system.today();
        skinnNPDGntObj.FillDataBasedOnStatus(wrpClsObj, wrpStgObj, obj1);
        obj1.Status__c='Not Started';
        skinnNPDGntObj.FillDataBasedOnStatus(wrpClsObj, wrpStgObj, obj1);
        obj1.Status__c='In Progress';
        skinnNPDGntObj.FillDataBasedOnStatus(wrpClsObj, wrpStgObj, obj1);
        map<String,List<Skinn_Collection_Template__c>> mapOfMSStageWithSubStage=new map<String,List<Skinn_Collection_Template__c>>();
        List<Skinn_Collection_Template__c> listCompo=new List<Skinn_Collection_Template__c>();
        listCompo.add(obj1);
        mapOfMSStageWithSubStage.put(obj1.Skinn_NPD_Template_Item__c,listCompo);
        list<Skinn_Model__c> MartetingStagelist=[SELECT Id FROM Skinn_Model__c where Skinn_Collection__c=:collectionRecords[0].Id and name='MarketingStage'];
        // Error fix by Ranjani n-Lister (List out out of bounds)
        system.debug('MartetingStagelist'+MartetingStagelist);
        if(MartetingStagelist!=null && !MartetingStagelist.isempty())
        {
            Skinn_Model__c MartetingStageId = MartetingStagelist[0];
            
        skinnNPDGntObj.fillDataBasedOnStatusWhenStage(wrpClsObj,wrpStgObj, wrpSubStageObj,obj1,mapOfMSStageWithSubStage,MartetingStageId.Id);
        obj1.Status__c='Not Started';
        skinnNPDGntObj.fillDataBasedOnStatusWhenStage(wrpClsObj,wrpStgObj, wrpSubStageObj,obj1,mapOfMSStageWithSubStage,MartetingStageId.Id);
        obj1.Status__c='Completed';
        skinnNPDGntObj.fillDataBasedOnStatusWhenStage(wrpClsObj,wrpStgObj, wrpSubStageObj,obj1,mapOfMSStageWithSubStage,MartetingStageId.Id);
        obj1.Status__c='Completed';
        skinnNPDGntObj.fillDataBasedOnStatusWhenStageSubStage(wrpClsObj,wrpStgObj, wrpSubStageObj,obj1,mapOfMSStageWithSubStage,MartetingStageId.Id);
        obj1.Status__c='Not Started';
        skinnNPDGntObj.fillDataBasedOnStatusWhenStageSubStage(wrpClsObj,wrpStgObj, wrpSubStageObj,obj1,mapOfMSStageWithSubStage,MartetingStageId.Id);
        obj1.Status__c='In Progress';
        skinnNPDGntObj.fillDataBasedOnStatusWhenStageSubStage(wrpClsObj,wrpStgObj, wrpSubStageObj,obj1,mapOfMSStageWithSubStage,MartetingStageId.Id);
        // obj1.Status__c='Completed';
        // skinnNPDGntObj.FillDataBasedOnStatus(wrpClsObj, wrpStgObj, obj1);
        //skinnNPDGntObj.fillDataBasedOnStatusWhenStage(tempVar, temvar2, temvar3, mseachstage, mapOfMSStageWithSubStage, currentmarketingStageId);
        //skinnNPDGntObj.skinnModelView();
        skinnNPDGntObj.IplusMethod();
        }
    }
}