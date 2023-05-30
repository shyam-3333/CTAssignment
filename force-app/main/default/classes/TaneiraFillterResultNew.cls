public class TaneiraFillterResultNew {
    
    Public Integer size{get;set;} 
    Public Integer noOfRecords{get; set;} 
    public string product {get; set;}
    public List<Product__c> searchResults {get; set; }    
    public List<SelectOption> paginationSizeOptions{get;set;}
    
    public List<SelectOption> getItems() {
		List<SelectOption> options = new List<SelectOption>(); 
		options.add(new SelectOption('SKU','SKU')); 
		options.add(new SelectOption('Vendor Prod Code','Vendor Prod Code')); 		
        return options; 
	}
    public string searchText
    {
        get
        {
            if (searchText==null) searchText = '';
            return searchText;
        }
        set;
	}
   public PageReference search()
    {
        if(SearchResults == null)
        {
        	SearchResults = new List<Product__c>();
        }
        else
        {
        	SearchResults.Clear();
        } 	   
            String qry = 'Select SKU_Code__c,Vendor_code__c from Product__c where SKU_Code__c  like \'%'+searchText+'%\' ';
            SearchResults = Database.query(qry);
            return null;
    }
 	 public string selectedAsset {get;set;}
   	 public PageReference assetClicked() 
    {
        PageReference redirect = new PageReference('/apex/newPage'); 
        redirect.getParameters().put('id',selectedAsset); 
    	redirect.setRedirect(true); 

   		 return redirect;
    }
    
    public TaneiraFillterResultNew(){    
       size=10;
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('5','5'));
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));          
    }
     
    public ApexPages.StandardSetController setCon {
        
        get {
            Id productRecordType = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
            if(setCon == null) {                
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                      [Select Id,name,Photo__c,Vendor_code__c,SKU_Code__c,Product_Category_Taneira__c,Vendor_Name__c,Proc_Type__c,Proc_Source__c,PO_Number__c,Cost__c,Quantity__c,Suggested_MRP__c,Cluster__c,Design_Story__c,Story_1__c,Story_2__c,Design_Description__c,Material_Wrap__c,Weft__c,Zari_Type__c,Base_Colour__c,Detailed_Colour__c,Workmanship__c,
                       Loom__c,Occasion__c,Fold__c,Fabric__c,Collection__c,Blouse_Dimensions__c,Blouse_Type__c,Blouse_Size__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c FROM Product__c where RecordTypeId = :productRecordType]));
                setCon.setPageSize(size);  
                noOfRecords = setCon.getResultSize();
            }            
            return setCon;
        }
        set;
    }
     
    //Changes the size of pagination
    public PageReference refreshPageSize() {
         setCon.setPageSize(size);
         return null;
    }

    public List<Product__c> getproducts() {
        list<Product__c> prd = setCon.getRecords();
         system.debug('-----prd-------'+prd.size());
         return (List<Product__c>) setCon.getRecords();      
    }		
}