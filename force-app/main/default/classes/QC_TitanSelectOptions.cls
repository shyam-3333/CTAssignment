/*
    Name:QC_TitanSelectOptions 
    Created By:Shamsher Singh
    Created Date:
    Modified By:Anand Durga Prasad
    Last Modified Date:
    Description: Page for selecting sample category, sample type to create different components like(Full-Watch, Watch-Head, Case, Dial, Metal-strap, Leather-strap, special-strap,Battery,Module, Packaging)
    Methods Used:
                1. compPicVal(): Dynamically retrive all the component picklist values form QC_Question__c object
                2. componentMaster(): Save records for components                
                3. markMasterVariant : Mark the parent component as master variant.
                4. componentMaster()
                5. submit()
                6. updateComponents()
                7. reSubmission()            :Method to pass the parent id to Tab page in case of resubmission.
                8. deepCloneFullWatchHead()  :Method for cloning the full watch and watch head components.
                9. deepCloneWatchComponent() :Method for cloning the individual component record.
                10. retrieveComponent()   : Retrieve the parent component details and input and test parameters records.
                11. selectCondition()     : Method to check the condition if input and test parameters are not captured
                12. cloneChildComponents(): Clone the child components 
                13. cloneComp()           : Clone the parent component/Individual component
                14. cloneInputParameter() : Clone input parameters of parent component.
                15. cloneTestParameter()  : Clone test parameters of parent component and individual component
*/
public with sharing class QC_TitanSelectOptions {
   public QC_Components__c component                {get;set;}    //Used to store the current component data 
   public boolean showFullWatchComp                 {get;set;} 
   public boolean showCopyComponent                 {get;set;}
   public boolean showWatchHeadComp                 {get;set;}
   public boolean showIndiComp                      {get;set;}
   public String selectIndiComp                     {get;set;}
   public QC_Components__c parentRecords            {get;set;}
   public QC_Components__c indiComponent            {get;set;}
   public list<QC_Components__c> insertComp         {get;set;}
   public list<QC_Components__c> updateParentData   {get;set;}
   public string firstSelection                     {get;set;}
   public list<QC_Components__c> masterChildList;
   public string  componentPicklist                 {get;set;}
   public List<String> componentWatchHead           {get;set;} 
   public list<string> componentFullWatch           {get;set;}  
   public list<string> copySelectedComp             {get;set;}    
   public string secondSelection                    {get;set;}
   public boolean showInputData                     {get;set;}  
   public boolean renderMaster                      {get;set;}
   public String error;                                             //String variable to show error message
   public List<SelectOption> optionCompFullWatch        {get;set;}  // List to hold all the components for full watch(all components except full watch,watch head,Battery,Module and Packaging.)
   public List<SelectOption> optionsWatchHead           {get;set;}  //List to hold the components for watch head(case and dial)   
   public List<SelectOption> optionIndividualComponent  {get;set;}  //List to hold the components for individual.
   public List<SelectOption> copyDataMasterVariant      {get;set;}
   
   public List<QC_Components__c> childOfMasterVariant   {get;set;}  //List to hold the child variants of master variant
   /*
        declaration for deep clone   
   */
   public QC_Components__c watchComponent           {get;set;}      //list to hold the individual component details for cloning 
   public QC_Components__c fullwatchComponent       {get;set;}
   public List<QC_Input_Data__c> inputParameters    {get;set;}      //List to retrieve all the input parameters of individual component
   public List<QC_Test_Data__c>  testParameters     {get;set;}      //List to retrieve all the test parameters of individual component
   public List<QC_Input_Data__c> cloneInputParam    {get;set;}      //List to all the input parameters records to clone of individual component
   public List<QC_Test_Data__c>  cloneTestData      {get;set;}      //List to all the test parameters records to clone of individual component
   QC_Components__c cloneRecords                    {get;set;}
   QC_Components__c cloneChildRecords               {get;set;}
   public List<QC_Components__c> childComponent     {get;set;}
   public List<QC_Input_Data__c> childComponentInputParameters  {get;set;}      //List to hold all the input parameter records of child components
   public List<QC_Test_Data__c>  childComponentTestParameters   {get;set;}     //List to hold all the input parameter records of child components
   public List<QC_Test_Data__c>  childComponentTestParametersAll   {get;set;}     //List to hold all the input parameter records of child components
   public List<QC_Input_Data__c> cloneChildComponentInputParam  {get;set;}      //List to hold all the input parameters records to clone of child component
   public List<QC_Test_Data__c>  cloneChildComponentTestData    {get;set;}      //List to hold all the test parameters records to clone of child component
   public List<QC_Components__c> cloneChildComponents           {get;set;} 
   set<String> childId                              {get;set;}
   set<string> savedCompIds;     // used to stored inserted component ids to update each component with component reference number.
   string parentReportRefNo;    // used to hold parent report reference number for re-submission.
   public Qc_Master__c master                       {get;set;}    //Used to reference filter lookup fields for filtering the component in page.
   Integer controlQuery=1;
   public List<QC_Components__c> masterChildComponent {get;set;}    //List to hold the child components of master selected in the lookup
   set<String>  masterChildCompName                   {get;set;}
   public QC_Components__c masterComCheck             {get;set;}
   public string parentComId;   //Used to store selected lookup field value for update and re-submission.
   private static Map<Integer,string> alphabateMap = new Map<Integer,string>();
   private static Map<String,Integer> reverseMap = new Map<String,Integer>();
   static {
            alphabateMap.put(1,'a');
            alphabateMap.put(2,'b');
            alphabateMap.put(3,'c');
            alphabateMap.put(4,'d');
            alphabateMap.put(5,'e');
            alphabateMap.put(6,'f');
            alphabateMap.put(7,'g');
            alphabateMap.put(8,'h');
            alphabateMap.put(9,'i');
            alphabateMap.put(10,'j');
            alphabateMap.put(11,'k');
            alphabateMap.put(12,'l');
            alphabateMap.put(13,'m');
            alphabateMap.put(14,'n');
            alphabateMap.put(15,'o');
            alphabateMap.put(16,'p');
            alphabateMap.put(17,'q');
            alphabateMap.put(18,'r');
            alphabateMap.put(19,'s');
            alphabateMap.put(20,'t');
            alphabateMap.put(21,'u');
            alphabateMap.put(22,'v');
            alphabateMap.put(23,'w');
            alphabateMap.put(24,'x');
            alphabateMap.put(25,'y');
            alphabateMap.put(26,'z');
            reverseMap.put('a',1);
            reverseMap.put('b',2);
            reverseMap.put('c',3);
            reverseMap.put('d',4);
            reverseMap.put('e',5);
            reverseMap.put('f',6);
            reverseMap.put('g',7);
            reverseMap.put('h',8);
            reverseMap.put('i',9);
            reverseMap.put('j',10);
            reverseMap.put('k',11);
            reverseMap.put('l',12);
            reverseMap.put('m',13);
            reverseMap.put('n',14);
            reverseMap.put('o',15);
            reverseMap.put('p',16);
            reverseMap.put('q',17);
            reverseMap.put('r',18);
            reverseMap.put('s',19);
            reverseMap.put('t',20);
            reverseMap.put('u',21);
            reverseMap.put('v',22);
            reverseMap.put('w',23);
            reverseMap.put('x',24);
            reverseMap.put('y',25);
            reverseMap.put('z',26);            
       }
   public QC_TitanSelectOptions(){
        component           = new QC_Components__c();
        indiComponent       = new QC_Components__c();
        componentFullWatch  = new List<String>();
        componentWatchHead  = new List<String>();
        copySelectedComp    = new List<String>();
        compPicVal();
        watchComponent  = new QC_Components__c();
        inputParameters = new List<QC_Input_Data__c>();
        testParameters  = new List<QC_Test_Data__c>();
        cloneInputParam = new List<QC_Input_Data__c>();
        cloneTestData   = new List<QC_Test_Data__c>();
        masterChildList = new List<QC_Components__c>();
        childOfMasterVariant = new List<QC_Components__c>();
        masterComCheck                  = new QC_Components__c(master__c=true); 
        childComponent                  = new List<QC_Components__c>();
        childComponentInputParameters   = new List<QC_Input_Data__c>();
        childComponentTestParameters    = new List<QC_Test_Data__c>();
        childComponentTestParametersAll    = new List<QC_Test_Data__c>();
        cloneChildComponentInputParam   = new List<QC_Input_Data__c>();
        cloneChildComponentTestData     = new List<QC_Test_Data__c>();
        cloneChildComponents            = new List<QC_Components__c>();
        childId                         = new set<String>();
        cloneRecords                    = new QC_Components__c();
        savedCompIds                    = new set<string>();
        master                          = new Qc_Master__c();                 
   }
   //Method to construct report reference number for each component.
   public string reportRefNumber(string uniqueNo, string comType){
     /****************** Change Request 4 added by Anand-4/21/2015*******************************/
      //Identifying the current Fiscal Year 
      //Integer orgFiscalMonth = [SELECT FiscalYearStartMonth FROM Organization].FiscalYearStartMonth; 
      
      Date d = System.today();
      system.debug('***********d*************'+d);
      integer currentYear = d.year() - ((d.month() == 1 ||  d.month() == 2 || d.month() == 3) ? 1 : 0);
      string fYearPeriod ='/'+ string.valueOf(currentYear).subString(2,4) + '-' + string.valueOf(currentYear+1).subString(2,4);
      string refNo = uniqueNo + fYearPeriod;
      if(firstSelection != 'Competitor Products'){
      refNo = (comtype == 'Full-Watch') ? ('FW/' + refno) 
             :(comtype == 'Watch-Head') ? ('WH/' + refno)
             :(comtype == 'Case') ? ('CA/' + refno)
             :(comtype == 'Dial') ? ('DL/' + refno)
             :(comtype == 'Metal-Strap') ? ('MS/' + refno)
             :(comtype == 'Leather-Strap' || comtype == 'Special-Strap') ? ('LS/' + refno)
             :(comtype == 'Module') ? ('FMA/' + refno)
             :(comtype == 'Battery') ? ('BT/' + refno)
             :(comtype == 'Packaging')  ? ('PA/' + refno) : fYearPeriod;
     /*******************************************************************************************/
       System.debug('Report number for parent='+refNo);
       }
       else{
        refNo = (comtype == 'Full-Watch') ? ('CFW/' + refno) 
             :(comtype == 'Watch-Head') ? ('CWH/' + refno)
             :(comtype == 'Case') ? ('CCA/' + refno)
             :(comtype == 'Dial') ? ('CDL/' + refno)
             :(comtype == 'Metal-Strap') ? ('CMS/' + refno)
             :(comtype == 'Leather-Strap' || comtype == 'Special-Strap') ? ('CLS/' + refno)
             :(comtype == 'Module') ? ('CFMA/' + refno)
             :(comtype == 'Battery') ? ('CBT/' + refno)
             :(comtype == 'Packaging')  ? ('CPA/' + refno) : fYearPeriod;
       }
       return refNo;
        
   }
   
   /* @Method      : compoentPrefix
    * @Description : Used to get the component short name with compoent name
    * @Param       : component name
    */
   
   public String componentPrefix(string compName){
   if(firstSelection != 'Competitor Products'){
     return (compName != null && compName != '')   
                     ?((compName == 'Full-Watch') ? 'FW' 
                     :(compName == 'Watch-Head') ? 'WH'
                     :(compName == 'Case') ? 'CA' 
                     :(compName == 'Dial') ? 'DL'
                     :(compName == 'Metal-Strap') ? 'MS'
                     :(compName == 'Leather-Strap' || compName == 'Special-Strap') ? 'LS'
                     :(compName == 'Module') ? 'FMA' 
                     :(compName == 'Battery') ? 'BT' 
                     :(compName == 'Packaging')  ? 'PA' : null)
                     : null;
   }
   else{
    return (compName != null && compName != '')   
                     ?((compName == 'Full-Watch') ? 'CFW' 
                     :(compName == 'Watch-Head') ? 'CWH'
                     :(compName == 'Case') ? 'CCA' 
                     :(compName == 'Dial') ? 'CDL'
                     :(compName == 'Metal-Strap') ? 'CMS'
                     :(compName == 'Leather-Strap' || compName == 'Special-Strap') ? 'CLS'
                     :(compName == 'Module') ? 'CFMA' 
                     :(compName == 'Battery') ? 'CBT' 
                     :(compName == 'Packaging')  ? 'CPA' : null)
                     : null;
   }   
        
   }
   
   
   //Method to update each component with report reference number
   public void initReportRefNo(){
      list<QC_Components__c> updateComList = new list<QC_Components__c>(); 
      system.debug('^^^^^^^savedCompIds'+savedCompIds); 
        
      if(!savedCompIds.isEmpty()){
          QC_Component_Prefix__c cusSettings = new QC_Component_Prefix__c();
          for(QC_Components__c comp : [select id,name__c,unique_number__c,Report_Ref_Number__c,Sample_Category__c from QC_Components__c where id in:savedCompIds]){
               //Getting sequence number from custom settings as per the component name prefix
                //and pass it to reportRefNumber method 
                cusSettings = QC_Component_Prefix__c.getValues(componentPrefix(comp.Name__c));
                
                if(cusSettings != null){
                    if(cusSettings.sequence_Number__c != null){
                    system.debug('**Sequence Number**'+cusSettings.sequence_Number__c);
                            comp.Report_Ref_Number__c = reportRefNumber(String.valueOf(cusSettings.sequence_Number__c),comp.name__c);
                            system.debug('**check the RFN**'+comp.Report_Ref_Number__c);
                            updateComList.add(comp);
                    }
                }      
          }
           system.debug('updateComList************'+updateComList);
           if(!updateComList.isEmpty()){
                try{
                  update updateComList; 
                }catch(Exception e){
                   system.debug('Exception::'+e);
                }
           }
   }
}//End of initReportRefNo Method 

 public void initReSubmissionRefNo()
 {
   
      list<QC_Components__c> updateComList = new list<QC_Components__c>(); 
        if(!savedCompIds.isEmpty() && (firstSelection == 'Re-Submission')){
          for(QC_Components__c comp : [select id,name__c,unique_number__c,Report_Ref_Number__c,Parent_Report_Reference_Number__c,Sample_Category__c from QC_Components__c where id in:savedCompIds]){
              //Initialize Report Ref Number with alphabatic if Sample_Category__c == Re-Submission
              //&& comp.Report_Ref_Number__c!='' && comp.Report_Ref_Number__c!=null){
                system.debug('^^^^^^^^^^^^^Re-Submission^^^^^^^^^');
                      string newRefNumber='';
                      Date d = System.today();
                      system.debug('***********d*************'+d);
                      integer currentYear = d.year() - ((d.month() == 1 ||  d.month() == 2 || d.month() == 3) ? 1 : 0);
                      system.debug('***********currentYear*************'+currentYear);
                      string fYearPeriod ='/'+ string.valueOf(currentYear).subString(2,4) + '-' + string.valueOf(currentYear+1).subString(2,4);
                      system.debug('***********fYearPeriod *************'+fYearPeriod );
                      if(parentReportRefNo !='' && !parentReportRefNo.contains('[')){ 
                               system.debug('***********parentReportRefNo111111*************'+parentReportRefNo);
                              for(string str : parentReportRefNo.split(fYearPeriod)){
                                 newRefNumber = str; 
                              }
                                newRefNumber += '[a]'+fYearPeriod; 
                      }
                      else{   
                              //Getting next alphabate based on current alphabate using Maps(alphabateMap,reverseMap)
                              system.debug('***********parentReportRefNo222222*************'+parentReportRefNo);
                              //string strref = parentReportRefNo;
                              //string strref2 = parentReportRefNo;
                              //system.debug('***********strref222222*************'+strref.substring(8,9));
                              //system.debug('***********reverseMap.get(strref2.substring(9,10)*************'+reverseMap.get(strref2.substring(8,9))+1);
                              
                             //string nextAlphabate = alphabateMap.get(reverseMap.get(parentReportRefNo.substring(8,9))+1);
                               String nextAlphabate=alphabateMap.get(reverseMap.get(parentReportRefNo.subString(parentReportRefNo.indexOf('[')+1,parentReportRefNo.indexOf(']')))+1);
                              system.debug('***********nextAlphabate*************'+nextAlphabate);
                              for(string str : parentReportRefNo.split(fYearPeriod)){
                                   newRefNumber = str.substring(0,str.length()-3); 
                              }
                                   newRefNumber += '[' + nextAlphabate + ']'+fYearPeriod; 
                                   System.debug('new Resubmission='+newRefNumber); 
                      }   
                      comp.Report_Ref_Number__c = newRefNumber != '' ? newRefNumber : comp.Report_Ref_Number__c; 
                      comp.Parent_Report_Reference_Number__c = parentReportRefNo;
                      comp.Sample_Date__c = null;
                      system.debug('***********newRefNumber*************'+newRefNumber);
                      system.debug('***********comp.Report_Ref_Number__c*************'+comp.Report_Ref_Number__c);         
                      updateComList.add(comp);         
          }//End of for
           if(!updateComList.isEmpty()){ 
              update updateComList; 
           }
        }// End of if
    }//End of initReSubmissionRefNo
    
   /*
        Created By : Shamsher
        Method Name : compPicVal()
        Method to dynamically query the picklist values from Question object component type field.
        Modified Date: 22-4-2015
        Description: compPicVal() method is modified to remove the battery, module and packaging component from full watch.
   */
   public void compPicVal(){
       optionCompFullWatch          = new List<SelectOption>();  
       optionsWatchHead             = new List<SelectOption>(); 
       optionIndividualComponent    = new List<SelectOption>(); 
       Schema.DescribeFieldResult fieldResult =  QC_Question__c.Component_Type__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry f : ple){
             //Remove Full Watch, Watch Head, Module, Battery, Packaging from the Full watch component list.
             if(f.getValue() != 'Full-Watch' && f.getValue() != 'Watch-Head' && f.getValue() != 'Battery' && f.getValue() != 'Module' &&  f.getValue() != 'Packaging'){
                optionCompFullWatch.add(new SelectOption(f.getLabel(),f.getValue()));
             }
             //Add all the components except full watch and watch head for individual component
             if(f.getValue() != 'Full-Watch' && f.getValue() != 'Watch-Head'){
                optionIndividualComponent.add(new SelectOption(f.getLabel(),f.getValue()));
             }
             //Include only case and dial for watch head
             if(f.getValue() == 'Case' || f.getValue() == 'Dial'){
                optionsWatchHead.add(new SelectOption(f.getLabel(),f.getValue()));
             } 
             
       }
   }
   //GetMethod to initalize Sample Category picklist values
   public List<selectOption> getFirstAction(){
      List<selectOption> options = new List<selectOption>();
       options.add(new selectOption('','--None--'));
       options.add(new selectOption('New','New')); 
       options.add(new selectOption('New Material','New Material'));
       options.add(new selectOption('New Design','New Design'));
       options.add(new selectOption('New Construction ','New Construction '));
       options.add(new selectOption('New Vendor','New Vendor'));
       options.add(new selectOption('New Color','New Color'));
       options.add(new selectOption('Bulk lot confirmation','Bulk lot confirmation'));
       options.add(new selectOption('Competitor Products','Competitor Products'));   // added by sudama for new requirement of adding competitor products
      options.add(new selectOption('Update','Update'));
      options.add(new selectOption('Re-Submission','Re-Submission'));
      options.add(new selectOption('Re-Certification','Re-Certification'));   
      return options;
   }
    //GetMethod to initalize Sample Type picklist values 
   public List<selectOption> getSecondAction(){
      List<selectOption> options = new List<selectOption>();
      options.add(new selectOption('','--None--'));
      options.add(new selectOption('Full-Watch','Full-Watch'));
      options.add(new selectOption('Watch-Head','Watch-Head'));
      options.add(new selectOption('Watch-Component','Watch-Component'));
      return options;
   }
   
    /*  Method to mark the sample as master variant. Option to mark the sample as master variant is displayed only when all the components are selected.
        Master variant is marked only when a new sample is getting created. */   
    public pageReference  markMasterVariant() {       
        renderMaster=false;
        pageReference pr=null;
        if(optionCompFullWatch.size() == componentFullWatch.size() && (firstSelection == 'New' || firstSelection == 'New Material' || firstSelection == 'New Design' || firstSelection == 'New Construction ' || firstSelection == 'New Vendor' || firstSelection == 'New Color' || firstSelection == 'Bulk lot confirmation' || firstSelection == 'Re-Certification' || firstSelection == 'Competitor Products')){
            renderMaster=true;
        }
        if(optionsWatchHead.size() == componentWatchHead.size() && (firstSelection == 'New' || firstSelection == 'New Material' || firstSelection == 'New Design' || firstSelection == 'New Construction ' || firstSelection == 'New Vendor' || firstSelection == 'New Color' || firstSelection == 'Bulk lot confirmation' || firstSelection == 'Re-Certification' || firstSelection == 'Competitor Products')){
            renderMaster=true;
        }
        return pr; 
    }  

