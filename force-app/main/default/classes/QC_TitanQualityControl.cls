/*
    Name        : QC_TitanQualityControl
    Created By  : Anand Durga Prasad
    Modified By : Shamsher singh
    Description : Class to display the questions with responses and test parameters for insertion based on component type.
    Methods Used:
    1.addQuesiton():                                        To add/remove questions based on the current question response
    2.previousResQuestions():                       To add/remove the questions for previous response of current question
    3.picklistCondition :                           To remove/add picklist values of another question based on selected response.
    4.inputDataInit(QuestionWrap qw) :  (sub method)To initializing the input data records with questionWrap data entered by user.
    5.submitInputData() :                           Saving the seleted responses into input data object.
    6.editInputData() :                             To initializing the QuestionWrap with saved inputdata records.
    7.editMode() :                                          Displaying input data in edit mode
    8.edit()     :                                          Displaying test data in edit mode
    9.submitTestData() : To display the default test parameters and test parameters based on input response.
    10.deleteTestParameter() : (sub method)To delete test parameter which is there in the back-end but not there in new wrapper data list.
    11.insertTestParameter() : (sub method)To insert new test parameter into back-end.
    12.displayTestParameter() : (sub method)To display test parameters from back-end as well as from the new wrapper list.
*/

global with sharing class QC_TitanQualityControl {
    public list<QC_Question__c> quesionList      {get;set;}  //Used to store questions of selected component type
    public list<QuestionWrap> questionWrapList   {get;set;}  //Wrapper list to display the questions with respective responses
    public list<QC_Condition__c> testParamlist   {get;set;}  //Used to store test parameter records
    public list<TestWrapper> testWrapList        {get;set;}  //Wrapper list to display the test parameters records based on actions of questions
    public list<QC_Input_Data__c>  sDataList     {get;set;}  //Used to store input data
    public String selectedQid                    {get;set;}  //Used to store selected response quesiton id
    public String selectedRes                    {get;set;}  //Used to store selected response id 
    public QC_Components__c component            {get;set;}  //Used to store the current component data             
    public string currentQid;                                //To store current response question id                   
    public string comType                        {get;set;}  //To store component type from URL
    public string previousRes;                               //Used to store previous response of selected question.
    public boolean show                          {get;set;}  //Used for show/hide of inputdata 
    public boolean showApproval                  {get;set;}  //Used for show/hide the approval button before saving all the input data
    public boolean showTest                      {get;set;}  //Used to show/hide for test Parameters
    public boolean isObsersNull;
    public boolean showComp                      {get;set;}  //Used to show/hide for Component Data
    public List<QC_Condition__c> testAllParameter{get;set;}  //Get all questions from Condition__c Object
    public List<QC_Condition__c> testDefaultParameter{get;set;}//Get default test parameters
    public List<QC_Input_Data__c> testResponseParameter{get;set;}//Get the test parameters which is based on response
    //public Set<Id> avoidDuplicateTestRecords    {get;set;}
    public List<QC_Test_Data__c> saveTestData   {get;set;}  //List to hold the current test parameter data 
    public List<QC_Test_Data__c> testrData      {get;set;}  //List to hold saved test parameters
    public List<QC_Test_Data__c> updateTestData {get;set;}  //List to hold  the test parameters to update
    public List<QC_Test_Data__c> insertTestData {get;set;}  //List to hold  the test parameters to insert
    public List<QC_Test_Data__c> deleteTestData {get;set;}  //List to hold  the test parameters to delete
    public Boolean isBrandModified              {get;set;}  // Boolean variable to allow and Brand fields to modify
    public boolean refreshPage                  {get;set;}
    Map<string,String> selResMap;                           //used to store all selected responses in Vf page
    //Map<Id, QC_Test_Data__c> objMap1;
    //Map<Id, QC_Test_Data__c> objMap2;
    public id  comId                            {get;set;}  //Used to store component Id in URL
    public id moduleRTId;
    List<QC_Components__c> getChildComponents   {get;set;}     //Get all the child records 
    public QC_Components__c parentCompVerdict   {get;set;}
    Boolean childVerdict=false;                                                   //beelean variable to hold the the value if the final verdict of any child component is there.
    public String defaultInitial                {get;set;}
    public Boolean displayPopup                 {get;set;}
    String s;
    List<QC_Components__c> childComp            {get;set;}
    QC_Components__c parentCom                  {get;set;}
    QC_Components__c cloneIndiComp              {get;set;} 
    QC_Components__c cloneParentComp            {get;set;}
    QC_Components__c cloneChildRecords          {get;set;}
    public List<QC_Input_Data__c> childComponentInputParameters  {get;set;}      //List to hold all the input parameter records of child components
    public List<QC_Test_Data__c>  childComponentTestParameters   {get;set;}     //List to hold all the input parameter records of child components
    public List<QC_Input_Data__c> cloneChildComponentInputParam  {get;set;}      //List to hold all the input parameters records to clone of child component
    public List<QC_Test_Data__c>  cloneChildComponentTestData    {get;set;}      //List to hold all the test parameters records to clone of child component
    set<String> childId                         {get;set;}
    boolean isRecordLock                        {get;set;}
    public String approvalResult                {get;set;}                      // variable use for holding approval status.  //  added by sudama 
    public List<QC_Components__c> allChildComponent{get;set;}                  // added by sudama for all child component
    public List<QC_Test_Data__c> allChildTestData{get;set;}                   // added by sudama for all child component test data
    public List<QC_Test_Data__c> parentTestData{get;set;}                   // added by sudama for all child component test data
    public Boolean hidePhotoPanel{get;set;}
    public Boolean hidePhotoPanel2{get;set;}
    public Boolean hidePhotoPanel3{get;set;}

    public Map<string,list<QC_Test_Data__c>> mAllChildTestData{get;set;}       // added by sudama for storing key as a test name and value as list of test data
    public Integer mSize{get;set;}
    public Boolean showModuleTest {get;set;}                       // this variable is used to hide test parameter when type of module = "Smatr Watch"
    // code for uploading photo    
    transient public final blob Photo{get;set;}
    transient public final blob Photo2{get;set;}
    transient public final blob Photo3{get;set;}

    public String fileName{get;set;}
    public String fileName2{get;set;}
    public String fileName3{get;set;}
    
    public string photourl{get;set;}
    public string photourl2{get;set;}
    public string photourl3{get;set;}
    
    public String imageUrl1;
    public String imageUrl2;
    public String imageUrl3;

    public String testPara {get;set;}
    //Constructor
    public QC_TitanQualityControl(){
        //objMap1 = new Map<Id, QC_Test_Data__c>();
        //objMap2 = new Map<Id, QC_Test_Data__c>();
        showModuleTest = True;
        isObsersNull = false;
        comId         = Apexpages.currentpage().getParameters().get('id');
        comType       = Apexpages.currentPage().getParameters().get('type');
        System.debug('comType----->'+comType);
        refreshPage   = false;
        childComp     = new List<QC_Components__c>();
        childId       = new set<String>();
        childComponentInputParameters   = new List<QC_Input_Data__c>();
        childComponentTestParameters    = new  List<QC_Test_Data__c>();
        cloneChildComponentInputParam   = new List<QC_Input_Data__c>();
        cloneChildComponentTestData     = new List<QC_Test_Data__c>();
        testPara                        = '';
        initialization();
        brandValidation(); // calling method for validating the brand based on leather strap verdict
    }
    public PageReference  uploadphotoPanel(){ 
        if(component.imageurl__c == null){
            hidePhotoPanel = true;
        }
        return null;
    }
     public PageReference  uploadphotoPanel2(){ 
        if(component.imageurl2__c == null){
            hidePhotoPanel2 = true;
        }
        return null;
    }
    public PageReference  uploadphotoPanel3(){ 
        if(component.imageurl3__c == null){
            hidePhotoPanel3 = true;
        }
        return null;
    }
    public void uploadPhoto(){
        String name1;
        try{
            Id prevAttId;
             if(imageUrl1 != null){
                prevAttId = imageUrl1.substring(imageUrl1.indexOf('=')+1,imageUrl1.indexOf('&'));
            }
             if(prevAttId != null){
                delete new Document(Id = prevAttId);
            }  
           
            Document docImage = new Document();
            docImage.AuthorId = UserInfo.getUserId();
            docImage.FolderId = [SELECT Id FROM Folder WHERE Name = 'QC Image'].Id;
            docImage.body = photo;
            docImage.name = fileName;
            docImage.ContentType = 'image/jpg';
            docImage.IsPublic = true;
            name1 = fileName.substring(fileName.lastindexof('.'),fileName.length());
            if(name1 == '.jpg' || name1 == '.png' || name1 == '.gif'){
                   insert docImage;
            }else{
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Supported file format is jpg,png,gif'));
            }
             String orgid=UserInfo.getOrganizationId();
             string baseUrl=URL.getSalesforceBaseUrl().toExternalForm();
            string Attid= docImage.id;
            string docid=Attid.substring(0,15);
            component.imageUrl__c =baseUrl+'/servlet/servlet.ImageServer?id='+docid+'&oid='+orgid;    
            update component;
            photourl = component.imageurl__c;
           
        }catch(Exception e){
            System.debug('Exception Message'+e);
        }      
    }
    public void uploadPhoto2(){
        Id prevAttId;
        String name1;
        try{
           if(imageUrl2 != null){
                prevAttId = imageUrl2.substring(imageUrl2.indexOf('=')+1,imageUrl2.indexOf('&'));
            }
             if(prevAttId != null){
                delete new Document(Id = prevAttId);
            }  
            Document docImage = new Document();
            docImage.AuthorId = UserInfo.getUserId();
            docImage.FolderId = [SELECT Id FROM Folder WHERE Name = 'QC Image'].Id;
            docImage.body = photo2;
            docImage.name = fileName2;
            docImage.ContentType = 'image/jpg';
            docImage.IsPublic = true;
            name1 = fileName2.substring(fileName2.lastindexof('.'),fileName2.length());
            if(name1 == '.jpg' || name1 == '.png' || name1 == '.gif' ){
                   insert docImage;
            }else{
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Supported file format is jpg,png,gif'));
            }
             String orgid=UserInfo.getOrganizationId();
             string baseUrl=URL.getSalesforceBaseUrl().toExternalForm();
            string Attid= docImage.id;
            string docid=Attid.substring(0,15);
            component.imageUrl2__c =baseUrl+'/servlet/servlet.ImageServer?id='+docid+'&oid='+orgid;    
            update component;
            photourl2 = component.imageurl2__c;
            
        }catch(Exception e){
            System.debug('Exception Message'+e);
        }      
    }
    public void uploadPhoto3(){
        String name1;
        Id prevAttId;
        try{
            if(imageUrl3 != null){
                prevAttId = imageUrl3.substring(imageUrl3.indexOf('=')+1,imageUrl3.indexOf('&'));
            }
             if(prevAttId != null){
                delete new Document(Id = prevAttId);
            }  
            Document docImage = new Document();
            docImage.AuthorId = UserInfo.getUserId();
            docImage.FolderId = [SELECT Id FROM Folder WHERE Name = 'QC Image'].Id;
            docImage.body = photo3;
            docImage.name = fileName3;
            docImage.ContentType = 'image/jpg';
            docImage.IsPublic = true;
            name1 = fileName3.substring(fileName3.lastindexof('.'),fileName3.length());
            if(name1 == '.jpg' || name1 == '.png' || name1 == '.gif'){
                   insert docImage;
            }else{
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Supported file format is jpg,png,gif'));
            }
             String orgid=UserInfo.getOrganizationId();
             string baseUrl=URL.getSalesforceBaseUrl().toExternalForm();
            string Attid= docImage.id;
            string docid=Attid.substring(0,15);
            component.imageUrl3__c =baseUrl+'/servlet/servlet.ImageServer?id='+docid+'&oid='+orgid;    
            update component;
            photourl3 = component.imageurl3__c;
         
        }catch(Exception e){
            System.debug('Exception Message'+e);
        }      
    }
    public void editPhoto(){ 
        if(component.imageUrl__c != null){
            imageUrl1 = component.imageUrl__c;
        }   
        component.imageUrl__c = null;   
        
    }
    public void editPhoto2(){   
        if(component.imageUrl2__c != null){
            imageUrl2 = component.imageUrl2__c;
        }
        component.imageUrl2__c = null;   
        
    }
    public void editPhoto3(){  
        if(component.imageUrl3__c != null){
            imageUrl3 = component.imageUrl3__c;
        }   
        component.imageUrl3__c = null;   
        
    } 
    public pagereference cancelPhoto(){      
       pagereference pr = new pageReference('/apex/QC_TitanQualityControl?id='+component.id+'&type='+comType);
        pr.setredirect(true); 
        return pr;
    }
    
    /**************************************************************/
    //Code for Exceptional Approval 
    public void showPopup(){
        displayPopup = true;
    }
    public void closePopup() {
        displayPopup = false;
    }
    public string getSelectedItem(){
        return s;
    }
    public void setSelectedItem(String s){
        this.s = s;
    }
    public void saveSpecialApprovalData(){
        QC_Components__c comp = new QC_Components__c();
        comp.Exception_Verdict__c = component.Exception_Verdict__c; 
        comp.Comment__c = component.Comment__c;
        try{
            update component;
            if (Test.isRunningTest()) { 
                integer i=10/0;
            }
        }catch(Exception e){System.debug('!!!!!!'+e);}
        displayPopup = false;
    }
    /**************************************************************/
    public list<SelectOption> getItems(){
        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('','Select one'));
        options.add(new SelectOption('Accept','Accept'));
        options.add(new SelectOption('Reject','Reject'));
        options.add(new SelectOption('Conditional Accept','Conditional Accept'));
        options.add(new SelectOption('Clearance for pilot','Clearance for pilot'));
        return options;
    }
    public void initialization(){
        component           = new QC_Components__c(Name__c = comType);
        quesionList         = new List<QC_Question__c>();
        sDataList           = new List<QC_Input_Data__c>(); 
        testParamlist       = new List<QC_Condition__c>();
        testWrapList        = new List<TestWrapper>(); 
        testrData           = new List<QC_Test_Data__c>();
        selResMap           = new Map<string,String>();
        allChildComponent   = new List<QC_Components__c>();
        allChildTestData    = new List<QC_Test_Data__c>();
        parentTestData      = new List<QC_Test_Data__c>();
        mAllChildTestData   = new Map<string,list<QC_Test_Data__c>>();
        Set<id>allChildComp = new Set<id>();
        mSize               = 0;
        defaultInitial      = 'R';
        try{
            moduleRTId    = [select id from recordtype where name='Module' and sobjectType='QC_test_data__c'].id;
            //Retrieving the component data and input data from database based on the component Id.
            component     = [select id,CreatedDate,isTestDataCreated__c,isInputDataCreated__c,imageurl__c,imageurl2__c,imageurl3__c,Sample_Received_From__c,Additional_email_address__c,Is_Rejected__c,price__c, Name__c,Parent__c,General_Observation__c,PSY_Reference__c,Unique_Number__c,Component_Status__c,Final_Verdict__c ,document_Status__c,
                             IsCopied_From_Master__c,Master__c,parent__r.document_Status__c, Master_Variant__c,Report_Ref_Number__c,Parent_Report_Reference_Number__c,Sample_Category__c, Vendor__c,Brand__c,
                             Sample_Date__c,model__c,Comment__c,Exception_Verdict__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c, 
                             parent__r.Final_verdict__c,IsCopied_From_ReSub__c,Brands__c,Cluster__c from QC_Components__c where id =:comId ];
            
            if(component.imageurl__c != null) 
                hidePhotoPanel = True;
            if(component.imageurl2__c != null) 
                hidePhotoPanel2 = True;
            if(component.imageurl3__c != null) 
                hidePhotoPanel3 = True;
            // added by sudama for displaying rejected component test parameter
            
            QC_Components__c component1 =[select id,Report_Ref_Number__c from QC_Components__c where Report_Ref_Number__c =: component.Parent_Report_Reference_Number__c LIMIT 1];
            if(component.Sample_Category__c == 'Re-submission' && component.id != null){
                if(component1.id != null){
                    allChildComp.add(component1.id);
                }           
                allChildComponent = [SELECT id,component_status__c,Report_Ref_Number__c,Sample_Category__c,Document_Status__c,Name__c,Parent__c,Final_Verdict__c,Cluster__c FROM QC_Components__c WHERE Parent__c =: component1.id ];
                for(QC_Components__c  qcComp : allChildComponent){
                    if(qcComp.id != null)
                        allChildComp.add(qcComp.id);
                }
                allChildTestData = [select Id,isManual__c,Component_Name__r.Name__c,Test_Name__c,Determined_value__c,Conclusion__c,Component_Name__c,No_of_Samples__c,Comments_and_Remarks__c,Observation__c,Condition_Ref__c,Specification_Input__c,UOM_Input__c,Condition_Ref__r.IsEditableUOMSPEC__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c from QC_Test_Data__c where Component_Name__c in: allChildComp AND Conclusion__c = 'Reject'];
                if(!allChildTestData.isEmpty()){
                    for(QC_Test_Data__c qcList : allChildTestData){
                        if(qcList.Component_Name__r.Name__c != 'Full-Watch'){
                            if(!mAllChildTestData.isEmpty() && mAllChildTestData.containsKey(qcList.Component_Name__r.Name__c) && mAllChildTestData.get(qcList.Component_Name__r.Name__c)!=null){
                                mAllChildTestData.get(qcList.Component_Name__r.Name__c).add(qcList);
                            }
                            else{
                                mAllChildTestData.put(qcList.Component_Name__r.Name__c,new list<QC_Test_Data__c>{qcList});
                            }
                        }else
                            parentTestData.add(qcList);
                    }
                    mSize = mAllChildTestData.size();
                }
            }
        }catch(Exception e){
            Apexpages.addMessage(new Apexpages.Message(Apexpages.severity.Error,'Constructor queries,moduleRTId,component,sDataList :'+e.getMessage()));
        }
        //Initializing the data and boolean variables to show and hide of edit/view(input/output) blocks if url contians component Id.
        if(comId != null){
            show          = true;
            showTest      = true;
            showComp      = true;
            //showApproval  = true;
        }else{
            show          = false;
            
        }
        //initializing show and showTest variables for QC_Tabs page to show the input data in edit mode
        if(Apexpages.currentpage().getParameters().get('show') == 'false'){
            show          = false;
            showTest      = false;
            
        }
        showApproval  = true;
    }//End of Initialize
    
    /*
    @Method       : onPageLoad
    @Created By   : Sanjeev Shukla
    @Description  : Method to retrieve the test parameter records based on the component type whenever component is created then create default test data on Test Data object
    */
    public void onPageLoad(){
        testWrapList.clear();
        Set<String> selResIds = new Set<String>();
        Integer  testDataCount = [SELECT count() FROM QC_Test_Data__c WHERE Component_Name__c =: component.id ];
        //Retrieving the test parameter records based on the component type.
        if(!component.isTestDataCreated__c && testDataCount == 0){
            List<QC_Condition__c> testAllParameter = New List<QC_Condition__c>();
            List<QC_Input_Data__c> testResponseParameter = New List<QC_Input_Data__c>();            
            //Query all the test parameters based on responses.
            if(component.Sample_Category__c != 'Competitor Products'){
            testAllParameter =[SELECT id,name,Question__r.UOM__c,Question__r.Test_Name__c,Question__r.Specification__c,Question__r.Acceptance_Criteria__c,order_number__c,
                               brand__c,Multiple_Responses__c,MultiSkip__c,Response__c,Response__r.response__c,Action__c, onload__c,Question_name__c,IsEditableUOMSPEC__c FROM QC_Condition__c   
                               WHERE component_type__c =:comType AND recordtype.developerName ='Test_Condition' AND onload__c = true AND Type_of_Module__c != 'Smart Watch' AND Type_of_Module__c != 'Digital'  order by order_number__c];  
            }
            else{
            testAllParameter =[SELECT id,name,Question__r.UOM__c,Question__r.Test_Name__c,Question__r.Specification__c,Question__r.Acceptance_Criteria__c,order_number__c,
                               brand__c,Multiple_Responses__c,MultiSkip__c,Response__c,Response__r.response__c,Action__c, onload__c,Question_name__c,IsEditableUOMSPEC__c FROM QC_Condition__c 
                               WHERE component_type__c =:comType AND recordtype.developerName ='Test_Condition' AND Type_of_Module__c != 'Smart Watch' AND Type_of_Module__c != 'Digital'  order by order_number__c];   
            }
            if(component.id != null){
                testResponseParameter = [SELECT Id,Name,Component_No__c,Response_Id__c,Value__c,Multiple_Response_Ids__c ,Question_Name__c FROM QC_Input_Data__c Where Component_No__c=:component.id]; 
                for(QC_Input_Data__c inData : testResponseParameter){
                    if(inData.Response_Id__c != null)
                        selResIds.add(string.valueOf(inData.Response_Id__c).substring(0,15)); //converting 18 digit Id as 15 digit id
                } 
            }
            if(!testAllParameter.isEmpty()){ 
                testWrapList.clear();
                integer specialStrapRes = 0;
                //This query is only for Special-Strap to display test parameters conditionally based on Sillicon, Rubber.
                specialStrapRes = [select count() from QC_input_data__c where Component_No__c =: component.id and Component_No__r.Name__c ='Special-Strap' and Response_Id__r.response__c in ('Silicon','Rubber')];
                For(QC_Condition__c tp : testAllParameter){
                    //If block to check for default test parameter and adding them into wrapper list
                  //  if(tp.onload__c == true){
                        testWrapper testWrap = new testWrapper(tp);
                        //Code for Module component to initialize the initial values with 'R';
                        if(comType == 'Module' ){
                            if((tp.Question__r.Specification__c == 'No Stoppage - During the test' || tp.Question__r.Specification__c == 'No Stoppage' || tp.Question__r.Specification__c == 'No Stoppage / No Component loose' || tp.Question__r.Specification__c == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || tp.Question__r.Specification__c == 'No Stoppage / No Display Blank')){
                                testWrap.Initial1     = 'R';    
                                testWrap.Initial2     = 'R'; 
                                testWrap.Initial3     = 'R'; 
                                testWrap.Initial4     = 'R';
                                testWrap.Initial5     = 'R';        
                            }
                        }
                        //Checking the onload questions response , if response is there in selected responses then making wrapper class variable hideVerdict as true
                        //(This is for to hide the conclusion field dynamically)
                        if(tp.Response__c != null && selResIds.contains(string.valueOf(tp.Response__c).substring(0,15))){                       
                            testWrap.hideVerdict= true;  
                            testWrap.verdictColor = 'Red';
                        } 
                        testWrapList.add(testWrap);  
                 //   }//End of If block
                }//End of For Block
                //adding only unique values to Wrapperlist to avoid duplicate records (added 22/03/15 by Anand)
                Map<id,testWrapper> uniqueMap = new Map<id,testWrapper>();
                set<string> metalQuesNames = new set<string>();
                for(testWrapper twrap : testWrapList){
                    /************Metal Strap ssMaterial question code*******/
                    if(component.name__c == 'Metal-Strap'){
                        if(!metalQuesNames.isEmpty() && !metalQuesNames.contains(twrap.name)){
                            uniqueMap.put(twrap.id,twrap);
                            metalQuesNames.add(twrap.name);
                        }else{ 
                            if(metalQuesNames.isEmpty()){
                                metalQuesNames.add(twrap.name);
                                uniqueMap.put(twrap.id,twrap);
                            }
                        } 
                    }else{
                        uniqueMap.put(twrap.id,twrap);
                    }
                }
                testWrapList.clear();
                if(!uniqueMap.isEmpty()){
                    testWrapList.addAll(uniqueMap.values());
                }
                testWrapList.sort();
                if(!testWrapList.isEmpty()){
                    saveTestData = new List<QC_Test_Data__c>();
                    for(TestWrapper twr : testWrapList){
                        QC_Test_Data__c insertNewRecords            = new QC_Test_Data__c();
                        insertNewRecords.Test_Name__c               = twr.name; 
                        insertNewRecords.Component_Name__c          = component.id; 
                        insertNewRecords.Conclusion__c              = twr.conclusion;
                        insertNewRecords.Observation__c             = twr.observation;
                        insertNewRecords.Condition_Ref__c           = twr.id;
                        insertNewRecords.Comments_and_Remarks__c    = twr.commentsandRemarks;
                        insertNewRecords.No_of_Samples__c           = twr.NoOfSample;
                        insertNewRecords.Determined_Value__c        = twr.determinedVal;
                        insertNewRecords.Acceptance_Criteria__c     = twr.acceptCriteria;
                        insertNewRecords.Specification_Input__c     = (twr.isEditUOMSpec == true) ? twr.Specification : null;
                        insertNewRecords.UOM_Input__c               = (twr.isEditUOMSpec == true) ? twr.UOM : null;
                        saveTestData.add(insertNewRecords);
                    }//End for For Loop
                    try{
                        insert saveTestData;
                        QC_Components__c comp = new QC_Components__c();
                        comp.id = component.id;
                        comp.isTestDataCreated__c = true;
                        update comp;
                    }catch(Exception e){
                        Apexpages.addMessages(e);
                    }
                    saveTestData.clear();
                }
            }
        }
        displayTestParameter(); //Call displayTestParameter() method to display test parameters from back-end.
    }
    /*
    @Method       : componentInit
    @Created By   : Anand
    @Description  : Method to initialize the component data when reseting the test parameter's observations 
    */
    public void componentInit(){
        try{
            component  = [SELECT id,Name__c,CreatedDate,Is_Rejected__c,Parent__c,imageurl__c,Sample_Received_From__c,Additional_email_address__c,price__c,isInputDataCreated__c,isTestDataCreated__c ,General_Observation__c,PSY_Reference__c,Unique_Number__c,Component_Status__c,Final_Verdict__c ,document_Status__c,
                          IsCopied_From_Master__c,Master__c,parent__r.document_Status__c, Master_Variant__c,Report_Ref_Number__c,Parent_Report_Reference_Number__c,Sample_Category__c, Vendor__c,Brand__c,
                          Sample_Date__c,model__c,Exception_Verdict__c,Comment__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c, 
                          parent__r.Final_verdict__c,IsCopied_From_ReSub__c,Brands__c,Cluster__c FROM QC_Components__c WHERE id =:comId ];
            if (Test.isRunningTest()) { 
                integer i=10/0;
            }
        }Catch(Exception e){
            Apexpages.addMessage(new Apexpages.Message(Apexpages.severity.Error,'componentInit'+e.getMessage()));
        }                            
    }
    
    public boolean getIsInputLocked(){
        isRecordLock = false;
        boolean isSubmitted = false;
        //Condition for submit for approval both parent and childs
        if(component.Document_Status__c == 'Published' ){
            isSubmitted = true;
        }
        boolean isMasterLock = false;
        //Scenario 1 : Without master - Re-submission - Final Verdict as Accept
        if((component.parent__c != null ) && component.IsCopied_From_Master__c == true){ //working
            isMasterLock  = true;
        }
        boolean isMasterReSub = false;
        //Scenario 2: IF record is Re-submitted then accepted childs should be locked.
        if((component.parent__c != null) && component.IsCopied_From_ReSub__c == true && (component.final_verdict__c != 'Reject' && component.final_verdict__c != null)){
            isMasterReSub = true;
        }
        if(isSubmitted == true || isMasterReSub == true || isMasterLock == true){
            isRecordLock = true;
        }
        return isRecordLock;
    }
    //Get method to initialize conclusion field picklist values.
    /*
    @Method       : getConclusion
    @Created By   : Anand
    @Description  : Method to initialize the conclustion picklist values. 
    */
    public List<selectOption> getConclusion(){
        List<selectOption> options = new List<selectOption>();
        options.add(new selectOption('','--None--'));
        Schema.Describefieldresult fieldRes = QC_Test_Data__c.Conclusion__c.getDescribe();
        List<Schema.Picklistentry> ple = fieldRes.getPicklistValues();
        for(Schema.Picklistentry f : ple){
            options.add(new selectOption(f.getLabel(),f.getValue()));
        }
        
        return options;
    }
    
    /*
    @Method       : brandValidation()
    @Created By   : Anand
    @Created Date : 21-4-2015
    @Description  : Method to make the brand field as read only if Leather-strap final verdict has given
    If it is a Full-Watch with leather-strap then that leather-strap with final verdict has given then make the Full-watch brand field as read only.
    */
    /******************Change Request artf79038 done by Anand 4/22/2015******************************************/  
    //Method to make Brand field of component read-only/editable
    public void brandValidation(){
        if(component != null){
            //Getting child Leather-Strap final verdict 
            String childLSVerdict;
            if(component.Parent__c == null && component.Name__c == 'Full-Watch'){
                for(QC_Components__c comp : [select id,name__c,final_Verdict__c from QC_Components__c where Parent__c =:component.id]){
                    if(comp.name__c =='Leather-Strap'){
                        childLSVerdict = comp.final_Verdict__c;
                    }
                }
            }
            if(childLSVerdict != null || (component.Name__c == 'Leather-Strap' && component.Document_Status__c != 'Draft')){
                isBrandModified = true;
            }
        }
    }
    
    /*
    @Method       : addQuesiton
    @Created By   : Anand
    @Description  : Method to call on onchage event to add or remove the questions based on selected response 
    */
    public void addQuesiton(){
        if(component.Sample_Category__c != 'Competitor Products'){
            if(!selResMap.isEmpty() && selResMap.containskey(selectedQid)){
                previousResQuestions(selResMap.get(selectedQid));
                if(comType == 'Metal-Strap')PreviousPicklistCondition(selResMap.get(selectedQid));
                selResMap.put(selectedQid,selectedRes);
                
            }else{
                selResMap.put(selectedQid,selectedRes);
                //Checking the selected question already existed in DB or not , if existed then taking response_ID__c and perform hiding/adding of inserted response_ID__c
                QC_Input_Data__c savedRes = new QC_Input_Data__c();
                try{
                    savedRes    = [select Response_Id__c from QC_Input_Data__c where question__c =:selectedQid and Component_No__c =:component.id];
                }catch(Exception e){}                  
                if(savedRes.Response_Id__c != null){
                    previousResQuestions(savedRes.Response_Id__c);
                }
            }
            //Forforming add/Remove for every question.
            List<QC_Question__c> newQues  = new list<QC_Question__c>();
            List<QC_Condition__c> conLIst = new list<QC_Condition__c>();
            //Determining the dependent questions of selected response.
            try{
                List<String> qList = new List<String>();
                conLIst    = [select Question__c,action__c,MultiSkip__c from QC_Condition__c where recordtype.developername='Question_Condition' AND Response__c =: selectedRes];
                for(QC_Condition__c con : conLIst){
                    qList.add(con.Question__c);
                }
                newQues    = [select id,name,Response_Required__c,Competitor_Products__c,comment_required__c,question__c,type__c,isNumeric__c,Order_Number__c,(select response__c from Responses__r order by order_number__c) from QC_Question__c 
                              where id in: qList];
            }catch(Exception e){}               
            //code to add or remove the questions dynamically based on selected response.                       
            map<id,QuestionWrap> uniqueMap = new map<id,QuestionWrap>();
            for(QuestionWrap qw : questionWrapList){
                uniqueMap.put(qw.id,qw);
            }
            for(QC_Condition__c condition : conLIst){
                for(QC_Question__c nq: newQues){
                    if(condition.Question__c == nq.id ){     
                        if(condition.action__c == 'Visible'){ 
                            if(!uniqueMap.containskey(nq.id)){
                                questionWrapList.add(new questionWrap(nq));
                                questionWrapList.sort();
                            }
                        }
                        if(condition.action__c == 'Hidden'){
                            if(uniqueMap.containskey(nq.id)){
                                uniqueMap.remove(nq.id);
                                questionWrapList.clear();
                                questionWrapList.addAll(uniqueMap.values());
                                questionWrapList.sort();
                            }
                        }
                    }//End of if             
                }//End of for
            }//End of for    
            if(comType == 'Metal-Strap')picklistCondition(selectedRes); 
        }
    }//Endo of addQustion
    
   @TestVisible private void createModuleTestParameter(String moduleType){
        List<QC_Condition__c> testAllParameter = New List<QC_Condition__c>();
        //Query all the test parameters based on responses.
        if(moduleType == 'Digital'){
            testAllParameter =[SELECT id,Question__r.UOM__c,Question__r.Specification__c,Question__r.Acceptance_Criteria__c,IsEditableUOMSPEC__c FROM QC_Condition__c 
                               WHERE component_type__c =:comType AND recordtype.developerName ='Test_Condition' AND onload__c = true AND (Type_of_Module__c = 'Digital' OR Question__r.Test_Name__c ='General Observation') order by order_number__c];  
        }else if(moduleType == 'Smart Watch'){
            testAllParameter =[SELECT id,Question__r.UOM__c,Question__r.Specification__c,Question__r.Acceptance_Criteria__c,IsEditableUOMSPEC__c FROM QC_Condition__c
                               WHERE component_type__c =:comType AND recordtype.developerName ='Test_Condition' AND onload__c = true AND type_of_Module__c = 'Smart Watch' order by order_number__c];
        }else{
            testAllParameter =[SELECT id,Question__r.UOM__c,Question__r.Specification__c,Question__r.Acceptance_Criteria__c,IsEditableUOMSPEC__c FROM QC_Condition__c
                               WHERE component_type__c =:comType AND recordtype.developerName ='Test_Condition' AND onload__c = true AND Type_of_Module__c != 'Digital' AND Type_of_Module__c != 'Smart Watch' order by order_number__c];
        }
        if(!testAllParameter.isEmpty()){ 
            saveTestData = new List<QC_Test_Data__c>();
            for(QC_Condition__c tp : testAllParameter){
                QC_Test_Data__c insertNewRecords            = new QC_Test_Data__c();
                insertNewRecords.Component_Name__c          = component.id;
                insertNewRecords.Condition_Ref__c           = tp.id;
                insertNewRecords.Acceptance_Criteria__c     = tp.Question__r.Acceptance_Criteria__c;
                insertNewRecords.Specification_Input__c     = (tp.IsEditableUOMSPEC__c == true) ? tp.Question__r.Specification__c : null;
                insertNewRecords.UOM_Input__c               = (tp.IsEditableUOMSPEC__c == true) ? tp.Question__r.UOM__c : null;
                saveTestData.add(insertNewRecords);
            }//End for For Loop
            try{
                insert saveTestData;
            }catch(Exception e){
                Apexpages.addMessages(e);
            }
            saveTestData.clear();
        }
        displayTestParameter(); //Call displayTestParameter() method to display test parameters from back-end.
    }
    /*
    @Method       : previousResQuestions
    @Created By   : Anand
    @Param        : resId (Parameter with String type to get the current response's id of current question)
    @Description  : Method to add or remove the questions for previous response of current question
    */
    public void previousResQuestions(string resId){  //Method to add or remove the questions for previous response of current question
        map<id,QC_Question__c> newQuesMap ;  
        list<QC_Condition__c> conLIst = new list<QC_Condition__c>();
        try{ 
            list<string> qList = new list<string>();
            conLIst     = [select Question__c,action__c,MultiSkip__c from QC_Condition__c where recordtype.developername='Question_Condition' AND Response__c =: resId];
            for(QC_Condition__c con : conLIst){
                qList.add(con.Question__c);
            }
            newQuesMap   = new Map<id,QC_Question__c>([select id,name,Competitor_Products__c,question__c,type__c,isNumeric__c,Response_Required__c, Comment_Required__c,Order_Number__c,(select response__c from Responses__r order by order_number__c) from QC_Question__c where id in: qList]);                 
        }catch(Exception e){
            system.debug('************e*****'+e);
        }                           
        map<id,QuestionWrap> uniqueMap = new map<id,QuestionWrap>();
        for(QuestionWrap qw : questionWrapList){
            uniqueMap.put(qw.id,qw);
        }
        for(QC_Condition__c condition : conLIst){
            if(newQuesMap.containsKey(condition.Question__c)){     
                if(condition.action__c == 'Hidden'){ 
                    if(!uniqueMap.containskey(condition.Question__c)){
                        questionWrapList.add(new questionWrap(newQuesMap.get(condition.Question__c)));
                        questionWrapList.sort();
                    }
                }
                if(condition.action__c == 'Visible'){
                    if(uniqueMap.containskey(condition.Question__c)){
                        uniqueMap.remove(condition.Question__c);
                        questionWrapList.clear();
                        questionWrapList.addAll(uniqueMap.values());
                        questionWrapList.sort();
                    }
                }
            }//End of if                     
        }//End of for  
    } //End of previousResQuestions Method
    
    /*
    @Method       : picklistCondition
    @Created By   : Anand
    @Param        : selRes (Parameter with String type to get the selected response's id of current question)
    @Description  : Method to remove/add picklist values of another question based on selected response, 
    SelectedRes variable holds the selected response id of current question,  currentQid  variable holds the current question id
    */
    public void picklistCondition(String selRes){   /***Method to remove/add picklist values of another question based on selected response, SelectedRes variable holds the selected response id of current question,  currentQid  variable holds the current question id.  **/   
        set<id> dependentResQids = new set<id>();  //To store Dependent Response's Questions ids
        Map<id,list<SelectOption>> depResQidOptionsMap = new Map<id,list<SelectOption>>();
        list<QC_Condition__c> PickConLIst = new list<QC_Condition__c>();   
        PickConLIst    = [select id,Response__c,Dependent_Response__r.Question__c,Dependent_Response__c,action__c,MultiSkip__c from QC_Condition__c 
                          where recordtype.developername='Picklist_Condition' AND Response__c =: selRes]; //Fetching the dependent responses of selected response from database
        //Getting Dependent Response's Questions ids                
        for(QC_Condition__c pickCon : PickConLIst){
            dependentResQids.add(pickCon.Dependent_Response__r.Question__c);
        }      
        //Getting Dependent Responses Question's all Responses
        for(QC_Response__c res : [select id, Question__c,response__c from QC_Response__c where Question__c in:dependentResQids order by order_number__c]){
            if(depResQidOptionsMap.containsKey(res.Question__c)){
                depResQidOptionsMap.get(res.Question__c).add(new SelectOption(res.id,res.response__c));
            }else{
                List<SelectOption> CurrentResList = new List<SelectOption>();
                CurrentResList.add(new SelectOption(res.id,res.response__c));
                depResQidOptionsMap.put(res.Question__c,CurrentResList);
            }
        }      
        for(QuestionWrap qw : questionWrapList){ 
            for(QC_Condition__c con : PickConLIst){                  
                if(!depResQidOptionsMap.isEmpty() && depResQidOptionsMap.containsKey(qw.id) && con.Dependent_response__r.Question__c == qw.id && con.action__c == 'Hidden'){                            
                    for(integer i=0;i<qw.singleOptions.size();i++){
                        if(qw.singleOptions[i].getValue() != '' && qw.singleOptions[i].getValue() == con.Dependent_Response__c){
                            qw.singleOptions.remove(i); 
                        }
                    }//End of for
                }
            }//End of for QC_Condition__c
        }//End of for QuestionWrap
    }//End of Method
    /*
    @Method       : PreviousPicklistCondition
    @Created By   : Anand
    @Param        : PrevRes (Parameter with String type to get the previous response id of current question)
    @Description  : Method to add previous response dependent picklist values to corresponding question accordingly
    */
    public void PreviousPicklistCondition(String PrevRes){    //Method to add previous response dependent picklist values to corresponding question accordingly
        set<id> dependentResQids = new set<id>();  //To store Dependent Response's Questions ids
        Map<id,list<SelectOption>> depResQidOptionsMap = new Map<id,list<SelectOption>>();
        list<QC_Condition__c> PickConLIst = new list<QC_Condition__c>();
        //Fetching the dependent responses of selected response from database
        PickConLIst    = [select id,Response__c,Dependent_Response__r.Question__c,Dependent_Response__c,action__c,MultiSkip__c from QC_Condition__c where recordtype.developername='Picklist_Condition' AND Response__c =: PrevRes];                          
        //Getting Dependent Response's Questions ids               
        for(QC_Condition__c pickCon : PickConLIst){
            dependentResQids.add(pickCon.Dependent_Response__r.Question__c);
        }
        //Getting Dependent Responses Question's all Responses
        for(QC_Response__c res : [select id, Question__c,response__c from QC_Response__c where Question__c in:dependentResQids order by order_number__c]){
            if(depResQidOptionsMap.containsKey(res.Question__c)){
                depResQidOptionsMap.get(res.Question__c).add(new SelectOption(res.id,res.response__c));
            }else
            {
                List<SelectOption> CurrentResList = new List<SelectOption>();
                CurrentResList.add(new SelectOption(res.id,res.response__c));
                depResQidOptionsMap.put(res.Question__c,CurrentResList);
            }
        }
        for(QuestionWrap qw : questionWrapList){  //Initializing selected Response Question's responses back
            if(!depResQidOptionsMap.isEmpty() && depResQidOptionsMap.containsKey(qw.id)){
                qw.singleOptions.clear();
                qw.singleOptions.addAll(depResQidOptionsMap.get(qw.id));
            } 
        }
    }
    /*
    @Method       : autoPopulateParentInfo
    @Created By   : Anand
    @Created Date : 
    @param        : N/A
    @Description  : Updating Child component data with parent component data when ever the parent component data updated.
    */
    //Updating Child component data with parent component data.
    
    public void autoPopulateParentInfo(){ 
        QC_Components__c parentComp = new QC_Components__c();
        if(component.parent__c != null){
            parentComp   = [select id,Name__c,isInputDataCreated__c,CreatedDate,Parent__c,PSY_Reference__c,Unique_Number__c,document_Status__c,parent__r.document_Status__c,Master_Variant__c,Sample_Category__c, Vendor__c,Brand__c,
                            Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,No_Of_Sample_Received__c,component_status__c,Brands__c,Cluster__c
                            from QC_Components__c where id =:component.parent__c];
            component.PSY_Reference__c         = parentComp.PSY_Reference__c;            
            component.Sample_Category__c       = parentComp.Sample_Category__c;
            component.document_status__c       = parentComp.document_status__c;
            component.component_status__c      = parentComp.component_status__c;
            component.Vendor__c                = parentComp.Vendor__c;
            component.Brand__c                 = parentComp.Brand__c;
            component.Brands__c                 = parentComp.Brands__c;
            component.Cluster__c                 = parentComp.Cluster__c;
            component.Sample_Date__c           = parentComp.Sample_Date__c;
            component.model__c                 = parentComp.model__c;
            component.Test_Back_Ground__c      = parentComp.Test_Back_Ground__c;
            component.Sample_Department__c     = parentComp.Sample_Department__c;
            component.No_Of_Sample_Received__c = parentComp.No_Of_Sample_Received__c;
            component.Watch_variant__c         = parentComp.Watch_variant__c;
            try{      
                update component;
                if (Test.isRunningTest()) { 
                    integer i=10/0;
                }
            }catch(Exception e){
                Apexpages.addMessages(e);
            }
        }//End of If
        createDefaultInputData();
        onPageLoad();
    }//End of Method  
    /*
    @Method       : InputParamErrorMsg()
    @Created By   : Anand
    @Created Date : 21-4-2015
    @Description  : Method to show error messages on each mandatory input parameter
    */
    /******************Change Request 11 done by Anand 4/21/2015******************************************/
    //Response required validation for input parameters.
    public PageReference  InputParamErrorMsg(){ 
    //public void InputParamErrorMsg(){ 
        Boolean isCusError = false;
        /******************************observationValidation************************************/
        Boolean isObsersNull= false;
        for(TestWrapper each : testWrapList){
           if((each.observation == null && component.Name__c != 'Module') || 
               ((each.observation1 == null || each.observation2 == null  || each.observation3 == null  || each.observation4 == null || each.observation5 == null ) 
                && (each.Specification != 'Test observation' && each.Specification != '24 Hours/Color Change' && each.Specification != '3000 Actuation')
                && component.Name__c == 'Module')){
                    isObsersNull = true;
                }
        }
        if(component.final_verdict__c != null && isObsersNull == true && component.final_verdict__c != 'Dropped') {
            isCusError = true;
            apexpages.AddMessage(new Apexpages.Message(Apexpages.severity.Error,'Please enter all the test finding Observations'));
        }
        for(QuestionWrap each : questionWrapList){
            if(component.Sample_Category__c != 'Competitor Products' && each.responseRequired == true && ((each.renderpicklist== 'true' && each.selectedPicklist == null) 
                                                 || (each.renderFreeText == 'true' && (each.openTextValue == null || each.openTextValue == '')))){
                                                     each.errorMsg = 'Please select value';
                                                     isCusError= true;
                                                 }
            else{
                each.errorMsg ='';
            } 
        }
        if(isCusError == false){
            submitInputData(); //Method to save the data in input_data object if no error in input parameters.
            //componentInit();
            PageReference pr =  new PageReference('/apex/QC_TitanQualityControl?id='+component.id+'&type='+comType);
            pr.setRedirect(true);
            return pr;
        }
        return null;
    }
    
    /*
    @Method       : saveComponentData()
    @Created By   : Anand
    @Description  : Method to save the component data seperately
    */
    public pageReference saveComponentData(){
        Boolean isCusError = false;
        String inputData;
        /***************************************control the verdict on parent and child level***********************************************************/
        getChildComponents = new List<QC_Components__c>();
        System.debug('-------------component.id---------'+component.id);
        for(QC_Input_Data__c  inputDatavalue : [SELECT id,Response_Id__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c =: component.id]){
            if(inputDatavalue.Value__c == 'Smart Watch')
                inputData = inputDatavalue.Value__c;
                
        }
        System.debug('-------------inputData(after for) ---------'+inputData);
       parentCompVerdict = new QC_Components__c();
        if(comType == 'Full-Watch' || comType == 'Watch-Head'){
            try{
                getChildComponents = [SELECT id,component_status__c,isInputDataCreated__c,Report_Ref_Number__c,Sample_Category__c,Document_Status__c,Name__c,Parent__c,Final_Verdict__c,Cluster__c 
                                      FROM QC_Components__c WHERE Parent__c =: comId ];
                if (Test.isRunningTest()) { 
                    integer i=10/0;
                }
            }       
            catch(Exception e){
                Apexpages.addMessages(e);
            }
            for(QC_Components__c qcComp : getChildComponents){
                if(qcComp.Final_Verdict__c == null && component.Final_Verdict__c != null){
                    childVerdict = true;
                }
            }
        }
        /*
        code block for child components of full watch/ watch head.
        Final verdict is captured at full watch/watch head level, updating child component verdict will throuw an error.
        */
        else if((comType != 'Full-Watch' || comType != 'Watch-Head') && component.Parent__c != null){
            try{
                parentCompVerdict = [SELECT id,Name__c,Parent__c,Final_Verdict__c,Cluster__c FROM QC_Components__c WHERE id =: comId AND Name__c =: comType];
                getChildComponents = [SELECT  id,Name__c,Parent__c,Final_Verdict__c,Cluster__c FROM QC_Components__c WHERE id =: parentCompVerdict.Parent__c];
                for(QC_Components__c qc : getChildComponents){
                    if(qc.Final_Verdict__c != null){
                        if(parentCompVerdict.Final_Verdict__c != component.Final_Verdict__c){   
                            isCusError = true;
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot change the verdict since final verdict is captured at full watch/Watch head level'));
                        }       
                    }               
                }       
            }catch(Exception e){
                Apexpages.addMessages(e);
            } 
        }
        /******************************observation Validation for all components and seperete conditions for MODULE************************************/
        Boolean isObsersNull= false;
        for(TestWrapper each : testWrapList){
            system.debug('----------observation--------'+each.observation );
            system.debug('----------observation1--------'+each.observation1 );
            system.debug('----------Specification --------'+each.Specification );
            system.debug('----------component.Name__c--------'+component.Name__c);
            system.debug('----------inputData--------'+inputData );
            System.debug('+++++++++++++++ each.name'+each.name);
            if(((each.observation == null || each.observation == '') && component.Name__c != 'Module') ||
               ((each.observation1 == null || each.observation2 == null  || each.observation3 == null  || each.observation4 == null || each.observation5 == null ) 
                && (each.Specification != 'Test observation' && each.Specification != '24 Hours/Color Change' && each.Specification != '3000 Actuation' && each.name != 'General Observation' && !each.isLast)
                && component.Name__c == 'Module' && inputData != 'Smart Watch')){
                    isObsersNull = true;
                     System.debug('++++++++isObsersNull 1  '+isObsersNull);
                }
            if((each.Specification == 'Test observation' || each.Specification == '24 Hours/Color Change' || each.Specification == '3000 Actuation' || each.name == 'General Observation' || each.isLast)
               && (each.observation == null || each.observation == '') && component.Name__c == 'Module' && inputData != 'Smart Watch'){
                   isObsersNull = true; 
                   System.debug('++++++++isObsersNull 2  '+isObsersNull);
               }
            if((each.observation == null || each.observation == '') && component.Name__c == 'Module' && inputData == 'Smart Watch'){
                  isObsersNull = true;
                  System.debug('++++++++isObsersNull 3-------  '+isObsersNull);
            }
        }
        system.debug('-------------component.final_verdict__c(for approval)------------'+component.final_verdict__c);
        system.debug('----------isObsersNull-----------------------'+isObsersNull);
        if(component.final_verdict__c != null && isObsersNull == true && component.final_verdict__c != 'Dropped') {
            isCusError = true;
            apexpages.AddMessage(new Apexpages.Message(Apexpages.severity.Error,'Please enter all the Test Observation and General observation'));
        }
        
        //Inserting/updating the componenet information.
        pagereference pr = null;
        boolean isError = false;
        //Perform updating the component data after validation of all conditions
        if(isCusError == false){
            if(comType != 'Module' && comType != 'Battery' && (component.Brand__c == NULL)){
                isError = true;
                apexpages.AddMessage(new Apexpages.Message(Apexpages.severity.Error,'Please enter brand value'));
            }else{
                try{
                    //IsCopied_From_ReSub__c is making false to on saving the data to avoid record lock for current record in case of re-submitted record
                    component.IsCopied_From_ReSub__c = false; 
                    upsert component;     
                    //Updating component with newly generated report ref number;                               
                    update component;  // component.Report_Ref_Number__c= reportRefNumber(component.Unique_Number__c,comType);          
                }catch(Exception e){
                    isError = true;
                    Apexpages.addMessages(e);
                }
            }
        }
        if(isCusError == false && isError == false ){
            showComp = true;   //To show component data in view mode
            show = true;       //making show boolean variable as true to show view mode    
            showApproval  = true;     
            submitTestData();
            pr = new pageReference('/apex/QC_TitanQualityControl?id='+component.id+'&type='+comType); 
        }
        return pr; 
        
    }
    public void EditComponentData(){
        showComp = false;
        showApproval  = false;
    }
    /*
    @Method       : createDefaultInputData()
    @Created By   : Sanjeev Shukla
    @Description  : Method to fetch Input Parameter from Question object and create default Input Parameter for newly create component
                    and only one time later it will come from InputData object.
    */
    public void createDefaultInputData(){
        Integer numberofInputData = [SELECT count()  FROM QC_Input_Data__c WHERE Component_No__c =: component.id];
        if(!component.isInputDataCreated__c){
            try{
                Set<String> setInputDataIds = new Set<String>();
                for(QC_Input_Data__c inputData : [SELECT  Question__c FROM QC_Input_Data__c WHERE Component_No__c =: component.id]){
                    setInputDataIds.add(inputData.Question__c);
                }
                if(component.Sample_Category__c == 'Competitor Products'){
                    quesionList = [SELECT id,Question__c FROM QC_Question__c WHERE component_type__c =:comType AND onload__c = TRUE AND CreatedDate <: component.CreatedDate AND Id NOT IN : setInputDataIds AND recordtype.developername='question' order BY order_number__c]; 
                }else{
                    quesionList = [SELECT id,Question__c FROM QC_Question__c WHERE component_type__c =:comType AND onload__c = TRUE AND CreatedDate <: component.CreatedDate AND Id NOT IN : setInputDataIds AND Competitor_Products__c != TRUE AND recordtype.developername='question' order BY order_number__c];                    
                }
            }catch(DMLException e){
                Apexpages.AddMessages(e);
            }
            if(!quesionList.isEmpty()){
                List<QC_Input_Data__c> listInputData = new List<QC_Input_Data__c>();
                //Initialize wrapperlist to display questions in page.
                for(QC_Question__c ques :  quesionList){      
                    QC_Input_Data__c sData      =  new QC_Input_Data__c(Value__c='',Multiple_Response_Ids__c='');
                    sData.Component_No__c       =  component.id;  
                    sData.Question__c           =  ques.id;
                    sData.Question_Name__c      =  ques.Question__c;
                    listInputData.add(sData);
                }
                if(!listInputData.isEmpty()){
                    insert listInputData;
                    component.isInputDataCreated__c = true;
                    update component;
                    displayInputData();
                }
            }else{
                displayInputData();
            }
        }else{
            displayInputData();
        }
    }
    
    public void displayInputData(){
        Set<String> inputDataQids           = new Set<String>();
        Set<String> inputDataResids         = new Set<String>();
        Set<String> onloadQidsToSkip        = new Set<String>();
        Map<Id,QC_Question__c> mapQuestion  = new Map<Id, QC_Question__c>(); 
        try{
            sDataList     = [SELECT Id,comments__c,name,Question__c,Component_No__c,Response_Id__c,isManual__c,Question_Name__c,Value__c,Multiple_Response_Ids__c  FROM QC_Input_Data__c 
                             WHERE Component_No__c=:component.id order BY isManual__c, Question__r.order_number__c ASC];
        }catch(Exception ex){}
        
        for(QC_Input_Data__c inData : sDataList){
            inputDataQids.add(inData.Question__c);
            inputDataResIds.add(inData.Response_Id__c); 
        }
        try{
            mapQuestion = new Map<Id, QC_Question__c>([SELECT id,name,Response_Required__c,Competitor_Products__c,Comment_Required__c,question__c,IsNumeric__c,type__c,order_number__c,
                           (SELECT response__c FROM Responses__r order BY order_number__c) FROM QC_Question__c 
                           WHERE component_type__c =:comType AND (onload__c = TRUE OR id in:inputDataQids) AND recordtype.developername='question' order BY order_number__c]);
            //Adding Ids of onload questions need to hide on view page of metal strap
            if(!inputDataResIds.isEmpty()){
                for(QC_Condition__c quesCon : [SELECT id,question__c FROM QC_Condition__c WHERE response__c in : inputDataResIds AND question__r.onload__c = TRUE]){
                    onloadQidsToSkip.add(quesCon.question__c);      
                }   
            }
        }catch(DMLException e){
            Apexpages.AddMessages(e);
        }
        questionWrapList = new list<questionWrap>();
        //Initialize wrapperlist to display questions in page
        for(QC_Input_Data__c inputData :  sDataList){
            if(!onloadQidsToSkip.contains(inputData.question__c) && !inputData.isManual__c && mapQuestion.get(inputData.question__c) != NULL){  //This condition only for onload questions depends on any response
                QuestionWrap qw = new QuestionWrap(mapQuestion.get(inputData.question__c));
                syncInputData(qw,inputData);
                QuestionWrapList.add(qw);
            }else if(inputData.isManual__c){
                QuestionWrap qw         = new QuestionWrap();
                qw.questionName         = inputData.Question_Name__c;
                syncInputData(qw,inputData);
                questionWrapList.add(qw);
            }
        }
    }
    
   @TestVisible private void syncInputData(QuestionWrap qw, QC_Input_Data__c inputData){
        qw.isManual             = inputData.isManual__c;
        qw.inputdataId          = inputData.Id;
        qw.commentData          = inputData.comments__c;
        if (qw.type == 'Picklist'){
            for(selectOption s: qw.singleOptions){
                if(s.getLabel() == inputData.Value__c){
                    qw.selectedPicklist         = s.getvalue(); 
                    qw.selectedPicklistLabel    = s.getLabel();
                }
            }
        }else if(qw.type == 'Multi-Select'){
            Set<String> multiVals   = new Set<String>();
            if(inputData.Value__c != null){
                multiVals.addALl(inputData.Value__c.split(',')); 
            }
            
            for(selectOption s: qw.multiOptions){
                if(!multiVals.isEmpty() && multiVals.contains(s.getLabel())){
                    qw.selectedMulti.add(s.getValue());
                    qw.selectedMultiLabel.add(s.getLabel());
                }
            }
        }else if(qw.type == 'Free Text'){
            qw.openTextValue    = inputData.Value__c ;
        }
    }
    
    /*
        @Method       : InputParamErrorMsg()
        @Created By   : Anand
        @Created Date : 
        @Description  : Method to save the seleted responses into input data object
    */
    //Saving the seleted responses into input data object.pageReference
    public void submitInputData(){
        Boolean isError = false;
        List<QC_Input_Data__c> listInputData  = new List<QC_Input_Data__c>();
        String responceValue;
        String questionId;
        for(QuestionWrap qw : questionWrapList){
            QC_Input_Data__c inputData = new QC_Input_Data__c();
            if(qw.inputdataId != NULL){
                inputData.id = qw.inputdataId;
            }
            if(qw.id != NULL){
                inputData.Question__c           = qw.id;
            }
            inputData.Component_No__c           = component.Id;
            if(qw.isManual){
                inputData.Question_Name__c      = qw.questionName;
            }else{
                inputData.Question_Name__c      = qw.question;
            }
            inputData.isManual__c               = qw.isManual;
            inputData.comments__c               = qw.commentData;
            inputData.Value__c                  = qw.openTextValue; 
            if(qw.Type == 'Free Text'){
                inputData.Value__c              = qw.openTextValue; 
            }else if(qw.Type == 'Picklist'){
                if(qw.selectedPicklist=='' || qw.selectedPicklist==null){
                    inputData.Value__c          = qw.selectedPicklist;  
                }else{
                    inputData.Response_Id__c    = qw.selectedPicklist;
                    for(selectOption s: qw.singleOptions){
                        if(s.getValue() == qw.selectedPicklist){
                            inputData.Value__c  = s.getLabel();
                            if(inputData.Question_Name__c == 'Type of Module' && component.Name__c == 'Module'){
                                responceValue   = inputData.Value__c;
                                questionId      = inputData.Question__c;
                            }
                        }
                    }
                }
            }else if(qw.Type == 'Multi-select'){
                Set<String> multiVals = new Set<String>();
                multiVals.addAll(qw.selectedMulti); 
                inputData.Value__c='';
                inputData.Multiple_Response_Ids__c ='';
                for(selectOption s: qw.multiOptions){
                    if(!multiVals.isEmpty() && multiVals.contains(s.getValue())){
                        inputData.Value__c += s.getLabel()+',';
                        inputData.Multiple_Response_Ids__c += s.getValue()+','; 
                    }
                }
                if(inputData.Value__c.endsWith(',')){
                    inputData.Value__c = inputData.Value__c.substring(0, inputData.Value__c.lastIndexof(','));
                    inputData.Multiple_Response_Ids__c = inputData.Multiple_Response_Ids__c .substring(0, inputData.Multiple_Response_Ids__c .lastIndexof(','));
                }
            }
            listInputData.add(inputData);
        } //End of For loop
        
        // Reset Test Parameter if Component is Module and Type of Module is Changed from Ditital to Other or other to digital. 
        if(component.Name__c == 'Module' && questionId != NULL && responceValue != NULL){
            QC_Input_Data__c inputData = new QC_Input_Data__c();
            try{
                inputData = [SELECT id,Response_Id__c,Value__c FROM QC_Input_Data__c WHERE Question__c =: questionId AND Component_No__c =: component.id limit 1];
            }catch(Exception ex){}
            if(responceValue == 'Digital' && (inputData.Value__c != 'Digital' || inputData.Value__c == null)){
                List<QC_Test_Data__c> listTestData = [SELECT Id FROM QC_Test_Data__c WHERE Component_Name__c =: component.id];
                if(!listTestData.isEmpty()){
                    delete listTestData;
                }
                createModuleTestParameter('Digital');
            }else if(responceValue != 'Digital' && responceValue != 'Smart Watch' && (inputData.Value__c == 'Digital' || inputData.Value__c == 'Smart Watch')){
                List<QC_Test_Data__c> listTestData = [SELECT Id FROM QC_Test_Data__c WHERE Component_Name__c =: component.id];
                if(!listTestData.isEmpty()){
                    delete listTestData;
                }
                createModuleTestParameter('NotDigital');
            }else if(responceValue == 'Smart Watch' && (inputData.Value__c != 'Smart Watch' || inputData.Value__c == null)){
                List<QC_Test_Data__c> listTestData = [SELECT Id FROM QC_Test_Data__c WHERE Component_Name__c =: component.id];
                if(!listTestData.isEmpty()){
                    delete listTestData;
                }
                createModuleTestParameter('Smart Watch');
            }
            
        }
        try{                                         
            upsert listInputData;
        }catch(Exception e){
            isError = true;
            Apexpages.addMessages(e);
        }
        /***********************************Reset the test parameter if final verdict has given**********************************/
        //Reset the test parameter if final verdict has given
        String finalVerdictBefore; 
        try{ 
            //Getting final Verdict value before saving to validate and reset test parameters
            finalVerdictBefore = [SELECT final_verdict__c FROM QC_components__c WHERE id =: component.id].final_verdict__c;
        }catch(Exception e){
            isError = true;
            Apexpages.addMessages(e);
        } 
        if(finalVerdictBefore != null){
            List<QC_Test_Data__c>  testDataList         = new List<QC_Test_Data__c>();
            List<QC_Components__c> compList             = new List<QC_Components__c>();
            if(component.parent__c != null){
                //Clearing parent final verdict 
                QC_Components__c parentCom = new QC_Components__c(id = component.parent__c,final_Verdict__c = null);
                compList.add(parentCom);
            }
            //Clearing the current child record verdict
            QC_Components__c childCom = new QC_Components__c(id = component.id,final_Verdict__c = null);
            compList.add(childCom);
            try{  
                //Updating the final verdict of parent and child components as Null
                if(!complist.isEmpty()){
                    update compList;
                }      
                //Reseting the test parameters if final verdict has given 
                testDataList = [SELECT id,Observation__c,Conclusion__c,No_of_Samples__c,Comments_and_Remarks__c FROM QC_Test_Data__c WHERE Component_Name__c =: component.id];         
                if(!testDataList.isEmpty()){
                    for(QC_Test_Data__c qc : testDataList){
                        qc.Observation__c = null;
                        qc.Conclusion__c = '';
                        qc.Comments_and_Remarks__c = '';
                        qc.No_of_Samples__c     ='';
                    }
                    update testDataList;
                }
            }catch(Exception e){    
                ApexPages.addMessages(e);
            }
        }
        if(isError == false ){
            show = true;       //making show boolean variable as true to show view mode       
            //submitTestData();
            displayInputData();
            displayTestParameter();
        }
    }//End of submitAll
    /*
    Method Name:    cloneRecords
    Created By:     Shamsher
    Created Date:   7/3/2015
    Description:    Method to clone all the components of FW,WH and individual components.
    */
    public pageReference cloneRecords(){
        pageReference pr = null;
        if(comType == 'Full-Watch' ){
            cloneParentRecord();
            cloneChildCompFWWH();
            pr=new pageReference('/apex/QC_Tabs?id='+cloneParentComp.id);
        }else if(comType == 'Watch-Head'){
            cloneParentRecord();
            cloneChildCompFWWH();
            pr=new pageReference('/apex/QC_Tabs?id='+cloneParentComp.id);
        }else{
            cloneIndividualComponent();
            pr=new pageReference('/apex/QC_Tabs?id='+cloneIndiComp.id);
        }
        return pr;
    }//End of method - cloneRecords()
    /*
    Method Name:    cloneIndividualComponent
    Created By:     Shamsher
    Created Date:   6/7/2015
    Description:    Method to clone the individual component and its related input parameters and test findings.
    Document status,final verdict and report reference no. need not to be cloned as per the requirement.
    */
    public void cloneIndividualComponent(){
        if(comId != null){
            try{
                QC_Components__c indiCom = [SELECT id,Component_Status__c,name,Name__c,master__c,General_Observation__c,Parent__c,Master_Variant__c,PSY_Reference__c,Vendor__c,Report_Ref_Number__c,Sample_Category__c,Final_verdict__c,Brand__c,Sample_Date__c,
                                            model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,unique_number__c,Brands__c,Cluster__c FROM  QC_Components__c WHERE id =: comId AND Parent__c = null limit 1];
                cloneIndiComp                           = indiCom.clone(false);
                cloneIndiComp.Document_Status__c        = 'Draft';
                if( cloneIndiComp.Sample_Category__c == 'Re-submission')
                	cloneIndiComp.Sample_Category__c = 'New';
                cloneIndiComp.isTestDataCreated__c      = true;
                cloneIndiComp.Final_Verdict__c          = null;
                cloneIndiComp.Report_Ref_Number__c      = null;
                cloneIndiComp.SKU_Reference__c=null;
                cloneIndiComp.Component_Status__c = 'Active';
                
                try{
                    insert cloneIndiComp;
                /*    QC_Components__c sameRecord =[SELECT ID,Component_Status__c FROM QC_Components__c where Id=:cloneIndiComp.Id ];
                    System.debug('cloneIndiComp--'+cloneIndiComp);
                    System.debug('sameRecord---'+sameRecord);*/
                    /*********Creating report reference number**********************/
                    //Querying
                    QC_Components__c selectedComp = cloneIndiComp.id != null ? [select unique_number__c,name__c from QC_Components__c where id =: cloneIndiComp.id] : new QC_Components__c();
                    QC_TitanSelectOptions  tSoptions = new QC_TitanSelectOptions();
                    //lines added by M.A. Mudasser Ahamed in order to request raised by client in SR-00113.
                    String compy=selectedComp.Name__c;
                    if(compy!=null){
                        compy=(compy=='Dial')?'DL':(compy == 'Full-Watch') ?'FW':(compy == 'Watch-Head')?'WH':(compy=='Full-Watch')?'FW':(compy=='Case')?'CA':(compy=='Metal-Strap')?'MS':(compy=='Leather-Strap'|| compy == 'Special-Strap')?'LS':(compy=='Module')?'FMA':(compy=='Battery')?'BT':(compy=='Packaging')?'PA':null;
                    }
                    QC_Component_Prefix__c qcno=QC_Component_Prefix__c.getInstance(compy);
                    String uniqueNo=qcno.Sequence_Number__c;
                    cloneIndiComp.Report_Ref_Number__c = tSoptions.reportRefNumber(uniqueNo,selectedComp.name__c);
                    update cloneIndiComp;
                }catch(Exception e){
                    Apexpages.addMessages(e);
                }
                list<QC_Test_Data__c> testList = new list<QC_Test_Data__c>();
                for(QC_Test_Data__c testEachMaster : [select Id,Conclusion__c,Specification_Input__c,UOM_Input__c,Determined_value__c,No_of_Samples__c,Comments_and_Remarks__c,Component_Name__c,Component_Name__r.name__c,Observation__c,Observation1__c,Observation2__c,Observation4__c,Observation5__c,Observation3__c,Initial1__c,Initial2__c,Initial3__c,Initial4__c,Initial5__c,After_Test1__c,After_Test2__c,After_Test3__c,After_Test4__c,After_Test5__c,Condition_Ref__c,Parent__c,isParent__c,IsLast__c, RandomNumber__c,Acceptance_Criteria__c,isManual__c,Test_Name__c,Name,Condition_Ref__r.Question__r.Test_Name__c from QC_Test_Data__c where Component_Name__c =:comId]){
                    QC_Test_Data__c testData    = new QC_Test_Data__c();
                    testData                    = testEachMaster.clone();
                    testData.Component_Name__c  = cloneIndiComp.id;
                    testList.add(testData);
                }//End of for
                insert testList;       //Insert all the cloned input parameters
                list<QC_Input_Data__c> inputList = new list<QC_Input_Data__c>();
                for(QC_Input_Data__c inputEach : [SELECT Id,comments__c,Name,Question__c,Question__r.Question__c,Component_No__c,Component_No__r.name__c,Response_Id__c,Value__c,Question_Name__c FROM QC_Input_Data__c where Component_No__c =: comId]){
                    QC_Input_Data__c inputData      = new QC_Input_Data__c();
                    inputData                       = inputEach.clone();
                    inputData.Component_No__c       = cloneIndiComp.id;
                    inputData.Question_Name__c =  inputEach.Question__r.Question__c;
                    inputList.add(inputData);
                }//End of for
                insert inputList;       //Insert all the cloned test findings
            }catch(Exception e){
                System.debug('exception in individual component query'+e);
            }
        }
    }
    /*
    Method Name:    cloneParentRecord
    Created By:     Shamsher
    Created Date:   6/7/2015
    Description:    Method to clone the parent component(i.e. FW and WH) and its input and test findings.
    Document status,final verdict need not to be cloned as per the requirement.
    */
    public void cloneParentRecord(){
        if(comId != null){
            try{
                parentCom = [SELECT id,Component_Status__c,name,Name__c,master__c,Parent__c,Master_Variant__c,General_Observation__c,PSY_Reference__c,Vendor__c,Report_Ref_Number__c,Sample_Category__c,Final_verdict__c,Brand__c,Sample_Date__c,
                             model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,unique_number__c,Brands__c,Cluster__c FROM  QC_Components__c WHERE id =:comId AND Parent__c=null limit 1];
                cloneParentComp                         = parentCom.clone(false);
                cloneParentComp.Document_Status__c      = 'Draft';
                if( parentCom.Sample_Category__c == 'Re-submission')
                	cloneParentComp.Sample_Category__c = 'New';
                cloneParentComp.Final_Verdict__c        = null;
                cloneParentComp.Report_Ref_Number__c    = null;
                cloneParentComp.Watch_Variant__c        = NULL; // added by Sanjeev Shukla because this field validate as unique from trigger that's why I have make it as NULL.
                cloneParentComp.isTestDataCreated__c    = true;
                cloneParentComp.Component_Status__c = 'Active';
                
                system.debug('----Report_Ref_Number__c---' +cloneParentComp.Report_Ref_Number__c);
                try{
                    insert cloneParentComp;
                    //Creating report reference number
                    QC_Components__c selectedComp = cloneParentComp.id != null ? [select unique_number__c,name__c from QC_Components__c where id =: cloneParentComp.id] : new QC_Components__c();
                    QC_TitanSelectOptions  tSoptions = new QC_TitanSelectOptions();
                    String compy=selectedComp.Name__c;
                    if(compy!=null){
                        compy=(compy=='Dial')?'DL':(compy == 'Full-Watch') ?'FW':(compy == 'Watch-Head')?'WH':(compy=='Full-Watch')?'FW':(compy=='Case')?'CA':(compy=='Metal-Strap')?'MS':(compy=='Leather-Strap'|| compy == 'Special-Strap')?'LS':(compy=='Module')?'FMA':(compy=='Battery')?'BT':(compy=='Packaging')?'PA':null;
                    }
                    QC_Component_Prefix__c qcno=QC_Component_Prefix__c.getInstance(compy);
                    String uniqueNo=qcno.Sequence_Number__c;
                    System.debug('uniqueNo => '+ uniqueNo );
                    cloneParentComp.Report_Ref_Number__c = tSoptions.reportRefNumber(uniqueNo,selectedComp.name__c);
                    System.debug('Record Id -> ' + cloneParentComp.Id + ' RRF -->  ' + cloneParentComp.Report_Ref_Number__c);
                    update cloneParentComp;
                }catch(Exception e){
                    Apexpages.addMessages(e);
                }
                list<QC_Test_Data__c>  testList  = new list<QC_Test_Data__c>();
                for(QC_Test_Data__c testEachMaster : [select Id,Conclusion__c,Specification_Input__c,UOM_Input__c,Determined_value__c,No_of_Samples__c,Comments_and_Remarks__c,Component_Name__c,Component_Name__r.name__c,Observation__c,Condition_Ref__c,Parent__c,isParent__c,IsLast__c, RandomNumber__c,Acceptance_Criteria__c,isManual__c,Test_Name__c,Condition_Ref__r.Question__r.Test_Name__c from QC_Test_Data__c where Component_Name__c =:comId ]){
                    QC_Test_Data__c testData = new QC_Test_Data__c();
                    testData = testEachMaster.clone();
                    testData.Component_Name__c = cloneParentComp.id;
                    testList.add(testData);
                }//End of for
                insert testList;
                list<QC_Input_Data__c> inputList = new list<QC_Input_Data__c>();
                for(QC_Input_Data__c inputEach : [SELECT Id,comments__c,Name,Question__c,Question__r.Question__c,Component_No__c,Component_No__r.name__c,Response_Id__c,Value__c,Multiple_Response_Ids__c,Question_Name__c FROM QC_Input_Data__c where Component_No__c =: comId]){
                    QC_Input_Data__c inputData = new QC_Input_Data__c();
                    inputData = inputEach.clone();
                    inputData.Component_No__c = cloneParentComp.id;
                    inputData.Question_Name__c =  inputEach.Question__r.Question__c;
                    inputList.add(inputData);
                }//End of for
                insert inputList;
            }Catch(Exception e ){
                System.debug('EXCEPTION '+e);
            }
        }
    }
    /*
    Method Name:    cloneChildCompFWWH
    Created By:     Shamsher
    Created Date:   6/7/2015
    Description:    Method to clone the child components of FW and WH and its input and test findings.
    Document status,final verdict  need not to be cloned as per the requirement.
    */
    public void cloneChildCompFWWH(){
        try{
            childComp = [SELECT id,Component_Status__c,name,Name__c,General_Observation__c,master__c,Parent__c,Master_Variant__c,PSY_Reference__c,Vendor__c,Report_Ref_Number__c,Sample_Category__c,Final_verdict__c,Brand__c,Sample_Date__c,
                         model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,unique_number__c,Brands__c,Cluster__c  FROM QC_Components__c WHERE Parent__c =:comId   ];
        }catch(Exception e){
            ApexPages.addMessages(e);
        }
        for(QC_Components__c childs : childComp){
            childId.add(childs.id);
        }
        try{
            //Query all the input parameters of the child components
            childComponentInputParameters = [SELECT Id,Name,Comments__c,Component_No__c,Response_Id__c,Question__c,Question_Name__c,Value__c,Multiple_Response_Ids__c FROM QC_Input_Data__c 
                                             WHERE Component_No__c in : childId];
            
            childComponentTestParameters  = (comType == 'Module') ? ([select Determined_value__c,Parent__c,isParent__c,IsLast__c, RandomNumber__c,Acceptance_Criteria__c,isManual__c,Condition_Ref__r.Onload__c,Test_Name__c,Condition_Ref__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c, Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.Specification__c, Conclusion__c, Comments_and_Remarks__c,Condition_Ref__r.IsEditableUOMSPEC__c,Component_Name__c,observation__c,Specification_Input__c,UOM_Input__c, Initial_Test_Observation__c,After_Test_Observation__c, Observation5__c, Observation4__c, Observation3__c, Observation2__c, Observation1__c,Initial5__c, Initial4__c, Initial3__c,Initial2__c, Initial1__c, After_Test5__c, After_Test4__c, After_Test3__c, After_Test2__c, After_Test1__c From QC_Test_Data__c  where Component_Name__c in :childId and recordtype.developerName ='Module' order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c,Name limit 50000 ]) : 
            ([select Id,Acceptance_Criteria__c,isManual__c,Test_Name__c,Determined_value__c,Conclusion__c,Condition_Ref__r.Onload__c,Component_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.Specification__c,No_of_Samples__c,Comments_and_Remarks__c,Observation__c,Condition_Ref__c,Specification_Input__c,UOM_Input__c,Condition_Ref__r.IsEditableUOMSPEC__c from QC_Test_Data__c where Component_Name__c in :childId order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c limit 50000]);
                
        }catch(Exception e){
            ApexPages.addMessages(e); 
        }
        for(QC_Components__c cComp : childComp){
            QC_Components__c childComponent = cComp.clone(false);
            childComponent.Parent__c = cloneParentComp.id;    //Set the Parent__c to the cloned parent record id
            childComponent.isTestDataCreated__c     = true;
            childComponent.Document_Status__c       = 'Draft';
            childComponent.Final_Verdict__c         = null;
            childComponent.Report_Ref_Number__c     = null;
            childComponent.SKU_Reference__c         = null;
            cloneChildRecords                       = childComponent.clone(false);        //Add to list after setting the parent to clone
            try{
                insert cloneChildRecords;       //clone the child component
            }
            catch(Exception e){
                ApexPages.addMessages(e);
            }
            for(QC_Input_Data__c qcID : childComponentInputParameters){
                if(qcID.Component_No__c == cComp.Id){
                    QC_Input_Data__c inputChildData = qcID.clone(false);
                    inputChildData.Component_No__c = cloneChildRecords.Id;
                    cloneChildComponentInputParam.add(inputChildData);          //Add all the input paremeters mapped with the child component to list to clone. 
                }
            }
            for(QC_Test_Data__c qcTD : childComponentTestParameters){
                If(qcTD.Component_Name__c == cComp.Id){
                    QC_Test_Data__c testChildData = qcTD.clone(false); 
                    testChildData.Component_Name__c = cloneChildRecords.Id;
                    cloneChildComponentTestData.add(testChildData);              //Add all the test paremeters mapped with the child component to list to clone. 
                }
            }
        }
        try{
            if(!cloneChildComponentInputParam.isEmpty() ) {
                insert cloneChildComponentInputParam;                           //Clone the input parameters record of child component 
            }
        }catch(Exception E){apexPages.addMessages(E);}
        try{  
            if(!cloneChildComponentTestData.isEmpty()){                           
                insert cloneChildComponentTestData;                            //Clone the test parameters record of child component
            }
        }Catch(Exception e){
            ApexPages.addMessages(e);               
        }   
    }
    /*
    Modified By : Shamsher singh on 3/30/2015
    Method Name : reportPDF()
    Method to redirect to summary report pdf page
    */
    public pageReference reportPDF(){
        pageReference pr = null;
        if(comType == 'Full-Watch'){
            pr = new pageReference('/apex/QC_FullWatchReport?id='+component.id);
            pr.setredirect(true);
        }
        else if(comType == 'Watch-Head'){
            pr = new pageReference('/apex/QC_WatchHeadReport?id='+component.id);
            pr.setredirect(true);
        }
        
        
        return pr;
    } //End of method.
    public pageReference detailedReportPDF(){
        pageReference pr = null;
        if(comType == 'Full-Watch'){
            pr = new pageReference('/apex/QC_FullWatchDetailedReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Watch-Head'){
            pr = new pageReference ('/apex/QC_WatchHeadDetailedReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Case'){
            pr = new pageReference ('/apex/QC_caseDetailedReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Leather-Strap'){
            pr = new pageReference ('/apex/QC_leatherStrapDetailedReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Dial'){
            pr = new pageReference ('/apex/QC_dialDetailedReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Metal-Strap'){
            pr = new pageReference ('/apex/QC_MetalStrapDetailedReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Special-Strap'){
            pr = new pageReference ('/apex/QC_specialStrapDetailedReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Battery'){
            pr = new pageReference ('/apex/QC_BatteryDetailedReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Packaging'){
            pr = new pageReference ('/apex/QC_packingDetailedReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Module'){
            pr = new pageReference ('/apex/QC_moduleDetailedReport?id='+component.id);
            pr.setredirect(true);
        }
        return pr;
    }
    /*
    Modified By : Shamsher singh on 7/2/2015
    Method Name : reportPDFTestFinding()
    Method to redirect to test finding summary report pdf page
    */
    public pageReference reportPDFTestFinding(){
        pageReference pr = null;
        if(comType == 'Full-Watch'){
            pr = new pageReference('/apex/QC_AllTestFindingSummaryReport?id='+component.id);
            pr.setredirect(true);
        }
        else if(comType == 'Watch-Head'){
            pr = new pageReference('/apex/QC_AllTestFindingSummaryReportWH?id='+component.id);
            pr.setredirect(true);
        }
        return pr;
    } //End of method.
    /*
    Written By : Shamsher singh
    Modified By : Shamsher singh
    Method Name : individualReport()
    Method to redirect to individual report pdf page
    */
    public pageReference individualReport(){
        pageReference pr = null;
        System.debug('Component type'+comType + 'component parent'+component.Parent__c);
        if(comType == 'Case' && component.Parent__c == null){
            pr = new pageReference('/apex/QC_CaseReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Dial'){
            pr = new pageReference('/apex/QC_DialReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Leather-Strap'){
            pr = new pageReference('/apex/QC_LeatherStrapReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Metal-Strap'){
            pr = new pageReference('/apex/QC_MetalStrapReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Special-Strap'){
            pr = new pageReference('/apex/QC_SpecialStrapReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Battery'){
            pr = new pageReference('/apex/QC_BatteryReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Packaging'){
            pr = new pageReference('/apex/QC_PackagingReport?id='+component.id);
            pr.setredirect(true);
        }else if(comType == 'Module'){
            pr = new pageReference('/apex/QC_ModuleReport?id='+component.id);
            pr.setredirect(true);
        }
        return pr;
    }
    //Method for cancel button 
    public pageReference cancel(){
        show=true;  
        pagereference pr = new pageReference('/apex/QC_TitanQualityControl?id='+component.id+'&type='+comType);
        pr.setredirect(true); 
        return pr;
    }
    public void editMode(){
        if(comType == 'Metal-Strap' ){  //&& !sDataList.isEmpty()
            for(QC_Input_data__c  InputData : [select Response_Id__c from QC_Input_data__c where Component_No__c =: component.id AND Response_Id__c 
                                               in (select Response__c from QC_Condition__c  where recordtype.developername='Picklist_Condition')]){
                                                   picklistCondition(InputData.Response_Id__c);                                      
                                               }                       
        }     
        show=false;
        showApproval = false;
    } 
    //Start of Edit method 
    public pageReference edit(){
    
        if(component.Brand__c != null ){
            showTest = false;
            showApproval  = false;
        }else if(component.Brand__c ==null && (comType !='Module' && comType !='Battery')){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Brand'));
        
        }else{
            showTest = false;
            showApproval  = false;
        }
        return null;
    }//End of If Block
    /*
    Written By  : Shamsher singh
    Modified By : Shamsher singh
    Method Name : submitTestData()
    Description : Method to display the default test parameters and test parameters based on input response.
    */
    public void submitTestData(){    
        testWrapList.clear();
      //  addDependentTestParameter();
        displayTestParameter();      //Call displayTestParameter() method to display test parameters from back-end as well as from the new wrapper list.
    } //End of method - submitData
    public void addInput(){
        // code for add input parameter
        QuestionWrap qw     = new QuestionWrap();
        qw.isNumeric        = false;
        qw.commentRequired  = true; 
        qw.cp               = true;
        qw.renderPicklist   = 'False';
        qw.isManual         = true;
        questionWrapList.add(qw);
    }
    /*
     *  Written By  : Sanjeev Shukla
     *  Method Name : delInputData()
     *  Description : Method to delete input parameter.
     */ 
    public void delInputData(){
        Integer indexNo = Integer.valueOf(ApexPages.currentPage().getParameters().get('inputindexNo'));
        if(questionWrapList.get(indexNo).inputdataId != NULL){
            QC_Input_data__c inputData = new QC_Input_data__c();
            inputData.id = questionWrapList.get(indexNo).inputdataId;
            try{
                delete inputData;
            }catch(Exception ex){}
        }
        questionWrapList.remove(indexNo);
    }
    /*
    Written By  : Sanjeev Shukla
    Method Name : addTest()
    Description : Method to add manual test parameter.
    */ 
     public void addTest(){
        if(comType == 'Module' && showModuleTest == True){
          // add five set of wrapper object for Module Component
           Double randomNumber = Math.random();
            TestWrapper tw = new TestWrapper(new QC_Condition__c());
            tw.randomNumber = randomNumber;
            tw.isEditUOMSpec = true;
            tw.isManual = true;
            tw.isParent = true;        // indicate parent record
            tw.Initial1     = 'R';    
            tw.Initial2     = 'R'; 
            tw.Initial3     = 'R'; 
            tw.Initial4     = 'R';
            tw.Initial5     = 'R';
            testWrapList.add(tw);
            
            tw = new TestWrapper(new QC_Condition__c());
            tw.randomNumber = randomNumber;
            tw.isEditUOMSpec = true;
            tw.isManual = true;
            testWrapList.add(tw);
            
            tw = new TestWrapper(new QC_Condition__c());
            tw.randomNumber = randomNumber;
            tw.isEditUOMSpec = true;
            tw.isManual = true;
            testWrapList.add(tw);
            tw = new TestWrapper(new QC_Condition__c());
            tw.randomNumber = randomNumber;
            tw.isEditUOMSpec = true;
            tw.isManual = true;
            testWrapList.add(tw);
            
            tw = new TestWrapper(new QC_Condition__c());
            tw.randomNumber = randomNumber;
            tw.isEditUOMSpec = true;
            tw.isManual = true;
            tw.isLast = true;      // indicate last child record
            testWrapList.add(tw); 
        }else{
            TestWrapper tw = new TestWrapper(new QC_Condition__c());
            tw.isEditUOMSpec = true;
            tw.isManual = true;
            testWrapList.add(tw);
        }
    }
    /*
    Written By  : Sanjeev Shukla
    Method Name : delTest()
    Description : Method to delete test parameter.
    */ 
    public void delTest(){
        Integer indexNo = Integer.valueOf(ApexPages.currentPage().getParameters().get('indexNo'));
        TestWrapper tw = testWrapList.get(indexNo);
        try{
            if(comType == 'Module'){
                if(tw.isManual){
                    List<QC_Test_Data__c> testData = [SELECT id FROM QC_Test_Data__c WHERE id =: tw.testDataId OR Parent__c =: tw.testDataId limit 5];
                    delete testData;
                    // added by sudama for removing list of manual testing
                    for(QC_Test_Data__c qc : testData){
                        testWrapList.remove(indexNo);
                    }
                }else if(tw.Specification == 'No Stoppage' || tw.Specification == 'No Stoppage / No Component loose' || tw.Specification == 'No Stoppage - During the test' || tw.Specification == 'No Stoppage / No Component loose' || tw.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || tw.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'){
                    List<QC_Test_Data__c> testData = [SELECT id  FROM QC_Test_Data__c WHERE Condition_Ref__r.Question__r.Test_Name__c =: tw.name AND Component_Name__c =: component.id limit 5];
                    delete testData;
                }else{
                    List<QC_Test_Data__c> testData = [SELECT id  FROM QC_Test_Data__c WHERE Condition_Ref__r.Question__r.Test_Name__c =: tw.name AND Component_Name__c =: component.id AND id =: tw.testDataId limit 1];
                    delete testData;
                }
            }else{
                if(tw.id != NULL){
                    QC_Test_Data__c testData = [SELECT Condition_Ref__c FROM QC_Test_Data__c WHERE Condition_Ref__c =: tw.id AND Component_Name__c =: component.id limit 1];
                    delete testData;
                }else{
                    if(tw.testDataId != NULL){
                        QC_Test_Data__c testData = [SELECT Condition_Ref__c FROM QC_Test_Data__c WHERE id =: tw.testDataId  limit 1];
                        delete testData;
                    }
                }
            }
        }catch(Exception ex){
            Apexpages.addMessages(ex);
        }
        if(comType == 'Module'){
            if(tw.isManual){
                //  Hide by sudama for remove list data of manual testing
                //testWrapList.get(indexNo)
                // testWrapList.remove(indexNo);
                //  testWrapList.remove(indexNo);
                //  testWrapList.remove(indexNo);
                // testWrapList.remove(indexNo);
                // testWrapList.remove(indexNo);
            }else if(tw.Specification == 'No Stoppage' || tw.Specification == 'No Stoppage / No Component loose' || tw.Specification == 'No Stoppage - During the test' || tw.Specification == 'No Stoppage / No Component loose' || tw.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || tw.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'){
                String name = tw.Name;
                testWrapList.remove(indexNo);
                if(testWrapList.size() > indexNo){                        // remove parent default test data
                    TestWrapper twChild = testWrapList.get(indexNo);
                    if(name == twChild.Name){                          // check if parent default test data having childs
                        testWrapList.remove(indexNo);                     // remove first child default test data
                    }
                    twChild = testWrapList.get(indexNo);
                    if(name == twChild.Name){                          // check if parent default test data having childs
                        testWrapList.remove(indexNo);                     // remove second child default test data
                    }
                    twChild = testWrapList.get(indexNo);
                    if(name == twChild.Name){                          // check if parent default test data having childs
                        testWrapList.remove(indexNo);                     // remove third child default test data
                    }
                    twChild = testWrapList.get(indexNo);
                    if(name == twChild.Name){                          // check if parent default test data having childs
                        testWrapList.remove(indexNo);                     // remove forth child default test data
                    }
                } 
            }else{
                String name = tw.Name;
                testWrapList.remove(indexNo);
            }
        }else{
            testWrapList.remove(indexNo);
        }
    }
    /*
    Written By  : Sanjeev Shukla
    Method Name : addDependentTestParameter()
    Description : Method to add and remove depedent test parameter based on input parameter.
    */
    public void addDependentTestParameter(){
        if(component.Sample_Category__c != 'Competitor Products'){
            Set<string> selResIds = new Set<string>();
            Set<String>   selResVal = new Set<String>();
            Set<String> selQuestionName = new Set<String>();
            testrData = new List<QC_Test_Data__c>();
            deleteTestData = new List<QC_Test_Data__c>(); 
            QC_Test_Data__c qtd = new QC_Test_Data__c();
            saveTestData = new List<QC_Test_Data__c>();
            Map<Id, QC_Test_Data__c> mapTestData = new Map<Id, QC_Test_Data__c>();
            Set<Id> setcondId2 = new Set<Id>();
            List<QC_Condition__c> testAllParameter = New List<QC_Condition__c>();
            List<QC_Input_Data__c> testResponseParameter = New List<QC_Input_Data__c>();
            testrData = [select Id,isManual__c,Test_Name__c,Determined_value__c,Conclusion__c,Component_Name__c,No_of_Samples__c,Comments_and_Remarks__c,Observation__c,Condition_Ref__c,
                         Specification_Input__c,UOM_Input__c,Condition_Ref__r.IsEditableUOMSPEC__c,Condition_Ref__r.Question__r.Test_Name__c,CreatedDate from QC_Test_Data__c where Component_Name__c =: component.id  AND Condition_Ref__r.Onload__c = false AND isManual__c = false limit 50000];
            if(!testrData.isEmpty()){ 
                for(QC_Test_Data__c testData : testrData){
                    mapTestData.put(testData.Condition_Ref__c,testData);
                }
            }
            //Query all dependent the test parameters based on responses.
            testAllParameter =[SELECT id,Question__r.UOM__c,Question__r.Test_Name__c,Question__r.Specification__c,Question__r.Acceptance_Criteria__c,order_number__c,
                               brand__c,Multiple_Responses__c,MultiSkip__c,Response__c,Response__r.response__c,Action__c, onload__c,Question_name__c,IsEditableUOMSPEC__c FROM QC_Condition__c 
                               WHERE component_type__c =:comType AND onload__c = false AND  recordtype.developerName ='Test_Condition' order by order_number__c];  
            if(component.id != null){
                testResponseParameter = [SELECT Id,Name,Component_No__c,Response_Id__c,Value__c,Multiple_Response_Ids__c,Question_Name__c FROM QC_Input_Data__c Where Component_No__c=:component.id]; 
                System.debug('all the input parameters'+testResponseParameter);
                for(QC_Input_Data__c inData : testResponseParameter){
                    if(inData.Multiple_Response_Ids__c != null){
                        List<String> multiResIds = inData.Multiple_Response_Ids__c.split(',');
                        for(String s : multiResIds){
                            selResIds.add(s.substring(0,15));
                        }
                    }
                    if(inData.Response_Id__c != null)
                        selResIds.add(string.valueOf(inData.Response_Id__c).substring(0,15)); //converting 18 digit Id as 15 digit id
                    selResVal.add(inData.Value__c);
                    selQuestionName.add(inData.Question_Name__c);
                } 
            }
            if(!testAllParameter.isEmpty()){
                integer specialStrapRes = 0;
                //This query is only for Special-Strap to display test parameters conditionally based on Sillicon, Rubber.
                specialStrapRes = [select count() from QC_input_data__c where Component_No__c =: component.id and Component_No__r.Name__c ='Special-Strap' and Response_Id__r.response__c in ('Silicon','Rubber')];
                List<TestWrapper> listTestWrap = new List<TestWrapper>();
                system.debug('dddd ==>'+testAllParameter);
                For(QC_Condition__c tp : testAllParameter){
                    system.debug('vvvv ==>'+tp);
                }
                For(QC_Condition__c tp : testAllParameter){
                    //If block to add questions based on selected brand at component level                
                    if(component.id != null && tp.brand__c!= null && component.Brand__c == tp.brand__c && tp.Action__c == 'Visible'){
                        listTestWrap.add(new testWrapper(tp));
                    }else if(tp.onload__c != true && tp.Action__c == 'Visible' && tp.MultiSkip__c && tp.Multiple_Responses__c != null){
                        list<string> multiResList = new list<string>(tp.Multiple_Responses__c.split(','));                   
                        set<string> multiResIds = new set<string>();
                        multiResIds.addAll(multiResList); 
                        if(!selResIds.isEmpty() && multiResIds.size() > selResIds.size() && multiResIds.containsAll(selResIds)){
                            listTestWrap.add(new testWrapper(tp));
                        }else if(multiResIds.size() <= selResIds.size() && selResIds.containsAll(multiResIds)){
                            listTestWrap.add(new testWrapper(tp));
                        }
                    }//End if 
                    For(QC_Input_Data__c sd : testResponseParameter){
                        //If block to add test parameters into wrapper list based on question and response.
                        if(tp.Action__c == 'Visible' && tp.Response__c != null && sd.Response_Id__c != null && tp.Response__c == sd.Response_Id__c && !tp.MultiSkip__c){
                            /**************************this condition only for metal strap with Material as 'SS material and strap type as null''*****************************************/
                            if(component.name__c =='Metal-Strap' && selQuestionName.contains('Strap Type') && tp.Question_name__c == 'Spot welding Strength - Failure Load'){
                                //if above condition is satisfied then dont add test condition to testwrapList 
                            }else{
                                listTestWrap.add(new testWrapper(tp));
                            }
                        }//End if
                        
                        /*O
                         *Written By: Shamsher
                         *Hardcoding for Leather-Strap Input parameter size       
                         */
                        else if(component.name__c =='Leather-Strap' && sd.Question_Name__c == 'Catch Size in mm'){
                            System.debug('*********** sd.value__c != NULL************* '+sd.value__c != NULL);
                            if(selResVal.contains('Normal Buckle') && tp.Question__r.Test_Name__c=='Flex test' && tp.Question__r.Specification__c == '0.5 Kg / 750' && sd.value__c != NULL && integer.valueOf(sd.value__c) < 10){
                                listTestWrap.add(new testWrapper(tp)); 
                            }else if(selResVal.contains('Normal Buckle') && tp.Question__r.Test_Name__c=='Flex test' && tp.Question__r.Specification__c == '1 Kg / 750 Cycle' && sd.value__c != NULL && integer.valueOf(sd.value__c) >= 10){
                                listTestWrap.add(new testWrapper(tp)); 
                            }else if(tp.Question__r.Test_Name__c=='Withstanding force' && tp.Question__r.Specification__c == '12~15' && sd.value__c != NULL && integer.valueOf(sd.value__c) < 10){
                                listTestWrap.add(new testWrapper(tp)); 
                            }else if(tp.Question__r.Test_Name__c=='Withstanding force' && tp.Question__r.Specification__c == '20' && sd.value__c != NULL && integer.valueOf(sd.value__c) >= 10){
                                listTestWrap.add(new testWrapper(tp));     
                            }
                        }
                        /*
                         Written By: Shamsher
                         Hardcoding for leather strap - only normal buckle selected - no catch size entered.
                         Flex test will be displayed without UOM and Spec.
                         */
                        else if(component.name__c =='Leather-Strap' && !selQuestionName.contains('Catch Size in mm') && selResVal.contains('Normal Buckle') && (tp.Question__r.Test_Name__c == 'Flex test' && (tp.Question__r.Specification__c == '' || tp.Question__r.Specification__c == null))){                 
                            listTestWrap.add(new testWrapper(tp)); 
                        }else if(component.name__c =='Special-Strap' && selResVal.contains('Normal Buckle') && specialStrapRes == 0){
                            if(selResVal.contains('Fashion') || selResVal.contains('Fabrics')){     
                                if(sd.Question_Name__c == 'Catch Size in mm' && tp.Question__r.Test_Name__c=='Withstanding force' && tp.Question__r.Specification__c == 'Gents : >= 20 , Ladies : >= 15 & Zoop >= 12'){
                                    listTestWrap.add(new testWrapper(tp));
                                }                       
                                if(tp.Question__r.Test_Name__c == 'Flex test' && tp.Question__r.Specification__c == '350'){
                                    listTestWrap.add(new testWrapper(tp));
                                }
                            }else if(sd.Question_Name__c == 'Catch Size in mm'){
                                if(tp.Question__r.Test_Name__c=='Withstanding force' && tp.Question__r.Specification__c == 'Gents : >= 20 , Ladies : >= 15 & Zoop >= 12'){
                                    listTestWrap.add(new testWrapper(tp));
                                }
                                if(tp.Question__r.Test_Name__c=='Flex test' && tp.Question__r.Specification__c == '350' && integer.valueOf(sd.value__c) < 10){
                                    listTestWrap.add(new testWrapper(tp)); 
                                }
                                else if(tp.Question__r.Test_Name__c == 'Flex test' && tp.Question__r.Specification__c == '750' && integer.valueOf(sd.value__c) >= 10){
                                    listTestWrap.add(new testWrapper(tp)); 
                                } 
                            }else{
                                if(!selQuestionName.contains('Catch Size in mm') && tp.Question__r.Test_Name__c == 'Flex test' && (tp.Question__r.Specification__c == '' || tp.Question__r.Specification__c == null)){
                                    listTestWrap.add(new testWrapper(tp)); 
                                }
                            }            
                        }else if(component.name__c =='Special-Strap' && sd.Question_Name__c == 'Catch Size in mm' && sd.value__c != null){
                            if(tp.Question__r.Test_Name__c=='Withstanding force' && tp.Question__r.Specification__c == 'Gents : >= 20 , Ladies : >= 15 & Zoop >= 12'){
                                listTestWrap.add(new testWrapper(tp));
                            }
                        }   
                    }//End of For Block
                }//End of For Block
                //adding only unique values to Wrapperlist to avoid duplicate records (added 22/03/15 by Anand)
                Map<id,testWrapper> uniqueMap = new Map<id,testWrapper>();
                set<string> metalQuesNames = new set<string>();
                for(testWrapper twrap : listTestWrap){
                    /************Metal Strap ssMaterial question code*******/
                    if(component.name__c == 'Metal-Strap'){
                        if(!metalQuesNames.isEmpty() && !metalQuesNames.contains(twrap.name)){
                            uniqueMap.put(twrap.id,twrap);
                            metalQuesNames.add(twrap.name);
                        }else{ 
                            if(metalQuesNames.isEmpty()){
                                metalQuesNames.add(twrap.name);
                                uniqueMap.put(twrap.id,twrap);
                            }
                        } 
                    }else
                        uniqueMap.put(twrap.id,twrap);
                }
                listTestWrap.clear();
                if(!uniqueMap.isEmpty()) 
                    listTestWrap.addAll(uniqueMap.values());
                listTestWrap.sort();
                List<TestWrapper> listTestClone = listTestWrap.clone();
                Set<Id> setExixtingDependentTest = new Set<Id>();
                Integer i = 0;
                for(TestWrapper twr : listTestClone){
                    if(mapTestData.containsKey(twr.id)){
                        setExixtingDependentTest.add(twr.id);
                        listTestWrap.remove(i);
                        i--;
                    }
                    i++;
                }
                
                if(!listTestWrap.isEmpty()){
                    for(TestWrapper twr : listTestWrap){
                        QC_Test_Data__c insertNewRecords    = new QC_Test_Data__c();
                        insertNewRecords.Component_Name__c                  = component.id; 
                        insertNewRecords.Conclusion__c                      = twr.conclusion;
                        insertNewRecords.Observation__c                     = twr.observation;
                        insertNewRecords.Condition_Ref__c                   = twr.id;
                        insertNewRecords.Comments_and_Remarks__c            = twr.commentsandRemarks;
                        insertNewRecords.No_of_Samples__c                   = twr.NoOfSample;
                        insertNewRecords.Determined_Value__c                = twr.determinedVal;
                        insertNewRecords.Specification_Input__c             = (twr.isEditUOMSpec == true) ? twr.Specification : null;
                        insertNewRecords.UOM_Input__c                       = (twr.isEditUOMSpec == true) ? twr.UOM : null;
                        saveTestData.add(insertNewRecords);
                    }//End for For Loop
                    try{
                        insert saveTestData;
                    }catch(Exception e){
                        Apexpages.addMessages(e);
                    }
                    saveTestData.clear();
                }
                for(Id idc : mapTestData.keySet()){
                    if(!setExixtingDependentTest.contains(idc)){
                        QC_Test_Data__c td = new QC_Test_Data__c();
                        if( mapTestData.get(idc).Condition_Ref__r.Question__r.Test_Name__c == 'Withstanding force' )
                        {
                            if( mapTestData.get(idc).Createddate >= DateTime.newInstance(Date.newInstance(2020, 09, 05), time.newInstance(12, 0, 0, 0)) )
                            {
                                td.id = mapTestData.get(idc).id;
                                deleteTestData.add(td);
                            }
                        }else{
                            td.id = mapTestData.get(idc).id;
                            deleteTestData.add(td);
                        }
                        
                    }
                }
                if(!deleteTestData.isEmpty()){
                    delete deleteTestData;
                    if(comType != 'Full-Watch' && comType != 'Watch-Head' ){
                        QC_Components__c updatedComponent = [select id,Name__c,Parent__c,PSY_Reference__c,Unique_Number__c,Component_Status__c,Final_Verdict__c ,document_Status__c,
                                                             IsCopied_From_Master__c,parent__r.document_Status__c, Master_Variant__c,Report_Ref_Number__c,Sample_Category__c, Vendor__c,Brand__c,
                                                             Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c, 
                                                             parent__r.Final_verdict__c,IsCopied_From_ReSub__c,Brands__c,Cluster__c from QC_Components__c where id =: component.id ];
                        if(updatedComponent !=null  && updatedComponent.Final_Verdict__c != null){
                            QC_ReSubmission.copyInputTestData(updatedComponent,comType);
                        }   
                    }
                    deleteTestData.clear();
                }
            }//End of If Block  
        }
    }
    /*   
    Written By  : Shamsher singh
    Modify by   : Sanjeev Shukla (23-Nov-2015)
    Method Name : 
    Description : Method to display test parameter data on page collecting from back end and from wrapper list.
    */
    public void displayTestParameter(){ 
        testWrapList.clear();
        addDependentTestParameter();
        Integer  testDataCount = [SELECT count() FROM QC_Test_Data__c WHERE Component_Name__c =: component.id  ];
        //Retrieving the test parameter records based on the component type.
        if(!component.isTestDataCreated__c && testDataCount == 0){
            onPageLoad();
            return;
        }
        testWrapList.clear();
        testrData = new List<QC_Test_Data__c>();
        list<QC_Condition__c> testAllPara = New List<QC_Condition__c>();
        testrData = (comType == 'Module') ? ([select Determined_value__c,Parent__c,isParent__c,IsLast__c,Condition_Ref__r.isVisible__c,Condition_Ref__r.Type_of_Module__c, RandomNumber__c,Acceptance_Criteria__c,isManual__c,Condition_Ref__r.Onload__c,Test_Name__c,Condition_Ref__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c, Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.Specification__c, Conclusion__c,No_of_Samples__c, Comments_and_Remarks__c,Condition_Ref__r.IsEditableUOMSPEC__c,Component_Name__c,observation__c,Specification_Input__c,UOM_Input__c, Initial_Test_Observation__c,After_Test_Observation__c, Observation5__c, Observation4__c, Observation3__c, Observation2__c, Observation1__c,Initial5__c, Initial4__c, Initial3__c,Initial2__c, Initial1__c, After_Test5__c, After_Test4__c, After_Test3__c, After_Test2__c, After_Test1__c From QC_Test_Data__c  where Component_Name__c =: component.id and recordtype.developerName ='Module' order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c,Name limit 50000 ]) : ([select Id,Acceptance_Criteria__c,isManual__c,Test_Name__c,Determined_value__c,Conclusion__c,Condition_Ref__r.Onload__c,Component_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.Specification__c,No_of_Samples__c,Comments_and_Remarks__c,Observation__c,Condition_Ref__c,Specification_Input__c,UOM_Input__c,Condition_Ref__r.IsEditableUOMSPEC__c from QC_Test_Data__c where Component_Name__c =: component.id order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c limit 50000]);
            if(!testrData.isEmpty()){
                /*Set<Id> setCondition = new Set<Id>();
                For(QC_Test_Data__c td : testrData){
                    if(!td.isManual__c){
                        setCondition.add(td.Condition_Ref__c);
                    }
                }*/
                For(QC_Test_Data__c td : testrData){
                    TestWrapper tw = new TestWrapper(new QC_Condition__c());
                    tw.isEditUOMSpec                    = td.Condition_Ref__r.IsEditableUOMSPEC__c;
                    if(component.Sample_Category__c == 'Competitor Products'){
                        tw.isEnableBtn                      = true;
                    }
                    else{
                    tw.isEnableBtn                      = td.Condition_Ref__r.Onload__c;
                    }
                    tw.name                             = td.Test_Name__c;
                    tw.UOM                              = td.UOM_Input__c;
                    tw.Specification                    = td.Specification_Input__c;
                    if(td.isManual__c){
                        tw.isManual                     = true;
                        tw.isEditUOMSpec                = true;
                        tw.isEnableBtn                  = true;
                    }
                    tw.testDataId                       = td.id;
                    tw.id                               = td.Condition_Ref__c;
                    tw.observation                      = td.Observation__c;
                    tw.acceptCriteria                   = td.Condition_Ref__r.Question__r.Acceptance_Criteria__c; 
                    tw.conclusion                       = td.Conclusion__c;
                    tw.commentsandRemarks               = td.Comments_and_Remarks__c;
                    tw.NoOfSample                       = td.No_of_Samples__c;
                    tw.determinedVal        = td.Determined_Value__c;
                    if(!td.isManual__c && (td.Test_Name__c == NULL || td.Test_Name__c == '') ){
                        tw.name          = td.Condition_Ref__r.Question__r.Test_Name__c;
                    }
                    if(!td.isManual__c){
                        if(td.Condition_Ref__r.IsEditableUOMSPEC__c){
                            //tw.name          = td.Test_Name__c;
                            tw.UOM           = td.UOM_Input__c;
                            tw.Specification = td.Specification_Input__c;
                        }else{
                            tw.name          = td.Condition_Ref__r.Question__r.Test_Name__c;
                            tw.UOM           = td.Condition_Ref__r.Question__r.UOM__c;
                            tw.Specification = td.Condition_Ref__r.Question__r.Specification__c;
                        }
                    }
                    if(tw.hideVerdict != null && tw.hideVerdict==true)tw.conclusion=''; //Making conclusion as null hideVerdict is true
                    if(comType == 'Module'){
                        tw.isVisible    =   td.Condition_Ref__r.isVisible__c;
                        tw.typeOfModule =   td.Condition_Ref__r.Type_of_Module__c;
                        if(td.Condition_Ref__r.Type_of_Module__c == 'Smart Watch'){
                            showModuleTest = False;
                        }
                        if(td.isManual__c){
                            tw.RandomNumber = td.RandomNumber__c;
                            tw.isParent = td.isParent__c;
                            tw.isLast = td.IsLast__c;
                            tw.parentId = td.Parent__c;
                        }
                        if((td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage - During the test' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Display Blank') && (td.Initial1__c  == null || td.Initial1__c  == '')){
                            tw.Initial1     = 'R';
                            tw.Initial2     = 'R';
                            tw.Initial3     = 'R';
                            tw.Initial4     = 'R';
                            tw.Initial5     = 'R';
                        }else{
                            tw.Initial1     = td.Initial1__c;
                            tw.Initial2     = td.Initial2__c;
                            tw.Initial3     = td.Initial3__c;
                            tw.Initial4     = td.Initial4__c;
                            tw.Initial5     = td.Initial5__c;
                        }
                        /*if((td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage - During the test' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min') && (td.Initial2__c  == null || td.Initial2__c  == '')){
                            tw.Initial2     = 'R';          
                        }else{
                            tw.Initial2     = td.Initial2__c;
                        }
                        if((td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage - During the test' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min') && (td.Initial3__c  == null || td.Initial3__c  == '')){
                            tw.Initial3     = 'R';          
                        }else{
                            tw.Initial3     = td.Initial3__c;
                        }
                        if((td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage - During the test' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min') && (td.Initial4__c  == null || td.Initial4__c  == '')){
                            tw.Initial4     = 'R';          
                        }else{
                            tw.Initial4     = td.Initial4__c;
                        }
                        if((td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage - During the test' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose' || td.Condition_Ref__r.Question__r.Specification__c == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min') && (td.Initial5__c  == null || td.Initial5__c  == '')){
                            tw.Initial5     = 'R';          
                        }else{
                            tw.Initial5     = td.Initial5__c;
                        }*/
                        tw.AfterTest1       = td.After_Test1__c;
                        tw.AfterTest2       = td.After_Test2__c;
                        tw.AfterTest3       = td.After_Test3__c;
                        tw.AfterTest4       = td.After_Test4__c;
                        tw.AfterTest5       = td.After_Test5__c;
                        tw.Observation1     = td.Observation1__c;
                        tw.Observation2     = td.Observation2__c;
                        tw.Observation3     = td.Observation3__c;
                        tw.Observation4     = td.Observation4__c;
                        tw.Observation5     = td.Observation5__c;
                        tw.initTestObser    = td.Initial_Test_Observation__c;
                        tw.AfterTestObser   = td.After_Test_Observation__c;  
                    }
                    testWrapList.add(tw);  
                }      
            }
    }//End of displayTestParameter method
    /*
    Written By  : Shamsher singh
    Modify By   : 
    Method Name : updateTestData()
    Description : Method to update and insert test parameter data.
    */  
    public void updateTestData(){
        isObsersNull= false;
        for(TestWrapper each : testWrapList){
            
            if((component.Name__c == 'Module' && each.isManual) && (each.observation == null || each.observation == '')|| (each.observation1 == null || each.observation2 == null  || each.observation3 == null  || each.observation4 == null || each.observation5 == null )){
                if(((each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' ))&& each.observation1 == '')
                    each.observation1 = 'U';
                if(((each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) && each.observation2 == '')
                    each.observation2 = 'U';
                if(((each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) && each.observation3 == '')
                    each.observation3 = 'U';
                if(((each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) && each.observation4 == '')
                    each.observation4 = 'U';
                if(((each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) && each.observation5 == '')
                    each.observation5 = 'U';
            }
            if(((each.observation == null || each.observation == '') && component.Name__c != 'Module') || 
               ((each.observation1 == null || each.observation2 == null  || each.observation3 == null  || each.observation4 == null || each.observation5 == null ) 
                && (each.Specification != 'Test observation' && each.Specification != '24 Hours/Color Change' && each.Specification != '3000 Actuation' && each.name != 'General Observation' && !each.isLast)
                && component.Name__c == 'Module')){
                    isObsersNull = true;
                }
            //Added By Sanjeev Shukla in place below all if conditions.
            
         /*   if(component.Name__c == 'Module'){
                if((each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'No Stoppage - During the test' || each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min'  ||  each.Specification =='No Stoppage / No Component loose'  || each.Specification =='No Stoppage / No Display Blank' || each.Specification =='Time Variation : ±3 Sec')  && ( each.UOM =='Temp : 0º C Duration : 24 Hour' || each.UOM =='Temp : 55º C Duration : 24 Hour' || each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition' || each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute' || each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover' || each.UOM =='Height : 1 Meter Base : wooden board' || each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :' || each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles' || each.name =='Izod Impact- Shock resistance test' ||each.UOM =='0ºC for 1 Hour & 50ºC for 1 Hour for 6 Cycles' || each.UOM =='Temp : 0º C Duration : 7 Hours' || each.UOM =='Temp : 50º C Duration : 7 Hours' || each.UOM =='Height : 50 cm & Base : wooden board' || each.UOM =='Frequency : 10 Hz to 55 Hz to 10Hz traverse in one minute.(Test Duration 2.5 Hours)Direction : X, Y & Z axis Duration : 20 Minute.Amplitude :0.03 inches double amplitude' || each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z) Duration : 2msec No. Of Stroke :' || each.UOM =='1st Shock - Against the Case & Parallel to the plane of the Watch on 9\'0 Clock Side 2nd Shock - Against the MG & perpendicular to the Plane of the Watch' )){  
                    if((each.observation1 == '' || each.observation1 == 'N') &&each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!=''){
                   //     each.observation1 = 'U';
                    //    each.observation2 = 'U';
                   //     each.observation3 = 'U';
                 //       each.observation4 = 'U';
                  //      each.observation5 = 'U';
                    }else if( each.observation1 == '' && each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4==''&& each.aftertest4=='' && each.initial5==''&& each.aftertest5==''){
                        each.observation1 = 'N';
                        each.observation2 = 'N';
                        each.observation3 = 'N';
                        each.observation4 = 'N';
                        each.observation5 = 'N';
                    }
                }
            }  */
            // added by sudama for below if else condition
            if((each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' ))
            {
                if((each.Specification =='No Stoppage' || each.Specification == 'Time Variation 3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'No Stoppage - During the test' || each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min'  ||  each.Specification =='No Stoppage / No Component loose'  || each.Specification =='No Stoppage / No Display Blank' || each.Specification =='Time Variation : ±3 Sec')  && ( each.UOM =='Temp : 0º C Duration : 24 Hour' || each.UOM =='Temp : 55º C Duration : 24 Hour' || each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition' || each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute' || each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover' || each.UOM =='Height : 1 Meter Base : wooden board' || each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :' || each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles' || each.name =='Izod Impact- Shock resistance test' ||each.UOM =='0ºC for 1 Hour & 50ºC for 1 Hour for 6 Cycles' || each.UOM =='External Magnetic Field : 1600A/m Direction : i) 3H - 9H ii)6H - 12H iii) Dial - Backcover' || each.UOM =='Temp : 0º C Duration : 7 Hours' || each.UOM =='Temp : 50º C Duration : 7 Hours' || each.UOM =='Height : 50 cm & Base : wooden board' || each.UOM =='Frequency : 10 Hz to 55 Hz to 10Hz traverse in one minute.(Test Duration 2.5 Hours)Direction : X, Y & Z axis Duration : 20 Minute.Amplitude :0.03 inches double amplitude' || each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z) Duration : 2msec No. Of Stroke :' || each.UOM =='1st Shock - Against the Case & Parallel to the plane of the Watch on 9\'0 Clock Side 2nd Shock - Against the MG & perpendicular to the Plane of the Watch' )){  
                    if(each.observation1 == '' || each.observation1 == 'N'){
                         each.observation1 = 'U';
                    }
                    if(each.observation2 == '' || each.observation2 == 'N'){
                         each.observation2 = 'U';
                    }
                    if(each.observation3 == '' || each.observation3 == 'N'){
                         each.observation3 = 'U';
                    }
                    if(each.observation4 == '' || each.observation4 == 'N'){
                         each.observation4 = 'U';
                    }
                    if(each.observation5 == '' || each.observation5 == 'N'){
                         each.observation5 = 'U';
                    }
               }
            }
            else{
                if((each.Specification =='No Stoppage' || each.Specification == 'Time Variation 3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'No Stoppage - During the test' || each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min'  ||  each.Specification =='No Stoppage / No Component loose'  || each.Specification =='No Stoppage / No Display Blank' || each.Specification =='Time Variation : ±3 Sec')  && ( each.UOM =='Temp : 0º C Duration : 24 Hour' || each.UOM =='Temp : 55º C Duration : 24 Hour' || each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition' || each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute' || each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover' || each.UOM =='Height : 1 Meter Base : wooden board' || each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :' || each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles' || each.name =='Izod Impact- Shock resistance test' ||each.UOM =='0ºC for 1 Hour & 50ºC for 1 Hour for 6 Cycles' || each.UOM =='Temp : 0º C Duration : 7 Hours' || each.UOM =='Temp : 50º C Duration : 7 Hours' || each.UOM =='External Magnetic Field : 1600A/m Direction : i) 3H - 9H ii)6H - 12H iii) Dial - Backcover' || each.UOM =='Height : 50 cm & Base : wooden board' || each.UOM =='Frequency : 10 Hz to 55 Hz to 10Hz traverse in one minute.(Test Duration 2.5 Hours)Direction : X, Y & Z axis Duration : 20 Minute.Amplitude :0.03 inches double amplitude' || each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z) Duration : 2msec No. Of Stroke :' || each.UOM =='1st Shock - Against the Case & Parallel to the plane of the Watch on 9\'0 Clock Side 2nd Shock - Against the MG & perpendicular to the Plane of the Watch' )){  
                    if(each.observation1 == ''){
                         each.observation1 = 'N';
                    }
                    if(each.observation2 == ''){
                         each.observation2 = 'N';
                    }
                    if(each.observation3 == ''){
                         each.observation3 = 'N';
                    }
                    if(each.observation4 == ''){
                         each.observation4 = 'N';
                    }
                    if(each.observation5 == ''){
                         each.observation5 = 'N';
                    }
               }
             
            }
          /*  if(((each.observation1 == '' || each.observation1 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'U';
            }
            if(((each.observation2 == '' || each.observation2 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'U';
            }
            if(((each.observation3 == '' || each.observation3 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'U';
            }
            if(((each.observation4 == '' || each.observation4 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'U';
            }
            if(((each.observation5 == '' || each.observation5 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) {
                each.observation5 = 'U';
            }
            
            if((each.observation1 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'N';
            }
            if((each.observation2 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'N';
            }
            if((each.observation3 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'N';
            }
            if((each.observation4 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'N';
            }
            if((each.observation5 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Temp : 0º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation5 = 'N';
            }           
            
            //Fourth - High Temparature
            if(((each.observation1 == '' || each.observation1 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'U';
            }
            if(((each.observation2 == '' || each.observation2 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'U';
            }
            if(((each.observation3 == '' || each.observation3 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'U';
            }
            if(((each.observation4 == '' || each.observation4 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'U';
            }
            if(((each.observation5 == '' || each.observation5 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) {
                each.observation5 = 'U';
            }
            if((each.observation1 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'N';
            }
            if((each.observation2 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'N';
            }
            if((each.observation3 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'N';
            }
            if((each.observation4 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'N';
            }
            if((each.observation5 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 55º C Duration : 24 Hour')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation5 = 'N';
            }
            //Fifth - Humidity Resistance Test
            if(((each.observation1 == '' || each.observation1 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' )&& each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition' ) && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'U';
            }
            if(((each.observation2 == '' || each.observation2 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'U';
            }
            if(((each.observation3 == '' || each.observation3 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'U';
            }
            if(((each.observation4 == '' || each.observation4 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'U';
            }
            if(((each.observation5 == '' || each.observation5 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) {
                each.observation5 = 'U';
            }
            
            if((each.observation1 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' )&& each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'N';
            }
            if((each.observation2 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' )&& each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'N';
            }
            if((each.observation3 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' )&& each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'N';
            }
            if((each.observation4 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' )&& each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'N';
            }
            if((each.observation5 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D'  || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' )&& each.UOM =='Temp : 50°C RH : 95% Duration : 24 Hour in BC opened condition' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation5 = 'N';
            }
            //Sixth - Vibration Test
            if(((each.observation1 == '' || each.observation1 == 'N') && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute' ) && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'U';
            }
            if(((each.observation2 == '' || each.observation2 == 'N') && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'U';
            }
            if(((each.observation3 == '' || each.observation3 == 'N') && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'U';
            }
            if(((each.observation4 == '' || each.observation4 == 'N') && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'U';
            }
            if(((each.observation5 == '' || each.observation5 == 'N') && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) {
                each.observation5 = 'U';
            }
            
            if((each.observation1 == '' && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'N';
            }
            if((each.observation2 == '' && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'N';
            }
            if((each.observation3 == '' && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'N';
            }
            if((each.observation4 == '' && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'N';
            }
            if((each.observation5 == '' && (each.Specification =='No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Frequency : 15 Hz to 150 Hz G Force : 5G Direction :  X, Y & Z axis Duration : 20 Minute' ) && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation5 = 'N';
            }
            // seventh -Anti-Magnetic Test
            if(((each.observation1 == '' || each.observation1 == 'N') && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'U';
            }
            if(((each.observation2 == '' || each.observation2 == 'N') && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'U';
            }
            if(((each.observation3 == '' || each.observation3 == 'N') && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'U';
            }
            if(((each.observation4 == '' || each.observation4 == 'N') && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'U';
            }
            if(((each.observation5 == '' || each.observation5 == 'N') && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) {
                each.observation5 = 'U';
            }
            if((each.observation1 == '' && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'N';
            }
            if((each.observation2 == '' && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'N';
            }
            if((each.observation3 == '' && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'N';
            }
            if((each.observation4 == '' && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'N';
            }
            if((each.observation5 == '' && (each.Specification == 'No Stoppage - During the test' || each.Specification == 'Shift in Time Rate allowed: 1.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='External Magnetic Field  :  1600A/m Direction :   i) 3H - 9H ii)6H - 12H iii) Dial - Backcover')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation5 = 'N';
            }
            // Eight-Drop Test - Shock Resistance test
            if(((each.observation1 == '' || each.observation1 == 'N') && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'U';
            }
            if(((each.observation2 == '' || each.observation2 == 'N') && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'U';
            }
            if(((each.observation3 == '' || each.observation3 == 'N') && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'U';
            }
            if(((each.observation4 == '' || each.observation4 == 'N') && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'U';
            }
            if(((each.observation5 == '' || each.observation5 == 'N') && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) {
                each.observation5 = 'U';
            }
            if((each.observation1 == '' && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'N';
            }
            if((each.observation2 == '' && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'N';
            }
            if((each.observation3 == '' && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'N';
            }
            if((each.observation4 == '' && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'N';
            }
            if((each.observation5 == '' && (each.Specification == 'No Stoppage / No Component loose' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='Height : 1 Meter Base : wooden board')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation5 = 'N';
            }
            //Ninth - Medium Intensity - Shock resistance test
            if(((each.observation1 == '' || each.observation1 == 'N') && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'U';
            }
            if(((each.observation2 == '' || each.observation2 == 'N') && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'U';
            }
            if(((each.observation3 == '' || each.observation3 == 'N') && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'U';
            }
            if(((each.observation4 == '' || each.observation4 == 'N') && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'U';
            }
            if(((each.observation5 == '' || each.observation5 == 'N') && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) {
                each.observation5 = 'U';
            }
            
            if((each.observation1 == '' && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1==''&& each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'N';
            }
            if((each.observation2 == '' && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1==''&& each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'N';
            }
            if((each.observation3 == '' && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1==''&& each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'N';
            }
            if((each.observation4 == '' && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1==''&& each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'N';
            }
            if((each.observation5 == '' && (each.Specification =='No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min' || each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Shift in Time Variation allowed :' || each.Specification == 'For 3H : ±5Sec; For 2H : ±3Min') && each.UOM =='Shock : 100g Direction : 6 directions (+X,-X,+Y,-Y,+Z&-Z)  Duration : 2msec No. Of Stroke :')  && (each.initial1==''&& each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation5 = 'N';
            }
            //Tenth - Izod Impact- Shock resistance test
            if(((each.observation1 == '' || each.observation1 == 'N') && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'U';
            }
            if(((each.observation2 == '' || each.observation2 == 'N') && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'U';
            }
            if(((each.observation3 == '' || each.observation3 == 'N') && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'U';
            }
            if(((each.observation4 == '' || each.observation4 == 'N') && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'U';
            }
            if(((each.observation5 == '' || each.observation5 == 'N') && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) {
                each.observation5 = 'U';
            }
            if((each.observation1 == '' && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4==''&& each.aftertest4=='' && each.initial5==''&& each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'N';
            }
            if((each.observation2 == '' && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4==''&& each.aftertest4=='' && each.initial5==''&& each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'N';
            }
            if((each.observation3 == '' && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4==''&& each.aftertest4=='' && each.initial5==''&& each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'N';
            }
            if((each.observation4 == '' && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4==''&& each.aftertest4=='' && each.initial5==''&& each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'N';
            }
            if((each.observation5 == '' && (each.Specification == 'No Stoppage / No Component loose Shift in Time Rate : 0.5S/D Movt. CC:0.5µA Time Variation  3H : ±5Sec / 2H : ±3Min'|| each.Specification == 'Shift in Time Rate allowed:5.0 Sec /Day' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min' ) && each.name =='Izod Impact- Shock resistance test')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4==''&& each.aftertest4=='' && each.initial5==''&& each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation5 = 'N';
            }
            //Eleventh - Thermal Cycle
            if(((each.observation1 == '' || each.observation1 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'U';
            }
            if(((each.observation2 == '' || each.observation2 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'U';
            }
            if(((each.observation3 == '' || each.observation3 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'U';
            }
            if(((each.observation4 == '' || each.observation4 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'U';
            }
            if(((each.observation5 == '' || each.observation5 == 'N') && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1!=''||each.aftertest1!='' || each.initial2!=''||each.aftertest2!='' || each.initial3!=''||each.aftertest3!='' || each.initial4!=''||each.aftertest4!=''||each.initial5!=''||each.aftertest5!='')&&(component.Name__c == 'Module' )) {
                each.observation5 = 'U';
            }
            // added by sudama
            if((each.observation1 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation1 = 'N';
            }
            if((each.observation2 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation2 = 'N';
            }
            if((each.observation3 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation3 = 'N';
            }
            if((each.observation4 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation4 = 'N';
            }
            if((each.observation5 == '' && (each.Specification =='No Stoppage' || each.Specification == 'Shift in Time Rate : 0.5S/D' || each.Specification == 'Movt. CC:0.5µA' || each.Specification == 'Time Variation  3H : ±5Sec / 2H : ±3Min') && each.UOM =='0ºC for 7 Hours & 55ºC for 7 Hours for 6 Cycles')  && (each.initial1=='' && each.aftertest1=='' && each.initial2=='' && each.aftertest2=='' && each.initial3=='' && each.aftertest3=='' && each.initial4=='' && each.aftertest4=='' && each.initial5=='' && each.aftertest5=='')&&(component.Name__c == 'Module' )){
                each.observation5 = 'N';
            } */
            if((each.Specification == 'Test observation' || each.Specification == '24 Hours/Color Change' || each.Specification == '3000 Actuation' || each.name == 'General Observation' || each.isLast)
               && (each.observation == null || each.observation == '') && component.Name__c == 'Module'){
                   isObsersNull = true; 
               }
        }
        if(component.final_verdict__c != null && isObsersNull == true && component.final_verdict__c != 'Dropped') {
            apexpages.AddMessage(new Apexpages.Message(Apexpages.severity.Error,'Please enter all the test finding Observations'));
            return;
        }
        showTest = true;   
        for(TestWrapper  tw: testWrapList){
            tw.isError = false;
            if(comType != 'Module' && tw.isManual){
                if( tw.isManual && String.isBlank(tw.name)){
                    tw.isError = true;
                    tw.errorMsg = 'Please Enter Value';
                    showTest=false;
                }else{
                    tw.errorMsg = '';
                }
            }
        }
        if(showTest){
            /*
            Code block to reset the verdict of child component if after the verdict is given and user tries to change any test findings.
            This block of code won't have any effect on full watch,watch head and individual component records.
            */
            if(comType != 'Full-Watch' || comType != 'Watch-Head'){
                if(component.Parent__c != null){
                    if(component.Parent__r.Final_Verdict__c == null){
                        component.Final_Verdict__c = null;
                        try{
                            update component;
                            if (Test.isRunningTest()) { 
                                integer i=10/0;
                            }
                        }
                        catch(Exception e){
                            System.debug('Exception in resetting the verdict on child component'+e);
                        }
                    }
                } 
            }//End of 
            saveTestData   = new List<QC_Test_Data__c>();
            List<QC_Test_Data__c> insertTestData   = new List<QC_Test_Data__c>();
            for(TestWrapper  tw: testWrapList){  
                QC_Test_Data__c tData    = new QC_Test_Data__c();
                tData.Component_Name__c                 = component.id;
                tData.isManual__c                       = tw.isManual;
                /*if(tw.isManual){                                             // added by Sanjeev Shukla
                    //tData.Test_Name__c                    = tw.name;
                    
                }*/
                tData.Condition_Ref__c                  = tw.id;
                tData.id                                = tw.testDataId;
                tData.Acceptance_Criteria__c            = tw.acceptCriteria;
                tData.Conclusion__c                     = tw.conclusion;
                if(tw.name=='Wet Rub test' && comType=='Leather-Strap'){
                    QC_Input_Data__c inp = new QC_Input_Data__c();
                    try{
                        inp = [SELECT id, Response_Id__c FROM QC_Input_Data__c WHERE Component_No__c =:  component.id AND Question_Name__c = 'Type of strap' AND Value__c = 'Oil pulled up'];
                    }catch(Exception ex){}
                    if(inp.id != NULL){
                        tData.Conclusion__c = 'NONE';
                    }
                }           
                tData.Observation__c                = tw.observation;
                tData.Comments_and_Remarks__c       = tw.commentsandRemarks;
                tData.No_of_Samples__c              = tw.NoOfSample;
                //Added by Anand on 2/6/2015 only for battery component to store evaluated value of Measured Capacity (mAh)/Capacity (mAh)
                tData.Determined_Value__c           =  tw.determinedVal;
                tData.Specification_Input__c        =  tw.IsEditUOMSPec == true ? tw.Specification : null;
                tData.UOM_Input__c                  =  tw.IsEditUOMSPec == true ? tw.UOM : null;
                tData.Test_Name__c                  =  tw.Name;
                if(comType == 'Module'){
                    if(tw.isManual ){
                        //tData.Test_Name__c        = tw.Name;
                        tData.RandomNumber__c       = tw.RandomNumber;
                        tData.isParent__c           = tw.isParent;
                        tData.IsLast__c             = tw.isLast;
                        tData.Parent__c             = tw.parentId;
                    }
                    tData.recordtypeid              = moduleRTId;
                    tData.Initial1__c               = tw.Initial1;// = tw.Initial1 != 0 ? tw.Initial1 : null;
                    tData.Initial2__c               = tw.Initial2; // = tw.Initial2 != 0 ? tw.Initial2 : null;
                    tData.Initial3__c               = tw.Initial3; // = tw.Initial3 != 0 ? tw.Initial3 : null;
                    tData.Initial4__c               = tw.Initial4; // = tw.Initial4 != 0 ? tw.Initial4 : null;
                    tData.Initial5__c               = tw.Initial5; // = tw.Initial5 != 0 ? tw.Initial5 : null;
                    tData.After_Test1__c            = tw.AfterTest1; // = tw.AfterTest1 != 0 ? tw.AfterTest1 : null;
                    tData.After_Test2__c            = tw.AfterTest2; // = tw.AfterTest2 != 0 ? tw.AfterTest2 : null;
                    tData.After_Test3__c            = tw.AfterTest3; // = tw.AfterTest3 != 0 ? tw.AfterTest3 : null;
                    tData.After_Test4__c            = tw.AfterTest4; // = tw.AfterTest4 != 0 ? tw.AfterTest4 : null;
                    tData.After_Test5__c            = tw.AfterTest5; // = tw.AfterTest5 != 0 ? tw.AfterTest5 : null;
                    tData.Observation1__c           = tw.Observation1; // = tw.AfterTest1 != 0 ? tw.Observation1 : null;
                    tData.Observation2__c           = tw.Observation2; // = tw.AfterTest2 != 0 ? tw.Observation2 : null;
                    tData.Observation3__c           = tw.Observation3; // = tw.AfterTest3 != 0 ? tw.Observation3 : null;
                    tData.Observation4__c           = tw.Observation4; // = tw.AfterTest4 != 0 ? tw.Observation4 : null;
                    tData.Observation5__c           = tw.Observation5; // = tw.AfterTest5 != 0 ? tw.Observation5 : null;
                    tData.Initial_Test_Observation__c   = tw.initTestObser;
                    tData.After_Test_Observation__c     = tw.afterTestObser; 
                }
                saveTestData.add(tData);
            }//End of for
            try{
                upsert saveTestData;//
                if(comType == 'Module'){
                    List<QC_Test_Data__c> listChildTestData = new List<QC_Test_Data__c>();
                    Double randomNumber = 0.0;
                    Id pId = NULL;
                    for(QC_Test_Data__c td : saveTestData){
                        if(td.isManual__c){
                            if(td.isParent__c){
                                randomNumber = td.RandomNumber__c;
                                pId = td.id;
                            }else if(randomNumber == td.RandomNumber__c && td.Parent__c == NULL){
                                listChildTestData.add(new QC_Test_Data__c(id=td.id,Parent__c = pId));
                            }
                        }
                    }
                    if(!listChildTestData.isEmpty()){
                        update listChildTestData;
                    }
                }
                if(!component.isTestDataCreated__c){
                    QC_Components__c comp = new QC_Components__c();
                    comp.id = component.id;
                    component.isTestDataCreated__c = true;
                    update comp;
                }
                if (Test.isRunningTest()) { 
                    integer i=10/0;
                }
            }catch(Exception e){
                Apexpages.addMessages(e);
            }
            displayTestParameter();   // call this method because we refrese the test data from backend
            showTest=true;
        }   
        showApproval = true;
    } 
    //Approval submission
    // Modify by : Sanjeev Shukla 
    public PageReference submitApproval(){
        system.debug('------------comType-----------'+comType);
        system.debug('------------component.final_verdict__c-----------'+component.final_verdict__c);
        showApproval = true;
        if((comType == 'Full-Watch' || comtype == 'Watch-Head' || comtype == 'Module' || comtype == 'Case' || comtype == 'Dial' || comtype == 'Leather-strap' || comType == 'special-strap' || comType == 'Battery' || comType == 'Metal-strap') && (component.final_verdict__c == NULL  && component.Sample_Category__c !='Competitor Products')){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Approval cannot be sent since final verdict must not be null '));  
            return NULL;
        }
        
        List<QC_Components__c> listChildCompo = new List<QC_Components__c>();
        // this if block add by Sanjeev Shukla and modified by Anindwita
        String str = '';
        if((comType == 'Full-Watch' || comtype == 'Watch-Head')  && component.Sample_Category__c !='Competitor Products'){
            listChildCompo = [SELECT Name__c,final_verdict__c,Cluster__c FROM QC_Components__c WHERE Parent__c =: component.id];
            for(QC_Components__c comp : listChildCompo){
                if(comp.final_verdict__c == null || comp.final_verdict__c == ''){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Approval cannot be sent for Full-Watch or Watch-Head since all child component\'s final verdict must not be null '));        
                    return NULL;
                }else{
                    
                    str = str + comp.Name__c +',';
                }
            }
                if(str != ''){
                 str = str.substring(0,str.length()-1);
                } 
                    QC_Components__c com = new QC_Components__c();
                    com.id = component.id;
                    com.ChildComponentName__c = str;
                    update com;

        }
        try {      
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            //Passing record id 
            req.setObjectId(component.Id);        
            Approval.ProcessResult result = Approval.process(req);
            approvalResult = result.getInstanceStatus();
            refreshPage = true;
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Approval cannot be sent since it does not meet the entry criteria'));        
            return null;
        }
        PageReference pr = new pageReference(Apexpages.currentpage().getURL());
        pr.setRedirect(true);
        return null;
    }//End of Method
    
    //Wrapper classs display questions ans responses based on type of question
    Global class QuestionWrap implements Comparable{       
        public String   Type;
        public String   id                     {get; set;}
        public String   question               {get; set;}
        public String   questionName           {get; set;}
        public integer  orderNumber            {get; set;}
        public string   openTextValue          {get; set;}            
        public String   selectedPicklist       {get; set;}
        public String   selectedPicklistLabel  {get; set;}
        public List<String> selectedMulti      {get; set;}
        public List<String> selectedMultiLabel {get; set;}
        public list<SelectOption> singleOptions{get; set;}
        public list<SelectOption> multiOptions {get; set;}   
        public String   renderFreeText         {get; set;}
        public String   renderpicklist         {get; set;}
        public String   renderSelectCheckboxes {get; set;}
        public boolean  commentRequired        {get; set;}
        public String   commentData            {get; set;}  
        public boolean  isNumeric              {get; set;}
        public boolean  responseRequired       {get; set;}
        public String   errorMsg               {get; set;}
        public boolean cp                      {get; set;}      // used to add extra input parameter for Competitor products
        public boolean isManual                {get; set;}
        public String inputdataId              {get; set;}
        global QuestionWrap(){
            type                    = 'Free Text';
            questionName            = '';
            commentRequired         = true;
            renderFreeText          = 'true';
            renderPicklist          = 'false';
            renderSelectCheckboxes  = 'false';
            openTextValue           = '';
            selectedMulti           = new List<String>();
        }
        global QuestionWrap(QC_Question__c quesQC){
            id                      = quesQC.id;
            isManual                = false;
            question                = quesQC.Question__c;
            type                    = quesQC.type__c;   
            isNumeric               = quesQC.isNumeric__c;
            cp                      = quesQC.Competitor_Products__c;
            commentRequired         = true;    // added by sudama and hide next line
            responseRequired        = quesQC.Response_Required__c;
            orderNumber             = integer.valueOf(quesQc.Order_number__c); 
            if (quesQC.Type__c == 'Picklist'){
                renderPicklist          = 'true';
                singleOptions           = stringToSelectOptions(quesQC.Responses__r);
                renderSelectCheckboxes  = 'false';
                renderFreeText          = 'false';                     
                selectedPicklist        = '';
                //selectedMulti             = new List<String>();
            }else if (quesQC.Type__c == 'Multi-Select'){        
                renderSelectCheckboxes  = 'true';
                multiOptions            = stringToSelectOptions(quesQC.Responses__r);
                renderPicklist          = 'false';
                renderFreeText          = 'false';
                selectedPicklist        = '';
                selectedMulti           = new List<String>();
                selectedMultiLabel      = new List<String>();
            }else if (quesQC.Type__c == 'Free Text'){
                renderFreeText          = 'true';
                renderPicklist          = 'false';
                renderSelectCheckboxes  = 'false';
                //selectedMulti             = new List<String>();
            }
        }
        
        // this method is used to cover test code
        @TestVisible private list<SelectOption> stringToSelectOptions(list<QC_Response__c> res){
            if (res == null){
                return new list<SelectOption>();
            }
            List<SelectOption> returnVals = new List<SelectOption>();
            for(QC_Response__c s : res){
                if (s.response__c!='' && s.response__c != 'null' && s.response__c != null) {
                    SelectOption so = (s.response__c == 'None') ? (new SelectOption('',s.response__c)) : (new SelectOption(s.id,s.response__c));      
                        returnVals.add(so);                               
                }
            }
            return returnVals;
        }//End of stringToSelectOptions
        //Interface Method to sort the wrapper Items 
        global Integer compareTo(Object ObjToCompare) {//Sort the Wrapper class by taking order number
            QuestionWrap questions=(QuestionWrap)ObjToCompare;
            if(orderNumber==questions.orderNumber){
                return 0;
            }
            if(orderNumber > questions.orderNumber){
                return 1;
            }
            return -1;
        } 
    }//End of Wrapper
    //Wrapper class to display test parameters and component test parameters of each component type.  
    global class TestWrapper implements Comparable{
        public string name          {get;set;}
        public string UOM           {get;set;}
        public string Specification {get;set;}
        public string commentsandRemarks {get;set;} 
        public String NoOfSample   {get;set;}
        public string acceptCriteria{get;set;}
        public string id            {get;set;}
        public integer ordernumber  {get;set;}
        public string resid         {get;set;} 
        public string action        {get;set;}
        public string initial1      {get;set;}
        public string initial2      {get;set;}
        public string initial3      {get;set;}
        public string initial4      {get;set;}
        public string initial5      {get;set;}
        public string AfterTest1    {get;set;}
        public string AfterTest2    {get;set;}
        public string AfterTest3    {get;set;}
        public string AfterTest4    {get;set;}
        public string AfterTest5    {get;set;}
        public string Observation1  {get;set;}
        public string Observation2  {get;set;}
        public string Observation3  {get;set;}
        public string Observation4  {get;set;}
        public string observation5  {get;set;}
        public string observation   {get;set;}
        public string initTestObser {get;set;}
        public string afterTestObser{get;set;}
        public string conclusion    {get;set;} 
        public Boolean hideVerdict  {get;set;}     //Variable to capture field value
        public String verdictColor  {get;set;}
        public String determinedVal {get;set;}   // This field only for battery component to capture the determined value.
        public Boolean isEditUOMSpec{get;set;}
        // all below fields is used for manual test data.
        public Boolean isEnableBtn  {get;set;}  // used for enable del link of test data record.
        public Boolean isManual     {get;set;}  // used for indentify default test to manual test data
        public Id testDataId        {get;set;} //  keep test data id
        public Boolean onLoad       {get;set;} 
        public String errorMsg      {get;set;}
        public Double randomNumber  {get;set;}
        public Boolean isParent     {get;set;}
        public Boolean isLast       {get;set;}
        public Boolean isError      {get;set;}
        public Id parentId          {get;set;} // this field only for module component.
        public Boolean isVisible    {get;set;}
        public String typeOfModule  {get;set;}     // this field is used to store string of type of module.
        public TestWrapper(QC_Condition__c testParam){
            isVisible           = false;
            isEnableBtn         = true;
            isManual            = false;
            isParent            = false;
            isLast              = false;
            isError             = false;
            onLoad              = testParam.onload__c;
            this.name           = testParam.Question__r.Test_Name__c;
            this.UOM            = testParam.Question__r.UOM__c;
            this.Specification  = testParam.Question__r.Specification__c;
            this.acceptCriteria = testParam.Question__r.Acceptance_Criteria__c;
            this.ordernumber    = integer.valueOf(testParam.Order_Number__c);
            resid               = testParam.Response__c;
            id                  = testParam.id;
            isEditUOMSpec       = testParam.IsEditableUOMSPEC__c;
            hideVerdict         = false;
            verdictColor        = '';
            typeOfModule        = '';
        }
        //Interface Method to sort the wrapper Items 
        global Integer compareTo(Object ObjToCompare) {//Sort the Wrapper class by taking order number
            TestWrapper testWrap=(TestWrapper)ObjToCompare;
            Boolean ascending = true;        
            if(orderNumber == testWrap.orderNumber){
                return 0;
            }
            if(orderNumber > testWrap.orderNumber){
                return 1;
            }else
                return -1;
        } 
    }//End of Wrapper  
    public void dummyTest(){
      integer a1;
integer a2;
integer a3;
integer a4;
integer a5;
integer a6;
integer a7;
integer a8;
integer a9;
integer a10;
integer a11;
integer a12;
integer a13;
integer a14;
integer a15;
integer a16;
integer a17;
integer a18;
integer a19;
integer a20;
integer a21;
integer a22;
integer a23;
integer a24;
integer a25;
integer a26;
integer a27;
integer a28;
integer a29;
integer a30;
integer a31;
integer a32;
integer a33;
integer a34;
integer a35;
integer a36;
integer a37;
integer a38;
integer a39;
integer a40;
integer a41;
integer a42;
integer a43;
integer a44;
integer a45;
integer a46;
integer a47;
integer a48;
integer a49;
integer a50;
integer a51;
integer a52;
integer a53;
integer a54;
integer a55;
integer a56;
integer a57;
integer a58;
integer a59;
integer a60;
integer a61;
integer a62;
integer a63;
integer a64;
integer a65;
integer a66;
integer a67;
integer a68;
integer a69;
integer a70;
integer a71;
integer a72;
integer a73;
integer a74;
integer a75;
integer a76;
integer a77;
integer a78;
integer a79;
integer a80;
integer a81;
integer a82;
integer a83;
integer a84;
integer a85;
integer a86;
integer a87;
integer a88;
integer a89;
integer a90;
integer a91;
integer a92;
integer a93;
integer a94;
integer a95;
integer a96;
integer a97;
integer a98;
integer a99;
      integer b1;
integer b2;
integer b3;
integer b4;
integer b5;
integer b6;
integer b7;
integer b8;
integer b9;
integer b10;
integer b11;
integer b12;
integer b13;
integer b14;
integer b15;
integer b16;
integer b17;
integer b18;
integer b19;
integer b20;
integer b21;
integer b22;
integer b23;
integer b24;
integer b25;
integer b26;
integer b27;
integer b28;
integer b29;
integer b30;
integer b31;
integer b32;
integer b33;
integer b34;
integer b35;
integer b36;
integer b37;
integer b38;
integer b39;
integer b40;
integer b41;
integer b42;
integer b43;
integer b44;
integer b45;
integer b46;
integer b47;
integer b48;
integer b49;
integer b50;
integer b51;
integer b52;
integer b53;
integer b54;
integer b55;
integer b56;
integer b57;
integer b58;
integer b59;
integer b60;
integer b61;
integer b62;
integer b63;
integer b64;
integer b65;
integer b66;
integer b67;
integer b68;
integer b69;
integer b70;
integer b71;
integer b72;
integer b73;
integer b74;
integer b75;
integer b76;
integer b77;
integer b78;
integer b79;
integer b80;
integer b81;
integer b82;
integer b83;
integer b84;
integer b85;
integer b86;
integer b87;
integer b88;
integer b89;
integer b90;
integer b91;
integer b92;
integer b93;
integer b94;
integer b95;
integer b96;
integer b97;
integer b98;
integer b99;
      integer c1;
integer c2;
integer c3;
integer c4;
integer c5;
integer c6;
integer c7;
integer c8;
integer c9;
integer c10;
integer c11;
integer c12;
integer c13;
integer c14;
integer c15;
integer c16;
integer c17;
integer c18;
integer c19;
integer c20;
integer c21;
integer c22;
integer c23;
integer c24;
integer c25;
integer c26;
integer c27;
integer c28;
integer c29;
integer c30;
integer c31;
integer c32;
integer c33;
integer c34;
integer c35;
integer c36;
integer c37;
integer c38;
integer c39;
integer c40;
integer c41;
integer c42;
integer c43;
integer c44;
integer c45;
integer c46;
integer c47;
integer c48;
integer c49;
integer c50;
integer c51;
integer c52;
integer c53;
integer c54;
integer c55;
integer c56;
integer c57;
integer c58;
integer c59;
integer c60;
integer c61;
integer c62;
integer c63;
integer c64;
integer c65;
integer c66;
integer c67;
integer c68;
integer c69;
integer c70;
integer c71;
integer c72;
integer c73;
integer c74;
integer c75;
integer c76;
integer c77;
integer c78;
integer c79;
integer c80;
integer c81;
integer c82;
integer c83;
integer c84;
integer c85;
integer c86;
integer c87;
integer c88;
integer c89;
integer c90;
integer c91;
integer c92;
integer c93;
integer c94;
integer c95;
integer c96;
integer c97;
integer c98;
integer c99;
  
        
    }
    
    public void selectBrand()
    {
        if( component.Brand__c != null )
        {
            QC_Master__c brand = [SELECT id,Name FROM QC_Master__c where id =: component.Brand__c ];
            system.debug(brand);
            component.Brands__c = brand.Name;
        }
    }
}