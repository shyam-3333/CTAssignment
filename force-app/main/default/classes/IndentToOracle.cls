public class IndentToOracle {
    public List<Quote> lQuote {get;set;}
    public LIst<Quote> lUpdateQuote;
     public String newLine {get;set;}
    
       public class DefinedTestParam {
       
            public id id{get;set;}            //String variable to hold the test name value
            public String Insti_ref{get;set;}                  //String variable to hold the UOM value
            public Date Indent_Created_Date{get;set;}       //String variable to hold the test specification value
            public  Decimal Discount{get;set;}         //String variable to hold the test observation value
            public String Cheque_No_RTGS_No {get;set;}             //String variable to hold the test verdict value    
            public date Cheque_Date{get;set;}                  //String variable to hold the UOM value
            public String Bank_Name{get;set;}       //String variable to hold the test specification value
            public string Customer_Id{get;set;}         //String variable to hold the test observation value
            public string Name{get;set;}         //String variable to hold the test observation value
            public String PO_No{get;set;}             //String variable to hold the test verdict value    
            public Date PO_Date{get;set;}       //String variable to hold the test specification value
            public String Region_Picklist{get;set;}   //Comments and remark value to capture in test finding  
            public Decimal Subtotal{get;set;}       //String variable to hold the test specification value
            public String Product_for_Approval{get;set;}         //String variable to hold the test observation value
            public String Commemt{get;set;}             //String variable to hold the test verdict value    
        public string QC{get;set;}
    
            
      }
         
      {
          newLine = '\n';
      }
      public List<DefinedTestParam> IndentRecords{get;set;}
        public IndentToOracle(){
        }
        public void fetch(){
           newLine = '\n';
           // string QC ='';
          IndentRecords  =  new List<DefinedTestParam>();  
            lUpdateQuote = new List<Quote>();
            List<string> POA_str = new List<string>();
            POA_str.addAll(system.label.Indent_Products.split(','));
            lQuote = [select id,name,Account.Name,Account.Customer_Id__c,Product_Catagory__c,Product_Sub_Category__c,Opportunity.Region_Picklist__c,Discount,Opportunity.PO_No__c,Indent_Created_Date__c, 
            Opportunity.PO_Date__c,Cheque_No__c,RTGS_No__c,Cheque_Date__c,Subtotal,Bank_Name__c,Product_for_Approval__c,Insti_ref__c,(Select Id,  ProcessInstanceId, TargetObjectId, Comments, IsDeleted, CreatedDate, CreatedById From ProcessSteps order by CreatedDate DESC limit 1) FROM Quote
            where (Product_for_Approval__c IN: POA_str) AND (Indent_Status__c = '' OR Indent_Status__c = null OR Indent_Status__c ='Not Processed') AND Indent_Created__c = True order by CreatedDate limit 10000];
            system.debug('POA_str+++++++++++++:'+POA_str); 
            system.debug('lQuote+++++++++++++:'+lQuote);
            List<string> productList = new List<string>();
            /*productList.add('e-Gift Card valid on Studded Jewellery');
            productList.add('Gift Card valid on Studded Jewellery');
            productList.add('Gift Card not valid on Gold coin');
            productList.add('e-Gift Card not valid on Gold coin');
            productList.add('e-Gift Card valid on Gold coin');
            productList.add('Gift Card valid on Gold coin');
            productList.add('Gift card(QC)');
            productList.add('EGift card(QC)');*/
            productList.addAll(system.label.IndentToOracleProductCategory.split(','));
           for(Quote qt : lQuote){
              DefinedTestParam indentQuote = new DefinedTestParam();
                indentQuote.id = qt.id;
                indentQuote.Insti_ref = qt.Insti_ref__c;
                indentQuote.Indent_Created_Date = qt.Indent_Created_Date__c;
                indentQuote.Discount = qt.Discount;
                
                if(qt.Cheque_No__c == null || qt.Cheque_No__c == '' || qt.Cheque_No__c == 'NA' || qt.Cheque_No__c == 'na'){
                    indentQuote.Cheque_No_RTGS_No = qt.RTGS_No__c;
                }else{
                    indentQuote.Cheque_No_RTGS_No = qt.Cheque_No__c; 
                }
                
                indentQuote.Cheque_Date = qt.Cheque_Date__c;
                indentQuote.Bank_Name  = qt.Bank_Name__c;
                indentQuote.Customer_Id = qt.Account.Customer_Id__c;
                indentQuote.Name       = qt.Account.Name;
                indentQuote.PO_No = qt.Opportunity.PO_No__c;
                indentQuote.PO_Date = qt.Opportunity.PO_Date__c;
                indentQuote.Region_Picklist = qt.Opportunity.Region_Picklist__c;
                indentQuote.Subtotal   =     qt.Subtotal;
                indentQuote.Product_for_Approval = qt.Product_for_Approval__c;
                for(ProcessInstanceHistory ps : qt.ProcessSteps){
                    indentQuote.Commemt = ps.Comments;
                }
               
               if(productList.contains(qt.Product_Catagory__c)){
                   indentQuote.QC = 'QC';
               } else {
                   indentQuote.QC = '';
               }
               system.debug('quote product value: '+qt.Product_Catagory__c+' '+qt.Product_Sub_Category__c);
               system.debug('QC value'+indentQuote.QC);
               system.debug('indentQuote:++++++'+indentQuote);
                IndentRecords.add(indentQuote);
               
           } 
        //To avoid 'Apex CPU time limit exceeded' in indentToOracle class, we have queued the dml action using Queueable apex 
       System.enqueueJob(new IndentToOracle_QueueableApex(lQuote));
        }
    }