/*
    Written by Shamsher
    Name: componentMaster()
    Description:
        1. Create the parent component and selected child components (Without master variant)
        2. Master Variant - create the parent component(copy brand and vendor value from master variant as well as input and test parameters) and selected child components.
            2.1 Create tab of selected components(List is componentWatchHead )
            2.2 Copy child component input and test parameters from master variant of the selected components (List is copySelectedComp)
*/
  public pageReference componentMaster() {
        pageReference pr=null;
        insertComp = new list<QC_Components__c>(); 
        updateParentData = new list<QC_Components__c>(); 
        showInputData=true; 
        System.debug('component master'+component.Master__c);
        System.debug('master variant'+component.Master_Variant__c);
        System.debug('master full watch'+master.Master_FullWatch__c);
        System.debug('master watch head'+master.Master_WatchHead__c);
        // added by Sanjeev Shukla for making brand as mandatory
        if(component.Brand__c == NULL && secondSelection != 'Watch-Component'){
            System.debug('test debug');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter brand value'));
            return NULL;
        }
        if((firstSelection == 'New' || firstSelection == 'New Material' || firstSelection == 'New Design' || firstSelection == 'New Construction ' || firstSelection == 'New Vendor' || firstSelection == 'New Color' || firstSelection == 'Bulk lot confirmation' || firstSelection == 'Re-Certification' || firstSelection == 'Competitor Products') && secondSelection == 'Watch-Head' && component.Master__c == false && master.Master_WatchHead__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Mark this sample as a master or link this to a master variant')); 
        }
        else if((firstSelection == 'New' || firstSelection == 'New Material' || firstSelection == 'New Design' || firstSelection == 'New Construction ' || firstSelection == 'New Vendor' || firstSelection == 'New Color' || firstSelection == 'Bulk lot confirmation' || firstSelection == 'Re-Certification' || firstSelection == 'Competitor Products') && secondSelection == 'Full-Watch' && component.Master__c == false && master.Master_FullWatch__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Mark this sample as a master or link this to a master variant')); 
        }
       /* if(component.Master__c == false && component.Master_Variant__c == null && (secondSelection == 'Watch-Head' || secondSelection == 'Full-Watch')&&(firstSelection == 'New' || firstSelection == 'New Material' || firstSelection == 'New Design' || firstSelection == 'New Construction ' || firstSelection == 'New Vendor' || firstSelection == 'New Color' || firstSelection == 'Bulk lot confirmation' || firstSelection == 'Re-Certification')){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Mark this sample as a master or link this to a master variant')); 
        }*/
        else{
        if(!componentWatchHead.isEmpty() && secondSelection == 'Watch-Head' && (firstSelection == 'New' || firstSelection == 'New Material' || firstSelection == 'New Design' || firstSelection == 'New Construction ' || firstSelection == 'New Vendor' || firstSelection == 'New Color' || firstSelection == 'Bulk lot confirmation' || firstSelection == 'Re-Certification' || firstSelection == 'Competitor Products')){ 
            try{
                component.Name__c               = secondSelection;
                component.Sample_Category__c    = firstSelection; 
                component.component_status__c   = 'Active';  
                //Copying the selected master variant in page to component ,
                //Here master variable reference to QC_Master__c object which contains all lookup with filter conditions.
                component.Master_Variant__c     = master.Master_WatchHead__c != null ? master.Master_WatchHead__c : null;   
                upsert component;                               //Create/Update the parent component record    
                savedCompIds.add(component.id);                 //Adding inserted component id in set to update with report reference number.  
                showInputData   =   false;
            }catch(Exception e){
            /* ******************************* hide by sudama for extra validation error message
              error=e.getMessage();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,error));
            **************************************************************************************
            */          
            } 
            
  /* 
    Retrieving the master variant child components along with inputdata and test data - watch head.     
  */          
         if(component.master_variant__c != null){
            try{
                QC_Components__c masterCom = [select id,name,Name__c,Parent__c,Report_Ref_Number__c,Vendor__c,Brand__c FROM QC_Components__c where id =:component.master_variant__c limit 1];
                component.Vendor__c                = masterCom.Vendor__c;  
                component.Brand__c                 = masterCom.Brand__c;
                component.IsCopied_From_Master__c  = true;          
                upsert component;               //update brand and vendor details from master variant
               list<QC_Test_Data__c>  testList  = new list<QC_Test_Data__c>();
               /*
                    CODE BLOCK TO CLONE THE PARENT COMPONENT TEST FINDINGS FROM MASTER VARIANT
               */
               for(QC_Test_Data__c testEachMaster : [select Id,Conclusion__c,Determined_value__c,Comments_and_Remarks__c,Component_Name__c,Component_Name__r.name__c,Observation__c,Condition_Ref__c from QC_Test_Data__c where Component_Name__c =: component.master_variant__c]){
                    QC_Test_Data__c testData = new QC_Test_Data__c();
                     testData = testEachMaster.clone();
                     testData.Component_Name__c = component.id;
                     testList.add(testData);
               }//End of for
              insert testList;
               /*
                    CODE BLOCK TO CLONE THE PARENT COMPONENT INPUT PARAMETERS FROM MASTER VARIANT
               */
              list<QC_Input_Data__c> inputList = new list<QC_Input_Data__c>();
               for(QC_Input_Data__c inputEach : [SELECT Id,comments__c,Name,Question__c,Component_No__c,Component_No__r.name__c,Response_Id__c,Value__c FROM QC_Input_Data__c where Component_No__c =: component.master_variant__c]){
                  QC_Input_Data__c inputData = new QC_Input_Data__c();
                     inputData = inputEach.clone();
                     inputData.Component_No__c = component.id;
                     inputList.add(inputData);
               }//End of for
                insert inputList;
            }catch(Exception e){
                System.debug('@@@@@@@@@@@@@@@@@@'+e);
            } 
            
            masterChildList =[select id,name,Name__c,Parent__c,PSY_Reference__c,Unique_Number__c,document_Status__c,parent__r.document_Status__c,Master_Variant__c,Report_Ref_Number__c,Sample_Category__c,
                             Vendor__c,Brand__c,Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,final_verdict__c,                
                             (select Id,Conclusion__c,Component_Name__c,Observation__c,Condition_Ref__c from  QC_Test_Datas__r),
                             (SELECT Id,Name,Component_No__c,Response_Id__c,Value__c FROM QC_Input_Datas__r) from QC_Components__c 
                             where parent__c =:component.master_variant__c AND Name__c IN:componentWatchHead];
 /*
    Storing all Master variant child component names in set - watch head
 */
        set<string> MasterChildComps = new set<string>();
        for(QC_Components__c ComName : masterChildList ){
            MasterChildComps.add(ComName.Name__c);
        }       
         System.debug('@@@MasterChildComps@@@'+MasterChildComps);   
        //storing all the selected components in to a set 
        //Adding selected components to parentRecords list if seleted components not there in the masterChildList.
       set<string> selectedComps = new set<string>();       
       for(string selComName : componentWatchHead ){
          selectedComps.add(selComName);
          if(!MasterChildComps.contains(selComName)){
             parentRecords              = new QC_Components__c(); 
             parentRecords              = component.clone();                                
             parentRecords.Name__c      = selComName;
             parentRecords.Parent__c    = component.Id;
             insertComp.add(parentRecords);
          }//End of if block - !MasterChildComps.contains(selComName)
       }//End of for loop
        System.debug('@@@@selectedComps@@@@'+selectedComps);
   //initializing the components with master variant components.
       for(QC_Components__c masterCom : masterChildList){
          if(!selectedComps.contains(masterCom.name)){                       
             parentRecords = new QC_Components__c();        
             parentRecords.Name__c                  = masterCom.name__c;
             parentRecords.Parent__c                = component.Id;  
             parentRecords.Vendor__c                = masterCom.Vendor__c;  
             parentRecords.Brand__c                 = masterCom.Brand__c;
             parentRecords.Final_Verdict__c         = null;
             for(String copyData: copySelectedComp){
                 if(copyData==masterCom.name__c){
                        parentRecords.IsCopied_From_Master__c  = true;  
                        parentRecords.Final_Verdict__c         = masterCom.Final_Verdict__c;
                 }
             }
             insertComp.add(parentRecords);                              
          }//End of if block - (!selectedComps.contains(masterCom.name) )   
       }//End of For(QC_Components__c masterCom : masterChildList)           
      } // End of If (component.master_variant__c != null)
     //If master variant is not selected, insert the selected components
       else{              
            for(integer i=0;i<componentWatchHead.size();i++){
                parentRecords           = new QC_Components__c();   
                parentRecords           = component.clone();
                parentRecords.Name__c   = componentWatchHead[i];
                parentRecords.Parent__c = component.Id;
                insertComp.add(parentRecords); 
            }
      }//End of else part
      System.debug('child components - watch head'+insertComp);      
      try{
        
        insert insertComp;          //Insert all the components related to parent record 
        insertComp.clear();
        pr=new pageReference('/apex/QC_Tabs?id='+component.id);
      }catch(Exception e){
        error=e.getMessage();
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,error));
      }
      cloneInputData();         //Cloning and creating the master variant child component input data records
      cloneTestData();          //Cloning and creating the master variant child component test data records
    }

    else if(!componentFullWatch.isEmpty() && secondSelection == 'Full-Watch' && (firstSelection == 'New' || firstSelection == 'New Material' || firstSelection == 'New Design' || firstSelection == 'New Construction ' || firstSelection == 'New Vendor' || firstSelection == 'New Color' || firstSelection == 'Bulk lot confirmation' || firstSelection == 'Re-Certification' || firstSelection == 'Competitor Products')){ 
        try{ 
            component.Name__c             = secondSelection;
            component.Sample_Category__c  =  firstSelection; 
            component.component_status__c = 'Active';
            component.Master_Variant__c   = master.Master_FullWatch__c != null ? master.Master_FullWatch__c : null;                                    
            upsert component;                       //Create/Update the parent component record                 
            savedCompIds.add(component.id);         //Adding inserted component id in set to update with report reference number. 
            System.debug('@@@savedCompIds @@@'+savedCompIds);
            //show=true;
            showInputData=false;
        }catch(Exception e){
             Apexpages.addMessages(e);
            //error=e.getMessage();
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,error));
        }                    
         /* 
            Retrieving the master variant component child components along with inputdata and test data.     
         */          
         if(component.master_variant__c != null){
            
            try{
                QC_Components__c masterCom = [select id,name,Name__c,Parent__c,Report_Ref_Number__c,Vendor__c,Brand__c FROM QC_Components__c where id =:component.master_variant__c limit 1];
                component.Vendor__c                 = masterCom.Vendor__c;  
                component.Brand__c                  = masterCom.Brand__c;
                //component.IsCopied_From_Master__c     = true;     
                upsert component;                   //update brand and vendor details from master variant
/*
        CODE BLOCK TO CLONE THE PARENT COMPONENT INPUT FINDINGS FROM MASTER VARIANT
   */
               list<QC_Input_Data__c> inputList = new list<QC_Input_Data__c>();
               for(QC_Input_Data__c inputEach : [SELECT Id,comments__c,Name,Question__c,Component_No__c,Component_No__r.name__c,Response_Id__c,Value__c,Question_Name__c 
                                                 FROM QC_Input_Data__c where Component_No__c =: component.master_variant__c]){
                  QC_Input_Data__c inputData = new QC_Input_Data__c();
                     inputData = inputEach.clone();
                     inputData.Component_No__c = component.id;
                     inputList.add(inputData);
               }//End of for
                insert inputList;
/*
        CODE BLOCK TO CLONE THE PARENT COMPONENT TEST FINDINGS FROM MASTER VARIANT
    */
                list<QC_Test_Data__c>  testList  = new list<QC_Test_Data__c>();
                for(QC_Test_Data__c testEachMaster : [select Id,Conclusion__c,Determined_value__c,Comments_and_Remarks__c,Component_Name__c,Component_Name__r.name__c,Observation__c,Condition_Ref__c,
                                                          Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.UOM__c
                                                          from QC_Test_Data__c where Component_Name__c =: component.master_variant__c]){
                    QC_Test_Data__c testData = new QC_Test_Data__c();
                     testData = testEachMaster.clone();
                     testData.Component_Name__c = component.id;
                     testList.add(testData);
                }//End of for
                  insert testList;
                }catch(Exception e){
                    System.debug('@@@@@@@@@@@@@@@@@@'+e);
                } 
                   masterChildList =[select id,name,Name__c,Parent__c,PSY_Reference__c,Unique_Number__c,document_Status__c,parent__r.document_Status__c,Master_Variant__c,Report_Ref_Number__c,Sample_Category__c,
                                     Vendor__c,Brand__c,Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,final_verdict__c,                
                                    (select Id,Conclusion__c,Component_Name__c,Observation__c,Condition_Ref__c from  QC_Test_Datas__r),
                                    (SELECT Id,Name,Component_No__c,Response_Id__c,Value__c FROM QC_Input_Datas__r) from QC_Components__c 
                                    where parent__c =:component.master_variant__c AND Name__c IN:componentFullWatch];
/*
    Storing all Master variant child component names in set
    */
            set<string> MasterChildComps = new set<string>();
            for(QC_Components__c ComName : masterChildList ){
                  MasterChildComps.add(ComName.Name__c);
            }   
            System.debug('@@@MasterChildComps@@@'+MasterChildComps);         
            //storing all the selected components in to a set 
            //Adding selected components to parentRecords list if seleted components not there in the masterChildList.
           set<string> selectedComps = new set<string>();       
           for(string selComName : componentFullWatch ){
              selectedComps.add(selComName);
              if(!MasterChildComps.contains(selComName)){ 
                 parentRecords = new QC_Components__c(); 
                 parentRecords = component.clone();                                
                 parentRecords.Name__c = selComName;
                 parentRecords.Parent__c = component.Id;
                 insertComp.add(parentRecords);
              }//End of if block
           }//End of for loop
           System.debug('@@@@selectedComps@@@@'+selectedComps);
           //initializing the components with master variant components.
           for(QC_Components__c masterCom : masterChildList){
              if(!selectedComps.contains(masterCom.name)){                       
                 parentRecords = new QC_Components__c();        
                 parentRecords.Name__c                  = masterCom.name__c;
                 parentRecords.Parent__c                = component.Id;
                 parentRecords.Vendor__c                = masterCom.Vendor__c;  
                 parentRecords.Final_Verdict__c         = null;
                 parentRecords.Brand__c                 = masterCom.Brand__c;  
                 for(String copyData: copySelectedComp){
                    if(copyData==masterCom.name__c){
                        parentRecords.IsCopied_From_Master__c  = true;  
                        parentRecords.Final_Verdict__c         = masterCom.Final_Verdict__c;
                    }
                }         
                 insertComp.add(parentRecords);                              
              }     
           }//End of For (QC_Components__c masterCom : masterChildList) 
      } // End of If (component.master_variant__c != null)
          //If master variant is not selected, insert the selected components
          else{
              for(integer i=0;i<componentFullWatch.size();i++){
                    parentRecords = new QC_Components__c();
                    parentRecords = component.clone();                
                    parentRecords.Name__c = componentFullWatch[i];
                    parentRecords.Parent__c = component.Id;  
                    parentRecords.component_status__c = 'Active';   
                    insertComp.add(parentRecords); 
              }//End of for loop
          }  //End of else block       
        try{
            System.debug('@@@insertComp@@@'+insertComp);
            insert insertComp;      //Create all the components related to parent record
            pr=new pageReference('/apex/QC_Tabs?id='+component.id);
        }catch(Exception e){
            Apexpages.addMessages(e);
        } 
        cloneInputData();           //Cloning and creating the master variant child component input data records
        cloneTestData();            //Cloning and creating the master variant child component test data records
    }
    else if(componentPicklist != null && secondSelection == 'Watch-Component'){    
        indiComponent = new QC_Components__c();
            indiComponent.Name__c = componentPicklist; 
            indiComponent.Sample_Category__c =  firstSelection; 
            indiComponent.component_status__c = 'Active'; 
            try{
                insert indiComponent;                 //Create the individual component record.                
                savedCompIds.add(indiComponent.id);   //Adding inserted component id in set to update with report reference number            
                showInputData=false;
                insertComp.clear();               
                pr=new pageReference('/apex/QC_Tabs?id='+indiComponent.id);      //Redirect to QC_TitanQualityControl page 
            }catch(Exception e){
                ApexPages.addMessages(e);
            }     
    }
    else{
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select the component for'+secondSelection )); 
    }
    
   }
   initReportRefNo();              //Method to generate Report reference number        
    pageReference finalPr = (component.id != null || indiComponent.id != null) ? pr : null ;  //Redirect the page if Full-Watch or Watch-Head (component.id) or individual component(indiComponent.id) not equal to null
    return finalPr;
 }//End of method -componentMaster

   /*
        Written by Shamsher
        Name : cloneInputData()
        Description : Method to copy the master variant child component input data to components of newly created record based on selection
   */
   public void cloneInputData(){
        Boolean watchHeadInput=false;
        Boolean fullWatchInput=false;
        System.debug('#####@@@@@@@'+masterChildList);
        
        for(QC_Components__c qcCom : [select id,name,Name__c from QC_Components__c  where id =:component.master_variant__c LIMIT 1]){
            if(qcCom.Name__c == 'Watch-Head'){
                watchHeadInput = true;
            }
            else if(qcCom.Name__c == 'Full-Watch'){
                fullWatchInput = true;
            }
        }
      //Adding companent name and Id to Map for initializing input data. 
      set<id> MasterChildIds = new set<id>();
      System.debug('copy selected comp'+copySelectedComp);
      //Query only the selected component whose data needs to be copied from master variant
      if(fullWatchInput == true || watchHeadInput == true){
          for(QC_Components__c Com : [select id,name,Name__c,Parent__c,IsCopied_From_Master__c,PSY_Reference__c,Unique_Number__c,document_Status__c,parent__r.document_Status__c,Master_Variant__c,Report_Ref_Number__c,Sample_Category__c,
                                     Vendor__c,Brand__c,Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,final_verdict__c                
                                     from QC_Components__c  where parent__c =:component.master_variant__c AND Name__c IN:copySelectedComp] ){
               MasterChildIds.add(Com.id);
               
          } 
      } 
      System.debug('@@@@MasterChildIds@@@@'+MasterChildIds);
      System.debug('######component id######'+component.id);
      Map<string,id> MasterChildIdsMap = new Map<string,id>();
      for(QC_Components__c masterCom : [select id, name__c from QC_Components__c where parent__c =: component.id]){                   
         MasterChildIdsMap.put(masterCom.name__c,masterCom.id);
      }  
      System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@'+MasterChildIdsMap);           
       //Initializing input data with master variant components input data
       list<QC_Input_Data__c> inputList = new list<QC_Input_Data__c>();
       for(QC_Input_Data__c inputEach : [SELECT Id,comments__c,Name,Question__c,Question_Name__c,Component_No__c,Component_No__r.name__c,Response_Id__c,Value__c FROM QC_Input_Data__c where Component_No__c in:MasterChildIds]){
          if(!MasterChildIdsMap.isEmpty() && MasterChildIdsMap.containskey(inputEach.Component_No__r.name__c)){
             QC_Input_Data__c inputData = new QC_Input_Data__c();
             inputData = inputEach.clone();
             inputData.Component_No__c = MasterChildIdsMap.get(inputEach.Component_No__r.name__c);
             inputList.add(inputData);
          }
       }//End of for
       
       try{
          System.debug('@@@@@inputList@@@@@'+inputList);
          insert inputList;
       }catch(DMLException e){
          ApexPages.addMessages(e);
       }
       MasterChildIds.clear();  
       MasterChildIdsMap.clear();
   }
     /*
        Written by Shamsher
        Name : cloneTestData()
        Description : Method to copy the master variant child component test data to components of newly created record based on selection
   */
   public void cloneTestData(){
        Boolean watchHeadTest=false;
        Boolean fullWatchTest=false;
        for(QC_Components__c qcCom : [select id,name,Name__c from QC_Components__c  where id =:component.master_variant__c limit 1]){
            if(qcCom.Name__c == 'Watch-Head'){
                watchHeadTest = true;
            }
            else if(qcCom.Name__c == 'Full-Watch'){
                fullWatchTest = true;
            }
        } 
      //Adding component name and Id to Map for initializing test data. 
         set<id> MasterChildIds = new set<id>();
         System.debug('Selected test data component'+copySelectedComp);
         if(fullWatchTest == true || watchHeadTest == true){
              for(QC_Components__c Com : [select id,name,Name__c,Parent__c,PSY_Reference__c,Unique_Number__c,document_Status__c,parent__r.document_Status__c,Master_Variant__c,Report_Ref_Number__c,Sample_Category__c,
                                         Vendor__c,Brand__c,Sample_Date__c,model__c,IsCopied_From_Master__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,final_verdict__c                
                                         from QC_Components__c  where parent__c =:component.master_variant__c AND Name__c IN:copySelectedComp] ){
                   MasterChildIds.add(Com.id);
              } 
        } 
         System.debug('@@@MasterChildIds@@@-test data cloning'+MasterChildIds);
         Map<string,id> MasterChildIdsMap = new Map<string,id>();
         for(QC_Components__c masterCom : [select id, name__c from QC_Components__c where parent__c =: component.id]){                  
            MasterChildIdsMap.put(masterCom.name__c,masterCom.id);
         }
         System.debug('@@@@@@@@test data@@@@@@@@@@@@@@@@@'+MasterChildIdsMap); 
       /*********Initializing input and Test data with master variant components input & test data ***************/
         list<QC_Test_Data__c>  testList  = new list<QC_Test_Data__c>();
           for(QC_Test_Data__c testEach : [select Id,Determined_value__c,Conclusion__c,Comments_and_Remarks__c,Component_Name__c,Component_Name__r.name__c,Observation__c,Condition_Ref__c from QC_Test_Data__c where Component_Name__c in:MasterChildIds]){
              if(!MasterChildIdsMap.isEmpty() && MasterChildIdsMap.containskey(testEach.Component_Name__r.name__c)){
                 QC_Test_Data__c testData = new QC_Test_Data__c();
                 testData = testEach.clone();
                 testData.Component_Name__c = MasterChildIdsMap.get(testEach.Component_Name__r.name__c);
                 testList.add(testData);
              }
           }//End of for
           try{
              System.debug('test data to insert - child variant'+testList);
              insert testList;
           }catch(DMLException e){
              ApexPages.addMessages(e);
           } 
       MasterChildIds.clear();  
       MasterChildIdsMap.clear(); 
   }
    
   public pageReference  submit(){   
     masterChildCompName = new set<String>();
     renderMaster=false;        pageReference pr = null;    showInputData=false;
     showFullWatchComp=false;   showWatchHeadComp=false;    showIndiComp=false;
     showCopyComponent = false;
     copyDataMasterVariant = new List<SelectOption>();
     if(master.master_fullWatch__c != null){
        try{
            for(QC_Components__c qcChildFW: [select id, name__c from QC_Components__c where parent__c =: master.master_fullWatch__c]){
                masterChildCompName.add(qcChildFW.name__c);
            }
            //controlQuery=0;
        }catch(Exception e){}
     }
     else if(master.master_watchHead__c != null){
        try{
            for(QC_Components__c qcChildWH: [select id, name__c from QC_Components__c where parent__c =: master.master_watchHead__c]){
                masterChildCompName.add(qcChildWH.name__c);
            }
            //controlQuery=0;
        }catch(Exception e){}
     }
     
     //if(component.Master_Variant__c != null){
     if(master.master_fullWatch__c != null || master.master_watchHead__c != null){
        showCopyComponent=true;
     }
     //Mark renderMaster checkbox to true to render master checkbox in page - Full Watch and Watch head
     if(firstSelection == 'New' || firstSelection == 'New Material' || firstSelection == 'New Design' || firstSelection == 'New Construction ' || firstSelection == 'New Vendor' || firstSelection == 'New Color' || firstSelection == 'Bulk lot confirmation' || firstSelection == 'Re-Certification' || firstSelection == 'Competitor Products'){
        if(optionCompFullWatch.size() == componentFullWatch.size()){
            renderMaster=true;
        }
        else if(optionsWatchHead.size() == componentWatchHead.size()){
            renderMaster=true;
        }
     }//End of If block - (firstSelection == 'New' || firstSelection == 'Re-Certification')
        
     /*
        If condititon to check the showFullWatchComp,showWatchHeadComp and showIndiComp to true to render the components for 
        Full Watch,Watch Head and individual components.
     */
     if((firstSelection == 'New' || firstSelection == 'New Material' || firstSelection == 'New Design' || firstSelection == 'New Construction ' || firstSelection == 'New Vendor' || firstSelection == 'New Color' || firstSelection == 'Bulk lot confirmation' || firstSelection == 'Re-Certification' || firstSelection == 'Competitor Products' ) && secondSelection != null ){
          if(secondSelection == 'Full-Watch'){  
            for(integer i=0;i<componentFullWatch.size();i++){  
                if(masterChildCompName.contains(componentFullWatch[i]))copyDataMasterVariant.add(new SelectOption(componentFullWatch[i],componentFullWatch[i]));    
            }
            System.debug('#########Full watch###########'+copyDataMasterVariant);
            showFullWatchComp=true;  
            showInputData=true;      
          }
         else if(secondSelection == 'Watch-Head'){
            for(integer i=0;i<componentWatchHead.size();i++){
                if(masterChildCompName.contains(componentWatchHead[i]))copyDataMasterVariant.add(new SelectOption(componentWatchHead[i],componentWatchHead[i]));
            }
            showWatchHeadComp=true;    
            showInputData=true;       
         }  
         else if(secondSelection == 'Watch-Component'){
            showIndiComp=true;  
         }
      }//End of if block - (firstSelection == 'New' || firstSelection == 'Re-Certification') && secondSelection != null)
    else{
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select the the type of components'));
      }     
      return pr;
   }
   //Method to get the user selected component no. and pass it to QC_TitanQualityControl class to update the record.
   public pageReference updateComponents(){
        pageReference pr=null;
        //Initializing selected component id into parentComId variable when update or Re-submitting the component   
        parentComId = master.Fullwatch_lookup__c !=null ? master.Fullwatch_lookup__c 
                     :master.WatchHead_lookup__c !=null ? master.WatchHead_lookup__c
                     :master.Component_lookup__c !=null ? master.Component_lookup__c : null;
        QC_components__c qcComp = new QC_components__c(Sample_Category__c ='Update',id = parentComId);
        
        QC_components__c selectedComp = new QC_components__c();
        Try{
        selectedComp = [select id, component_status__c from QC_components__c where id =: parentComId];
        }catch(Exception ex){}
        if(selectedComp.Component_Status__c == 'Obsolete'){
           Apexpages.addMessage(new Apexpages.message(Apexpages.severity.Error,'This record cannot be updated since it is an obsolete record. Please choose an active record for updation'));
        }
        else{
            Try{
                //Updating the selected component sample category as Update
                 Update qcComp;
                 if(firstSelection == 'Update' && (secondSelection == 'Watch-Head' || secondSelection == 'Full-Watch') && parentComId != null){
                    pr= new pageReference('/apex/QC_Tabs?id='+parentComId);  
                 }
                 else if(firstSelection == 'Update' && secondSelection == 'Watch-Component' && parentComId != null){
                        pr= new pageReference('/apex/QC_Tabs?id='+parentComId );  
                 }
            }catch(Exception e){
                Apexpages.addMessages(e);
            }
        }//End of else
        return pr;
   }
  
   /*   Method to get the component no. for Re-Submission and create a separate set of components including question response and test parameters based on input components */          
   public pageReference reSubmission(){         
    string parentComId;  //Initializing selected component id into parentComId variable when update or Re-submitting the component  
    parentComId = master.Resub_Fullwatch__c !=null ? master.Resub_Fullwatch__c 
                     :master.Resub_WatchHead__c !=null ? master.Resub_WatchHead__c
                     :master.Resub_Component__c !=null ? master.Resub_Component__c : null; 
        System.debug('reSubmission()@@@@@@@parentComId@@@@@@'+parentComId);                              
    
    pageReference pr = null;
    if(firstSelection == 'Re-Submission' && (secondSelection == 'Full-Watch' || secondSelection == 'Watch-Head' ) && parentComId != null){
        //Call the deepCloneFullWatchHead() method for full watch and watch head cloning
        deepCloneFullWatchHead(); 
        //Redirect to QC_Tabs page in case of full watch and watch head      
        pr= new pageReference('/apex/QC_Tabs?id='+cloneRecords.id); 
    }
    else if(firstSelection == 'Re-Submission' && secondSelection == 'Watch-Component' && parentComId != null){ 
        //Call () method for individual component clone
        deepCloneWatchComponent();  
        //Redirect to  QC_TitanQualityControl in case of individual component   
          pr=new pageReference('/apex/QC_Tabs?id='+cloneRecords.id);
    }
    return pr;
   }
   /*
        deepCloneFullWatchHead()
        Method to clone parent record of full watch and watch head,their child component and question and 
        response records and test parameters of parent and child components.
        
   */
    public void deepCloneFullWatchHead(){
      retrieveComponent();
      selectCondition();      
      cloneChildComponents();
   }      
    /*
        deepCloneWatchComponent()
        Method to clone the individual component record and related input parameters and test findings record
    */
    public void deepCloneWatchComponent(){
        retrieveComponent();           
        selectCondition();  
   }      
   /*
        cloneChildComponents()
        Method to clone the child components of the parent component and question and test parameters for cloned child component
   */
   public void cloneChildComponents(){
        try{
            //Query the child components of the parent components
            childComponent = [SELECT id,Name__c,final_verdict__c,IsCopied_From_Master__c,Parent__c,PSY_Reference__c,Unique_Number__c,document_Status__c,parent__r.document_Status__c,Master_Variant__c,Report_Ref_Number__c,Sample_Category__c, Vendor__c,Brand__c,
                              Sample_Date__c,model__c,Test_Back_Ground__c,parent__r.Master__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE Parent__c =: watchComponent.id];   
           System.debug('+++++++childComponent++++++++'+childComponent);                                                  
        }
        catch(Exception e){
            ApexPages.addMessages(e);
        }
        for(QC_Components__c childComp : childComponent ){
            //Condition for rejected components which are not copied form master, then should not copy the input and test parameters of these components
            System.debug('*****childComp.IsCopied_From_Master__c******'+childComp.IsCopied_From_Master__c+'   '+childComp.final_verdict__c);
            if(childComp.final_verdict__c != 'Reject' || childComp.IsCopied_From_Master__c == true){
                 childId.add(childComp.Id); 
            }  
            System.debug('+++++++++childId+++++++++++++'+childId);
            //Condition for rejected components which will be copied if it is a master variant
            if(childComp.final_verdict__c == 'Reject' && childComp.IsCopied_From_Master__c == false){
             childId.add(childComp.Id); 
            }    
        }
        try{
            System.debug('****childId****** '+childId.size());
            //Query all the input parameters of the child components
            childComponentInputParameters = [SELECT Id,Name,Comments__c,Component_No__c,Response_Id__c,Question__c,Question_Name__c,Value__c FROM QC_Input_Data__c 
                                             WHERE Component_No__c in : childId];
            //Query all the test parameters of the child components
            /*childComponentTestParameters  = [SELECT Id,Determined_value__c,Conclusion__c,Comments_and_Remarks__c,Component_Name__c,Observation__c,Condition_Ref__c FROM QC_Test_Data__c 
                                             WHERE Component_Name__c in :childId];*/
                                             
             childComponentTestParametersAll  = [select Determined_value__c,Parent__c,Component_Name__r.final_verdict__c,isParent__c,IsLast__c, RandomNumber__c,Acceptance_Criteria__c,isManual__c,Condition_Ref__r.Onload__c,Test_Name__c,Condition_Ref__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c, Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.Specification__c, Conclusion__c, Comments_and_Remarks__c,Condition_Ref__r.IsEditableUOMSPEC__c,Component_Name__c,observation__c,Specification_Input__c,UOM_Input__c, Initial_Test_Observation__c,After_Test_Observation__c, Observation5__c, Observation4__c, Observation3__c, Observation2__c, Observation1__c,Initial5__c, Initial4__c, Initial3__c,Initial2__c, Initial1__c, After_Test5__c, After_Test4__c, After_Test3__c, After_Test2__c, After_Test1__c From QC_Test_Data__c  where Component_Name__c in :childId and recordtype.developerName ='Module' order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c,Name limit 50000 ];

             System.debug('****childComponentTestParameters****** '+childComponentTestParameters.size());
             System.debug('****childComponentTestParameters****** '+childComponentTestParameters);
             System.debug('****childComponentTestParameters****** '+childComponentTestParametersAll);
             
             //this "if" condition is used to display only the accepted test parameters and reset the rejected parameters if the final verdict is 'reject'.
                for(QC_Test_Data__c testData : childComponentTestParametersAll){
                     if(testData.Component_Name__r.final_verdict__c == 'Reject' && testData.Conclusion__c == 'Reject'){
                        testData.Conclusion__c = '';
                        testData.Comments_and_Remarks__c = '';
                        testData.Observation__c = '';
                        childComponentTestParameters.add(testData); 
                    }
                    else
                    childComponentTestParameters.add(testData);
             }
            System.debug('++++++++childComponentTestParameters++++++++++'+childComponentTestParameters.size());         

        }catch(Exception e){
            ApexPages.addMessages(e);
        }
        for(QC_Components__c cComp : childComponent){
            QC_Components__c childComponent = cComp.clone(false);
            childComponent.Parent__c = cloneRecords.id;    //Set the Parent__c to the cloned parent record id
            childComponent.document_status__c = 'Draft';  //set document status as null for newly created child
            childComponent.Sample_Category__c = 'Re-submission'; //set Sample_Category as Re-Submission of all childs
            childComponent.IsCopied_From_ReSub__c = true;
            //if(childComponent.IsCopied_From_Master__c == false){
              //  childComponent.final_verdict__c = null; 
            //}
            //Condition to control copy of rejected component final verdict when it is not copied from master.
            if(childComponent.final_verdict__c == 'Reject' && childComponent.IsCopied_From_Master__c == false){
                childComponent.final_verdict__c = null; 
            }
            cloneChildRecords = childComponent.clone(false);        //Add to list after setting the parent to clone
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
                    cloneChildComponentTestData.add(testChildData);             //Add all the test paremeters mapped with the child component to list to clone. 
                }
            }
        }
        try{
            System.debug('****cloneChildComponentTestData****** '+cloneChildComponentTestData.size());
            insert cloneChildComponentInputParam;                                //Clone the input parameters record of child component 
            insert cloneChildComponentTestData;                                  //Clone the test parameters record of child component 
        }Catch(Exception e){
            ApexPages.addMessages(e);               
        } 
   }
   
   public void retrieveComponent(){
       System.debug('coming here from other end of data='+parentComId);
    //Initializing selected component id into parentComId variable when update or Re-submitting the component   
    if(firstSelection == 'Re-Submission'){
       parentComId = master.Resub_Fullwatch__c !=null ? master.Resub_Fullwatch__c 
                    :master.Resub_WatchHead__c !=null ? master.Resub_WatchHead__c
                    :master.Resub_Component__c !=null ? master.Resub_Component__c : null; 
    }else{
       parentComId = master.Fullwatch_lookup__c !=null ? master.Fullwatch_lookup__c 
                    :master.WatchHead_lookup__c !=null ? master.WatchHead_lookup__c
                    :master.Component_lookup__c !=null ? master.Component_lookup__c : null;
    }
    System.debug('retrieveComponent()@@@@@@@parentComId@@@@@@'+parentComId);
    if(parentComId != null){
        try{
            //Query the individual component detail
            watchComponent = [SELECT id, name,Name__c,master__c,Parent__c,Master_Variant__c,PSY_Reference__c,Vendor__c,Report_Ref_Number__c,Sample_Category__c,Final_verdict__c,Brand__c,Sample_Date__c,imageurl__c,imageurl2__c,imageurl3__c,
                               model__c,Test_Back_Ground__c,General_Observation__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,Published_Date__c,
                              (SELECT id FROM Component__r) FROM QC_Components__c WHERE id=: parentComId];
            //Initializing selected component report reference number to change the alphabate in case of Re-submission. 
            parentReportRefNo = (watchComponent.id != null) ? watchComponent.Report_Ref_Number__c:'';
            //Query all the input parameters for the individual component
            inputParameters = [SELECT Id,Name,Comments__c,Component_No__c,Response_Id__c,Question__c,Question_Name__c,Value__c FROM QC_Input_Data__c 
                                WHERE Component_No__c =: parentComId];
            System.debug('------inputParameters------'+inputParameters);
            //Query all the related test parameters for the individual component
            /*testParameters = [SELECT Id,Conclusion__c,Determined_value__c,Comments_and_Remarks__c,Component_Name__c,Observation__c,Condition_Ref__c FROM QC_Test_Data__c 
                              WHERE Component_Name__c = :parentComId]; */
                           
            testParameters = [select Determined_value__c,Parent__c,isParent__c,IsLast__c, RandomNumber__c,Acceptance_Criteria__c,isManual__c,Condition_Ref__r.Onload__c,Test_Name__c,Condition_Ref__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c, Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.Specification__c, Conclusion__c, Comments_and_Remarks__c,Condition_Ref__r.IsEditableUOMSPEC__c,Component_Name__c,observation__c,Specification_Input__c,UOM_Input__c, Initial_Test_Observation__c,After_Test_Observation__c, Observation5__c, Observation4__c, Observation3__c, Observation2__c, Observation1__c,Initial5__c, Initial4__c, Initial3__c,Initial2__c, Initial1__c, After_Test5__c, After_Test4__c, After_Test3__c, After_Test2__c, After_Test1__c From QC_Test_Data__c  where Component_Name__c =: parentComId and recordtype.developerName ='Module' order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c,Name limit 50000 ]; 
        
            System.debug('-------testParameters-------'+testParameters);
            //Making all child components of selected component as 'Obsolete'
           if(watchComponent.id!= null){
             list<QC_Components__c> updatelist = new list<QC_Components__c>();
             watchComponent.component_status__c = 'Obsolete';
             updatelist.add(watchComponent);
             for(QC_Components__c com : watchComponent.component__r){
                 com.component_status__c = 'Obsolete';
                 updatelist.add(com);
             }
             update updatelist;
           }
        }
        catch(Exception e){
            ApexPages.addMessages(e);
        }
    }
    else{
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'parent selected is not valid')); 
    }
  }
  /*
        Method to check for condition and call the methods.
        Check if input and test parameters are captured or not.if not clone only the component.
        If yes clone the component along with input and test parameters.  
 */
   public void selectCondition(){
   if(watchComponent.Parent__c  == null){
        if(!inputParameters.isEmpty() && !testParameters.isEmpty())  {
            cloneComp();
            cloneInputParameter(); 
            cloneTestParameter();
        }
        else if(inputParameters.size() == null && !testParameters.isEmpty()){
            cloneComp();
            cloneTestParameter();
        }  
        else if(!inputParameters.isEmpty() && testParameters.isEmpty()){
            cloneComp();
            cloneInputParameter(); 
        }
        else{
            cloneComp(); 
        }
      }
   }        
 /*
  public void selectCondition1(){
   if(fullwatchComponent.Parent__c  == null){
        if(!inputParameters.isEmpty() && !testParameters.isEmpty())  {
            cloneComp();
            cloneInputParameter(); 
            cloneTestParameter();
        }
        else if(inputParameters.size() == null && !testParameters.isEmpty()){
            cloneComp();
            cloneTestParameter();
        }  
        else if(!inputParameters.isEmpty() && testParameters.size() == null){
            cloneComp();
            cloneInputParameter(); 
        }
        else{
            cloneComp(); 
        }
      }
   }
  */ 
   public void cloneComp(){        /*  Method to clone the parent component record   */
    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+watchComponent);
    cloneRecords = watchComponent.clone(false);
    cloneRecords.component_status__c = 'Active';
    cloneRecords.Report_Ref_Number__c = null;
    cloneRecords.Sample_Category__c = 'Re-submission';
    cloneRecords.Final_Verdict__c = null;
    cloneRecords.Document_Status__c = 'Draft';
    cloneRecords.IsCopied_From_ReSub__c = true;
    cloneRecords.published_Date__c = null;
    
    
    try{
        //Clone the individual component record 
        insert cloneRecords; 
        //Adding component id to savedCompIds for initializing  report reference number       
        savedCompIds.add(cloneRecords.id);
        
        //updateChildVariantRejectedComponents();
    
       // parentComponentData method call to update the child records with newly created parent on resubmission.
        QC_ReSubmission.parentComponentData(cloneRecords, parentComId);
    
        //Method to initialize report reference number on re-submission.
        initReSubmissionRefNo();
    }Catch(Exception e){
        ApexPages.addMessages(e); 
        Apexpages.AddMessage(new Apexpages.Message(ApexPages.Severity.Warning,'line Number:'+e.getLineNumber()));              
    }     
   }
   
