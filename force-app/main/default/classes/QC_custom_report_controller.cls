public class QC_custom_report_controller {
    public date tillDate{get;set;}
    //public QC_components__c dummy{get;set;}
    public date startDate{get;set;}
    public string compType{get;set;}
    public string finalVerdict{get;set;}
    public list<QC_Components__c> records;
    public Map<Id,list<QC_Components__c>> childCompMap{get;set;}
    public List <selectoption> qcBrandOption {get;set;}
    public String selectedBrandName {get;set;}
    public transient list<wrapperClass> toVF{get;set;}
    public transient list<wrapperClass> toVFDL{get;set;}
    public Set<string> compHeaders{get;set;}
    
    public Class wrapperClass{
        public QC_Components__c comp{get;set;}
        public list<testWrapper> testResults {get;set;}
        public wrapperClass(){
            testResults = new list<testWrapper>();
            comp = new QC_Components__c();
        }
    }
    public class testWrapper{
        public String testName{get;set;}
        public string Observation{get;set;}
        public string verdict{get;set;}
        
        public testWrapper(){
            testName = '-NA-';
            Observation ='-NA-';
            verdict = '-NA-';
        }
    }
    
    public QC_custom_report_controller(){
        // dummy = new qc_components__c();
        records = new list<QC_Components__c>();
        childCompMap = new Map<Id,list<QC_Components__c>>();
        selectBrand();
        toVF = new list<wrapperClass>();
        compHeaders = new Set<string>();
        
    }
    
    
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None--','--None--'));
        options.add(new SelectOption('All','All'));
        options.add(new SelectOption('Case','Case'));
        options.add(new SelectOption('Dial','Dial'));
        options.add(new SelectOption('Module','Module'));
        options.add(new SelectOption('Battery','Battery'));
        options.add(new SelectOption('Metal-Strap','Metal-Strap'));
        options.add(new SelectOption('Leather-Strap',' Leather-Strap'));
        options.add(new SelectOption('Special-Strap','Special-Strap'));
        options.add(new SelectOption('Packaging','Packaging'));
        options.add(new SelectOption('Full-Watch','Full-Watch'));//Full-Watch
        options.add(new SelectOption('Watch-Head','Watch-Head'));
        return options;
    }
    public  List<SelectOption> getverdicts() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None--','--None--'));
        options.add(new SelectOption('All','All'));
        options.add(new SelectOption('Accept','Accept'));
        options.add(new SelectOption('Reject','Reject'));
        options.add(new SelectOption('Conditional Accept','Conditional Accept'));
        options.add(new SelectOption('Clearance for Pilot','Clearance for Pilot'));
        options.add(new SelectOption('Dropped','Dropped'));
        return options;
    }
    public void selectBrand(){
        qcBrandOption  =  new List<selectoption>();
        qcBrandOption.add(new selectoption('None', '--None--'));
        qcBrandOption.add(new selectoption('All', 'All'));
        for (QC_Master__c master: [select id, Name from QC_Master__c where RecordType.Name = 'Brand Details' order by Name]) {
            qcBrandOption.add(new selectoption(master.name, master.Name));
        }
    }
    public void getComponents(){
        toVF = new list<wrapperClass>();
        list<QC_condition__c> testConditions = new list<QC_condition__c>();
        if( compType != 'All')
        	 testConditions = [Select Component_Type__c,Question_Name__c,RecordType.Name,Onload__c from QC_condition__c where Component_Type__c = :compType and RecordType.Name = 'Test Condition'  Order By Question_Name__c Asc];
        else
            testConditions = [Select Component_Type__c,Question_Name__c,RecordType.Name,Onload__c from QC_condition__c where RecordType.Name = 'Test Condition' Order By Question_Name__c Asc ];
        compHeaders.clear();
        for(QC_condition__c QC : testConditions){
            compHeaders.add(QC.Question_Name__c);
        }
        
        string query,dateAsString,endDateString;
        endDateString = String.ValueOf(tillDate)+'T00:00:00Z';
        dateAsString = String.ValueOf(startDate)+'T00:00:00Z';
        query = 'SELECT id,createdDate,Name,Name__c,Report_Ref_Number__c,Parent__c,Watch_variant__c,Model__c,Pending_lead_time__c,SKU_Reference__c,Vendor__c,General_Observation__c,Final_Verdict__c,Master__c,(Select Test_Name__c,Observation__c,Conclusion__c from QC_Test_Datas__r order by Test_Name__c ASC) from QC_Components__c ';
        if( compType != 'All')
        {
            If(finalVerdict == 'All'){
                if(selectedBrandName == 'All'){
                    query = query + '  where Name__c =\''+compType+'\''+' AND createdDate >'+dateAsString+' AND createdDate <'+endDateString +'Order By Name ';
                }
                else{
                    query = query + '  where Name__c =\''+compType+'\''+' AND createdDate >'+dateAsString+' AND createdDate <'+endDateString+ ' And Brand__r.Name=\''+selectedBrandName+'\'' +'Order By Name ';
                }
            }
            else{
                if(selectedBrandName == 'All'){
                    query = query + '  where Name__c =\''+compType+'\''+' and final_verdict__c = \''+finalVerdict+'\''+' AND createdDate >'+dateAsString+' AND createdDate <'+endDateString +'Order By Name '; 
                }
                else{
                    query = query + ' where Name__c =\''+compType+'\''+' and final_verdict__c = \''+finalVerdict+'\''+' AND createdDate >'+dateAsString+' AND createdDate <'+endDateString+ ' And Brand__r.Name=\''+selectedBrandName+'\'' +'Order By Name ';
                }
                
            }
        }
        else{
            If(finalVerdict == 'All'){
                if(selectedBrandName == 'All'){
                    query = query + ' where  createdDate >'+dateAsString+' AND createdDate <'+endDateString +'Order By Name ';
                }
                else{
                    query = query + ' where  createdDate >'+dateAsString+' AND createdDate <'+endDateString+ ' And Brand__r.Name=\''+selectedBrandName+'\'' +'Order By Name ';
                }
            }
            else{
                if(selectedBrandName == 'All'){
                    query = query + ' where final_verdict__c = \''+finalVerdict+'\''+' AND createdDate >'+dateAsString+' AND createdDate <'+endDateString +'Order By Name '; 
                }
                else{
                    query = query + ' where  final_verdict__c = \''+finalVerdict+'\''+' AND createdDate >'+dateAsString+' AND createdDate <'+endDateString+ ' And Brand__r.Name=\''+selectedBrandName+'\'' +'Order By Name ';
                }
                
            }
        }
        records = database.query(query);
        toVF.clear();
        childCompMap.clear();
        
        Set<Id> setOfParentCompId = new Set<Id>();
         

        for(QC_Components__c qc :  records){
            wrapperClass w1 = new wrapperClass();
            w1.comp = qc;
            list<testWrapper> testValues = new list<testWrapper>();
            for(QC_Test_Data__c qct :qc.QC_Test_Datas__r){
                testWrapper tw1 = new testWrapper();
                tw1.testName = qct.Test_Name__c;
                tw1.Observation = qct.Observation__c;
                tw1.verdict = qct.Conclusion__c;
                testValues.add(tw1); 
                
            }
            wrapperClass ww1 = new wrapperClass();
            ww1.comp = qc;
            if(testValues.size() >0)
                ww1.testResults = testValues;
            toVF.add(ww1);
            setOfParentCompId.add(qc.Id);
        }
         
        if( compType == 'Full-Watch' || compType == 'All' ){
            
            for( QC_Components__c qComp:[SELECT id,createdDate,Name,Name__c,Report_Ref_Number__c,Parent__c,Watch_variant__c,Model__c,SKU_Reference__c,Pending_lead_time__c,Vendor__c,General_Observation__c,Final_Verdict__c,Master__c,(Select Test_Name__c,Observation__c,Conclusion__c from QC_Test_Datas__r order by Test_Name__c ASC) from QC_Components__c where Parent__c=: setOfParentCompId  ] )
            {
                if(!childCompMap.containsKey(qComp.Parent__c)){
                    childCompMap.put( qComp.Parent__c,new List<QC_Components__c>{qComp});
                    system.debug(qComp);
                }
                else{
                    childCompMap.get( qComp.Parent__c ).add(qComp);
                    system.debug(qComp);
                }
            }
        }
    }
    
    public pageReference download(){
        pageReference pageRef = new PageReference('/apex/QC_custom_report_download');
        pageRef.getParameters().put('compType',compType);
        pageRef.getParameters().put('finalVerdict',finalVerdict);
        pageRef.getParameters().put('selectedBrandName',selectedBrandName);
        pageRef.getParameters().put('startDate',String.ValueOf(startDate));
        pageRef.getParameters().put('tillDate',String.ValueOf(tillDate));
        pageRef.setRedirect(true);
        system.debug('pageRef -->'+pageRef);
        return pageRef;
    }
    public void getDownloadComps(){
        
        string compTypeDL = ApexPages.currentPage().getParameters().get('compType');
        string finalVerdictDL = ApexPages.currentPage().getParameters().get('finalVerdict');
        string selectedBrandNameDL = ApexPages.currentPage().getParameters().get('selectedBrandName');
        string startDateDL = ApexPages.currentPage().getParameters().get('startDate');
        string tillDateDL = ApexPages.currentPage().getParameters().get('tillDate');
        system.debug('compTypeDL'+compTypeDL);
          string endDateStringDL = tillDateDL+'T00:00:00Z';
         string dateAsStringDL = startDateDL+'T00:00:00Z';
        list<QC_condition__c> testConditions = new list<QC_condition__c>();
        if( compTypeDL != 'All')
        	 testConditions = [Select Component_Type__c,Question_Name__c,RecordType.Name,Onload__c from QC_condition__c where Component_Type__c = :compTypeDL and RecordType.Name = 'Test Condition' and Onload__c = true];
        else
            testConditions = [Select Component_Type__c,Question_Name__c,RecordType.Name,Onload__c from QC_condition__c where RecordType.Name = 'Test Condition' ];
        compHeaders.clear();
        
        for(QC_condition__c QC : testConditions){
            //compHeaders.add(QC.Question_Name__c);
        } 
        system.debug('compHeaders'+compHeaders);
        string query;
        query = 'SELECT id,createdDate,Name,Name__c,Report_Ref_Number__c,Parent__c,Watch_variant__c,Model__c,SKU_Reference__c,Pending_lead_time__c,Vendor__c,General_Observation__c,Final_Verdict__c,Master__c,(Select Test_Name__c,Observation__c,Conclusion__c from QC_Test_Datas__r order by Test_Name__c ASC) from QC_Components__c ';
        
        if( compTypeDL != 'All' )
        {
            If(finalVerdictDL == 'All'){
                if(selectedBrandNameDL == 'All'){
                    query = query + 'where Name__c =\''+compTypeDL+'\''+' AND createdDate >'+dateAsStringDL+' AND createdDate <'+endDateStringDL;
                }
                else{
                    query = query + 'where Name__c =\''+compTypeDL+'\''+' AND createdDate >'+dateAsStringDL+' AND createdDate <'+endDateStringDL+ ' And Brand__r.Name=\''+selectedBrandNameDL+'\'';
                }
            }
            else{
                if(selectedBrandNameDL == 'All'){
                    query = query + 'where Name__c =\''+compTypeDL+'\''+' and final_verdict__c = \''+finalVerdictDL+'\''+' AND createdDate >'+dateAsStringDL+' AND createdDate <'+endDateStringDL; 
                }
                else{
                    query = query + 'where Name__c =\''+compTypeDL+'\''+' and final_verdict__c = \''+finalVerdictDL+'\''+' AND createdDate >'+dateAsStringDL+' AND createdDate <'+endDateStringDL+ ' And Brand__r.Name=\''+selectedBrandNameDL+'\'';
                }
            }
        }
        else{
            If(finalVerdictDL == 'All'){
                if(selectedBrandNameDL == 'All'){
                    query = query + 'where createdDate >'+dateAsStringDL+' AND createdDate <'+endDateStringDL;
                }
                else{
                    query = query + 'where createdDate >'+dateAsStringDL+' AND createdDate <'+endDateStringDL+ ' And Brand__r.Name=\''+selectedBrandNameDL+'\'';
                }
            }
            else{
                if(selectedBrandNameDL == 'All'){
                    query = query + 'where final_verdict__c = \''+finalVerdictDL+'\''+' AND createdDate >'+dateAsStringDL+' AND createdDate <'+endDateStringDL; 
                }
                else{
                    query = query + 'where final_verdict__c = \''+finalVerdictDL+'\''+' AND createdDate >'+dateAsStringDL+' AND createdDate <'+endDateStringDL+ ' And Brand__r.Name=\''+selectedBrandNameDL+'\'';
                }
            }
        }
        records = database.query(query);
        toVF.clear();
        childCompMap.clear();
        
        Set<Id> setOfParentCompId = new Set<Id>();
        for(QC_Components__c qc : records){
            wrapperClass w1 = new wrapperClass();
            w1.comp = qc;
            list<testWrapper> testValues = new list<testWrapper>();
            for(QC_Test_Data__c qct :qc.QC_Test_Datas__r){
                testWrapper tw1 = new testWrapper();
                tw1.testName = qct.Test_Name__c;
                tw1.Observation = qct.Observation__c;
                tw1.verdict = qct.Conclusion__c;
                testValues.add(tw1); 
            }
            wrapperClass ww1 = new wrapperClass();
            ww1.comp = qc;
            ww1.testResults = testValues;
            toVF.add(ww1);
            setOfParentCompId.add(qc.Id);
        }
        if( compTypeDL == 'Full-Watch' || compTypeDL == 'All' ){
            for( QC_Components__c qComp:[SELECT id,createdDate,Name,Name__c,Report_Ref_Number__c,Parent__c,Watch_variant__c,Model__c,SKU_Reference__c,Pending_lead_time__c,Vendor__c,General_Observation__c,Final_Verdict__c,Master__c,(Select Test_Name__c,Observation__c,Conclusion__c from QC_Test_Datas__r order by Test_Name__c ASC) from QC_Components__c where Parent__c=: setOfParentCompId  ] )
            {
                if(!childCompMap.containsKey(qComp.Parent__c)){
                    childCompMap.put( qComp.Parent__c,new List<QC_Components__c>{qComp});
                    system.debug(qComp);
                }
                else{
                    childCompMap.get( qComp.Parent__c ).add(qComp);
                    system.debug(qComp);
                }
            }
        }
    }
}