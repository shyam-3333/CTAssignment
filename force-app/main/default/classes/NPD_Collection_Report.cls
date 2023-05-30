public class NPD_Collection_Report {

    public List < selectoption >            npdBrandOption           {get;set;}
    public List < selectoption >            npdBrandManagerOption    {get;set;}
    public List < selectoption >            npdDesignManagerOption    {get;set;}
    public List < selectoption >            npdType                  {get;set;}                           // This List is used to capture report type like upstream,Design etc
    public List < selectoption >            npdCollectionType        {get;set;}                           // This List is used to capture report type like upstream,Design etc
    public List < selectoption >            npdCollectionOption      {get;set;}
    public List < selectoption >            npdfiscalYearOption      {get;set;}
    public String                           selectedBrandName        {get;set;}
    public String                           selectedCollectionName   {get;set;}
    public String                           npdBrandManagerName      {get;set;}
    public String                           npdDesignManagerName     {get;set;}
    public String                           selectedFiscalYear       {get;set;}
    public String                           selectedType             {get;set;}
    public String                           selectedCollectionType   {get;set;}
    public String                           excReportType            {get;set;}
    public String                           excCollectionStatus      {get;set;}
    public String                           excBrand                 {get;set;}
    public String                           ExcFascalYear            {get;set;}
    public String                           ExcFromDate              {get;set;}
    public String                           ExcToDate                {get;set;}
    public String                           ExcCollectionType        {get;set;}
    public String                           ExcProductDgr            {get;set;}
    public String                           ExcBrandMgr              {get;set;}
    public String                           ExcCollection            {get;set;}  
    public map < String, npd_stage__c >     CollectionName;
    public boolean                          showUpstream             {get;set;}
    public boolean                          showDesign               {get;set;}
    public List < wraperTable >             lWrapperList             {get;set;}                             // List for displaying data from wrapper table
    public date fromDate                                             {get;set;}                             // collect date from visual force page (tentative lunch from date)
    public date toDate                                               {get;set;}                             // collect date from visual force page (tentative lunch from date)
    
    
/****************************  Declare Wrapper table for displaying data to the VF page  *******************************/
    public class wraperTable {
        //-------wrapper variables for design report-------//
        public String          release           {get;set;}
        public String          acceptance        {get;set;}
        public String          lt                {get;set;}
        public Integer         ActLt             {get;set;}
        public String          id                {get;set;}
        public Date            prostartDate      {get;set;}
        public Date            proendDate        {get;set;}
        public Date            RelEndDate        {get;set;}
        public Integer         ActLTDesign       {get;set;}
        public String          TechDesigner         {get;set;}
        public String          TechApproverName     {get;set;}
        public String          designComplexity     {get;set;}
        public String          ComplexityName           {get;set;}
        public date            protoDgnReleaseAED   {get;set;}
        public date            protoMfgAslyAED      {get;set;}
        public Decimal         protoMfgAslyPlanLT   {get;set;}
        public Decimal         designPlanLT         {get;set;}
        public Decimal         designProtoMfgLT     {get;set;}
        public String          designFPDRComplexity {get;set;}
        public Date            designFPDRATD        {get;set;}
        public Date            designFPDRAED        {get;set;}
        public Decimal         designFPDRLT         {get;set;}
        public Decimal         designFPDRPlanLT     {get;set;}
        public Decimal         designIFPDRlanLT     {get;set;}
        public Decimal         designIFPDRlanLTCal  {get;set;}
        public date            addDevStartDate      {get;set;}
        public date            watchBOCompDevAED    {get;set;}
        public Integer         addDevLT             {get;set;}
        public date            planedOrderLodingSD  {get;set;}
        public date            planedOrderLodingAED {get;set;}
        public Integer         planedOrderLodingLT  {get;set;}
        public date            launchSD             {get;set;}
        public date            launchED             {get;set;}
        public Integer         launchLT             {get;set;}
        public date            protoApprvSD         {get;set;}
        public date            protoApprvED         {get;set;}
        
        //-------------wrapper list var for upstream report------------//
        public Date            ISCM              {get;set;}
        public Date            endDateEd         {get;set;}
        public Date            startDateEd       {get;set;}
        public Date            Approval          {get;set;}
        public Date            endDate           {get;set;}
        public Date            startDate         {get;set;}
        public Date            approvedDate      {get;set;}
        public Date            submittedDate     {get;set;}
        public Date            drawingStartDate  {get;set;}
        public Date            drawingEndDate    {get;set;}
        public Date            protoEndDate      {get;set;}
        public Date            protoStartDate    {get;set;}
        public Date            pbReleaseStartDate {get;set;}
        public Date            pbReleaseEndDate   {get;set;}
        public Date            protoDesignStartDate {get;set;}
        public Date            protoDesignEndDate {get;set;}
        public Integer         ISCMLT            {get;set;}
        public Integer         noOfDays          {get;set;}
        public Integer         conceptdesignLT   {get;set;}
        public Decimal         endminusstart     {get;set;}
        public Decimal         PlanLTEd          {get;set;}
        public Decimal         PlanLT            {get;set;}
        public String          EnggDegName       {get;set;}
        public String          complexity        {get;set;}
        public String          conceptDgnApprovalSt {get;set;}
        public String          productDegName    {get;set;}
        public String          owner             {get;set;}
        public String          model             {get;set;}
        public String          Psynum            {get;set;}
        public String          designNo          {get;set;}
        public String          collection        {get;set;}
        public String          brand             {get;set;}
        
    }
/*********************************** End Of Wrapper Class   ********************************************/
/*********************************** Constructor start for initialization  *****************************/   
    public NPD_Collection_Report() {        
        showUpstream = false;
        showDesign = false;
        lWrapperList = new List < wraperTable > ();
        selectedBrandName = 'None';
        selectedFiscalYear = 'None';
        npdBrandManagerName = 'None';
        selectBrand();
        selectYear();    
        selectReportTypeAndStatus();
      //  selectedType();
    }
/*****************************   End of Constructor   *******************************************************/
/*********************************** ClickToDownload method is used to make page as a excel format *********/
    public PageReference ClickToDownload(){
        String reportType;
        String collectionStatus;
        String brand;
        String fascalYear;
        String fromDate1;
        String toDate1;
        String brandMgr;
        String productDnr;
        String collection;
        
        reportType       = selectedType;
        brand            = selectedBrandName;
        collectionStatus = selectedCollectionType;
        collection       = selectedCollectionName;
        fascalYear       = selectedFiscalYear;
        fromDate1        =  String.valueOf(fromDate);
        toDate1          = String.valueOf(toDate);
        brandMgr         = npdBrandManagerName;
        productDnr       = npdDesignManagerName;
        
        PageReference  pr = null;
        if(reportType != 'None' && toDate1== null && fromDate1 == null ){
            pr = new pageReference('/apex/NPD_Collection_ReportExcel?id1='+reportType+'&id2='+brand+'&id3='+fascalYear+'&id4='+collection+'&id7='+collectionStatus+'&id8='+brandMgr+'&id9='+productDnr);
        }
        else{
                    pr = new pageReference('/apex/NPD_Collection_ReportExcel?id1='+reportType+'&id2='+brand+'&id3='+fascalYear+'&id4='+collection+'&id5='+fromDate1+'&id6='+toDate1+'&id7='+collectionStatus+'&id8='+brandMgr+'&id9='+productDnr);
        }
      /*  if(reportType != null && brand != null && fascalYear != null && collection != null && fromDate1 != null && toDate1 != null){
            pr = new pageReference('/apex/NPD_Collection_ReportExcel?id1='+reportType+'&id2=' +brand+'&id3=' +fascalYear+'&id4=' +collection+'&id5=' +fromDate1+'&id6=' +toDate1+'&id7=' +collectionStatus+'&id8=' +brandMgr+'&id9=' +productDnr);
        }
        else if(reportType != null && brand != null && fascalYear != null && collection != null){
            pr = new pageReference('/apex/NPD_Collection_ReportExcel?id1='+reportType+'&id2=' +brand+'&id3=' +fascalYear+'&id4=' +collection);
        }  */
        pr.setredirect(true);
        return pr;
    }
/*********************************** End of ClickToDownload method ******************************************************/
/******************** newcollectionReportExc method is called directly from NPD_Collection_ReportExcel Page from Action ***********/
    public void newcollectionReportExc(){
           excReportType         = Apexpages.currentpage().getParameters().get('id1');
           excBrand              = Apexpages.currentpage().getParameters().get('id2');
           excFascalYear         = Apexpages.currentpage().getParameters().get('id3');
           ExcCollection         = Apexpages.currentpage().getParameters().get('id4');
           ExcFromDate           = Apexpages.currentpage().getParameters().get('id5');
           ExcToDate             = Apexpages.currentpage().getParameters().get('id6');
           ExcCollectionType     = Apexpages.currentpage().getParameters().get('id7');
           ExcBrandMgr           = Apexpages.currentpage().getParameters().get('id8');
           ExcProductDgr         = Apexpages.currentpage().getParameters().get('id9');

           if(excReportType != null){
                selectedType = excReportType;
                System.debug('+++++++++++excReportType++++++++++++++++++'+selectedType);
            }
            if(excBrand != null){
                selectedBrandName = excBrand;
                System.debug('+++++++++++excBrand++++++++++++++++++'+selectedBrandName);
            }
            if(excFascalYear != null){
                selectedFiscalYear = excFascalYear;
                System.debug('+++++++++++excFascalYear++++++++++++++++++'+selectedFiscalYear);
            }     
            if(ExcCollection != null){
                selectedCollectionName = ExcCollection;
                System.debug('+++++++++++ExcCollection++++++++++++++++++'+selectedCollectionName);
            }  
            if(ExcFromDate != null){
                fromDate = date.valueOf(ExcFromDate);
                System.debug('+++++++++++ExcFromDate++++++++++++++++++'+fromDate);
            }   
            if(ExcToDate != null){
                toDate = Date.valueOf(ExcToDate);
                System.debug('+++++++++++ExcToDate++++++++++++++++++'+toDate);
            }  
            if(ExcCollectionType != null){
                selectedCollectionType = ExcCollectionType;
                System.debug('+++++++++++ExcCollectionType++++++++++++++++++'+selectedCollectionType);
            }  
            if(ExcBrandMgr != null){
                npdBrandManagerName = ExcBrandMgr;
                System.debug('+++++++++++ExcBrandMgr++++++++++++++++++'+npdBrandManagerName);
            }     
            if(ExcProductDgr != null){
                npdDesignManagerName = ExcProductDgr;
                System.debug('+++++++++++ExcProductDgr++++++++++++++++++'+npdDesignManagerName);
            }               
            selectCollection();
            displayTable();
    }
/*************************************** End of newcollectionReportExc **************************************************************/
/**************************************** This method is used to select report type And Report status *******************************/
    public void selectReportTypeAndStatus(){
        npdType = new List < selectoption > ();
        npdCollectionType = new List<selectoption>();
        npdType.add(new selectoption('None', '--None--'));
        npdType.add(new selectoption('Upstream', 'Upstream'));
        npdType.add(new selectoption('Design', 'DnD'));
        
        npdCollectionType.add(new selectoption('None', '--None--'));
        npdCollectionType.add(new selectoption('All', 'All'));
        npdCollectionType.add(new selectoption('Open', 'Open'));
        npdCollectionType.add(new selectoption('Close', 'Close'));
    }   
/*************************************** End of selectReportTypeAndStatus method  ***************************************************/
/******************************   Method used to select Brand from picklist value   **************************/
    public void selectBrand() {
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        npdBrandOption = new List < selectoption > ();
        npdBrandOption.add(new selectoption('None', '--None--'));
        npdBrandOption.add(new selectoption('All', 'All'));
        for (NPD_Master__c master: [select id, Name from NPD_Master__c where Type__c = 'Brand' order by Name]) {
            npdBrandOption.add(new selectoption(master.name, master.Name));
        }
    }
/******************************* End of selectBrand method    *************************************************/
/******************************* method for selecting Brand manager  ********************************************/
    public void selectBrandManager(){
        npdBrandManagerOption  =  new List<selectoption>();
        npdBrandManagerOption.add(new selectoption('None', '--None--'));
        for (NPD_Master__c master: [select id, Name from NPD_Master__c where Name LIKE '%PMG%']) {
            npdBrandManagerOption.add(new selectoption(master.name, master.Name));
        }
    }
/***************************** End of selectBrandManager method  ***************************************************/
/******************************* method for selecting Design manager  ********************************************/
    public void selectDesignManager(){
        npdDesignManagerOption  =  new List<selectoption>();
        npdDesignManagerOption.add(new selectoption('None', '--None--'));
        for (NPD_Master__c master: [select id, Name from NPD_Master__c where type__c='Product Designer Name' order by Name]) {
            npdDesignManagerOption.add(new selectoption(master.name, master.Name));
        }
    }
/***************************** End of selectDesignManager method  ***************************************************/
/******************************* selectCollection method is used to display collection name based on combination of 
                                1. Based on selected Brand  OR 
                                2. Based on selected Fiscal Years 
                                3.Either combination of Brand & Fiscal Years
**************************************************************************************************************/ 
    public void selectCollection() {
        if(npdBrandManagerName == null){
            npdBrandManagerName = 'None';
        }
        CollectionName = new map < String, npd_stage__c > ();
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        npdCollectionOption = new List < selectoption > ();
        List<String> collectionNamesLst = new list<String>();
        List < npd_stage__c > lstage = new List < npd_stage__c > ();
        npdCollectionOption.add(new selectoption('None', '--None--'));
        npdCollectionOption.add(new selectoption('All', 'All'));
        System.debug('++++++++++++++selectedBrandName++++++++++++++++++'+selectedBrandName);
                System.debug('++++++++++++++npdBrandManagerName++++++++++++++++++'+npdBrandManagerName);

        if(selectedBrandName == 'All' && selectedFiscalYear == 'None'){
            if(fromDate == null && toDate == null && npdBrandManagerName == 'None'){
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c];   
                System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
            }
           else if(fromDate != null && toDate != null && npdBrandManagerName == 'None'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }   
           else if(fromDate != null && toDate != null && npdBrandManagerName != 'None' && selectedType == 'Upstream'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND owner.name =: npdBrandManagerName];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }   
           else if(fromDate == null && toDate == null && npdBrandManagerName != 'None' && selectedType == 'Upstream'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where owner.name =: npdBrandManagerName];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }
                 System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
        }
        else if(selectedBrandName != 'All' && selectedBrandName != 'None' && selectedFiscalYear == 'None'){
            if(fromDate == null && toDate == null && npdBrandManagerName == 'None'){
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName];  
            }
           else if(fromDate != null && toDate != null && npdBrandManagerName == 'None'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND brand1__c =: selectedBrandName];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }   
           else if(fromDate != null && toDate != null && npdBrandManagerName != 'None' && selectedType == 'Upstream'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND owner.name =: npdBrandManagerName AND brand1__c =: selectedBrandName];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }   
           else if(fromDate == null && toDate == null && npdBrandManagerName != 'None' && selectedType == 'Upstream'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where owner.name =: npdBrandManagerName AND brand1__c =: selectedBrandName];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }
        }
        else if(selectedBrandName == 'All' && selectedFiscalYear != 'None' && fromDate == null && toDate == null){
                if (selectedFiscalYear == 'THIS_FISCAL_YEAR' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c = THIS_FISCAL_YEAR];
                else if (selectedFiscalYear == 'LAST_N_FISCAL_​YEARS:1' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c = LAST_FISCAL_YEAR];
                else if (selectedFiscalYear == 'LAST_N_FISCAL_​YEARS:2' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 1)];
                else if (selectedFiscalYear == 'LAST_N_FISCAL_​YEARS:3' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 2)];
                else if (selectedFiscalYear == 'NEXT_N_FISCAL_​YEARS:1' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c = NEXT_FISCAL_YEAR limit 999];
                else if (selectedFiscalYear == 'NEXT_N_FISCAL_​YEARS:2' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 1)];
                else if (selectedFiscalYear == 'NEXT_N_FISCAL_​YEARS:3' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
        }
        else if(selectedBrandName != 'All' && selectedBrandName != 'None' && selectedFiscalYear != 'None' && fromDate == null && toDate == null){
                if (selectedFiscalYear == 'THIS_FISCAL_YEAR')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Tentative_Launch_Month_Date__c = THIS_FISCAL_YEAR];
                else if (selectedFiscalYear == 'LAST_N_FISCAL_​YEARS:1')
                    lstage = [select id, name__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Tentative_Launch_Month_Date__c = LAST_FISCAL_YEAR];
                else if (selectedFiscalYear == 'LAST_N_FISCAL_​YEARS:2')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 1)];
                else if (selectedFiscalYear == 'LAST_N_FISCAL_​YEARS:3')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 2)];
                else if (selectedFiscalYear == 'NEXT_N_FISCAL_​YEARS:1')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Tentative_Launch_Month_Date__c = NEXT_FISCAL_YEAR limit 999];
                else if (selectedFiscalYear == 'NEXT_N_FISCAL_​YEARS:2')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 1)];
                else if (selectedFiscalYear == 'NEXT_N_FISCAL_​YEARS:3')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
        }

        
        for (npd_stage__c stage: lstage) {
            if (stage.npd_collections__r.Name != null) {
                CollectionName.put(stage.npd_collections__r.Name, stage);
            }
            system.debug('+++++++++++++++CollectionName+++++++++++++' + CollectionName.values());   
        }
        for (String name: CollectionName.keyset()) {
            collectionNamesLst.add(name);
            //npdCollectionOption.add(new selectoption(name, name));
        }
        collectionNamesLst.sort();
        
        for(String Names : collectionNamesLst){
            npdCollectionOption.add(new selectoption(Names, Names));
        }
    }
