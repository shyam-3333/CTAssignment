@isTest
public class QC_custom_report_controllerTest {
 //TriggerExecutionController__c.getInstance('Qc_Component_Lightning_Trigger').TriggerIsActive__c == false;
    
    /* Map<String, ServiceTokens__c> setting = ServiceTokens__c.getall();
    ServiceTokens__c token = setting.get('Token__c');                              
    String token = token.Token__c;
In the test setup method I have the following:

    ServiceTokens__c tokenCustomSetting = new ServiceTokens__c();         
    tokenCustomSetting.Name = 'Token__c';        
    tokenCustomSetting.Token__c = 'placholder';        
    insert tokenCustomSetting; */
    
    @isTest
    public static void testMethod1()
    {


    TriggerExecutionController__c tokenCustomSetting = new TriggerExecutionController__c();         
    tokenCustomSetting.Name = 'Qc_Component_Lightning_Trigger';        
    tokenCustomSetting.TriggerIsActive__c = false;        
    insert tokenCustomSetting;
        QC_custom_report_controller qc_controller = new QC_custom_report_controller();
        List<SelectOption> getItem = qc_controller.getItems();
        List<SelectOption> getVerdict = qc_controller.getverdicts();
        list<QC_Components__c> getrecords = qc_controller.records;
        
        Id ConditionRT = [Select id From RecordType Where sObjectType = 'QC_condition__c'and RecordType.Name = 'Test Condition' limit 1].id;
        Id BrandRT = [Select id From RecordType Where sObjectType = 'QC_Master__c'and RecordType.Name = 'Brand Details' limit 1].id;
        
        QC_Master__c qcMaster = new QC_Master__c();
        qcMaster.Name = 'TITAN';
        qcMaster.RecordTypeId = BrandRT;
        insert qcMaster;
        
        QC_condition__c q1 = new QC_condition__c();
        q1.Component_Type__c = 'Dial';
        q1.RecordTypeId = ConditionRT;
        q1.Onload__c = true;
        insert q1;
        
        QC_Components__c qcComp1 = new QC_Components__c();
        qcComp1.Name__c ='Dail';
        qcComp1.Report_Ref_Number__c = 'refNum1';
        qcComp1.Watch_variant__c = 'mbvfd';
        qcComp1.Model__c ='fd';
        qcComp1.SKU_Reference__c ='dfghbfhfgbfgbfg';
        qcComp1.Brand__c = qcMaster.Id;
        //qcComp1.Vendor__c ='';
        qcComp1.Final_Verdict__c = 'All';
        qcComp1.Master_Variant__c=qcComp1.Id;
        qcComp1.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp1.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        insert qcComp1;
        
        QC_Test_Data__c qcTests = new QC_Test_Data__c();
        qcTests.Test_Name__c = 'test1';
        qcTests.Observation__c = 'ob1';
        qcTests.Conclusion__c = 'Accept';
        qcTests.Component_Name__c = qcComp1.Id;
        insert qcTests;
        
        QC_Components__c qcComp2 = new QC_Components__c();
        qcComp2.Name__c = 'All';
        qcComp2.Report_Ref_Number__c = 'refNum2';
        qcComp2.Watch_variant__c = 'watch';
        qcComp2.Model__c ='fdfbhjd';
        qcComp2.SKU_Reference__c ='hgvbghvvhgg';
        qcComp2.Final_Verdict__c = 'Accept';
        qcComp2.Brand__c = qcMaster.Id;
        qcComp2.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp2.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.approval_submitted_date__c = date.newInstance(2020, 4, 20);
       qcComp2.createdDate =  date.newInstance(2020, 4, 20);
        insert qcComp2;
        
        QC_Test_Data__c qcTests1 = new QC_Test_Data__c();
        qcTests1.Test_Name__c = 'test2';
        qcTests1.Observation__c = 'ob2';
        qcTests1.Conclusion__c = 'Reject';
        qcTests1.Component_Name__c = qcComp2.Id;
        insert qcTests1;
        
        
        
        
     
         qc_controller.startDate = date.newInstance(2010, 11, 01);
        qc_controller.tillDate = date.newInstance(2021, 11, 01);
        qc_controller.compType = 'Dail';
        qc_controller.finalVerdict = 'All';
        qc_controller.selectedBrandName = 'TITAN';
        
        QC_custom_report_controller.wrapperClass wp = new QC_custom_report_controller.wrapperClass();
      
        QC_custom_report_controller.testWrapper tp = new QC_custom_report_controller.testWrapper();
        
        qc_controller.getComponents();
          //QC_custom_report_controller.wrapperClass wrapperList = qc_controller.getComponents();
        pageReference pageRef = qc_controller.download();
        
        Test.setCurrentPageReference(pageRef);
        qc_controller.getDownloadComps();
    }
     @isTest
    public static void testMethod2()
    {
         TriggerExecutionController__c tokenCustomSetting = new TriggerExecutionController__c();         
    tokenCustomSetting.Name = 'Qc_Component_Lightning_Trigger';        
    tokenCustomSetting.TriggerIsActive__c = false;        
    insert tokenCustomSetting;
        QC_custom_report_controller qc_controller = new QC_custom_report_controller();
        List<SelectOption> getItem = qc_controller.getItems();
        List<SelectOption> getVerdict = qc_controller.getverdicts();
        
        Id ConditionRT = [Select id From RecordType Where sObjectType = 'QC_condition__c'and RecordType.Name = 'Test Condition' limit 1].id;
        Id BrandRT = [Select id From RecordType Where sObjectType = 'QC_Master__c'and RecordType.Name = 'Brand Details' limit 1].id;
        
        QC_Master__c qcMaster = new QC_Master__c();
        qcMaster.Name = 'TITAN';
        qcMaster.RecordTypeId = BrandRT;
        insert qcMaster;
        
        QC_condition__c q1 = new QC_condition__c();
        q1.Component_Type__c = 'Dial';
        q1.RecordTypeId = ConditionRT;
        q1.Onload__c = true;
        insert q1;
        
        QC_Components__c qcComp1 = new QC_Components__c();
        qcComp1.Name__c ='Dail';
        qcComp1.Report_Ref_Number__c = 'refNum1';
        qcComp1.Watch_variant__c = 'mbvfd';
        qcComp1.Model__c ='fd';
        qcComp1.SKU_Reference__c ='dfghbfhfgbfgbfg';
        qcComp1.Brand__c = qcMaster.Id;
        //qcComp1.Vendor__c ='';
        qcComp1.Final_Verdict__c = 'All';
        qcComp1.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp1.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        insert qcComp1;
        
        QC_Test_Data__c qcTests = new QC_Test_Data__c();
        qcTests.Test_Name__c = 'test1';
        qcTests.Observation__c = 'ob1';
        qcTests.Conclusion__c = 'Accept';
        qcTests.Component_Name__c = qcComp1.Id;
        insert qcTests;
        
        QC_Components__c qcComp2 = new QC_Components__c();
        qcComp2.Name__c = 'All';
        qcComp2.Report_Ref_Number__c = 'refNum2';
        qcComp2.Watch_variant__c = 'watch';
        qcComp2.Model__c ='fdfbhjd';
        qcComp2.SKU_Reference__c ='hgvbghvvhgg';
        qcComp2.Final_Verdict__c = 'Accept';
        qcComp2.Brand__c = qcMaster.Id;
        qcComp2.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp2.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        insert qcComp2;
        
        QC_Test_Data__c qcTests1 = new QC_Test_Data__c();
        qcTests1.Test_Name__c = 'test2';
        qcTests1.Observation__c = 'ob2';
        qcTests1.Conclusion__c = 'Reject';
        qcTests1.Component_Name__c = qcComp2.Id;
        insert qcTests1;
        
        
        
        
        
        qc_controller.startDate = date.newInstance(2010, 11, 01);
        qc_controller.tillDate = date.newInstance(2021, 11, 01);
        qc_controller.compType = 'Dail';
        qc_controller.finalVerdict = 'Accept';
        qc_controller.selectedBrandName = 'All';
        QC_custom_report_controller.wrapperClass wp = new QC_custom_report_controller.wrapperClass();
        wp.comp=qcComp1;
        QC_custom_report_controller.testWrapper tp = new QC_custom_report_controller.testWrapper();
         tp.testName = qcTests.Test_Name__c;
                tp.Observation = qcTests.Observation__c;
                tp.verdict = qcTests.Conclusion__c;
        
        qc_controller.getComponents();
        
        pageReference pageRef = qc_controller.download();
        
        Test.setCurrentPageReference(pageRef);
        qc_controller.getDownloadComps();
    }
    @isTest
    public static void testMethod3()
    {
         TriggerExecutionController__c tokenCustomSetting = new TriggerExecutionController__c();         
    tokenCustomSetting.Name = 'Qc_Component_Lightning_Trigger';        
    tokenCustomSetting.TriggerIsActive__c = false;        
    insert tokenCustomSetting;
        QC_custom_report_controller qc_controller = new QC_custom_report_controller();
        List<SelectOption> getItem = qc_controller.getItems();
        List<SelectOption> getVerdict = qc_controller.getverdicts();
        
        Id ConditionRT = [Select id From RecordType Where sObjectType = 'QC_condition__c'and RecordType.Name = 'Test Condition' limit 1].id;
        Id BrandRT = [Select id From RecordType Where sObjectType = 'QC_Master__c'and RecordType.Name = 'Brand Details' limit 1].id;
        
        QC_Master__c qcMaster = new QC_Master__c();
        qcMaster.Name = 'TITAN';
        qcMaster.RecordTypeId = BrandRT;
        insert qcMaster;
        
        QC_condition__c q1 = new QC_condition__c();
        q1.Component_Type__c = 'All';
        q1.RecordTypeId = ConditionRT;
        q1.Onload__c = true;
        insert q1;
        
        QC_Components__c qcComp1 = new QC_Components__c();
        qcComp1.Name__c ='Dail';
        qcComp1.Report_Ref_Number__c = 'refNum1';
        qcComp1.Watch_variant__c = 'mbvfd';
        qcComp1.Model__c ='fd';
        qcComp1.SKU_Reference__c ='dfghbfhfgbfgbfg';
        qcComp1.Brand__c = qcMaster.Id;
        //qcComp1.Vendor__c ='';
        qcComp1.Final_Verdict__c = 'All';
        qcComp1.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp1.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        insert qcComp1;
        
        QC_Test_Data__c qcTests = new QC_Test_Data__c();
        qcTests.Test_Name__c = 'test1';
        qcTests.Observation__c = 'ob1';
        qcTests.Conclusion__c = 'Accept';
        qcTests.Component_Name__c = qcComp1.Id;
        insert qcTests;
        
        QC_Components__c qcComp2 = new QC_Components__c();
        qcComp2.Name__c = 'All';
        qcComp2.Report_Ref_Number__c = 'refNum2';
        qcComp2.Watch_variant__c = 'watch';
        qcComp2.Model__c ='fdfbhjd';
        qcComp2.SKU_Reference__c ='hgvbghvvhgg';
        qcComp2.Final_Verdict__c = 'Accept';
        qcComp2.Brand__c = qcMaster.Id;
        qcComp2.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp2.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        insert qcComp2;
        
        QC_Test_Data__c qcTests1 = new QC_Test_Data__c();
        qcTests1.Test_Name__c = 'test2';
        qcTests1.Observation__c = 'ob2';
        qcTests1.Conclusion__c = 'Reject';
        qcTests1.Component_Name__c = qcComp2.Id;
        insert qcTests1;
        
        
        
        
        
        qc_controller.startDate = date.newInstance(2010, 11, 01);
        qc_controller.tillDate = date.newInstance(2021, 11, 01);
        qc_controller.compType = 'All';
        qc_controller.finalVerdict = 'All';
        qc_controller.selectedBrandName = 'All';
        QC_custom_report_controller.wrapperClass wp = new QC_custom_report_controller.wrapperClass();
        wp.comp=qcComp2;
        QC_custom_report_controller.testWrapper tp = new QC_custom_report_controller.testWrapper();
         tp.testName = qcTests1.Test_Name__c;
                tp.Observation = qcTests1.Observation__c;
                tp.verdict = qcTests1.Conclusion__c;
        
        qc_controller.getComponents();
        
        pageReference pageRef = qc_controller.download();
        
        Test.setCurrentPageReference(pageRef);
        qc_controller.getDownloadComps();
        
    }
     @isTest
    public static void testMethod4()
    { 
         TriggerExecutionController__c tokenCustomSetting = new TriggerExecutionController__c();         
    tokenCustomSetting.Name = 'Qc_Component_Lightning_Trigger';        
    tokenCustomSetting.TriggerIsActive__c = false;        
    insert tokenCustomSetting;
        
        QC_custom_report_controller qc_controller = new QC_custom_report_controller();
        List<SelectOption> getItem = qc_controller.getItems();
        List<SelectOption> getVerdict = qc_controller.getverdicts();
        
        Id ConditionRT = [Select id From RecordType Where sObjectType = 'QC_condition__c'and RecordType.Name = 'Test Condition' limit 1].id;
        Id BrandRT = [Select id From RecordType Where sObjectType = 'QC_Master__c'and RecordType.Name = 'Brand Details' limit 1].id;
        
        
        QC_Master__c qcMaster = new QC_Master__c();
        qcMaster.Name = 'TITAN';
        qcMaster.RecordTypeId = BrandRT;
        insert qcMaster;
        
        
        QC_condition__c q1 = new QC_condition__c();
        q1.Component_Type__c = 'All';
        q1.RecordTypeId = ConditionRT;
        q1.Onload__c = true;
        insert q1;
        
        QC_Components__c qcComp3 = new QC_Components__c();
        qcComp3.Name__c ='Dail';
        qcComp3.Report_Ref_Number__c = 'refNum1';
        qcComp3.Watch_variant__c = 'mbvfd';
        qcComp3.Model__c ='fd';
        qcComp3.SKU_Reference__c ='dfghbfhfgbfgbfg';
        qcComp3.Brand__c = qcMaster.Id;
        //qcComp1.Vendor__c ='';
        qcComp3.Final_Verdict__c = 'All';
        qcComp3.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp3.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp3.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp3.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        qcComp3.Createddate = date.newInstance(2011, 1, 20);
        insert qcComp3;
        
        QC_Test_Data__c qcTests2 = new QC_Test_Data__c();
        qcTests2.Test_Name__c = 'test1';
        qcTests2.Observation__c = 'ob1';
        qcTests2.Conclusion__c = 'Accept';
        qcTests2.Component_Name__c = qcComp3.Id;
        insert qcTests2;
        
        QC_Components__c qcComp4 = new QC_Components__c();
        qcComp4.Name__c = 'All';
        qcComp4.Report_Ref_Number__c = 'refNum2';
        qcComp4.Watch_variant__c = 'watch';
        qcComp4.Model__c ='fdfbhjd';
        qcComp4.SKU_Reference__c ='hgvbghvvhgg';
        qcComp4.Final_Verdict__c = 'Accept';
        qcComp4.Brand__c = qcMaster.Id;
        qcComp4.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp4.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp4.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp4.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        qcComp4.Createddate = date.newInstance(2010, 12, 20);
        
        insert qcComp4;
        Apexpages.currentPage().getparameters().put('id',qcComp4.id);
        
        QC_Test_Data__c qcTests3 = new QC_Test_Data__c();
        qcTests3.Test_Name__c = 'test2';
        qcTests3.Observation__c = 'ob2';
        qcTests3.Conclusion__c = 'Reject';
        qcTests3.Component_Name__c = qcComp3.Id;
        insert qcTests3;
        
    
        
        
        
        
        
        qc_controller.startDate = date.newInstance(2010, 11, 01);
        qc_controller.tillDate = date.newInstance(2021, 11, 01);
       // qc_controller.dateAsStringDL = date.newInstance(2021, 11, 01);
        qc_controller.compType = '';
        qc_controller.finalVerdict = 'All';
        qc_controller.selectedBrandName = 'All';
        
        QC_custom_report_controller.wrapperClass wp = new QC_custom_report_controller.wrapperClass();
       
        QC_custom_report_controller.testWrapper tp = new QC_custom_report_controller.testWrapper();
       
        List<QC_Components__c> qcToInsert = new List<QC_Components__c>{
            new QC_Components__c (Name__c = 'A'),
            new QC_Components__c (Name__c = 'B')    
        }; 
        insert qcToInsert;    
        
        List<string> strList = new List<string>();
        strList.add('A');
        strList.add('B');
     //  List<QC_custom_report_controller.wrapperClass> wrapperList = QC_custom_report_controller. wrapperClass();
        
      //  system.assert(wrapperList.size() == 2);
        
        
        qc_controller.getComponents();
        
        
        pageReference pageRef = qc_controller.download();
        
        Test.setCurrentPageReference(pageRef);
        qc_controller.getDownloadComps();
       
        
    }
     @isTest
    public static void testMethod5()
    {
         TriggerExecutionController__c tokenCustomSetting = new TriggerExecutionController__c();         
    tokenCustomSetting.Name = 'Qc_Component_Lightning_Trigger';        
    tokenCustomSetting.TriggerIsActive__c = false;        
    insert tokenCustomSetting;
        QC_custom_report_controller qc_controller = new QC_custom_report_controller();
        List<SelectOption> getItem = qc_controller.getItems();
        List<SelectOption> getVerdict = qc_controller.getverdicts();
        
        Id ConditionRT = [Select id From RecordType Where sObjectType = 'QC_condition__c'and RecordType.Name = 'Test Condition' limit 1].id;
        Id BrandRT = [Select id From RecordType Where sObjectType = 'QC_Master__c'and RecordType.Name = 'Brand Details' limit 1].id;
        
        QC_Master__c qcMaster = new QC_Master__c();
        qcMaster.Name = 'TITAN';
        qcMaster.RecordTypeId = BrandRT;
        
        insert qcMaster;
        
        QC_condition__c q1 = new QC_condition__c();
        q1.Component_Type__c = 'All';
        q1.RecordTypeId = ConditionRT;
        q1.Onload__c = true;
        insert q1;
        
        QC_Components__c qcComp1 = new QC_Components__c();
        qcComp1.Name__c ='Dail';
        qcComp1.Report_Ref_Number__c = 'refNum1';
        qcComp1.Watch_variant__c = 'mbvfd';
        qcComp1.Model__c ='fd';
        qcComp1.SKU_Reference__c ='dfghbfhfgbfgbfg';
        qcComp1.Brand__c = qcMaster.Id;
        //qcComp1.Vendor__c ='';
        qcComp1.Final_Verdict__c = 'All';
        qcComp1.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp1.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        insert qcComp1;
        
        QC_Test_Data__c qcTests = new QC_Test_Data__c();
        qcTests.Test_Name__c = 'test1';
        qcTests.Observation__c = 'ob1';
        qcTests.Conclusion__c = 'Accept';
        qcTests.Component_Name__c = qcComp1.Id;
        insert qcTests;
        
        QC_Components__c qcComp2 = new QC_Components__c();
        qcComp2.Name__c = 'All';
        qcComp2.Report_Ref_Number__c = 'refNum2';
        qcComp2.Watch_variant__c = 'watch';
        qcComp2.Model__c ='fdfbhjd';
        qcComp2.SKU_Reference__c ='hgvbghvvhgg';
        qcComp2.Final_Verdict__c = 'Accept';
        qcComp2.Brand__c = qcMaster.Id;
        qcComp2.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp2.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        insert qcComp2;
        
        QC_Test_Data__c qcTests1 = new QC_Test_Data__c();
        qcTests1.Test_Name__c = 'test2';
        qcTests1.Observation__c = 'ob2';
        qcTests1.Conclusion__c = 'Reject';
        qcTests1.Component_Name__c = qcComp2.Id;
        insert qcTests1;
        
        
        
        
        
        qc_controller.startDate = date.newInstance(2010, 11, 01);
        qc_controller.tillDate = date.newInstance(2021, 11, 01);
        qc_controller.compType = 'All';
        qc_controller.finalVerdict = 'Accept';
        qc_controller.selectedBrandName = 'All';
        QC_custom_report_controller.wrapperClass wp = new QC_custom_report_controller.wrapperClass();
        wp.comp=qcComp2;
        QC_custom_report_controller.testWrapper tp = new QC_custom_report_controller.testWrapper();
         tp.testName = qcTests1.Test_Name__c;
                tp.Observation = qcTests1.Observation__c;
                tp.verdict = qcTests1.Conclusion__c;
        
        qc_controller.getComponents();
        
        pageReference pageRef = qc_controller.download();
        
        Test.setCurrentPageReference(pageRef);
        qc_controller.getDownloadComps();
        
    }
   @isTest
    public static void testMethod6()
    {
         TriggerExecutionController__c tokenCustomSetting = new TriggerExecutionController__c();         
    tokenCustomSetting.Name = 'Qc_Component_Lightning_Trigger';        
    tokenCustomSetting.TriggerIsActive__c = false;        
    insert tokenCustomSetting;
        QC_custom_report_controller qc_controller = new QC_custom_report_controller();
        List<SelectOption> getItem = qc_controller.getItems();
        List<SelectOption> getVerdict = qc_controller.getverdicts();
        
        Id ConditionRT = [Select id From RecordType Where sObjectType = 'QC_condition__c'and RecordType.Name = 'Test Condition' limit 1].id;
        Id BrandRT = [Select id From RecordType Where sObjectType = 'QC_Master__c'and RecordType.Name = 'Brand Details' limit 1].id;
        
        QC_Master__c qcMaster = new QC_Master__c();
        qcMaster.Name = 'TITAN';
        qcMaster.RecordTypeId = BrandRT;
        
        insert qcMaster;
        
        QC_condition__c q1 = new QC_condition__c();
        q1.Component_Type__c = 'All';
        q1.RecordTypeId = ConditionRT;
        q1.Onload__c = true;
        insert q1;
        
        QC_Components__c qcComp1 = new QC_Components__c();
        qcComp1.Name__c ='Dail';
        qcComp1.Report_Ref_Number__c = 'refNum1';
        qcComp1.Watch_variant__c = 'mbvfd';
        qcComp1.Model__c ='fd';
        qcComp1.SKU_Reference__c ='dfghbfhfgbfgbfg';
        qcComp1.Brand__c = qcMaster.Id;
        //qcComp1.Vendor__c ='';
        qcComp1.Final_Verdict__c = 'All';
        qcComp1.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp1.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp1.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        insert qcComp1;
        
        QC_Test_Data__c qcTests = new QC_Test_Data__c();
        qcTests.Test_Name__c = 'test1';
        qcTests.Observation__c = 'ob1';
        qcTests.Conclusion__c = 'Accept';
        qcTests.Component_Name__c = qcComp1.Id;
        insert qcTests;
        
        QC_Components__c qcComp2 = new QC_Components__c();
        qcComp2.Name__c = 'All';
        qcComp2.Report_Ref_Number__c = 'refNum2';
        qcComp2.Watch_variant__c = 'watch';
        qcComp2.Model__c ='fdfbhjd';
        qcComp2.SKU_Reference__c ='hgvbghvvhgg';
        qcComp2.Final_Verdict__c = 'Accept';
        qcComp2.Brand__c = qcMaster.Id;
        qcComp2.Sample_Date__c = date.newInstance(2020, 4, 15);
        qcComp2.Published_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        qcComp2.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        insert qcComp2;
        
        QC_Test_Data__c qcTests1 = new QC_Test_Data__c();
        qcTests1.Test_Name__c = 'test2';
        qcTests1.Observation__c = 'ob2';
        qcTests1.Conclusion__c = 'Reject';
        qcTests1.Component_Name__c = qcComp2.Id;
        insert qcTests1;
        
        
        
        
        
        qc_controller.startDate = date.newInstance(2010, 11, 01);
        qc_controller.tillDate = date.newInstance(2021, 11, 01);
        qc_controller.compType = 'All';
        qc_controller.finalVerdict = 'Accept';
        qc_controller.selectedBrandName = '';
        QC_custom_report_controller.wrapperClass wp = new QC_custom_report_controller.wrapperClass();
        wp.comp=qcComp2;
        QC_custom_report_controller.testWrapper tp = new QC_custom_report_controller.testWrapper();
         tp.testName = qcTests1.Test_Name__c;
                tp.Observation = qcTests1.Observation__c;
                tp.verdict = qcTests1.Conclusion__c;
        
        qc_controller.getComponents();
        
        pageReference pageRef = qc_controller.download();
        
        Test.setCurrentPageReference(pageRef);
        qc_controller.getDownloadComps();
        
    }
}