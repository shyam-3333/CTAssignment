public with sharing class TaneiraPortalSearch {
	//Variable declaration
    Public  String   seachKeyWord{get;set;}
    public  boolean  advanceSearchDisplay{get;set;}
    public String[] autoFillData{get;set;}
    List<advanceSearchWrraper> vendorList;
    List<advanceSearchWrraper> originList;
    List<advanceSearchWrraper> proCatList;
    string selectedVendors;
    string selectedOrigin;
    string selectedCateg;
    Id productRecordType;
    public  String profileName{get;set;}
    public string searchCategory{get;set;}
    public TaneiraPortalSearch(){
    	seachKeyWord = null; 
        searchCategory = 'SKU';
        profileName =  apexpages.currentPage().getParameters().get('profileName');
        if(profileName == 'Ask Me Taneira Vendor-Taneira Vendor'){
        	advanceSearchDisplay = false;    
        }
        else{
        	advanceSearchDisplay = true;    
        }
        vendorList = new List<advanceSearchWrraper>();
        originList = new List<advanceSearchWrraper>();
        proCatList = new List<advanceSearchWrraper>();
        selectedVendors = '';
        selectedOrigin = '';
        selectedCateg = '';
        autoFillData = new List<String>();
        productRecordType = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        getautoFillDataList();
    }
    //code to get list of vendors for advance search
    public List<advanceSearchWrraper> getVendorList(){
    	vendorList = new advanceSearchWrraper[1];
         // code to vendors name
        Id vendorRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        List<Account> vendors = [SELECT Id,Name FROM Account WHERE RecordTypeId =: vendorRecordTypeId];
        advanceSearchWrraper searcRecAll = new advanceSearchWrraper();
        searcRecAll.name = 'All';
        vendorList.set(0, searcRecAll);
        for(Account acc : vendors){
        	advanceSearchWrraper searcRec = new advanceSearchWrraper();
            searcRec.name = acc.name;
            vendorList.add(searcRec);
        }
        return vendorList;
    }
    //method to list of origin for advance search
    public List<advanceSearchWrraper> getOriginList(){
        originList = new advanceSearchWrraper[1];
        List<Master__c> masterList = [Select Id, Name,Name__c FROM Master__c WHERE Active__c=TRUE and Name__c =: 'Origin'];
        advanceSearchWrraper searcRecAll = new advanceSearchWrraper();
        searcRecAll.name = 'All';
        originList.set(0, searcRecAll);
        for(Master__c org : masterList){
        	advanceSearchWrraper searcRec = new advanceSearchWrraper();
            searcRec.name = org.name; 
            originList.add(searcRec);
        }
        return originList;
    }
    //method to get list of product category
    public List<advanceSearchWrraper> getProCatList(){
    	proCatList = new advanceSearchWrraper[0];
        List<Master__c> masterList = [Select Id, Name,Name__c FROM Master__c WHERE Active__c=TRUE and Name__c =: 'Product Category'];
        advanceSearchWrraper searcRecAll = new advanceSearchWrraper();
        //searcRecAll.name = 'All';//made changes here by Rahul(Commented to check if All is not visible!!)
        //proCatList.set(0, searcRecAll);//To avoid the response size in VF,which should be below 15 MB.
        for(Master__c proCat : masterList){
        	advanceSearchWrraper searcRec = new advanceSearchWrraper();
            searcRec.name = proCat.name; 
            proCatList.add(searcRec);
        }
        return proCatList;
    }
    //On load action method declaration for session management
    public pagereference  sessionManagement(){
        
      PageReference pr =null;  
      Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '900', and isSecure 'false'. 
        if (counter == null) {
                pr = new PageReference('/apex/NewLogin');
                pr.setredirect(true);
        } else {
        
        // If this isn't the first time the user is accessing the page
        // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
        }        
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});

        return pr;
    }//End of method
     //Method for navigating to refined search page for product user or final result page for process user with search key  values
    public pageReference searchProduct(){
    	advanceSearchDisplay = (profileName =='Ask Me Taneira Vendor-Taneira Vendor')?false:true;
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr = new PageReference('/apex/NewLogin');
                pr.setredirect(true);
                pr.setCookies(new Cookie[]{counter});
                return pr;
                
        } else {
        
            // If this isn't the first time the user is accessing the page
            // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
        
        }
        
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
      
        string url           =  '';
        if(string.isBlank(seachKeyWord)){
            for(advanceSearchWrraper ven : vendorList){
                if(ven.isSelected == true && ven.name == 'All'){
                	selectedVendors = ven.name;
                    break;
                }
                else if(ven.isSelected == true){
                    if(selectedVendors == '')
                    	selectedVendors = ven.name;
                    else
                        selectedVendors = selectedVendors + ','+ven.name;
                }
            } 
            for(advanceSearchWrraper org : originList){
                if(org.isSelected == true && org.name == 'All'){
                	selectedOrigin = org.name;
                    break;
                }
                if(org.isSelected == true){
                    if(selectedOrigin == '')
                    	selectedOrigin = org.name;
                    else
                        selectedOrigin = selectedOrigin + ','+org.name;
                }
            } 
            System.debug('======proCatList===>>'+proCatList);
            for(advanceSearchWrraper cat : proCatList){
                /*if(cat.isSelected == true && cat.name == 'All'){
                	selectedCateg = cat.name;
                    break;
                }*/
                System.debug('====cat.isSelected====='+cat.isSelected);
                System.debug('==-==cat.name===='+cat.name);
                if(cat.isSelected == true){
                    if(selectedCateg == '')
                    	selectedCateg = cat.name;
                    else
                        selectedCateg = selectedCateg + ','+cat.name;
                }
            }System.debug('=====selectedCateg----->>'+selectedCateg);
            url='/apex/TaneiraFillterResult?profileName='+profileName+'&Vendors='+selectedVendors+'&origin='+selectedOrigin+'&selectedCateg='+selectedCateg;
        }
        else
			url='/apex/TaneiraFillterResult?profileName='+profileName+'&searchkey='+seachKeyWord+'&searchType='+searchCategory;        
        //Navigate to next page either refined saearch page or fianl page
        PageReference pr = new PageReference(url);
        pr.setCookies(new Cookie[]{counter});
        pr.setredirect(true);
        return pr;
       
    }//End of Method

    //Method declaration for autocomplete values
    public PageReference getautoFillDataList(){
        autoFillData = new List<string>();
            //List of Product
            List<product__c> productList=[SELECT id,name,SKU_Code__c FROM product__c where recordtypeId =: productRecordType and Approval_Status__c =: 'Approved' LIMIT 50000];                       
            String quoteStr='"';
            if(searchCategory == 'SKU'){
                //Iterate to collect sku code in string format
                for(product__c pro: productList){
                    autoFillData.add('"'+pro.SKU_Code__c+'"');
                }
            }
            else{
                //Iterate to collect Model in string format
                    for(product__c pro: productList){
                        autoFillData.add('"'+pro.Name+'"');
                    }    
            }
            //To sort the nicopin list
           autoFillData.sort();
           return null;
    }//End of method
   
	//Method to logout by expiring the cookie
    public pagereference logout(){
    
       Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
         
         counter = new Cookie('counter','1',null,0,false);
         
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
       //Navigating to login page with expired Cookie
       PageReference pr1 = new PageReference('/apex/NewLogin');
            pr1.setredirect(true);
            return pr1;
    }//End of Logout method
    //wrraper class for adavnace search
    public class advanceSearchWrraper{
        public string name{get;set;}
        public boolean isSelected{get;set;}
        
        advanceSearchWrraper(){
        	name ='';
            isSelected = false;
        }
        
    }
}