/***************************  End of selectCollection method   ************************************/

/***************************   selectYear is used to create picklist of npdfiscalYearOption list for storing data of fiscal year values  ****************/
    public void selectYear() {
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        Map < String, String > fiscalMap = new Map < String, String > ();
        npdfiscalYearOption = new List < selectoption > ();
        Date strToday = System.Today().addmonths(0);
        Integer currentFiscalYear = Integer.valueof([SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year'
            AND StartDate <=: strToday AND EndDate >=: strToday
        ].FiscalYearSettings.Name);
        npdfiscalYearOption.add(new selectoption('None', '--None--'));
        npdfiscalYearOption.add(new selectoption('LAST_N_FISCAL_​YEARS:3', String.ValueOf(currentFiscalYear - 3) + '-' + String.valueOf(currentFiscalYear - 2)));
        npdfiscalYearOption.add(new selectoption('LAST_N_FISCAL_​YEARS:2', String.ValueOf(currentFiscalYear - 2) + '-' + String.valueOf(currentFiscalYear - 1)));
        npdfiscalYearOption.add(new selectoption('LAST_N_FISCAL_​YEARS:1', String.ValueOf(currentFiscalYear - 1) + '-' + String.valueOf(currentFiscalYear)));
        npdfiscalYearOption.add(new selectoption('THIS_FISCAL_YEAR', String.ValueOf(currentFiscalYear) + '-' + String.valueOf(currentFiscalYear + 1)));
        npdfiscalYearOption.add(new selectoption('NEXT_N_FISCAL_​YEARS:1', String.ValueOf(currentFiscalYear + 1) + '-' + String.valueOf(currentFiscalYear + 2)));
        npdfiscalYearOption.add(new selectoption('NEXT_N_FISCAL_​YEARS:2', String.ValueOf(currentFiscalYear + 2) + '-' + String.valueOf(currentFiscalYear + 3)));
        npdfiscalYearOption.add(new selectoption('NEXT_N_FISCAL_​YEARS:3', String.ValueOf(currentFiscalYear + 3) + '-' + String.valueOf(currentFiscalYear + 4)));
        System.debug('+++++++fiscalMap++++++' + fiscalMap.values());
    }
