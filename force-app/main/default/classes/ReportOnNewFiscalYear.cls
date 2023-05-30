/*
    File Name: ReportOnNewFiscalYear
    Created By:Laavanya
    Created Date:19-01-2015
    Last Modified By:Laavanya
                     Shamsher Singh:Have included sorting of data by Expected_Date_of_finalizing_of_Order__c field
                      Dhriti:Included Serial number and sub total of each month
    Last Modified Date:22-01-2015
                       28-01-2015
    Description:Custom Report 
    Methods Used:
                1. generateExcel()
                2. generateReport()              
*/
public with sharing class ReportOnNewFiscalYear{
    Public String selectReportType{get;set;}//holds selected Fiscal year 
    Public List<Opportunity> accountOppListForNew{get;set;}//holds records having customer-type=new, Record-type=MBA,stage values 
    Public List<Opportunity> accountOppListForExisting{get;set;}//holds records having customer-type=Existing customer, Record-type=MBA,stage values
    Public Double moderateRevnue{get;set;}// to hold summed have for records having Manager_s_Probability__c == 50 && Account.Industry == 'Automotive' && customer-type is Existing-Customer
    Public Double highRevnue{get;set;}//to hold summed have for records having Manager_s_Probability__c == 90 && Account.Industry == 'Automotive' && customer-type is Existing-Customer
    Public Double mediumRevnue{get;set;}//to hold summed have for records having Manager_s_Probability__c == 70 && Account.Industry == 'Automotive' && customer-type is Existing-Customer
    Public Double moderateRevnueForNew{get;set;}//to hold summed have for records having Manager_s_Probability__c == 50 && Account.Industry == 'Automotive' && customer-type is new
    Public Double highRevnueForNew{get;set;}//to hold summed have for records having Manager_s_Probability__c == 90 && Account.Industry == 'Automotive' && customer-type is new
    Public Double mediumRevnueForNew{get;set;}//to hold summed have for records having Manager_s_Probability__c == 70 && Account.Industry == 'Automotive' && customer-type is new
    Public Double GrndHighValue{get;set;}// to hold grnd total for high
    Public Double GrandMediumValue{get;set;}//to hold grnd total for Medium
    Public Double GrandModerateValue{get;set;}//to hold grnd total for Moderate
    public Boolean highValue{get;set;}
    public Boolean mediumValue{get;set;}
    public Boolean moderateValue{get;set;}
    
    public Map<Integer,List<WrapperClassToDisplayRecords>> sortedMapByMonth{get;set;}//This Map contains value of Automatic -new
    public Map<Integer,List<WrapperClassToDisplayRecords>> sortedMapNonAutoNew{get;set;}//This Map contains value of non Automatic -new
    public Map<Integer,List<WrapperClassToDisplayRecords>> sortedMapAutoExist{get;set;}//This Map contains value of Automatic -Existing
    public Map<Integer,List<WrapperClassToDisplayRecords>> sortedMapNonAutoExist{get;set;}//This Map contains value of Non Automatic -Existing
    
    public List<WrapperToDisplaySubtotal> wrapNewAutoSum{get;set;}//This wrapper contains subtotal of each month for Automatic-New
    public List<WrapperToDisplaySubtotal> wrapNewNonAutoSum{get;set;}//This wrapper contains subtotal of each month for Non Automatic-New
    public List<WrapperToDisplaySubtotal> wrapExistAutoSum{get;set;}//This wrapper contains subtotal of each month for  Automatic-Existing
    public List<WrapperToDisplaySubtotal> wrapExistNonAutoSum{get;set;}//This wrapper contains subtotal of each month for Non Automatic-Existing
    
    public ReportOnNewFiscalYear(ApexPages.StandardController controller) {   //Calling Standard Controller              
       sortedMapByMonth = new Map<Integer,List<WrapperClassToDisplayRecords>>();
       sortedMapNonAutoNew= new Map<Integer,List<WrapperClassToDisplayRecords>>();
       sortedMapAutoExist= new Map<Integer,List<WrapperClassToDisplayRecords>>();
       sortedMapNonAutoExist= new Map<Integer,List<WrapperClassToDisplayRecords>>();
       
       wrapNewAutoSum = new List<WrapperToDisplaySubtotal>();
       wrapNewNonAutoSum = new List<WrapperToDisplaySubtotal>();
       wrapExistAutoSum = new List<WrapperToDisplaySubtotal>();
       wrapExistNonAutoSum = new List<WrapperToDisplaySubtotal>();
       highValue=false;
       mediumValue=false;
       moderateValue=false;          
    }
   
    Public PageReference generateExcel(){//Exporting excel result
         PageReference exdownload = new PageReference('/apex/ExportMBAnew');
         exdownload.setRedirect(false);
         return exdownload ; 
         } 
    Public void generateReport(){//Generate reports
         highRevnueForNew=0.0;
         moderateRevnue=0.0;
         highRevnue=0.0;
         mediumRevnue=0.0;
         moderateRevnueForNew=0.0;
         mediumRevnueForNew=0.0;
         GrndHighValue=0.0;
         GrandMediumValue=0.0;
         GrandModerateValue=0.0;
         accountOppListForNew = new List<Opportunity>();
         accountOppListForExisting = new List<Opportunity>();   
         accountOppListForNew.clear();
         accountOppListForExisting.clear();
         accountOppListForNew.clear();
         sortedMapByMonth.clear();
         sortedMapNonAutoNew.clear();
         sortedMapAutoExist.clear();
         sortedMapNonAutoExist.clear();
         String queryForNew='';
         String queryForExisting='';      
            queryForNew='select name,Opportunity.Account.name,Expected_Date_of_finalizing_of_Order__c,Manager_s_Expected_Revenue_In_Lakhs__c,Manager_s_Probability__c,opportunity.Account.Industry,opportunity.Account.Account_Record_Type__c,account.recordtype.name from opportunity where Customer_Type__c=\'New\' AND account.recordtype.name=\'MBA\' AND ';                       
            queryForNew=queryForNew+ ' Projected_Date_of_Dispatch__c='+ selectReportType + ' AND ( StageName= \'Concept Finalization\' OR StageName= \'Preliminary Opportunity\' OR StageName= \'RFQ Study\' OR StageName=\'Costing\' OR StageName=\'Quote Preparation\')' + 'Order By Expected_Date_of_finalizing_of_Order__c';
            System.debug('Query String for New'+queryForNew);
            accountOppListForNew=DataBase.query(queryForNew); 
            System.debug('^^^^^^^^^^accountOppListForNew^^^^^^^^'+accountOppListForNew); 
            queryForNew='';                     
            queryForExisting='select name,Opportunity.Account.name,Expected_Date_of_finalizing_of_Order__c,Manager_s_Expected_Revenue_In_Lakhs__c,Manager_s_Probability__c,opportunity.Account.Industry,account.recordtype.name from opportunity where Customer_Type__c=\'Existing Customer\' AND account.recordtype.name=\'MBA\' AND ';
            queryForExisting=queryForExisting+ ' Projected_Date_of_Dispatch__c='+ selectReportType + ' AND ( StageName= \'Concept Finalization\' OR StageName=\'Preliminary Opportunity\' OR StageName= \'RFQ Study\' OR StageName=\'Costing\' OR StageName=\'Quote Preparation\')' + 'Order By Expected_Date_of_finalizing_of_Order__c'; 
            System.debug('Query String for Existing'+queryForExisting);
            accountOppListForExisting=DataBase.query(queryForExisting);       
            queryForExisting='';                    
            List<WrapperClassToDisplayRecords> opportunityLists = new List<WrapperClassToDisplayRecords>();
            Integer serailNo=1;        
            Integer serialnewNonAuto=1; 
            Integer months;
            for(Opportunity acc : accountOppListForNew){
            if(acc.Expected_Date_of_finalizing_of_Order__c!=null){
                 months=Integer.valueOf(acc.Expected_Date_of_finalizing_of_Order__c.Month());   
                }          
                if(acc.Manager_s_Probability__c == 50 && acc.Account.Industry == 'Automotive'){//When Account Industry is Automotive and Probability is 50
                    moderateValue=true;
                    mediumValue=false;
                    highValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serailNo,acc,highValue,mediumValue,moderateValue);
                    serailNo++;
                    if(acc.Manager_s_Expected_Revenue_In_Lakhs__c != null){
                        moderateRevnueForNew=moderateRevnueForNew+acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.moderateRevnueForNew=acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    if(!sortedMapByMonth.isEmpty() && sortedMapByMonth.containsKey(months)){ 
                        sortedMapByMonth.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                         sortedMapByMonth.put(months,opportunityLists);
                    }
                }
                if(acc.Manager_s_Probability__c == 50 && acc.Account.Industry != 'Automotive' ){//When Account Industry is Non Automotive and Probability is 50
                    moderateValue=true;
                    mediumValue=false;
                    highValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serialnewNonAuto,acc,highValue,mediumValue,moderateValue);
                   // wrapperNewNonAutomative.add(wrp );
                    serialnewNonAuto++;
                    if(acc.Manager_s_Expected_Revenue_In_Lakhs__c != null){
                        moderateRevnueForNew=moderateRevnueForNew+acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.moderateRevnueForNew=acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    if(!sortedMapNonAutoNew.isEmpty() && sortedMapNonAutoNew.containsKey(months)){ 
                        sortedMapNonAutoNew.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapNonAutoNew.put(months,opportunityLists);
                    }
                }
                if(acc.Manager_s_Probability__c == 70 && acc.Account.Industry == 'Automotive' ){//When Account Industry is Automotive and Probability is 70
                    mediumValue=true;
                    moderateValue=false;
                    highValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serailNo,acc,highValue,mediumValue,moderateValue);
                    serailNo++;
                    if(acc.Manager_s_Expected_Revenue_In_Lakhs__c != null){
                        mediumRevnueForNew=mediumRevnueForNew+acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.mediumRevnueForNew=acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    if(!sortedMapByMonth.isEmpty() && sortedMapByMonth.containsKey(months)){ 
                        sortedMapByMonth.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapByMonth.put(months,opportunityLists);
                    }
                 }
                if(acc.Manager_s_Probability__c == 70 && acc.Account.Industry != 'Automotive' ){//When Account Industry is Non Automotive and Probability is 70
                    mediumValue=true;
                    moderateValue=false;
                    highValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serialnewNonAuto,acc,highValue,mediumValue,moderateValue);
                    serialnewNonAuto++;
                    if(acc.Manager_s_Expected_Revenue_In_Lakhs__c != null){
                        mediumRevnueForNew=mediumRevnueForNew+acc.Manager_s_Expected_Revenue_In_Lakhs__c;}
                        wrp.mediumRevnueForNew=acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                    if(!sortedMapNonAutoNew.isEmpty() && sortedMapNonAutoNew.containsKey(months)){ 
                        sortedMapNonAutoNew.get(months).add(wrp);
                       
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapNonAutoNew.put(months,opportunityLists);
                    }
                }
                if(acc.Manager_s_Probability__c == 90 && acc.Account.Industry == 'Automotive'){//When Account Industry is Automotive and Probability is 90
                    highValue=true;
                    mediumValue=false;
                    moderateValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serailNo,acc,highValue,mediumValue,moderateValue);
                    serailNo++;
                    if(acc.Manager_s_Expected_Revenue_In_Lakhs__c != null){
                        highRevnueForNew=highRevnueForNew+acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.highRevnueForNew=acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    if(!sortedMapByMonth.isEmpty() && sortedMapByMonth.containsKey(months)){ 
                        sortedMapByMonth.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapByMonth.put(months,opportunityLists);
                    }
                 }
                if(acc.Manager_s_Probability__c == 90 && acc.Account.Industry != 'Automotive' ){//When Account Industry is Non Automotive and Probability is 50
                    highValue=true;
                    mediumValue=false;
                    moderateValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serialnewNonAuto,acc,highValue,mediumValue,moderateValue);
                    serialnewNonAuto++;
                    if(acc.Manager_s_Expected_Revenue_In_Lakhs__c != null){
                        highRevnueForNew=highRevnueForNew+acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.highRevnueForNew=acc.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    if(!sortedMapNonAutoNew.isEmpty() && sortedMapNonAutoNew.containsKey(months)){ 
                        sortedMapNonAutoNew.get(months).add(wrp);
                       
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapNonAutoNew.put(months,opportunityLists);
                    }
                } 
              
            }
             summaryNewAuto();
             summaryNewNonAuto();
             Integer serialAuto=1;
             Integer serialNonAuto=1;
             for(Opportunity opp : accountOppListForExisting){             
                if(opp.Expected_Date_of_finalizing_of_Order__c!=null){
                 months=Integer.valueOf(opp.Expected_Date_of_finalizing_of_Order__c.Month());
                }
                if(opp.Manager_s_Probability__c == 50 && opp.Account.Industry == 'Automotive' ){//When Account Industry is Automotive and Probability is 50
                    highValue=false;
                    mediumValue=false;
                    moderateValue=true;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serialAuto,opp,highValue,mediumValue,moderateValue);
                    serialAuto++;
                    if(opp.Manager_s_Expected_Revenue_In_Lakhs__c != null){ 
                        moderateRevnue=moderateRevnue+opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.moderateRevnueForNew=opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    if(!sortedMapAutoExist.isEmpty() && sortedMapAutoExist.containsKey(months)){ 
                        sortedMapAutoExist.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapAutoExist.put(months,opportunityLists);
                    }
                    
                }
               if(opp.Manager_s_Probability__c == 50 && opp.Account.Industry != 'Automotive' ){//When Account Industry is Non Automotive and Probability is 50
                    highValue=false;
                    mediumValue=false;
                    moderateValue=true;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serialNonAuto,opp,highValue,mediumValue,moderateValue);
                    serialNonAuto++;
                    if(opp.Manager_s_Expected_Revenue_In_Lakhs__c != null){ 
                        moderateRevnue=moderateRevnue+opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.moderateRevnueForNew=opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    if(!sortedMapNonAutoExist.isEmpty() && sortedMapNonAutoExist.containsKey(months)){ 
                        sortedMapNonAutoExist.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapNonAutoExist.put(months,opportunityLists);
                    }
                }
                if(opp.Manager_s_Probability__c == 70 && opp.Account.Industry == 'Automotive' ){//When Account Industry is Automotive and Probability is 70
                    highValue=false;
                    mediumValue=true;
                    moderateValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serialAuto,opp,highValue,mediumValue,moderateValue);
                    serialAuto++;
                    if(opp.Manager_s_Expected_Revenue_In_Lakhs__c != null){ 
                        mediumRevnue=mediumRevnue+opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.mediumRevnueForNew=opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                   
                    if(!sortedMapAutoExist.isEmpty() && sortedMapAutoExist.containsKey(months)){ 
                        sortedMapAutoExist.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapAutoExist.put(months,opportunityLists);
                    }
                }
                if(opp.Manager_s_Probability__c == 70 && opp.Account.Industry != 'Automotive' ){//When Account Industry is Non Automotive and Probability is 70
                    highValue=false;
                    mediumValue=true;
                    moderateValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serialNonAuto,opp,highValue,mediumValue,moderateValue);
                    serialNonAuto++;
                    if(opp.Manager_s_Expected_Revenue_In_Lakhs__c != null){ 
                        mediumRevnue=mediumRevnue+opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                         wrp.mediumRevnueForNew=opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    if(!sortedMapNonAutoExist.isEmpty() && sortedMapNonAutoExist.containsKey(months)){ 
                        sortedMapNonAutoExist.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapNonAutoExist.put(months,opportunityLists);
                    }
                }
                if(opp.Manager_s_Probability__c == 90 && opp.Account.Industry == 'Automotive' ){//When Account Industry is Automotive and Probability is 90
                    highValue=true;
                    mediumValue=false;
                    moderateValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serialAuto,opp,highValue,mediumValue,moderateValue);
                    serialAuto++;
                    if(opp.Manager_s_Expected_Revenue_In_Lakhs__c != null){
                        highRevnue=highRevnue+opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.highRevnueForNew=opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    
                    if(!sortedMapAutoExist.isEmpty() && sortedMapAutoExist.containsKey(months)){ 
                        sortedMapAutoExist.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapAutoExist.put(months,opportunityLists);
                    }
                    
                }
                if(opp.Manager_s_Probability__c == 90 && opp.Account.Industry != 'Automotive' ){//When Account Industry is Non Automotive and Probability is 90
                    highValue=true;
                    mediumValue=false;
                    moderateValue=false;
                    WrapperClassToDisplayRecords wrp = new WrapperClassToDisplayRecords(serialNonAuto,opp,highValue,mediumValue,moderateValue);
                    serialNonAuto++;
                    if(opp.Manager_s_Expected_Revenue_In_Lakhs__c != null){
                        highRevnue=highRevnue+opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                        wrp.highRevnueForNew=opp.Manager_s_Expected_Revenue_In_Lakhs__c;
                    }
                    if(!sortedMapNonAutoExist.isEmpty() && sortedMapNonAutoExist.containsKey(months)){ 
                        sortedMapNonAutoExist.get(months).add(wrp);
                    }
                    else{
                        opportunityLists = new List<WrapperClassToDisplayRecords>();
                        opportunityLists.add(wrp);
                        sortedMapNonAutoExist.put(months,opportunityLists);
                    }
                }
            }
            summaryExistAuto();
            summaryExistNonAuto();
            GrndHighValue=highRevnue+highRevnueForNew;
            GrandMediumValue=mediumRevnue+mediumRevnueForNew;
            GrandModerateValue=moderateRevnue+moderateRevnueForNew;         
    }
    public void summaryNewAuto(){//This function will calculate the total for each month if it is Automatic-New
      wrapNewAutoSum.clear();
      for(Integer ints:sortedMapByMonth.keyset()){
          WrapperToDisplaySubtotal wrapsum = new WrapperToDisplaySubtotal();
          wrapsum.months=ints;
          decimal high= 0;
          decimal medium= 0;
          decimal moderate= 0;
          for(WrapperClassToDisplayRecords wrp:sortedMapByMonth.get(ints)){
               if(wrp.moderateRevnueForNew!= null){
                            moderate+= wrp.moderateRevnueForNew;
               }
               if(wrp.mediumRevnueForNew!= null){
                            medium+= wrp.mediumRevnueForNew;
               }
               if(wrp.highRevnueForNew!= null){
                            high+= wrp.highRevnueForNew;
               }
          }
            wrapsum.moderateValueRecord=integer.valueOf(moderate);
            wrapsum.mediumValueRecord=integer.valueOf(medium);
            wrapsum.highValueRecord=integer.valueOf(high);
            wrapNewAutoSum.add(wrapsum);
      }
    }
    
    public void summaryNewNonAuto(){//This function will calculate the total for each month if it is Non Automatic-New
      wrapNewNonAutoSum.clear();
      for(Integer ints: sortedMapNonAutoNew.keyset()){
          WrapperToDisplaySubtotal wrapsum = new WrapperToDisplaySubtotal();
          wrapsum.months=ints;
          decimal high= 0;
          decimal medium= 0;
          decimal moderate= 0;
          for(WrapperClassToDisplayRecords wrp: sortedMapNonAutoNew.get(ints)){
               if(wrp.moderateRevnueForNew!= null){
                            moderate+= wrp.moderateRevnueForNew;
               }
               if(wrp.mediumRevnueForNew!= null){
                            medium+= wrp.mediumRevnueForNew;
               }
               if(wrp.highRevnueForNew!= null){
                            high+= wrp.highRevnueForNew;
               }
          }
            wrapsum.moderateValueRecord=integer.valueOf(moderate);
            wrapsum.mediumValueRecord=integer.valueOf(medium);
            wrapsum.highValueRecord=integer.valueOf(high);
            wrapNewNonAutoSum.add(wrapsum);
      }
    }
    
    public void summaryExistAuto(){//This function will calculate the total for each month if it is Automatic-Existing
      wrapExistAutoSum.clear();
      for(Integer ints: sortedMapAutoExist.keyset()){
          WrapperToDisplaySubtotal wrapsum = new WrapperToDisplaySubtotal();
          wrapsum.months=ints;
          decimal high= 0;
          decimal medium= 0;
          decimal moderate= 0;
          for(WrapperClassToDisplayRecords wrp: sortedMapAutoExist.get(ints)){
               if(wrp.moderateRevnueForNew!= null){
                            moderate+= wrp.moderateRevnueForNew;
               }
               if(wrp.mediumRevnueForNew!= null){
                            medium+= wrp.mediumRevnueForNew;
               }
               if(wrp.highRevnueForNew!= null){
                            high+= wrp.highRevnueForNew;
               }
          }
          wrapsum.moderateValueRecord=integer.valueOf(moderate);
          wrapsum.mediumValueRecord=integer.valueOf(medium);
          wrapsum.highValueRecord=integer.valueOf(high);
          wrapExistAutoSum.add(wrapsum);
      }
    }
     public void summaryExistNonAuto(){//This function will calculate the total for each month if it is Non Automatic-Existing
      wrapExistNonAutoSum.clear();
      for(Integer ints: sortedMapNonAutoExist.keyset()){
          WrapperToDisplaySubtotal wrapsum = new WrapperToDisplaySubtotal();
          wrapsum.months=ints;
          decimal high= 0;
          decimal medium= 0;
          decimal moderate= 0;
          for(WrapperClassToDisplayRecords wrp: sortedMapNonAutoExist.get(ints)){
              if(wrp.moderateRevnueForNew!= null){
                            moderate+= wrp.moderateRevnueForNew;
               }
               if(wrp.mediumRevnueForNew!= null){
                            medium+= wrp.mediumRevnueForNew;
               }
               if(wrp.highRevnueForNew!= null){
                            high+= wrp.highRevnueForNew;
               }
          }
           wrapsum.moderateValueRecord=integer.valueOf(moderate);
           wrapsum.mediumValueRecord=integer.valueOf(medium);
           wrapsum.highValueRecord=integer.valueOf(high);
           wrapExistNonAutoSum.add(wrapsum);
      }
    }
    public Class WrapperClassToDisplayRecords{//This wrapper is used to display records in page
        public Opportunity opportunityList{get;set;}//Declaration for opportunity records
        public Integer serialNo{get;set;}//Serial number for each record
        public Boolean highValue{get;set;}//If Confidence Level is high this boolean will become true
        public Boolean mediumValue{get;set;}//If Confidence Level is medium this boolean will become true
        public Boolean moderateValue{get;set;}//If Confidence Level is moderate this boolean will become true
        public Double highRevnueForNew{get;set;}//This value is initialized if high value is exist
        public Double mediumRevnueForNew{get;set;}//This value is initialized if medium value is exist
        public Double moderateRevnueForNew{get;set;}//This value is initialized if moderate value is exist
        public WrapperClassToDisplayRecords(Integer ints,Opportunity oppList,Boolean high,Boolean medium,Boolean moderate){
               opportunityList = new Opportunity();
               opportunityList=oppList;
               serialNo=ints;
               highValue=high;
               mediumValue=medium;
               moderateValue=moderate;
        }
    }
    public Class WrapperToDisplaySubtotal{//This wrapper is used to display sub total of each month
        public Integer months{get;set;}//Contains the month value
        public long mediumValueRecord{get;set;}//Contains the medium confidence level value
        public long highValueRecord{get;set;}//Contains the high confidence level value
        public long moderateValueRecord{get;set;}//Contains the moderate confidence level value
        public WrapperToDisplaySubtotal(){
        }
    }
}