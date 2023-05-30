public class QC_UtilitiesSupportObj{
    
    public QC_Components__c getqcComponent()
    {
        QC_Master__c qcbrand = getqcMasterTestBrand();
        insert qcbrand;
        QC_Master__c qcVendor = getqcMasterTestVendor();
        insert qcVendor;
        QC_Components__c qcinputTestdata = new QC_Components__c();          
        qcinputTestdata.Brand__c= qcbrand.id;
        qcinputTestdata.Brands__c= qcbrand.name;
        qcinputTestdata.Component_Status__c= 'Active';
        qcinputTestdata.Document_Status__c= 'Approved';
        qcinputTestdata.Master__c= true;
        qcinputTestdata.Model__c= 'test';
        qcinputTestdata.Name__c= 'Full-Watch';
        qcinputTestdata.No_Of_Sample_Received__c= 10;
        qcinputTestdata.PSY_Reference__c= 'test';
        qcinputTestdata.Parent__c= null;
        qcinputTestdata.Sample_Category__c= 'New';
        qcinputTestdata.Sample_Department__c= 'Brand Team';
        qcinputTestdata.Test_Back_Ground__c= 'test';        
        qcinputTestdata.Vendor__c= qcVendor.Id;
        qcinputTestdata.IsCopied_From_Master__c= false;
        qcinputTestdata.IsCopied_From_ReSub__c= false;
        qcinputTestdata.General_Observation__c= 'test';
        qcinputTestdata.Is_Rejected__c= false;
        qcinputTestdata.isTestDataCreated__c= false;
        qcinputTestdata.Sample_Received_From__c= 'prabhat.p@vpcorp.com';
        qcinputTestdata.isInputDataCreated__c= false;
        qcinputTestdata.Cluster__c= 'ANALG'; 
        qcinputTestdata.Test_generated__c= false;
        
        return qcinputTestdata;
    }
    public QC_Components__c getqcChildComponent()
    {
        QC_Master__c qcbrand = getqcMasterTestBrand();
        insert qcbrand;
        QC_Master__c qcVendor = getqcMasterTestVendor();
        insert qcVendor;
        QC_Components__c qcinputTestdata1 = getqcComponent();  
        QC_Components__c qcinputTestdata = new QC_Components__c();  
        // this data need to be created added during the time of using component
        qcinputTestdata.Brand__c= qcbrand.id;
        qcinputTestdata.Brands__c= qcbrand.name;
        qcinputTestdata.Component_Status__c= 'Active';
        qcinputTestdata.Document_Status__c= 'Approved';
        //qcinputTestdata.Final_Verdict__c= null;
        //qcinputTestdata.Master_Variant__c= null;
        qcinputTestdata.Master__c= False;
        qcinputTestdata.Model__c= 'test';
        qcinputTestdata.Name__c= 'Case';
        qcinputTestdata.No_Of_Sample_Received__c= 10;
        qcinputTestdata.PSY_Reference__c= 'test';
        qcinputTestdata.Parent__c= qcinputTestdata1.id;
        //qcinputTestdata.SKU_Reference__c= null;
        qcinputTestdata.Sample_Category__c= 'New';
        qcinputTestdata.Sample_Department__c= 'Brand Team';
        qcinputTestdata.Test_Back_Ground__c= 'test';        
        qcinputTestdata.Vendor__c= qcVendor.Id;
        //qcinputTestdata.Watch_variant__c= null;       
        //qcinputTestdata.Exception_Verdict__c= null;
        qcinputTestdata.IsCopied_From_Master__c= false;
        qcinputTestdata.IsCopied_From_ReSub__c= false;
        //qcinputTestdata.Comment__c= null;
        //qcinputTestdata.ChildComponentName__c= null;
        qcinputTestdata.General_Observation__c= 'test';
        qcinputTestdata.Is_Rejected__c= false;
        //qcinputTestdata.Published_Date__c= null;
        qcinputTestdata.isTestDataCreated__c= false;
        //qcinputTestdata.Parent_Report_Reference_Number__c= null;
        //qcinputTestdata.approval_submitted_date__c= null;
        //qcinputTestdata.Number_of_Sunday__c= null;
        qcinputTestdata.Sample_Received_From__c= 'prabhat.p@vpcorp.com';
        qcinputTestdata.isInputDataCreated__c= false;
        qcinputTestdata.Cluster__c= 'ANALG'; 
        qcinputTestdata.Test_generated__c= true;
        
        return qcinputTestdata;
    }
    
    public QC_Master__c getqcMasterTestBrand()
    {
        Id brandDetailsId = Schema.SObjectType.QC_Master__c.getRecordTypeInfosByDeveloperName().get('Brand_Details').getRecordTypeId();
        QC_Master__c qcMaster=new QC_Master__c();       
        qcMaster.Name= 'Fastrack';
        qcMaster.CurrencyIsoCode= 'INR';
        qcMaster.RecordTypeId = brandDetailsId;
        return qcMaster;
    }
    
    public QC_Master__c getqcMasterTestVendor(){
        Id vendorDetailsId = Schema.SObjectType.QC_Master__c.getRecordTypeInfosByDeveloperName().get('Vendor_Details').getRecordTypeId();
        QC_Master__c qcMaster=new QC_Master__c();        
        qcMaster.Name = 'FOSSIL';
        qcMaster.CurrencyIsoCode = 'INR';
        qcMaster.RecordTypeId = vendorDetailsId;
        return qcMaster;
    }
    
    public QC_Condition__c getCondition()
    {
        Id testConditionId = Schema.SObjectType.QC_Condition__c.getRecordTypeInfosByDeveloperName().get('Test_Condition').getRecordTypeId();
        QC_Condition__c qcCondition = new QC_Condition__c();
        qcCondition.CurrencyIsoCode= 'INR';
        qcCondition.RecordTypeId= testConditionId;
        qcCondition.Action__c= null;
        qcCondition.Brand__c= null;
        qcCondition.Component_Type__c= 'Full-Watch';
        qcCondition.Dependent_Response__c= null;
        qcCondition.MultiSkip__c= false;
        qcCondition.Multiple_Responses__c= null;
        qcCondition.Onload__c= true;
        qcCondition.Order_Number__c= 30;
        qcCondition.Response__c= null;
        qcCondition.IsEditableUOMSPEC__c= false;
        qcCondition.isVisible__c= false;
        qcCondition.Type_of_Module__c= null;
        
        return qcCondition;
    }
    
    public QC_Test_Data__c getTestData(Id compID)
    {
        Id orderRecordTypeId = Schema.SObjectType.QC_Condition__c.getRecordTypeInfosByDeveloperName().get('Others').getRecordTypeId();
        QC_Condition__c qcCondition=new QC_Condition__c();
        insert qcCondition;
        QC_Test_Data__c qcInput = new QC_Test_Data__c();
        qcInput.CurrencyIsoCode= 'INR';
        qcInput.RecordTypeId= orderRecordTypeId;
        qcInput.Component_Name__c= compID;
        qcInput.After_Test1__c= null;
        qcInput.After_Test2__c= null;
        qcInput.After_Test3__c= null;
        qcInput.After_Test4__c= null;
        qcInput.After_Test5__c= null;
        qcInput.After_Test_Observation__c= null;
        qcInput.Conclusion__c= 'Reject';
        qcInput.Condition_Ref__c= qcCondition.id;
        qcInput.Initial1__c= null;
        qcInput.Initial2__c= null;
        qcInput.Initial4__c= null;
        qcInput.Initial5__c= null;
        qcInput.Initial_Test_Observation__c= null;
        qcInput.Observation2__c= null;
        qcInput.Observation3__c= null;
        qcInput.Observation4__c= null;
        qcInput.Observation5__c= null;
        qcInput.Observation__c= 'test';
        qcInput.Comments_and_Remarks__c= null;
        qcInput.Determined_value__c= null;
        qcInput.Specification_Input__c= 'Gents - 20 Ladies - 15 Zoop -12';
        qcInput.UOM_Input__c= 'Kgs';
        qcInput.Acceptance_Criteria__c= null;
        qcInput.IsLast__c= false;
        qcInput.Parent__c= null;
        qcInput.RandomNumber__c= null;
        qcInput.Test_Name__c= 'With Standing Force - Case & Strap';
        qcInput.isManual__c= false;
        qcInput.isParent__c= false;
        qcInput.No_of_Samples__c= null;
        qcInput.Active__c= true;
        qcInput.imageurl__c= null;
        return qcInput;
    }
    /*public QC_Input_Data__c getInputData(){   
            QC_Components__c qcinputTestdata = getqcComponent();
            insert qcinputTestdata;
            QC_Question__c qcQues = getQuestion();
            insert qcQues;
            QC_Input_Data__c qcInp = new QC_Input_Data__c();        
            qcInp.CurrencyIsoCode= 'INR';
            qcInp.Component_No__c= qcinputTestdata.id;
            qcInp.Comments__c= null;
            qcInp.Question_Name__c = qcQues.Name;
            qcInp.Question__c= qcQues.id;
            qcInp.Response_Id__c= null;
            qcInp.Value__c= null;
            qcInp.Multiple_Response_Ids__c= null;
            qcInp.isManual__c= false;
            return qcInp;
			} */
    
    public QC_Question__c getModuleQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        //qcQues.RecordTypeId= '01214000001RWq3AAG';
        qcQues.RecordTypeId= conditionRecordTypeId;  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Full-Watch';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Module';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    public QC_Question__c getCrownQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        //qcQues.RecordTypeId= '01214000001RWq3AAG';  
        qcQues.RecordTypeId= conditionRecordTypeId;
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Full-Watch';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Module';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    public QC_Question__c getCasetoStrapQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId= conditionRecordTypeId;  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Full-Watch';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Case to Strap';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    public QC_Question__c getWatchTotalLengthinmmQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId= conditionRecordTypeId;  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Full-Watch';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Watch Total Length in mm';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    
    
    public QC_Question__c getwatchMaterialQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.Acceptance_Criteria__c = null;
        qcQues.Comment_Required__c =	false;
        qcQues.Competitor_Products__c=	false;
        qcQues.Component_Type__c=	'Case';
        qcQues.CurrencyIsoCode=	'INR';
        qcQues.IsNumeric__c=	false;
        qcQues.Onload__c=	true;
        qcQues.Order_Number__c=	10.0;
        qcQues.Question_Unique_No__c=	1.0;
        qcQues.Question__c=	'Material';
        qcQues.RecordTypeId =	conditionRecordTypeId;
        qcQues.Response_Required__c = true;
        qcQues.Specification__c = null	;
        qcQues.Test_Name__c= null	;
        qcQues.Type__c=	'Picklist';
        qcQues.UOM__c= null	;
        return qcQues;
    }
    
    
    public QC_Question__c getMaterialQuestion()
    {
         Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId= conditionRecordTypeId; //01214000001RWq3AAG  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Case';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Material';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    
    public QC_Question__c getConstructionQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId= conditionRecordTypeId; //01214000001RWq3AAG  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Case';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Construction';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    
    public QC_Question__c getBCFittingQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId = conditionRecordTypeId; //01214000001RWq3AAG  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Case';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'BC Fitting';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    
    public QC_Question__c getSpecialFeatureinCaseQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId= conditionRecordTypeId; //01214000001RWq3AAG;  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Case';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Special Feature in Case';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    
    public QC_Question__c getTypeofGlassQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId = conditionRecordTypeId; //01214000001RWq3AAG';  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Case';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Type of Glass';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    public QC_Question__c getGlassProfileQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId= conditionRecordTypeId; //01214000001RWq3AAG;  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Case';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Glass Profile';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    public QC_Question__c getGlassFittingQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId= conditionRecordTypeId; //'01214000001RWq3AAG';  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Case';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Glass Fitting';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    
    public QC_Question__c getProvisionForSpacerAssemblyQuestion()
    {
		Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId= conditionRecordTypeId; // '01214000001RWq3AAG';  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Case';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Provision For Spacer Assembly';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    public QC_Question__c getPushbuttonQuestion()
    {
        Id conditionRecordTypeId = Schema.SObjectType.QC_Question__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();
        QC_Question__c qcQues = new QC_Question__c();
        qcQues.CurrencyIsoCode= 'INR';
        qcQues.RecordTypeId= conditionRecordTypeId; //'01214000001RWq3AAG';  
        qcQues.Acceptance_Criteria__c= null;
        qcQues.Comment_Required__c= true;
        qcQues.Component_Type__c= 'Case';
        qcQues.IsNumeric__c= false;
        qcQues.Onload__c= true;
        qcQues.Order_Number__c= 10;
        qcQues.Question__c= 'Push button';
        qcQues.Specification__c= null;
        qcQues.Test_Name__c= null;
        qcQues.Type__c= 'Picklist';
        qcQues.UOM__c= null;
        qcQues.Response_Required__c= true;
        qcQues.Question_Unique_No__c= 38;
        qcQues.Competitor_Products__c= false;
        return qcQues;
    }
    public user getAdmin()
    {
        Profile pse = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User us1=new User();
        us1.Alias = 'standt';
        us1.EmailEncodingKey='UTF-8';
        us1.LastName='Testing';
        us1.LanguageLocaleKey='en_US';
        us1.LocaleSidKey='en_US';
        us1.ProfileId = pse.Id;
        us1.Email='test1@gmail.com';
        us1.TimeZoneSidKey='Asia/Kolkata';
        us1.UserName='standarduser@testokinds123.com';
        us1.IsActive=True;
        return  us1;
    }
    
}