/*********************************  End of selectYear method   *******************************************************/
/********************************* selectedType method is used to display and hide report type based on condition   **********************/
    public void selectedType() {  
        System.debug('+++++++++++++++++selectedType ++++++++++++++++++++++'+selectedType);
        npdBrandManagerOption  =  new List<selectoption>();
        npdDesignManagerOption  =  new List<selectoption>();
        if (selectedType == 'Upstream') {
            showUpstream = true;
            showDesign = false;
            selectBrandManager();
            selectDesignManager();
        }
        if (selectedType == 'Design') {
            showUpstream = false;
            showDesign = true;
        }
    }
/******************************* End of selectedType method    ***************************************/
/**************************************** Start displayTable method   ********************************/
    public void displayTable(){
        if(selectedType == 'Upstream'){
            displayTableUpstrfeam();
        }
        if(selectedType == 'Design'){
            displayTableDesign();
        }
    }
/********************************************* End of displayTable ********************************************************************/
/****************************************** This Table is used to display data when report type is design *****************************/    
    public void displayTableDesign(){
        selectedType();
        system.debug('lWrapperList'+lWrapperList);
        if (!lWrapperList.isEmpty()) {
        lWrapperList.clear();
        }
        Map<String,list<NPD_Project_Name__c>>  mCollectionToProject = new Map<String,List<NPD_Project_Name__c>>();
        map < String, NPD_Activity__c > mCheckListDBRDesign  = new map < String, NPD_Activity__c > ();
        map < String, NPD_Checklist__c > mCheckListPSY  = new map < String, NPD_Checklist__c > ();
        map < String, NPD_Activity__c > npdStageappDateProtecDesign = new map < String, NPD_Activity__c > ();  //
        map < String, NPD_Activity__c > npdActivityComplexityDesign = new map < String, NPD_Activity__c > ();  //
        map < String, NPD_Activity__c > npdActivityPlanLTDesign = new map < String, NPD_Activity__c > ();  //
        map < String, NPD_Activity__c > mActivityProtoDgnAED = new map < String, NPD_Activity__c > ();  //
        map < String, NPD_Activity__c > mActivityProtoMfgAslyAED = new map < String, NPD_Activity__c > ();  //
        map < String, NPD_Activity__c > mActivityFPDRComplexity = new map < String, NPD_Activity__c > ();  //
        map < String, NPD_Activity__c > mActivityIFPDRPlanLT = new map < String, NPD_Activity__c > ();  //
        map < String, NPD_Activity__c > mActivityProtoApprvl = new map < String, NPD_Activity__c > ();
        map < String, npd_stage__c > mStageWatchBOComp = new map < String, npd_stage__c > ();  //
        map < String, NPD_Activity__c > mActivityPlanOrderAED = new map < String, NPD_Activity__c > ();  //
        map < String, NPD_Activity__c > mActivityLaunchAED = new map < String, NPD_Activity__c > ();  //

        List<NPD_Project_Name__c> lproject = new List<NPD_Project_Name__c>();
        list < NPD_Activity__c > lCheckListDesign  =  new List < NPD_Activity__c > ();
        list < NPD_Activity__c > lCheckListProTecDesign      = new List < NPD_Activity__c > ();  //
        list < NPD_Activity__c > lActivityProtoDgnAED      = new List < NPD_Activity__c > ();  //
        list < NPD_Activity__c > lActivityListComplexityDesign      = new List < NPD_Activity__c > ();  //
        list < NPD_Checklist__c > lCheckListPSY  = new List < NPD_Checklist__c > (); 
        List<String> ProjectName = new List<String>();
        if (selectedCollectionName == 'All') {
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN: CollectionName.keyset()];    
            for(NPD_Project_Name__c project : lproject){
                ProjectName.add(project.Name);
                if(!mCollectionToProject.isEmpty() && mCollectionToProject.containskey(project.NPD_Collections__r.Name) && mCollectionToProject.get(project.NPD_Collections__r.Name) != null)
                {
                    mCollectionToProject.get(project.NPD_Collections__r.Name).add(project);
                }
                else{
                    mCollectionToProject.put(project.NPD_Collections__r.Name,new List<NPD_Project_Name__c>{project});
                }          
            }
            System.debug('+++++++++++mCollectionToProject++++++++++++++++++++'+mCollectionToProject.keyset());
            lCheckListDesign = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Dial blank release/proto drg release'];
            
            for (NPD_Activity__c activityList: lCheckListDesign) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mCheckListDBRDesign.put(activityList.NPD_Project_Name__r.Name,activityList);
                    system.debug('+++++++mCheckListDBRDesign++++++++++++++++++++'+mCheckListDBRDesign.keyset());
                }
            }
            
            lCheckListPSY = [Select id,project_name__c, Model_No__c,CollectionName__c, PSY_No__c, Collection__r.name, NPD_Activity_Chklist__r.Complexity_Typess__c,NPD_Activity_Chklist__r.Brand1__c from npd_checklist__c where CollectionName__c IN: CollectionName.keyset() AND NPD_Activity_Chklist__r.name__c = 'Make or Buy and Model No. Allocation' AND NPD_Activity_Chklist__r.Type__c ='Activity'];
            system.debug('--------lCheckListPSY---------'+lCheckListPSY);
            for (NPD_Checklist__c check: lCheckListPSY) {
                if (check.Model_No__c != null) {
                    mCheckListPSY.put(check.Model_No__c,check);
                   // system.debug('+++++++mCheckListDBRDesign++++++++++++++++++++'+mCheckListDBRDesign.keyset());
                   
                }
            }
            system.debug('--------mCheckListPSY-------'+mCheckListPSY);
            // Used to capture 2D Drawing/3D Model Release/Approval AED
            lCheckListProTecDesign = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = '2D Drawing/3D Model Release/Approval'];
            for (NPD_Activity__c activityList: lCheckListProTecDesign) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    npdStageappDateProtecDesign.put(activityList.NPD_Project_Name__r.Name, activityList);
                    system.debug('*******npdStageappDateProtecDesign*********'+npdStageappDateProtecDesign);
                }
            }
            // Used to capture Proto Design - Release AED
            lActivityProtoDgnAED = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Proto Design - Release'];
            for (NPD_Activity__c activityList: lActivityProtoDgnAED) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProtoDgnAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                    system.debug('*******mActivityProtoDgnAED*********'+mActivityProtoDgnAED);
                }
            }
            //  used for capturing Proto Manufacturing & Assembly AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Proto Manufacturing & Assembly']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProtoMfgAslyAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }   
            //  used for capturing Input - Final Product Design Plan Lead Time
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Input - Final Product Design']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityIFPDRPlanLT.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
            //  used for capturing Proto Approval
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Proto Approval']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProtoApprvl.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
            //  used for capturing Final Product Drawing Release Complexity
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Final Product Drawing Release']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityFPDRComplexity.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }       
            // used for Complexity calculatation based on component 
            lActivityListComplexityDesign  = [Select id,Complexity_Number__c,Component_Name__c, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND (name__c = 'Dial for Proto Mfg' OR name__c = 'Hands for Proto Mfg' OR name__c = 'Leather Strap For Proto Mfg' OR name__c = 'Glass for Proto Mfg' OR name__c = 'Crown for Proto Mfg' OR name__c = 'Metal Strap for Proto Mfg') Order By Complexity_Number__c Desc];
            for (NPD_Activity__c activityList: lActivityListComplexityDesign) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    if(npdActivityComplexityDesign.get(activityList.NPD_Project_Name__r.Name) == null){ 
                        npdActivityComplexityDesign.put(activityList.NPD_Project_Name__r.Name, activityList);
                    }
                }
            }
            // used for calculate Plan LT based on maximum of 
            for (NPD_Activity__c activityList: [Select id,Complexity_Number__c,Component_Name__c, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND (name__c = 'Dial for Proto Mfg' OR name__c = 'Hands for Proto Mfg' OR name__c = 'Leather Strap For Proto Mfg' OR name__c = 'Glass for Proto Mfg' OR name__c = 'Crown for Proto Mfg' OR name__c = 'Metal Strap for Proto Mfg') Order By Planned_Lead_Time__c Desc]) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    if(npdActivityPlanLTDesign.get(activityList.NPD_Project_Name__r.Name) == null){ 
                        npdActivityPlanLTDesign.put(activityList.NPD_Project_Name__r.Name, activityList);
                    }
                }
            }
            // used to capture Watch BO Component Development - Sub-stage - Actual End date
            for (npd_stage__c stage: [select id, name__c,Actual_End_Date__c,Actual_Start_Date__c,NPD_Project_Name__r.Name, brand1__c,Owner.name, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.name =: CollectionName.keyset() AND Name__c = 'Watch BO Component Development']) {
                if (stage.NPD_Project_Name__r.Name != null) {
                    mStageWatchBOComp.put(stage.NPD_Project_Name__r.Name, stage);
                }
            }
            //  used for capturing Planned Order Loading AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Planned Order Loading']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityPlanOrderAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }   
            //  used for capturing Watch Deposition AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Watch Deposition']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityLaunchAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }   
        }else{
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName];    
            for(NPD_Project_Name__c project : lproject){
                ProjectName.add(project.Name);
                if(!mCollectionToProject.isEmpty() && mCollectionToProject.containskey(project.NPD_Collections__r.Name) && mCollectionToProject.get(project.NPD_Collections__r.Name) != null)
                {
                    mCollectionToProject.get(project.NPD_Collections__r.Name).add(project);
                }
                else{
                    mCollectionToProject.put(project.NPD_Collections__r.Name,new List<NPD_Project_Name__c>{project});
                }          
            }
            System.debug('+++++++++++mCollectionToProject++++++++++++++++++++'+mCollectionToProject.keyset());
            lCheckListDesign = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Dial blank release/proto drg release'];
            
            for (NPD_Activity__c activityList: lCheckListDesign) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mCheckListDBRDesign.put(activityList.NPD_Project_Name__r.Name,activityList);
                    system.debug('+++++++mCheckListDBRDesign++++++++++++++++++++'+mCheckListDBRDesign.keyset());
                }
            }
            
            lCheckListPSY = [Select id,project_name__c, Model_No__c,CollectionName__c, PSY_No__c, Collection__r.name, NPD_Activity_Chklist__r.Complexity_Typess__c,NPD_Activity_Chklist__r.Brand1__c from npd_checklist__c where CollectionName__c =: selectedCollectionName AND NPD_Activity_Chklist__r.name__c = 'Make or Buy and Model No. Allocation' AND NPD_Activity_Chklist__r.Type__c ='Activity'];
            system.debug('--------lCheckListPSY---------'+lCheckListPSY);
            for (NPD_Checklist__c check: lCheckListPSY) {
                if (check.Model_No__c != null) {
                    mCheckListPSY.put(check.Model_No__c,check);
                   // system.debug('+++++++mCheckListDBRDesign++++++++++++++++++++'+mCheckListDBRDesign.keyset());
                   //system.debug('--------mCheckListPSY.keyset()---------'+mCheckListPSY.keyset());
                }
            }
            system.debug('--------mCheckListPSY-------'+mCheckListPSY);
            // Used to capture 2D Drawing/3D Model Release/Approval Activity Date
            lCheckListProTecDesign = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = '2D Drawing/3D Model Release/Approval'];
            for (NPD_Activity__c activityList: lCheckListProTecDesign) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    npdStageappDateProtecDesign.put(activityList.NPD_Project_Name__r.Name, activityList);
                    system.debug('*******npdStageappDateProtecDesign*********'+npdStageappDateProtecDesign);
                }
            }
            // Used to capture Proto Design - Release AED
            lActivityProtoDgnAED = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Proto Design - Release'];
            for (NPD_Activity__c activityList: lActivityProtoDgnAED) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProtoDgnAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                    system.debug('*******mActivityProtoDgnAED*********'+mActivityProtoDgnAED);
                }
            }
            //  used for capturing Proto Manufacturing & Assembly AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Proto Manufacturing & Assembly']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProtoMfgAslyAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }   
            //  used for capturing Input - Final Product Design Plan Lead Time
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Input - Final Product Design']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityIFPDRPlanLT.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
            //  used for capturing Proto Approval
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Proto Approval']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProtoApprvl.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
            //  used for capturing Final Product Drawing Release Complexity
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Final Product Drawing Release']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityFPDRComplexity.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }       
            // used for Complexity calculatation based on component 
            lActivityListComplexityDesign  = [Select id,Complexity_Number__c,Component_Name__c, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND (name__c = 'Dial for Proto Mfg' OR name__c = 'Hands for Proto Mfg' OR name__c = 'Leather Strap For Proto Mfg' OR name__c = 'Glass for Proto Mfg' OR name__c = 'Crown for Proto Mfg' OR name__c = 'Metal Strap for Proto Mfg') Order By Complexity_Number__c Desc];
            for (NPD_Activity__c activityList: lActivityListComplexityDesign) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    if(npdActivityComplexityDesign.get(activityList.NPD_Project_Name__r.Name) == null){ 
                        npdActivityComplexityDesign.put(activityList.NPD_Project_Name__r.Name, activityList);
                    }
                }
            }
            // used for calculate Plan LT based on maximum of 
            for (NPD_Activity__c activityList: [Select id,Complexity_Number__c,Component_Name__c, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND (name__c = 'Dial for Proto Mfg' OR name__c = 'Hands for Proto Mfg' OR name__c = 'Leather Strap For Proto Mfg' OR name__c = 'Glass for Proto Mfg' OR name__c = 'Crown for Proto Mfg' OR name__c = 'Metal Strap for Proto Mfg') Order By Planned_Lead_Time__c Desc]) {
                if (activityList.NPD_Project_Name__r.Name != null) {
                    if(npdActivityPlanLTDesign.get(activityList.NPD_Project_Name__r.Name) == null){ 
                        npdActivityPlanLTDesign.put(activityList.NPD_Project_Name__r.Name, activityList);
                    }
                }
            }
            // used to capture Watch BO Component Development - Sub-stage - Actual End date
            for (npd_stage__c stage: [select id, name__c,Actual_End_Date__c,Actual_Start_Date__c,NPD_Project_Name__r.Name, brand1__c,Owner.name, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.name =: selectedCollectionName AND Name__c = 'Watch BO Component Development']) {
                if (stage.NPD_Project_Name__r.Name != null) {
                    mStageWatchBOComp.put(stage.NPD_Project_Name__r.Name, stage);
                }
            }
            //  used for capturing Planned Order Loading AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Planned Order Loading']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityPlanOrderAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }   
            //  used for capturing Watch Deposition AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Watch Deposition']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityLaunchAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }           
        }
        for (NPD_Project_Name__c wProject : lproject) {
            wraperTable collectionTable = new wraperTable();
            collectionTable.collection = wProject.NPD_Collections__r.Name;             
            collectionTable.brand     = wProject.Brand1__c;
            collectionTable.model = wProject.Name;
            system.debug('-------wProject.Name---------'+wProject.Name);
            system.debug('--------mCheckListPSY.get(wProject.Name)---------'+mCheckListPSY.get(wProject.Name));
            if(wProject.Name != null && mCheckListPSY.get(wProject.Name) != null){
                collectionTable.Psynum   = mCheckListPSY.get(wProject.Name).PSY_No__c;
            }   
            if(wProject.Name != null && mCheckListDBRDesign.get(wProject.Name) != null){
                //collectionTable.designNo = mCheckListDBRDesign.get(wProject.Name).Design_No__c;
                
               // collectionTable.TechDesigner   = mCheckListDBRDesign.get(wProject.Name).Tech_Designer_Allocation__r.Name;
               // collectionTable.TechApproverName   = mCheckListDBRDesign.get(wProject.Name).Tech_Approver__r.Name;
                collectionTable.RelEndDate= mCheckListDBRDesign.get(wProject.Name).Actual_End_Date__c;
            }
            if(npdStageappDateProtecDesign.size()>0 && !(npdStageappDateProtecDesign.values()).isempty()&& npdStageappDateProtecDesign.get(wProject.Name)!=null)
                collectionTable.proendDate = npdStageappDateProtecDesign.get(wProject.Name).Actual_End_Date__c;
            collectionTable.ActLTDesign=(collectionTable.proendDate != null && collectionTable.RelEndDate != null) ? collectionTable.RelEndDate.daysbetween(collectionTable.proendDate) : null;
            system.debug('-------------key--------------'+npdActivityComplexityDesign.containsKey(wProject.Name));
            system.debug('-------------value--------------'+npdActivityComplexityDesign.get(wProject.Name));
            if(npdActivityComplexityDesign.size()>0 && !(npdActivityComplexityDesign.values()).isempty()&& npdActivityComplexityDesign.get(wProject.Name)!=null){
                collectionTable.ComplexityName = npdActivityComplexityDesign.get(wProject.Name).Complexity_Typess__c;
                collectionTable.designComplexity = npdActivityComplexityDesign.get(wProject.Name).Component_Name__c;
            }
            if(mActivityProtoDgnAED.size()>0 && !(mActivityProtoDgnAED.values()).isempty()&& mActivityProtoDgnAED.get(wProject.Name)!=null)
                collectionTable.protoDgnReleaseAED= mActivityProtoDgnAED.get(wProject.Name).Actual_End_Date__c;
            if(mActivityProtoMfgAslyAED.size()>0 && !(mActivityProtoMfgAslyAED.values()).isempty()&& mActivityProtoMfgAslyAED.get(wProject.Name)!=null){
                collectionTable.protoMfgAslyAED= mActivityProtoMfgAslyAED.get(wProject.Name).Actual_End_Date__c;
                collectionTable.protoMfgAslyPlanLT= mActivityProtoMfgAslyAED.get(wProject.Name).Planned_Lead_Time__c;   
            }
            if(npdActivityPlanLTDesign.size()>0 && !(npdActivityPlanLTDesign.values()).isempty()&& npdActivityPlanLTDesign.get(wProject.Name)!=null)
                collectionTable.designPlanLT = npdActivityPlanLTDesign.get(wProject.Name).Planned_Lead_Time__c + collectionTable.protoMfgAslyPlanLT;
            collectionTable.designProtoMfgLT=(collectionTable.protoMfgAslyAED != null && collectionTable.protoDgnReleaseAED != null) ? collectionTable.protoDgnReleaseAED.daysbetween(collectionTable.protoMfgAslyAED) : null;
            if(mActivityFPDRComplexity.size()>0 && !(mActivityFPDRComplexity.values()).isempty()&& mActivityFPDRComplexity.get(wProject.Name)!=null){
                collectionTable.designFPDRComplexity= mActivityFPDRComplexity.get(wProject.Name).Complexity_Typess__c;
                collectionTable.designFPDRATD= mActivityFPDRComplexity.get(wProject.Name).Actual_Start_Date__c;
                collectionTable.designFPDRAED= mActivityFPDRComplexity.get(wProject.Name).Actual_End_Date__c;
                collectionTable.designFPDRPlanLT= mActivityFPDRComplexity.get(wProject.Name).Planned_Lead_Time__c;
            }
            if(mActivityIFPDRPlanLT.size()>0 && !(mActivityIFPDRPlanLT.values()).isempty()&& mActivityIFPDRPlanLT.get(wProject.Name)!=null){
                collectionTable.designIFPDRlanLT= mActivityIFPDRPlanLT.get(wProject.Name).Planned_Lead_Time__c;
            }
            collectionTable.designIFPDRlanLTCal = 0;
            if( collectionTable.designIFPDRlanLT != null ){
                collectionTable.designIFPDRlanLTCal = collectionTable.designIFPDRlanLT ;
            }
            if( collectionTable.designFPDRPlanLT != null){
                collectionTable.designIFPDRlanLTCal +=  collectionTable.designFPDRPlanLT;
            }
            collectionTable.designFPDRLT=(collectionTable.designFPDRATD != null && collectionTable.designFPDRAED != null) ? collectionTable.designFPDRATD.daysbetween(collectionTable.designFPDRAED) : null;
            collectionTable.addDevStartDate = (collectionTable.designFPDRAED != null) ? collectionTable.designFPDRAED.addDays(1) : null;
            if(mStageWatchBOComp.size()>0 && !(mStageWatchBOComp.values()).isempty()&& mStageWatchBOComp.get(wProject.Name)!=null){
                collectionTable.watchBOCompDevAED= mStageWatchBOComp.get(wProject.Name).Actual_End_Date__c;
            }   
            collectionTable.addDevLT=(collectionTable.addDevStartDate != null && collectionTable.watchBOCompDevAED != null) ? collectionTable.addDevStartDate.daysbetween(collectionTable.watchBOCompDevAED) : null;         
            //modified by anindwita
            //collectionTable.planedOrderLodingSD = (collectionTable.watchBOCompDevAED != null) ? collectionTable.watchBOCompDevAED.addDays(1) : null;
            if(mActivityPlanOrderAED.size()>0 && !(mActivityPlanOrderAED.values()).isempty()&& mActivityPlanOrderAED.get(wProject.Name)!=null){
                collectionTable.planedOrderLodingAED= mActivityPlanOrderAED.get(wProject.Name).Actual_End_Date__c;
                collectionTable.planedOrderLodingSD = mActivityPlanOrderAED.get(wProject.Name).Actual_Start_Date__c;
            }
            collectionTable.planedOrderLodingLT=(collectionTable.planedOrderLodingAED != null && collectionTable.planedOrderLodingSD != null) ? collectionTable.planedOrderLodingSD.daysbetween(collectionTable.planedOrderLodingAED) : null;        
            collectionTable.launchSD = (collectionTable.planedOrderLodingAED != null) ? collectionTable.planedOrderLodingAED : null;
            if(mActivityLaunchAED.size()>0 && !(mActivityLaunchAED.values()).isempty()&& mActivityLaunchAED.get(wProject.Name)!=null){
                collectionTable.launchED= mActivityLaunchAED.get(wProject.Name).Actual_End_Date__c;
            }
            collectionTable.launchLT=(collectionTable.launchSD != null && collectionTable.launchED != null) ? collectionTable.launchSD.daysbetween(collectionTable.launchED) : null;         
            if(mActivityProtoApprvl.size()>0 && !(mActivityProtoApprvl.values()).isempty()&& mActivityProtoApprvl.get(wProject.Name)!=null){
                collectionTable.protoApprvSD= mActivityProtoApprvl.get(wProject.Name).Actual_Start_Date__c;
                collectionTable.protoApprvED= mActivityProtoApprvl.get(wProject.Name).Actual_End_Date__c;
            }
            lWrapperList.add(collectionTable);
        }
   }
 /*************************************************** END OF displayTableDesign       ******************************************************/
