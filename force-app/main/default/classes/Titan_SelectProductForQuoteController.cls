public class Titan_SelectProductForQuoteController {
    public List<Product2> productList{get;set;}
    public List<Product2> selectedProduct{get;set;}
    public boolean selectRow{get;set;}             
    public List<SelectOption> options;
    public List<Pricebook2> pricebookList{get;set;}
    //public List<SelectOption> productType{get;set;}
    public String pricebookValue{get;set;}    
    public boolean hasnextRows{get;set;}
    public String keyValue { get; set; }
    public String conditionValues{get;set;}
    public String fieldValue { get; set; }   
    public String lValue { get; set; }
    public String conditionValues1{get;set;}
    public String fieldValue1 { get; set; }   
    public String lValue1 { get; set; }
    public String conditionValues2{get;set;}
    public String fieldValue2 { get; set; }   
    public String lValue2 { get; set; }
    public String conditionValues3{get;set;}
    public String fieldValue3 { get; set; }   
    public String lValue3 { get; set; }
    public String conditionValues4{get;set;}
    public String fieldValue4 { get; set; }   
    public String lValue4 { get; set; }
    
    public String strPriceBookId { get; set; }
    public String strProduct2Id  { get; set; }
    
    public Decimal intUcp  { get; set; }
    public Decimal intSalesValue  { get; set;}
    public Decimal intQuantity  { get; set; }
    public Decimal intDiscount  { get; set; }
    public Decimal intDiscountValues  { get; set; }
    public Decimal intNoOfLineItems  { get; set; }
     public Decimal decUcpQLIno   {get; set;}
    public Product2 objProduct {get; set;}
    //public String proType { get; set; }
    public Id QuoteId{get;set;}
    public Id RecQId{get;set;}
    public boolean mainPanel{ get; set;}
    public boolean secondPanel{ get; set;}
    public boolean pricePanel{get;set;}
    public List<recordWrapper> lstrecWrapp {get; set;}
    public List<recordWrapper> quoterecordWrapper {get; set;}
    public List<recordWrapper> lstrecordWrapper {get; set;}
    public Decimal SalesVlaue {get; set;} 
    public Decimal quantity {get; set;}
    public Decimal Discount {get; set;}
   // public Decimal EnquiredQuantity {get; set;}
    public String sprproducts{ get; set;}
    Public Map<String,String> FieldtoTypeMap {get; set;}  
    public Map<Integer,List<recordWrapper>> pageNoToProductList = new Map<Integer,List<recordWrapper>>();
    
    
    public Titan_SelectProductForQuoteController(ApexPages.StandardController controller){
        mainPanel=true;
        secondPanel=false;
        pricePanel=true;
        sprproducts='SPR';
        conditionValues = '';
        fieldValue = '';
        lValue = '';
        conditionValues1 = '';
        fieldValue1 = '';
        lValue1 = '';
        conditionValues2 = '';
        fieldValue2 = '';
        lValue2 = '';
        conditionValues3 = '';
        fieldValue3 = '';
        lValue3 = '';
        conditionValues4 = '';
        fieldValue4 = '';
        lValue4 = '';
        keyValue = '';  
        lstrecWrapp = new List<recordWrapper>();
        objProduct = new Product2();
        QuoteId= Apexpages.currentPage().getparameters().get('QuoteId'); 
        List<Quote> PbId = [Select Pricebook2Id from Quote where id =: QuoteId];
        system.debug('------PbId---'+PbId);
        if(PbId.Size()>0){
            if(PbId[0].Pricebook2Id == null){
                mainPanel=false;
                secondPanel=false;
                pricePanel=true;    
            }
            else{
                mainPanel=true; 
                secondPanel=false;
                pricePanel=false;     
            }
        }
        
        pricebookList =[Select Name from Pricebook2];
        con = new ApexPages.StandardSetController([select Name, Family,IS_GV_GC__c,(Select id,UnitPrice  from PricebookEntries where Pricebook2.IsStandard = true and IsActive = true), Description, productCode,RecordType.Name from Product2 where IsActive = true and (NOT Name like 'SPR%')and (RecordType.Name = 'Jewellery' or  RecordType.Name = 'Watches')  Limit 1000]); 
        con.setPageSize(50) ;
        FieldtoTypeMap  = new Map<String,String>();
        if(!Test.isRunningTest()){    
            productList = con.getRecords();
        } else {
            productList = [select Id from Product2 limit 1000];
        }
        System.debug('---productList----'+productList);
        
        lstrecWrapp = new List<recordWrapper>();
        for (Product2 pro2 : productList){
            recordWrapper rw = new recordWrapper();
            //rw.isSelected = false;
            rw.pro2 = pro2;
            lstrecWrapp.add(rw);
       }  
               
       pageNoToProductList.put(con.getPageNumber(),lstrecWrapp); 
    
    }
    public List<SelectOption> getpricebookName(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--None--'));
        for (Pricebook2 pb:pricebookList){
            System.debug('-------pb.name---------'+pb.name);
            options.add(new SelectOption(pb.id,pb.name));
        }
        return options;   
    }
    public List<SelectOption> getoptions(){
       SObjectType objToken = Schema.getGlobalDescribe().get('Product2');
       DescribeSObjectResult objDef = objToken.getDescribe();
       Map<String, SObjectField> fields = objDef.fields.getMap(); 
        
       Set<String> fieldSet = fields.keySet();
      
       if (options == null){
          options = new List<SelectOption>();
          options.add(new SelectOption('','--None--'));
          for(String s:fieldSet)
          {
             SObjectField fieldToken = fields.get(s);
             DescribeFieldResult selectedField = fieldToken.getDescribe();
             FieldtoTypeMap.put( selectedField.getName(),String.valueOf(selectedField.getType() ) );
             //System.debug(selectedField.getName());
             options.add(new SelectOption(selectedField.getName(),selectedField.getLabel()));
          }
       }
       return options;
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--None--'));
        options.add(new SelectOption('=','equals'));
        options.add(new SelectOption('!=','not equal to'));
        options.add(new SelectOption('starts with','starts with'));
        options.add(new SelectOption('contains','contains'));
        options.add(new SelectOption('does not contain','does not contain'));
        options.add(new SelectOption('<','less than'));
        options.add(new SelectOption('>','greater than'));
        options.add(new SelectOption('<=','less or equal'));
        options.add(new SelectOption('>=','greater or equal'));
        return options;
    }
   
      
     public ApexPages.StandardSetController con{get;set;}
        // Search Filtter
     public void Search()  
        {                 
            String query1='select Name, Family,IS_GV_GC__c,(Select id,UnitPrice from PricebookEntries where Pricebook2.IsStandard = true and IsActive = true), Description, productCode,RecordType.Name from Product2';
            if(keyValue != ''){
                 
                query1 =query1 + ' where ( Name Like  \''+ keyValue +'%\' OR Name Like  \'%' + keyValue +'%\' OR  Family Like  \'%' + keyValue +'%\' OR Description Like  \'%' + keyValue +'%\' OR productCode Like  \'%' + keyValue +'%\' ) and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')';                               
            }   
            
            
             if(conditionValues != '' && fieldValue != '' && lValue != '' ){
            
           //  System.debug('----targetType---'+ targetType ); 
              
                 if(conditionValues == 'starts with' )
                 {                     
                      query1=query1 + ' where ( '+ fieldValue +' Like  \''+ lValue +'%\' ) and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                     
                 }
                 else if(conditionValues == 'contains' ){                     
                      query1=query1 + ' where ( '+ fieldValue +' Like  \'%'+ lValue +'%\' ) and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                      
                 }
                 else 
                 if(conditionValues == 'does not contain' ){                    
                      query1=query1 + ' where ( NOT '+ fieldValue +'   Like  \'%'+ lValue +'%\' ) and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                     
                 }
                 else
                 if( conditionValues == '=' ||  conditionValues == '!='  )    
                 {
                  if( FieldtoTypeMap.get( fieldValue   ) == 'STRING'|| FieldtoTypeMap.get( fieldValue   ) == 'TEXTAREA'|| FieldtoTypeMap.get( fieldValue  ) == 'PICKLIST' || FieldtoTypeMap.get( fieldValue   ) == 'PHONE' ||FieldtoTypeMap.get(fieldValue   ) == 'ID') 
                  query1=query1 + ' where ( '+ fieldValue +' '+ conditionValues + ' '+'\''+ lValue + '\' ) and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                  else
                  query1=query1 + ' where ( '+ fieldValue +' '+ conditionValues + ' '+ lValue + ' ) and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                 }
                 else
                 {
                  query1=query1 + ' where ( '+ fieldValue +' '+ conditionValues + ' '+'\''+ lValue + '\' ) and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                 }
                }
              if(conditionValues1 != '' && fieldValue1 != '' && lValue1 != '' ){
                if(conditionValues1 == 'starts with' ){                     
                      query1=query1 + ' AND ( '+ fieldValue1 +' Like  \''+ lValue1 +'%\' ) and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                     
                 }
                 else if(conditionValues1 == 'contains' ){                     
                      query1=query1 + ' AND ( '+ fieldValue1 +' Like  \'%'+ lValue1 +'%\')and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                      
                 }
                 else if(conditionValues1 == 'does not contain' ){                    
                      query1=query1 + ' AND ( NOT '+ fieldValue1 +' Like  \'%'+ lValue1 +'%\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                     
                 }
                  else
                 if( conditionValues1 == '=' ||  conditionValues1 == '!='  )    
                 {
                  if( FieldtoTypeMap.get( fieldValue1   ) == 'STRING'|| FieldtoTypeMap.get( fieldValue1   ) == 'TEXTAREA'|| FieldtoTypeMap.get( fieldValue1  ) == 'PICKLIST' || FieldtoTypeMap.get( fieldValue1   ) == 'PHONE' ||FieldtoTypeMap.get(fieldValue1   ) == 'ID') 
                  query1=query1 + ' AND ( '+ fieldValue1 +' '+ conditionValues1 + ' '+'\''+ lValue1 + '\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                  else
                  query1=query1 + ' AND ( '+ fieldValue1 +' '+ conditionValues1 + ' '+ lValue1 + ' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                 }
                 else{
                query1=query1 + ' AND ('+ fieldValue1 +' '+ conditionValues1 + ' '+ '\''+ lValue1 + '\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')';
                }
                }
              if(conditionValues2 != '' && fieldValue2 != '' && lValue2 != '' ){
                  if(conditionValues2 == 'starts with' ){                     
                      query1=query1 + ' AND ( '+ fieldValue2 +' Like  \''+ lValue2 +'%\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                     
                 }
                 else if(conditionValues2 == 'contains' ){                     
                      query1=query1 + ' AND ( '+ fieldValue2 +' Like  \'%'+ lValue2 +'%\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                      
                 }
                 else if(conditionValues2 == 'does not contain' ){                    
                      query1=query1 + ' AND ( NOT '+ fieldValue2 +' Like  \'%'+ lValue2 +'%\' not )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;                     
                 }
                  else
                 if( conditionValues2 == '=' ||  conditionValues2 == '!='  )    
                 {
                  if( FieldtoTypeMap.get( fieldValue2   ) == 'STRING'|| FieldtoTypeMap.get( fieldValue2   ) == 'TEXTAREA'|| FieldtoTypeMap.get( fieldValue2  ) == 'PICKLIST' || FieldtoTypeMap.get( fieldValue2   ) == 'PHONE' ||FieldtoTypeMap.get(fieldValue2   ) == 'ID') 
                  query1=query1 + ' AND ( '+ fieldValue2 +' '+ conditionValues2 + ' '+'\''+ lValue2 + '\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                  else
                  query1=query1 + ' AND ( '+ fieldValue2 +' '+ conditionValues2 + ' '+ lValue2 + ' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                 }
                 else{
                query1=query1 + ' AND ( '+ fieldValue2 +' '+ conditionValues2 + ' '+'\''+ lValue2 + '\')and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                }
                }
              if(conditionValues3 != '' && fieldValue3 != '' && lValue3 != '' ){
                  if(conditionValues3 == 'starts with' ){                     
                      query1=query1 + ' AND ( '+ fieldValue3 +' Like  \''+ lValue3 +'%\')and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                     
                 }
                 else if(conditionValues3 == 'contains' ){                     
                      query1=query1 + ' AND ( '+ fieldValue3 +' Like  \'%'+ lValue3 +'%\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                      
                 }
                 else if(conditionValues3 == 'does not contain' ){                    
                      query1=query1 + ' AND ( NOT '+ fieldValue3 +' Like  \'%'+ lValue3 +'%\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                     
                 }
                  else
                 if( conditionValues3 == '=' ||  conditionValues3 == '!='  )    
                 {
                  if( FieldtoTypeMap.get( fieldValue3   ) == 'STRING'|| FieldtoTypeMap.get( fieldValue3   ) == 'TEXTAREA'|| FieldtoTypeMap.get( fieldValue3  ) == 'PICKLIST' || FieldtoTypeMap.get( fieldValue3   ) == 'PHONE' ||FieldtoTypeMap.get(fieldValue   ) == 'ID') 
                  query1=query1 + ' AND ( '+ fieldValue3 +' '+ conditionValues3 + ' '+'\''+ lValue + '\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                  else
                  query1=query1 + ' AND ( '+ fieldValue3 +' '+ conditionValues3 + ' '+ lValue + ' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                 }
                 else{
               query1=query1 + ' AND ( '+ fieldValue3 +' '+ conditionValues3 + ' '+'\''+ lValue3 + '\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
               }
                }
               if(conditionValues4 != '' && fieldValue4 != '' && lValue4 != '' ){
                   if(conditionValues4 == 'starts with' ){                     
                      query1=query1 + ' AND ( '+ fieldValue4 +' Like  \''+ lValue4 +'%\')and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                     
                 }
                 else if(conditionValues4 == 'contains' ){                     
                      query1=query1 + ' AND ('+ fieldValue4 +' Like  \'%'+ lValue4 +'%\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                      
                 }
                 else if(conditionValues4 == 'does not contain' ){                    
                      query1=query1 + ' AND ( NOT '+ fieldValue4 +' Like  \'%'+ lValue4 +'%\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')' ;                     
                 }
                  else
                 if( conditionValues4 == '=' ||  conditionValues4 == '!='  )    
                 {
                  if( FieldtoTypeMap.get( fieldValue4   ) == 'STRING'|| FieldtoTypeMap.get( fieldValue4   ) == 'TEXTAREA'|| FieldtoTypeMap.get( fieldValue4  ) == 'PICKLIST' || FieldtoTypeMap.get( fieldValue4   ) == 'PHONE' ||FieldtoTypeMap.get(fieldValue   ) == 'ID') 
                  query1=query1 + ' AND ( '+ fieldValue4 +' '+ conditionValues4 + ' '+'\''+ lValue4 + '\' )and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                  else
                  query1=query1 + ' AND ( '+ fieldValue4 +' '+ conditionValues4 + ' '+ lValue4 + ')and IsActive = true  and (NOT Name like \'%' + sprproducts +'%\')'  ;
                 }
                 else{
                }
                }
                system.debug('----query1----'+query1);
                string str ='and (RecordType.Name = \'Jewellery\' or  RecordType.Name = \'Watches\')';
                query1 = query1+' ' +str+' ' + ' Limit 1000 ';
                con = new ApexPages.StandardSetController(Database.query(query1)); 
                
                
               productList = con.getRecords(); 

               pageNoToProductList.clear();
               //lstrecWrapp = new List<recordWrapper>();
               List<recordWrapper> lstrecWrappTemp = new List<recordWrapper>();
               System.debug('--------lstrecWrapp-------->'+lstrecWrapp);
                for(recordWrapper rw : lstrecWrapp){
                  if(rw.isSelected){  
                    recordWrapper rw1 = new recordWrapper();
                    rw1.isSelected = true;
                    rw1.pro2 = rw.pro2;
                    lstrecWrappTemp.add(rw1);
                  }
                }
                System.debug('--------lstrecWrappTemp-------->'+lstrecWrappTemp);
               System.debug('--------productList-------->'+productList);
               lstrecWrapp = new List<recordWrapper>();
               lstrecWrapp.addAll(lstrecWrappTemp);
               for(Product2 pro2 : productList){
                    recordWrapper rw = new recordWrapper();
                    rw.isSelected = false;
                    rw.pro2 = pro2;
                    lstrecWrapp.add(rw);
               }
               
               pageNoToProductList.put(con.getPageNumber(),lstrecWrapp);
               
        }
        
       
        //Select
       
         public void SelectProduct() {        
           lstrecordWrapper = new List<recordWrapper>();
            
            for( List<recordWrapper>  lstWrapp:  pageNoToProductList.values()  )
           
            {
            for(recordWrapper rw : lstWrapp){
                if(rw.isSelected ){
                    recordWrapper rwNew = new recordWrapper();
                    rwNew.isSelected = true;
                    rwNew.pro2 = rw.pro2;
                    system.debug('+++++++++rw.pro2'+rw.pro2);
                    rwNew.discount = 0;
                    //rwNew.quantity = 0;                    
                    if(!rw.pro2.PricebookEntries.isEmpty()){    
                        rwNew.salesValue = rw.pro2.PricebookEntries[0].UnitPrice;
                    }                   
                    lstrecordWrapper.add(rwNew);
                }
            } 
            }                       
             mainPanel=false;
             secondPanel=true;
        }
        
        
        
        public void createRecords(){
            List<PricebookEntry> pbe;
            
            product2 objPro = [Select p.Name, p.Id,p.IS_GV_GC__c,(Select Id, Name, Pricebook2Id, Product2Id, CurrencyIsoCode, UnitPrice, IsActive, UseStandardPrice, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, ProductCode, IsDeleted From PricebookEntries)From Product2 p where id =: objProduct.id];
            //lstrecordWrapper =  new  list<recordWrapper>();
            //lstrecordWrapper.addAll(lstWrapper);
            system.debug('+++++++++lstrecWrapp'+lstrecWrapp);
            system.debug('objProduct.Id'+objProduct);
            system.debug('intUcp'+intUcp);
            system.debug('intSalesValue'+intSalesValue);
            system.debug('intQuantity'+intQuantity);
            system.debug('intDiscount'+intDiscount);
            system.debug('intNoOfLineItems'+intNoOfLineItems);
             //pbe = [select id from pricebookEntry where Product2.id = :objProduct.Id  Limit 1];
            for(integer i =0; i< = intNoOfLineItems-2 ;i++) {
                recordWrapper objRecordWrapper = new recordWrapper();
                objRecordWrapper.pro2 =objPro;
                objRecordWrapper.decUcpQLI =intUcp;
                objRecordWrapper.salesValue = intSalesValue;
                objRecordWrapper.quantity = intQuantity;
                objRecordWrapper.discount = intDiscount;
                objRecordWrapper.discountvalues = intDiscountValues;
                objRecordWrapper.isSelected = true;
                //objRecordWrapper.PricebookEntry = pbe[0].id;
                system.debug('objRecordWrapper>>>>>>>>>>'+objRecordWrapper);
                lstrecordWrapper.add(objRecordWrapper);
            
            }
        
        system.debug('lstrecWrapp>>>>>>>>>>'+lstrecordWrapper);
        }
       
         
    public class recordWrapper {
        public Product2 pro2 {get; set;}
        public Product2 PricebookEntry {get; set;}
        public Boolean isSelected {get; set;}
        public Decimal salesValue {get; set;}
        public Decimal decUcpQLI {get; set;}
        public Decimal quantity {get; set;}
        public Decimal discount {get; set;}
        public Decimal discountvalues {get; set;}
       
        public Integer NoOfLineItems {get; set;}
       // public Decimal EnquiredQuantity {get; set;}
      //  public String proType {get; set;}
        public recordWrapper(){
            salesValue = 0;
            isSelected  = false;
            discount = 0;
           // proType ='--None--';
           // EnquiredQuantity  = 0; 
            
        }
    }
    public Pagereference  cancelQuote() {
    
        PageReference pageRef = new PageReference('/'+QuoteId);
        pageRef.setRedirect(true);
        return pageRef;
    }
     public Pagereference  Save() {
            integer i=0;
            integer j=0;
            integer q=0;
            integer q1=0; 
            integer j1=0;          
            integer totalSize=0;
            List<Quote> PId = [Select Pricebook2Id from Quote where id =: QuoteId];
            Integer counter=lstrecordWrapper.size();
            List<PricebookEntry> pbe;
            RecQId= QuoteId;
            /*for(recordWrapper rw : lstrecordWrapper){
                if(rw.pro2.PricebookEntries.size() > 0 && rw.pro2.PricebookEntries[0].UnitPrice!=null)
                ++counter;
            }*/
            
            List<QuoteLineItem> quoteProductList = new List<QuoteLineItem>();
            quoterecordWrapper = new List<recordWrapper>();
            for(recordWrapper rw : lstrecordWrapper){
                if(rw.quantity == null){
                    ++q;
                }
                if(rw.quantity == 0){
                    ++q1;
                }               
            }
           
            if(q>0){
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Error: Qunatity is a required field');
                ApexPages.addMessage(message);
                return null;    
            }
            if(q1>0){
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Error: Qunatity must be greater than zero');
                ApexPages.addMessage(message);
                return null;    
            }           
            for(recordWrapper rw : lstrecordWrapper){
                if(rw.pro2.PricebookEntries.size() > 0 && rw.pro2.PricebookEntries[0].UnitPrice == 0){
                    ++j;
                }
                if(rw.pro2.PricebookEntries.size() > 0 && rw.pro2.PricebookEntries[0].UnitPrice != 0 && rw.salesValue == rw.pro2.PricebookEntries[0].UnitPrice ) {
                   ++i;
               } 
               if(rw.pro2.PricebookEntries.size() > 0 && rw.pro2.PricebookEntries[0].UnitPrice == 0 && rw.salesValue != rw.pro2.PricebookEntries[0].UnitPrice){
                    ++j1;
                }
               
            }
            if(j != j1){
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Error: Sales Price must be greater than zero.');
                ApexPages.addMessage(message);
                return null;    
            }     
            totalSize=i+j; 
            integer size= i+j1;
            system.debug('--------totalSize---------'+totalSize);  
            system.debug('--------i+j1---------'+size);      
            system.debug('--------RecQId---------'+QuoteId);   
         pbe = [select id from pricebookEntry];// where Product2.id = : rw.pro2.id  Limit 1]; 
            if(totalSize == counter){
                for(recordWrapper rw : lstrecordWrapper){   
                   QuoteLineItem qLI = new QuoteLineItem ();
                  
                      
                     // pbe = [select id from pricebookEntry where Product2.id = : rw.pro2.id  Limit 1];
                    //  if(!pbe.isEmpty()){    
                          qLI.PriceBookEntryid=rw.pro2.PricebookEntries[0].id ;               
                         // qLI.PricebookEntry.Product2.Name = rw.pro2.Name; 
                          qLI.UnitPrice = rw.salesValue;
                          qLI.Sales_Price_c__c = rw.decUcpQLI;
                         // qLI.Enquired_Quantity__c = rw.EnquiredQuantity;
                          qLI.Quantity = rw.quantity;
                          qLI.QuoteId = QuoteId;
                          qLI.Discount_c__c = rw.discount; 
                          qli.Discount= rw.discount;
                          qli.Discount_In_Values_For_Corporate__c =rw.discountvalues ;
                         // qLI.Product_Type__c=rw.proType ;                                     
                          quoteProductList.add(qLI); 
                          }
                     
                     
                }
                 if(!Test.isrunningTest()){
                 insert quoteProductList;               
                 return new Pagereference('/'+QuoteId);
            } else {
              if(!Test.isRunningtest()) 
              { 
                ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'Error: Sales price is editable only for SPR products');
                ApexPages.addMessage(message);
              }
                return null;
            }
            
        }
        //save to select pricebook
         public void  pricebookSave() {
             List<Quote> PriceId = [Select Pricebook2Id from Quote where id =: QuoteId];
            // List<Pricebook2> bookId = [Select Id from pricebook2 where name =: pricebookValue];
             PriceId[0].Pricebook2Id =pricebookValue;
             update PriceId ;
             mainPanel=true;
             pricePanel=false;    
         }
        //Boolean to check if there are more records after the present displaying records  
        public Boolean hasNext{  
            get{  
                boolean temp = con.getHasNext(); 
                return  temp;
            }  
            set;  
        }
        
        //Boolean to check if there are more records before the present displaying records  
        public Boolean hasPrevious{  
            get{  
                return con.getHasPrevious();  
            }  
            set;  
        }
        
        //Page number of the current displaying records  
        public Integer pageNumber{  
            get{  
                return con.getPageNumber();  
            }  
            set;  
        }
        
        //Returns the previous page of records  
        public void previous(){ 
            con.previous(); 
            productList = con.getRecords();
            
            system.debug('Page No : '+ con.getPageNumber());
            if(pageNoToProductList.get(con.getPageNumber()) == null){
            
                lstrecWrapp = new List<recordWrapper>();
                   for(Product2 pro2 : productList){
                    recordWrapper rw = new recordWrapper();
                    //rw.isSelected = false;
                    rw.pro2 = pro2;
                    lstrecWrapp.add(rw);
                   }  
                pageNoToProductList.put(con.getPageNumber(),lstrecWrapp);   
             }else{
                 //system.debug('shiv-----'+ pageNoToProductList.get(con.getPageNumber())[0].isSelected );
                 lstrecWrapp = pageNoToProductList.get(con.getPageNumber());
                 for(recordWrapper rec : lstrecWrapp ){
                     system.debug('shiv1-----'+rec.isSelected);
                 }
             }
                   
        }  
   
        //Returns the next page of records  
        public void next(){  
            con.next();  
            productList = con.getRecords();
            
            if(pageNoToProductList.get(con.getPageNumber()) == null){
                lstrecWrapp = new List<recordWrapper>();
                   for(Product2 pro2 : productList){
                    recordWrapper rw = new recordWrapper();
                    //rw.isSelected = false;
                    rw.pro2 = pro2;
                    lstrecWrapp.add(rw);
                   }  
                pageNoToProductList.put(con.getPageNumber(),lstrecWrapp);   
            }else{
                
                lstrecWrapp = pageNoToProductList.get(con.getPageNumber());
            } 
        }
        
        public Integer resultSize{
            get{
                return con.getResultSize();
            }
            set;
        }
        
        public Integer pageSize{
            get{
                return con.getPageSize();
            }
            set;
        }
        
        public void count(){
            system.debug('selectedItems : ----'+(con.getSelected()).size());
        }
}