/*    public void updateChildVariantRejectedComponents(){
       list<QC_Components__c> updateMasterVariant = new list<QC_Components__c>();
       try{
            //Query all the child variants
            childOfMasterVariant = [SELECT id,name,Name__c,Master_Variant__c FROM QC_Components__c WHERE Master_Variant__c =: parentComId];
        }catch(Exception e){
            System.debug('exception in child variant query'+e);
        }
        System.debug('child variant of master'+childOfMasterVariant.size());
        //Check whether if any of the child variants component is copied from master variant
        System.debug('new record id'+cloneRecords.id);
        if(childOfMasterVariant != null){
            for(QC_Components__c qc : childOfMasterVariant){            
                qc.Master_Variant__c = cloneRecords.id;
                updateMasterVariant.add(qc);
            }
        }
        System.debug('list of records to update the master variant'+updateMasterVariant.size());
        try{
            update updateMasterVariant;
        }catch(Exception e){
            System.debug('exception in updating master variant lookup of child variant'+e);
        }
   }
*/   
   /*
        Method to clone the component input parameters records
   */
   public void cloneInputParameter(){           
    //For block to add all the input parameters to list to clone  
    for(QC_Input_Data__c ip : inputParameters){
          QC_Input_Data__c qcInput = ip.clone(false);
          qcInput.Component_No__c = cloneRecords.id;            //set the component ref of newly cloned component        
          cloneInputParam.add(qcInput);      
    }//End of for loop
    try{
          insert cloneInputParam;                               //clone all the input parameters records
    }catch(Exception e){
          ApexPages.addMessages(e); 
    }             
   }
   /*
        Method to clone the parent component test parameters records
   */
   public void cloneTestParameter(){
   //For block to add all the test parameters to list to clone and also to reset all the rejected test parameters while re-submission
    for(QC_Test_Data__c td : testParameters){
    //condition is added by Anindwita
        if(td.Conclusion__c == 'Reject'){
            td.Conclusion__c = '';
            td.Comments_and_Remarks__c = '';
            td.Observation__c = '';
            QC_Test_Data__c qcTest = td.clone(false);
            qcTest.Component_Name__c = cloneRecords.id;         //set the component ref of newly cloned component
            cloneTestData.add(qcTest);
        }else{
            QC_Test_Data__c qcTest = td.clone(false);
            qcTest.Component_Name__c = cloneRecords.id;         //set the component ref of newly cloned component
            cloneTestData.add(qcTest);
        }
        system.debug('**cloneTestData**'+cloneTestData);
    }//End of for block
    try{
        insert cloneTestData;                               //clone all the test findings records
    }catch(Exception e){
        ApexPages.addMessages(e); 
    }     
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