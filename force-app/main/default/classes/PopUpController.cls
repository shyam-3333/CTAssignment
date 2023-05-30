global class PopUpController{
   
    public string strType{get;set;}  
    public string Model{get;set;}   
    public string brandValue{get;set;}
    public string subBrand{get;set;}
    public string Brand{get;set;}
    public string UserName{get;set;}
    public string TAG{get;set;}
    public string PSY{get;set;}
    public string SRC{get;set;}
    public string VEN{get;set;}
    public string GEN{get;set;}
    public string SUPAGENCY{get;set;}
    public String strComCat {get; set;}
    public string SubBrandComponent{get;set;}
    public string BrandComponent{get;set;}
    public string UserComponent{get;set;}
    Public String complexType {get; set;}
    Public String ActivityName {get; set;}
    public Decimal numLeadTime {get;set;}
    public String strLeadTime {get; set;}
   // public String strComCat {get; set;}
    public String strCheklistName{get;set;}
    public String strCopyTableName{get; set;}
    public String strPIRecName{get;set;}   
    public String strComplexity{get;set;}
    public List<NPD_Complexity__c> complexityList{get;set;}  
    public List<complexWrapper> ComplexWrapperList{get; set;}   
    public List<SubBrandWrapper> SubBrandWrapperList{get; set;}
    public List<BrandWrapper> BrandWrapperList{get; set;}
    public List<UserWrapper> UserWrapperList{get; set;}
    public List<ModelWrapper> ModelWrapperList{get; set;} 
    //Public string SRCIO{get; set;}  
    public string recsource{set;get;}
    Public string textval{get;set;}                        // modified by sai for assigning task module
    public list<NPD_Master__c>  npdmasteruser  {set;get;}  
    
    

    
    
        /********************   Code by sai for assigning task module  ***********************************/

    
    
    // To display the list of complexity Categories based on Type
    
    /*******************************************************************************************
    public List<complexWrapper> getcomplexityValues(){   
            ComplexWrapperList = new List<complexWrapper>(); 
            complexType = ApexPages.currentPage().getParameters().get('comType');
             ActivityName =  ApexPages.currentPage().getParameters().get('title');
             system.debug('*********Name*****'+ActivityName);
             strType = ApexPages.currentPage().getParameters().get('type');
             
            if(complexType != NULL && complexType !=''){
            if(strType == 'Activity') { 
                 
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE Complexity_Type__r.Name__c =:complexType AND Record_Type__c ='Complexity Category' AND NPD_Activity__c != NULL AND NPD_Activity__r.Title__c =: ActivityName AND Sub_Stage__r.Title__c= 'Case Development - INH' ORDER BY Name__c ASC]){
               
            ComplexWrapperList.add(new complexWrapper(com)); 
            }
          }
            else if(ActivityName == 'Case Development - INH'){
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE Complexity_Type__r.Name__c =:complexType   AND Record_Type__c ='Complexity Category' AND Sub_Stage__c != NULL AND Sub_Stage__r.Title__c=: ActivityName AND NPD_Activity__c = NULL ORDER BY Name__c ASC]){
             ComplexWrapperList.add(new complexWrapper(com)); 
            }
         }
      }    
          if(ComplexWrapperList.isempty()){
          
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There are no Categories for the selected Complexity Type'));
                return null;
          }      
        return ComplexWrapperList;
    }   

    // Method to display Complexity Types
    public List<complexWrapper> getcomplexityTypeValues(){   
            ComplexWrapperList = new List<complexWrapper>(); 
            complexType = ApexPages.currentPage().getParameters().get('comType');
             ActivityName =  ApexPages.currentPage().getParameters().get('title');
             strType = ApexPages.currentPage().getParameters().get('type');
            if(strType == 'Activity') {                 
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE  Record_Type__c ='Complexity Type' AND Type__c='Activity' ORDER BY Name__c ASC]){               
            ComplexWrapperList.add(new complexWrapper(com)); 
            
            }
           }
            else {
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE Record_Type__c ='Complexity Type' AND Type__c ='Sub-stage' ORDER BY Name__c ASC]){
             ComplexWrapperList.add(new complexWrapper(com)); 
            }
         }
          
        return ComplexWrapperList;
    }   
    
    ********************************************************************************************************************/
    
    
       public List<complexWrapper> getcomplexityValues(){   
            ComplexWrapperList = new List<complexWrapper>(); 
            complexType = ApexPages.currentPage().getParameters().get('comType');
             ActivityName =  ApexPages.currentPage().getParameters().get('title');
             system.debug('*********Name*****'+ActivityName);
             strType = ApexPages.currentPage().getParameters().get('type');
             
            if(complexType != NULL && complexType !=''){
            if(strType == 'Activity' || strType == 'Sub-Activity') { 
                 
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE Complexity_Type__r.Name__c =:complexType AND Record_Type__c ='Complexity Category' AND NPD_Activity__c != NULL AND NPD_Activity__r.Title__c =: ActivityName AND Sub_Stage__r.Title__c= 'Case Development - INH' ORDER BY Name__c ASC]){
               
            ComplexWrapperList.add(new complexWrapper(com)); 
            }
          }
            else if(ActivityName == 'Case Development - INH'){
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE Complexity_Type__r.Name__c =:complexType   AND Record_Type__c ='Complexity Category' AND Sub_Stage__c != NULL AND Sub_Stage__r.Title__c=: ActivityName AND NPD_Activity__c = NULL ORDER BY Name__c ASC]){
             ComplexWrapperList.add(new complexWrapper(com)); 
            }
         }
      }    
          if(ComplexWrapperList.isempty()){
          
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There are no Categories for the selected Complexity Type'));
                return null;
          }      
        return ComplexWrapperList;
    }   

    // Method to display Complexity Types
    public List<complexWrapper> getcomplexityTypeValues(){   
            ComplexWrapperList = new List<complexWrapper>(); 
            complexType = ApexPages.currentPage().getParameters().get('comType');
             ActivityName =  ApexPages.currentPage().getParameters().get('title');
                   
             
             strType = ApexPages.currentPage().getParameters().get('type');
             recsource = ApexPages.currentPage().getParameters().get('source');
             
             system.debug('the value of recsource is: ' + recsource);
             system.debug('the value of recsource is:ActivityName  ' + ActivityName );
            
             
            if(strType == 'Activity' ) {                 
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE  Record_Type__c ='Complexity Type' AND Type__c='Activity'  AND record_name__c=:ActivityName AND source__c=:recsource ORDER BY Name__c ASC]){               
            ComplexWrapperList.add(new complexWrapper(com)); 
            
            }
           }
            else {
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE Record_Type__c ='Complexity Type' AND Type__c ='Sub-stage' AND record_name__c=:ActivityName AND source__c=:recsource ORDER BY Name__c ASC]){
             ComplexWrapperList.add(new complexWrapper(com)); 
            }
         }
          
        return ComplexWrapperList;
    }   
 
    
    //Method to display Brand
    
     public List<BrandWrapper> getBrandValues(){   
            BrandWrapperList = new List<BrandWrapper>(); 
            BrandComponent = ApexPages.currentPage().getParameters().get('BrandComponent');
            brandValue       =  ApexPages.currentPage().getParameters().get('brandValue');     
            For(NPD_Master__c com:[SELECT ID,Name,Brand__c,Type__c FROM NPD_Master__c where Type__c='Brand' ORDER BY Name ASC ]){               
            BrandWrapperList.add(new BrandWrapper(com));             
            }
  
        return BrandWrapperList;
    } 
   
    //Method to display Sub Brands for the selected Brand
     public List<SubBrandWrapper> getSubBrandValues(){   
            SubBrandWrapperList = new List<SubBrandWrapper>(); 
            SubBrandComponent = ApexPages.currentPage().getParameters().get('SubBrandComponent');
            brandValue       =  ApexPages.currentPage().getParameters().get('brandValue'); system.debug('==brandValue=='+brandValue);
            if(!string.isblank(brandValue)) {                  
            For(NPD_Master__c com:[SELECT ID,Name,Brand__c,Type__c FROM NPD_Master__c WHERE Brand__r.Name =: brandValue ORDER BY Name ASC ]){       
            SubBrandWrapperList.add(new SubBrandWrapper(com));             
            }
           }
            else {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please Select a Brand first'));
                return null; 
            }
            
         if(SubBrandWrapperList.isempty()){
         
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There are no Sub-Brandsfor the selected Brand'));
                return null; 
         }
          
        return SubBrandWrapperList;
    } 
    
    
    //Method to display Salesforceuser
    
     public List<UserWrapper>   getUserValues(){   
            UserWrapperList = new List<UserWrapper>(); 
            UserComponent = ApexPages.currentPage().getParameters().get('taskid');
                 
            For(NPD_Master__c com:[SELECT ID,Name,SalesforceUser__c,SalesforceUser__r.email, Type__c,UserID__c FROM NPD_Master__c where Type__c='TaskOwner' ORDER BY Name ASC ]){               
            UserWrapperList .add(new UserWrapper(com));             
            }
  
        return UserWrapperList ;
    } 
    
    
    
    
    //Method to display List of Model Number based on the Activities Checklist Item.
     public List<ModelWrapper> getModelValues(){   
            ModelWrapperList = new List<ModelWrapper>(); 
           
            ActivityName =  ApexPages.currentPage().getParameters().get('ActID');
            
             strType     =  ApexPages.currentPage().getParameters().get('ModelComponent');// AND approval_status__c = 'Approved'
          
            if(!string.isblank(ActivityName)) { 
                 //,PSY_No__c AND approval_status__c = 'Approved'
            For(NPD_Checklist__c com:[SELECT ID,PSY_No__c,Name,Model_No__c,Vendor_Ref_No__c,Case_Sourcing__c,Supply_Agency__c,Gender__c,Tag__c FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__c =:ActivityName ]){
               
            ModelWrapperList.add(new ModelWrapper(com));            
            }
           }
            else {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please Select a Stage'));
                return null; 
            }
            
         if(ModelWrapperList.isempty()){         
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There are no Models for the Collection'));
                return null; 
         }
          
        return ModelWrapperList;
    }                 
        //Method to get selected Sub-Brand from the Masters
    public void doComplexitySelection(){                             
        for(complexWrapper cw : ComplexWrapperList ){        
            if(cw.com.Name__c == strComCat){          
                if(cw.com.Lead_Time_del__c != NULL)                  
                    numLeadTime = cw.com.Lead_Time_del__c;                     
            }
         }            
    }
    
     //Method to get selected Model from the Checklist
    public void doModelSelection(){    
                 
        for(ModelWrapper cw : ModelWrapperList ){ 
         if(cw.com.Model_No__c == strComCat){
            Model = cw.com.Model_No__c;
            
            SUPAGENCY=cw.com.Supply_Agency__c;
             
             PSY   =  cw.com.PSY_No__c;
            
             SRC   =  cw.com.Case_Sourcing__c;
             
             VEN   =  cw.com.Vendor_Ref_No__c;
             
             GEN   =  cw.com.Gender__c;
             
             TAG   =  cw.com.Tag__c;
             
             system.debug('GENtagtag'+TAG);
                    
           }
         }            
    }
         public void doBrandSelection(){                     
        for(BrandWrapper cw : BrandWrapperList ){          
            if(cw.com.Name == strComCat){
            Brand = cw.com.Name;                                  
            }                       
         }            
    }      
        
        //Method to get selected checklist from the Checklist Columns 
    public void doSubBrandSelection(){    
                 
        for(SubBrandWrapper cw : SubBrandWrapperList ){ 
         system.debug('*************subBrand *Name****'+strComCat);
          system.debug('*************cw.com.Name****'+cw.com.Name);
            if(cw.com.Name == strComCat){
            subBrand = cw.com.Name;           
              system.debug('************subBrand *'+subBrand );
            }
            
           
         }            
    }
    
    
    public void doUserSelection(){                     
        for(UserWrapper cw : UserWrapperList ){          
            if(cw.com.Name == strComCat){
            UserName= cw.com.Name;                                  
            }                       
         }            
    }  
    
    
    public class UserWrapper {
        
       
        public NPD_Master__c com{get;set;}
        
            public UserWrapper (NPD_Master__c c) {           
                    com = c;
                    
                    
            }
        }
    
    
    //
    public class BrandWrapper{
        
       
        public NPD_Master__c com{get;set;}
        
            public BrandWrapper(NPD_Master__c c) {           
                    com = c;
                    
                    
            }
        }
        
         //Class for Sub Brand selection in popup
        public class SubBrandWrapper{
        
        public Boolean selected {get; set;}  
        public NPD_Master__c com{get;set;}
        
            public SubBrandWrapper(NPD_Master__c c) {           
                    com = c;
                    selected = false;
                    
            }
        }
        
         //Class for Sub Brand selection in popup
        public class ModelWrapper{
        
        public Boolean selected {get; set;}  
        public NPD_Checklist__c com{get;set;}
        
            public ModelWrapper(NPD_Checklist__c c) {           
                    com = c;
                    selected = false;
                    
            }
        }
        
        
        
        //Class for Complexity Category selection in popup
        public class complexWrapper{
        
        public Boolean selected {get; set;}  
        public NPD_Complexity__c com{get;set;}
        
            public complexWrapper(NPD_Complexity__c c) {           
                    com = c;
                    selected = false;
                    
            }
        }
   }