/******************************* displayTableUpstrfeam method is used to create WrapperTable and display data to the front End  **********************/
    public void displayTableUpstrfeam() {
        selectedType();
        system.debug('lWrapperList'+lWrapperList);
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        map < String, list<npd_stage__c > > npdStage = new map < String, list<npd_stage__c > > ();                    // map is uesd to display marketting brief Released and Acceptance date
        map < String, NPD_Activity__c > npdStageappDate = new map < String, NPD_Activity__c > ();       // map is used to store Concept Design App Date
        map < String, NPD_Activity__c > npdStageappDateED = new map < String, NPD_Activity__c > ();     // map is used to store Engineering Design - IDS
        map < String, NPD_Activity__c > npdStageappDateISCM = new map < String, NPD_Activity__c > ();   // map is used to store ISCM
        map < String, NPD_Activity__c > npdStageappDateProtec = new map < String, NPD_Activity__c > (); // map is used to store Proto Tech Design
        map < String, NPD_Activity__c > npdStageappDateRel = new map < String, NPD_Activity__c > ();
        map < String, NPD_Checklist__c > mCheckListEngg  = new map < String, NPD_Checklist__c > ();
        map < String, list<NPD_Checklist__c> > mCheckListMakeBuy  = new map < String, list<NPD_Checklist__c> > ();
        map < String, NPD_Checklist__c > mCheckListMakeBuyModel  = new map < String, NPD_Checklist__c > ();
        map < String, NPD_Activity__c > npdStageappConceptDate = new map < String, NPD_Activity__c > (); // map is used to store Concept Design - IDS start and end date
        map < String, list<NPD_Checklist__c> > mCheckListEngPSY = new map < String, list<NPD_Checklist__c> > ();
        map < String, NPD_Checklist__c > mapCheckListMakeBuy  = new map < String, NPD_Checklist__c> ();
        map < String, NPD_Checklist__c > mapCheckListEngPSY  = new map < String, NPD_Checklist__c> ();
        map < String, NPD_Activity__c > npdStageDatePBReleas = new map < String, NPD_Activity__c > ();
        map < String, NPD_Activity__c > npdStageDateProtodesign = new map < String, NPD_Activity__c > ();
        
        //   lWrapperList = new List<wraperTable>();
        list < NPD_Checklist__c > lCheckList         = new List < NPD_Checklist__c > ();
        list < NPD_Checklist__c > lCheckListEngg     = new List < NPD_Checklist__c > ();
        list < NPD_Checklist__c > lCheckListMakeBuy     = new List < NPD_Checklist__c > ();
        list < NPD_Activity__c > lCheckListCP        = new List < NPD_Activity__c > ();
        list < NPD_Activity__c > lCheckListED        = new List < NPD_Activity__c > ();
        list < NPD_Activity__c > lCheckListISCM      = new List < NPD_Activity__c > ();
        list < NPD_Activity__c > lCheckListProTec    = new List < NPD_Activity__c > ();
        list < NPD_Activity__c > lCheckListrele      = new List < NPD_Activity__c > ();
        list < NPD_Activity__c > lCheckListPBRelease   = new List < NPD_Activity__c > ();
        list < NPD_Activity__c > lCheckListCPDate    = new List < NPD_Activity__c > ();
        list < NPD_Activity__c > lCheckListProtoDesign    = new List < NPD_Activity__c > ();
        
        
        if (selectedCollectionName == 'All') {
            if(npdDesignManagerName != '' && npdDesignManagerName != 'None'){
                system.debug('+++++++++++++npdDesignManagerName+++++++++++++++++++'+npdDesignManagerName);
                lCheckList = [Select id, Design_No__c, Model_No__c,Product_Designer_Name__r.Name,Approval_Status__c,CollectionName__c, PSY_No__c, Collection__r.name, NPD_Activity_Chklist__r.Complexity_Typess__c, NPD_Activity_Chklist__r.Actual_Start_Date__c, NPD_Activity_Chklist__r.Actual_End_Date__c, NPD_Activity_Chklist__r.Planned_Lead_Time__c from npd_checklist__c where CollectionName__c IN: CollectionName.keyset() AND NPD_Activity_Chklist__r.name__c = 'Concept Presentation to PMG - IDS' AND Product_Designer_Name__r.Name=:npdDesignManagerName];    
            
            }else{
                system.debug('+++++++++++++npdDesignManagerName+++++++++++++++++++'+npdDesignManagerName);
                lCheckList = [Select id, Design_No__c, Model_No__c,Product_Designer_Name__r.Name,Approval_Status__c,CollectionName__c, PSY_No__c, Collection__r.name, NPD_Activity_Chklist__r.Complexity_Typess__c, NPD_Activity_Chklist__r.Actual_Start_Date__c, NPD_Activity_Chklist__r.Actual_End_Date__c, NPD_Activity_Chklist__r.Planned_Lead_Time__c from npd_checklist__c where CollectionName__c IN: CollectionName.keyset() AND NPD_Activity_Chklist__r.name__c = 'Concept Presentation to PMG - IDS'];    
            }
            
            lCheckListCPDate = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Concept Design - IDS'];
            for (NPD_Activity__c activityList: lCheckListCPDate) {
                System.debug('++++++++++++++++activityList.NPD_Collections__r.name+++++++++++++++++++'+activityList.NPD_Collections__r.name);
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappConceptDate.put(activityList.NPD_Collections__r.name, activityList);
                }
            }
            
            lCheckListEngg = [Select id, Design_No__c, Model_No__c,Engineering_Designer_Name__r.Name,Product_Designer_Name__r.Name,Approval_Status__c,CollectionName__c, PSY_No__c, Collection__r.name, NPD_Activity_Chklist__r.Complexity_Typess__c, NPD_Activity_Chklist__r.Actual_Start_Date__c, NPD_Activity_Chklist__r.Actual_End_Date__c, NPD_Activity_Chklist__r.Planned_Lead_Time__c from npd_checklist__c where CollectionName__c IN: CollectionName.keyset() AND NPD_Activity_Chklist__r.name__c = 'Engineering Design - IDS'];
            system.debug('------------lCheckListEngg--------------'+lCheckListEngg);
            for (NPD_Checklist__c check: lCheckListEngg) {
                if (check.Design_No__c != null) {
                    mCheckListEngg.put(check.Design_No__c,check);
                    system.debug('+++++++mCheckListEngg++++++++++++++++++++'+mCheckListEngg.keyset());
                }    
                if (check.CollectionName__c != null ) {
                
                    if(!mCheckListEngPSY.containsKey(check.CollectionName__c)){
                        mCheckListEngPSY.put(check.CollectionName__c,new List<NPD_Checklist__c>{check});
                    }else{
                        mCheckListEngPSY.get(check.CollectionName__c).add(check);
                    }
                    mapCheckListEngPSY.put(check.CollectionName__c+'_'+check.PSY_No__c,check);
                    system.debug('----------mCheckListEngPSY----------'+mCheckListEngPSY.keyset());
                }
                
            }
            system.debug('----------mapCheckListEngPSY----------'+mapCheckListEngPSY);
            lCheckListMakeBuy = [Select id, Model_No__c,CollectionName__c, PSY_No__c, Collection__r.name, NPD_Activity_Chklist__r.Complexity_Typess__c, NPD_Activity_Chklist__r.Actual_Start_Date__c, NPD_Activity_Chklist__r.Actual_End_Date__c, NPD_Activity_Chklist__r.Planned_Lead_Time__c from npd_checklist__c where CollectionName__c IN: CollectionName.keyset() AND NPD_Activity_Chklist__r.name__c = 'Make or Buy and Model No. Allocation'];
            system.debug('-------------lCheckListMakeBuy-------------'+lCheckListMakeBuy);
            for(NPD_Checklist__c checkMake: lCheckListMakeBuy){
                if (checkMake.CollectionName__c != null ) {
                    if(!mCheckListMakeBuy.containsKey(checkMake.CollectionName__c)){
                        mCheckListMakeBuy.put(checkMake.CollectionName__c,new List<NPD_Checklist__c>{checkMake});
                    }else{
                        mCheckListMakeBuy.get(checkMake.CollectionName__c).add(checkMake);
                    }
                    mapCheckListMakeBuy.put(checkMake.CollectionName__c+'_'+checkMake.PSY_No__c,checkMake);
                }
                
            }
            system.debug('----------mapCheckListMakeBuy----------'+mapCheckListMakeBuy);
           List < npd_stage__c > ldateStage = [select id, name__c, brand1__c,Owner.name, Actual_Start_Date__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.name =: CollectionName.keyset() AND Name__c = 'Marketing Brief/Concept' AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage'];
            for (npd_stage__c stage: ldateStage) {
                if (stage.npd_collections__r.Name != null) {
                    if(!npdStage.containsKey(stage.npd_collections__r.Name)){
                        npdStage.put(stage.npd_collections__r.Name, new list<npd_stage__c>{stage});
                    }else{
                        npdStage.get(stage.npd_collections__r.Name).add(stage);
                    }
                }
            }
            lCheckListCP = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Concept Presentation to PMG - IDS'];
            for (NPD_Activity__c activityList: lCheckListCP) {
                System.debug('++++++++++++++++activityList.NPD_Collections__r.name+++++++++++++++++++'+activityList.NPD_Collections__r.name);
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappDate.put(activityList.NPD_Collections__r.name, activityList);
                }
            }

            lCheckListED = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Engineering Design - IDS'];
            system.debug('lCheckListED******** ' + lCheckListED);
            for (NPD_Activity__c activityList: lCheckListED) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappDateED.put(activityList.NPD_Collections__r.name, activityList);
                }
            }

            lCheckListISCM = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c, ISCM_Briefing_Date__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Make or Buy and Model No. Allocation'];
            for (NPD_Activity__c activityList: lCheckListISCM) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappDateISCM.put(activityList.NPD_Collections__r.name, activityList);
                }
            }
        //added by Anindwita
        //  used for capturing 2D Drawing/3D Model Release/Approval Date
            lCheckListProTec = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = '2D Drawing/3D Model Release/Approval'];
            if(lCheckListProTec!=NUll){
                for (NPD_Activity__c activityList: lCheckListProTec) {
                    if (activityList.NPD_Collections__r.name != null) {
                        npdStageappDateProtec.put(activityList.NPD_Collections__r.name, activityList);
                         system.debug('*******npdStageappDateProtec*********'+npdStageappDateProtec);
                    }
                }
            }
            
        //  used for capturing Proto Dial Drawing Release and Receipt Date
            lCheckListrele = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Proto Dial Drawing Release and Receipt'];
          
            for (NPD_Activity__c activityList: lCheckListrele ) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappDateRel.put(activityList.NPD_Collections__r.name, activityList);
                     system.debug('*******npdStageappDateRel*********'+npdStageappDateRel);
                }
            }
            
        //  used for capturing PB/PM Release , Approval and Recipt Date
            lCheckListPBRelease = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'PB/PM Release , Approval and Recipt'];
          
            for (NPD_Activity__c activityList: lCheckListPBRelease ) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageDatePBReleas.put(activityList.NPD_Collections__r.name, activityList);
                     system.debug('*******npdStageDatePBReleas*********'+npdStageDatePBReleas);
                }
            }
            
        //  used for capturing Proto Design Input Date
            lCheckListProtoDesign = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Proto Design Input'];
          
            for (NPD_Activity__c activityList: lCheckListProtoDesign ) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageDateProtodesign.put(activityList.NPD_Collections__r.name, activityList);
                     system.debug('*******npdStageDateProtodesign*********'+npdStageDateProtodesign);
                }
            }
            
        } else {
            if(npdDesignManagerName != '' && npdDesignManagerName != 'None'){
                lCheckList = [Select id, Design_No__c, Model_No__c,Product_Designer_Name__r.Name, PSY_No__c,Approval_Status__c,CollectionName__c, Collection__r.name, NPD_Activity_Chklist__r.Actual_Start_Date__c, NPD_Activity_Chklist__r.Complexity_Typess__c, NPD_Activity_Chklist__r.Planned_Lead_Time__c, NPD_Activity_Chklist__r.Actual_End_Date__c from npd_checklist__c where CollectionName__c =: selectedCollectionName AND NPD_Activity_Chklist__r.name__c = 'Concept Presentation to PMG - IDS' AND Product_Designer_Name__r.Name=:npdDesignManagerName];
            }else{
                lCheckList = [Select id, Design_No__c, Model_No__c,Product_Designer_Name__r.Name, PSY_No__c,Approval_Status__c,CollectionName__c, Collection__r.name, NPD_Activity_Chklist__r.Actual_Start_Date__c, NPD_Activity_Chklist__r.Complexity_Typess__c, NPD_Activity_Chklist__r.Planned_Lead_Time__c, NPD_Activity_Chklist__r.Actual_End_Date__c from npd_checklist__c where CollectionName__c =: selectedCollectionName AND NPD_Activity_Chklist__r.name__c = 'Concept Presentation to PMG - IDS'];          
            }
            lCheckListEngg = [Select id, Design_No__c, Model_No__c,Engineering_Designer_Name__r.Name,Product_Designer_Name__r.Name, PSY_No__c,Approval_Status__c,CollectionName__c, Collection__r.name, NPD_Activity_Chklist__r.Actual_Start_Date__c, NPD_Activity_Chklist__r.Complexity_Typess__c, NPD_Activity_Chklist__r.Planned_Lead_Time__c, NPD_Activity_Chklist__r.Actual_End_Date__c from npd_checklist__c where CollectionName__c =: selectedCollectionName AND NPD_Activity_Chklist__r.name__c = 'Engineering Design - IDS'];
            system.debug('--------lCheckListEngg(else)------------'+lCheckListEngg);
            //modified by anindwita
            for (NPD_Checklist__c check: lCheckListEngg) {
                if (check.Design_No__c != null) {
                    mCheckListEngg.put(check.Design_No__c,check);
                }
                if (check.CollectionName__c != null ) {
                
                    if(!mCheckListEngPSY.containsKey(check.CollectionName__c)){
                        mCheckListEngPSY.put(check.CollectionName__c,new List<NPD_Checklist__c>{check});
                    }else{
                        mCheckListEngPSY.get(check.CollectionName__c).add(check);
                    }
                    mapCheckListEngPSY.put(check.CollectionName__c+'_'+check.PSY_No__c,check);
                }
                system.debug('--------mCheckListEngPSY(else)------------'+mCheckListEngPSY.keyset());
            }
            system.debug('----------mapCheckListEngPSY----------'+mapCheckListEngPSY);
            lCheckListMakeBuy = [Select id, Model_No__c,CollectionName__c, PSY_No__c, Collection__r.name, NPD_Activity_Chklist__r.Complexity_Typess__c, NPD_Activity_Chklist__r.Actual_Start_Date__c, NPD_Activity_Chklist__r.Actual_End_Date__c, NPD_Activity_Chklist__r.Planned_Lead_Time__c from npd_checklist__c where CollectionName__c =: selectedCollectionName AND NPD_Activity_Chklist__r.name__c = 'Make or Buy and Model No. Allocation'];
            system.debug('-------------lCheckListMakeBuyElse-------------'+lCheckListMakeBuy);
            for(NPD_Checklist__c checkMake: lCheckListMakeBuy){
                if (checkMake.CollectionName__c != null ) {
                    
                    if(!mCheckListMakeBuy.containsKey(checkMake.CollectionName__c)){
                        mCheckListMakeBuy.put(checkMake.CollectionName__c,new List<NPD_Checklist__c>{checkMake});
                    }else{
                        mCheckListMakeBuy.get(checkMake.CollectionName__c).add(checkMake);
                    }
                    mapCheckListMakeBuy.put(checkMake.CollectionName__c+'_'+checkMake.PSY_No__c,checkMake);
                }
                
            }
            system.debug('----------mapCheckListMakeBuy----------'+mapCheckListMakeBuy);
            
            lCheckListCPDate = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Concept Design - IDS'];
            for (NPD_Activity__c activityList: lCheckListCPDate) {
               // System.debug('++++++++++++++++activityList.NPD_Collections__r.name+++++++++++++++++++'+activityList.NPD_Collections__r.name);
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappConceptDate.put(activityList.NPD_Collections__r.name, activityList);
                }
            }
            
            List < npd_stage__c > ldateStage = [select id, name__c, brand1__c,Owner.Name, Actual_Start_Date__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.name =: selectedCollectionName AND Name__c = 'Marketing Brief/Concept' AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage'];
            for (npd_stage__c stage: ldateStage) {
                if (stage.npd_collections__r.Name != null) {
                    if(!npdStage.containsKey(stage.npd_collections__r.Name)){
                        npdStage.put(stage.npd_collections__r.Name, new list<npd_stage__c>{stage});
                    }else{
                    npdStage.get(stage.npd_collections__r.Name).add(stage);
                    }
                    System.debug('+++++++++++++stage Date+++++++++++++++'+stage.Approval_Submitted_Date__c);
                }
            }
            lCheckListCP = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Concept Presentation to PMG - IDS'];
            for (NPD_Activity__c activityList: lCheckListCP) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappDate.put(activityList.NPD_Collections__r.name, activityList);
                }
            }

            lCheckListED = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Engineering Design - IDS'];
            for (NPD_Activity__c activityList: lCheckListED) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappDateED.put(activityList.NPD_Collections__r.name, activityList);
                }
            }

            lCheckListISCM = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c, ISCM_Briefing_Date__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Make or Buy and Model No. Allocation'];
            for (NPD_Activity__c activityList: lCheckListISCM) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappDateISCM.put(activityList.NPD_Collections__r.name, activityList);
                }
            }

        //  used for capturing 2D Drawing/3D Model Release/Approval Date
            lCheckListProTec = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = '2D Drawing/3D Model Release/Approval'];
          
            for (NPD_Activity__c activityList: lCheckListProTec) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappDateProtec.put(activityList.NPD_Collections__r.name, activityList);
                    system.debug('*******npdStageappDateProtec*********'+npdStageappDateProtec);
                }
            
            }
        
        //  used for capturing Proto Dial Drawing Release and Receipt Date
            lCheckListrele = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Proto Dial Drawing Release and Receipt'];
          
            for (NPD_Activity__c activityList: lCheckListrele ) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageappDateRel.put(activityList.NPD_Collections__r.name, activityList);
                    
                }
            }
            
        //  used for capturing PB/PM Release , Approval and Recipt Date
            lCheckListPBRelease = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'PB/PM Release , Approval and Recipt'];
          
            for (NPD_Activity__c activityList: lCheckListPBRelease ) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageDatePBReleas.put(activityList.NPD_Collections__r.name, activityList);
                     system.debug('*******npdStageDatePBReleas*********'+npdStageDatePBReleas);
                }
            }
        
        //  used for capturing Proto Design Input Date
            lCheckListProtoDesign = [Select id, NPD_Collections__r.name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Proto Design Input'];
          
            for (NPD_Activity__c activityList: lCheckListProtoDesign ) {
                if (activityList.NPD_Collections__r.name != null) {
                    npdStageDateProtodesign.put(activityList.NPD_Collections__r.name, activityList);
                     system.debug('*******npdStageDateProtodesign*********'+npdStageDateProtodesign);
                }
            }
        }
        set<String> setPSY = new set<String>();
        
        for (NPD_Checklist__c checklist: lCheckList) {
            System.debug('-------checklist----------'+checklist);
            System.debug('++++++++++++++++++mCheckListEngg.get(checklist.design_no__c).Engineering_Designer_Name__r.Name++++++++++++++++++++++++++++++'+checklist.design_no__c);
            wraperTable collectionTable = new wraperTable();
            if(checklist.CollectionName__c !=  null){
                collectionTable.brand = CollectionName.get(checklist.CollectionName__c).brand1__c;
                //collectionTable.model = checklist.Model_No__c;
                system.debug('-------------mCheckListMakeBuy.get(checklist.CollectionName__c)-------------'+mCheckListMakeBuy.get(checklist.CollectionName__c));
                system.debug('-------------mCheckListEngPSY.get(checklist.CollectionName__c)-------------'+mCheckListEngPSY.get(checklist.CollectionName__c));
                if(checklist.CollectionName__c != null  && mCheckListMakeBuy.containsKey(checklist.CollectionName__c) && mCheckListMakeBuy.get(checklist.CollectionName__c) != null && mCheckListEngPSY.containsKey(checklist.CollectionName__c) && mCheckListEngPSY.get(checklist.CollectionName__c) != null){
                    for(NPD_Checklist__c eng :mCheckListEngPSY.get(checklist.CollectionName__c)){
                        system.debug('----eng--'+eng);
                        if(!setPSY.contains(checklist.CollectionName__c+'_'+eng.PSY_No__c) && mapCheckListMakeBuy.containsKey(checklist.CollectionName__c+'_'+eng.PSY_No__c) ){
                            NPD_Checklist__c chkMatch = mapCheckListMakeBuy.get(checklist.CollectionName__c+'_'+eng.PSY_No__c);
                            if(chkMatch != null){
                                collectionTable.Psynum = chkMatch.PSY_No__c;
                                collectionTable.model = chkMatch.Model_No__c;
                                setPSY.add(checklist.CollectionName__c+'_'+eng.PSY_No__c);
                                break;
                            }
                        }
                        
                       system.debug('--outer--setPSY--'+setPSY); 
                    }
                    //collectionTable.Psynum = mCheckListMakeBuy.get(checklist.CollectionName__c).PSY_No__c;
                    //collectionTable.model = mCheckListMakeBuy.get(checklist.CollectionName__c).Model_No__c;
                }
                
                collectionTable.designNo = checklist.design_no__c;
                collectionTable.collection = checklist.CollectionName__c;
                collectionTable.complexity = checklist.NPD_Activity_Chklist__r.Complexity_Typess__c;
                collectionTable.productDegName  = checklist.Product_Designer_Name__r.Name;
                if(checklist.design_no__c != null && mCheckListEngg.get(checklist.design_no__c) != null){
                   collectionTable.EnggDegName     = mCheckListEngg.get(checklist.design_no__c).Engineering_Designer_Name__r.Name;
                }
                collectionTable.conceptDgnApprovalSt = checklist.Approval_Status__c;
                collectionTable.id = checklist.NPD_Activity_Chklist__r.id;
                if(npdStage.size()>0 && !npdStage.isempty()&& npdStage.get(checklist.CollectionName__c)!=null && npdStage.containsKey(checklist.CollectionName__c)){
                    for(npd_stage__c stg :npdStage.get(checklist.CollectionName__c)){
                        collectionTable.submittedDate = stg.Actual_Start_Date__c;
                    }
                //collectionTable.submittedDate = npdStage.get(checklist.CollectionName__c).Actual_Start_Date__c;
                //collectionTable.approvedDate = npdStage.get(checklist.CollectionName__c).Approved_Date__c;
                //collectionTable.owner        = npdStage.get(checklist.CollectionName__c).owner.name;
                }
                collectionTable.noOfDays = (collectionTable.submittedDate != null && collectionTable.approvedDate != null) ? collectionTable.submittedDate.daysbetween(collectionTable.approvedDate) : null;
                if(npdStageappConceptDate.containsKey(checklist.CollectionName__c) && npdStageappConceptDate.get(checklist.CollectionName__c) != null){
                    collectionTable.startDate = npdStageappConceptDate.get(checklist.CollectionName__c).Actual_Start_Date__c;
                    collectionTable.endDate = npdStageappConceptDate.get(checklist.CollectionName__c).Actual_End_Date__c;
                }
                collectionTable.Approval = (npdStageappDate.get(checklist.CollectionName__c).Approval_Status__c == 'Approved' && npdStageappDate.get(checklist.CollectionName__c).Status__c == 'Completed') ? npdStageappDate.get(checklist.CollectionName__c).Actual_End_Date__c : null;
                collectionTable.conceptdesignLT = (collectionTable.startDate != null && collectionTable.Approval != null) ? collectionTable.startDate.daysbetween(collectionTable.Approval) : null;
                collectionTable.PlanLT = (npdStageappDate.get(checklist.CollectionName__c).Planned_Lead_Time__c + npdStageappConceptDate.get(checklist.CollectionName__c).Planned_Lead_Time__c);
                collectionTable.startDateEd = npdStageappDateED.get(checklist.CollectionName__c).Actual_Start_Date__c;
                collectionTable.endDateEd = npdStageappDateED.get(checklist.CollectionName__c).Actual_End_Date__c;
                collectionTable.PlanLTEd = npdStageappDateED.get(checklist.CollectionName__c).Planned_Lead_Time__c;
                if(npdStageappDateISCM.containsKey(checklist.CollectionName__c) && npdStageappDateISCM.get(checklist.CollectionName__c) != null){
                    collectionTable.ISCM = npdStageappDateISCM.get(checklist.CollectionName__c).ISCM_Briefing_Date__c;
                }
                collectionTable.endminusstart = (collectionTable.endDateEd != null && collectionTable.startDateEd != null) ? (collectionTable.startDateEd.daysbetween(collectionTable.endDateEd) + 1) : null;
                if(npdStageappDateRel.size()>0 &&!(npdStageappDateRel.values()).isempty()&& npdStageappDateRel.get(checklist.CollectionName__c)!=null){
                 collectionTable.protoStartDate= npdStageappDateRel.get(checklist.CollectionName__c).Actual_Start_Date__c;
                 collectionTable.protoEndDate= npdStageappDateRel.get(checklist.CollectionName__c).Actual_End_Date__c;
                } 
                if(npdStageappDateProtec.size()>0 && !(npdStageappDateProtec.values()).isempty()&& npdStageappDateProtec.get(checklist.CollectionName__c)!=null){
                    collectionTable.drawingStartDate = npdStageappDateProtec.get(checklist.CollectionName__c).Actual_Start_Date__c;
                    collectionTable.drawingEndDate = npdStageappDateProtec.get(checklist.CollectionName__c).Actual_End_Date__c;
                }
                if(npdStageDatePBReleas.size()>0 && !(npdStageDatePBReleas.values()).isempty()&& npdStageDatePBReleas.get(checklist.CollectionName__c)!=null){
                    collectionTable.pbReleaseStartDate = npdStageDatePBReleas.get(checklist.CollectionName__c).Actual_Start_Date__c;
                    collectionTable.pbReleaseEndDate = npdStageDatePBReleas.get(checklist.CollectionName__c).Actual_End_Date__c;
                }
                if(npdStageDateProtodesign.size()>0 && !(npdStageDateProtodesign.values()).isempty()&& npdStageDateProtodesign.get(checklist.CollectionName__c)!=null){
                    collectionTable.protoDesignStartDate = npdStageDateProtodesign.get(checklist.CollectionName__c).Actual_Start_Date__c;
                    collectionTable.protoDesignEndDate = npdStageDateProtodesign.get(checklist.CollectionName__c).Actual_End_Date__c;
                }
               collectionTable.ISCMLT = (collectionTable.ISCM != null && collectionTable.endDateEd!= null) ? collectionTable.endDateEd.daysbetween(collectionTable.ISCM) : null;
               lWrapperList.add(collectionTable);
           }
       }
    }
}