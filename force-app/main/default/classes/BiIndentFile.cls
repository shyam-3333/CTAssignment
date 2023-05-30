/*Name             : BiIndentFile 
    Created By         : Suyog B Magar
    Email              : magarsuyog.b@kvpcorp.com
    Created Date       :
    Modified By        :
    Last Modified Date :
    Description        : Indent records created within 24 hours should be sent in  txt file format    */
public class BiIndentFile {
    public list<Quote> lstQuote{get;set;}
    public String newLine {get;set;}

    public class DefinedTestParam {
        public Id Id{get;set;}
        public Integer SI_No{get;set;}
        public String Account_Name{get;set;}
        public String Industry_Channel{get;set;}
        public String Account_Owner_Full_Name{get;set;}
        public String Customer_Subsegment{get;set;}
        public String Customer_Category{get;set;}
        public Boolean YES_Tata_And_Tata_Group_of_Companies{get;set;}
        public String Account_Type{get;set;}
        public String Financial_Year{get;set;}
        public String Region{get;set;}
        public Decimal Sale_Target {get;set;}
        public String Opportunity_Type{get;set;}
        public String Lead_Source{get;set;}
        public String Sambandh_Classification{get;set;}
        public String Opportunity_Name{get;set;}
        public String Insti_Order_Reference{get;set;}
        public DateTime Indent_Created_Date{get;set;}

    }
    public List<DefinedTestParam> IndentRecords{get;set;}
    {
          newLine = '\n';
    }
   
    public BiIndentFile(){}
    
    public void fetch(){
        list<String> lstOfAccountType=new List<String>{'Jewellery','Lifestyle','Watches'};
        {
          newLine = '\n';
        }
        integer SINOcount=0;
        IndentRecords=new List<DefinedTestParam>(); 
        lstQuote=[SELECT ID,Opportunity.Account.CustomerSegment__c,Opportunity.Account.Owner.Name,
                   Opportunity.Account.Customer_Subsegment__c,Opportunity.Customer_category__c,Opportunity.Account.YES_Tata_Tata_Group_of_Companies__c,Opportunity.Account.Account_Type__c,
                   Opportunity.Account.Financial_Year__c,Opportunity.Account.Region_Picklist__c,Opportunity.Account.Sale_Target__c,
                   Opportunity.Opportunity_Type__c,Opportunity.LeadSource,Opportunity.Sambandh_Classification__c,
                   Opportunity.Name,Opportunity.INSTI_Order_Reference__c,Indent_Created_Date__c,Opportunity.Account.Name
                   FROM  Quote WHERE  Indent_Created__c = True  AND (( BI_Indent_Created_Date__c =YESTERDAY AND HOUR_IN_DAY(convertTimezone(BI_Indent_Created_Date__c)) >= 17) OR ( BI_Indent_Created_Date__c = TODAY AND HOUR_IN_DAY(convertTimezone(BI_Indent_Created_Date__c)) < 17))
                   AND (Opportunity.Record_Type__c IN : lstOfAccountType) ];
        
                   
       // system.debug(lstIndent.size());
        for(Quote quo:lstQuote){
            DefinedTestParam definedobj=new DefinedTestParam();
            definedobj.Id=quo.Id;
            SINOcount++;
            
            definedobj.SI_No=SINOcount; 
            
            if(quo.Opportunity.Account.Name==NULL){
                definedobj.Account_Name='NULL';
            }else{
               definedobj.Account_Name=quo.Opportunity.Account.Name; 
            }
            
            if(quo.Opportunity.Account.CustomerSegment__c==NULL){
                definedobj.Industry_Channel='NULL';
            }else{
                definedobj.Industry_Channel=quo.Opportunity.Account.CustomerSegment__c;
            }
            if(quo.Opportunity.Account.Owner.Name==NULL){
                definedobj.Account_Owner_Full_Name='NULL';
            }else{
                definedobj.Account_Owner_Full_Name=quo.Opportunity.Account.Owner.Name;
            }
            
            if(quo.Opportunity.Account.Customer_Subsegment__c==NULL){
                definedobj.Customer_Subsegment='NULL';
            }else{
                definedobj.Customer_Subsegment=quo.Opportunity.Account.Customer_Subsegment__c;  
            }
            if(quo.Opportunity.Customer_category__c==NULL){
                definedobj.Customer_Category='NULL';
            }else{
                definedobj.Customer_Category=quo.Opportunity.Customer_category__c;
            }
            
            definedobj.YES_Tata_And_Tata_Group_of_Companies=quo.Opportunity.Account.YES_Tata_Tata_Group_of_Companies__c;  
            
            if(quo.Opportunity.Account.Account_Type__c==NULL){
                definedobj.Account_Type='NULL';
            }else{
                definedobj.Account_Type=quo.Opportunity.Account.Account_Type__c;  
            }
            if(quo.Opportunity.Account.Financial_Year__c==NULL){
                definedobj.Financial_Year='NULL';
            }else{
                definedobj.Financial_Year=quo.Opportunity.Account.Financial_Year__c;  
            }
            if(quo.Opportunity.Account.Region_Picklist__c==NULL){
                definedobj.Region='NULL';
            }else{
                definedobj.Region=quo.Opportunity.Account.Region_Picklist__c;
            }
            
            definedobj.Sale_Target=quo.Opportunity.Account.Sale_Target__c;
            
            if(quo.Opportunity.Opportunity_Type__c==NULL){
                definedobj.Opportunity_Type='NULL';
            }else{
                definedobj.Opportunity_Type=quo.Opportunity.Opportunity_Type__c;
            }
            if(quo.Opportunity.LeadSource==NULL){
                definedobj.Lead_Source='NULL';
            }else{
                definedobj.Lead_Source=quo.Opportunity.LeadSource;
            }
            if(quo.Opportunity.Sambandh_Classification__c==NULL){
                definedobj.Sambandh_Classification='NULL';
            }else{
                definedobj.Sambandh_Classification=quo.Opportunity.Sambandh_Classification__c;  
            }
            if(quo.Opportunity.Name==NULL){
                definedobj.Opportunity_Name='NULL';
            }else{
              definedobj.Opportunity_Name=quo.Opportunity.Name;  
            }
            
            if(quo.Opportunity.INSTI_Order_Reference__c==NULL){
                definedobj.Insti_Order_Reference='NULL';
            }else{
                definedobj.Insti_Order_Reference=quo.Opportunity.INSTI_Order_Reference__c;  
            }
            
            definedobj.Indent_Created_Date=quo.Indent_Created_Date__c;
            
            IndentRecords.add(definedobj);
            
        }
      
    }
     public Integer getCount(){
         Integer Record_Count=0;
         fetch();
         if(IndentRecords!=Null){
             Record_Count=IndentRecords.size();
         }
         return Record_Count;
    }
}