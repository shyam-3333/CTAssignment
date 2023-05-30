public class Paymenttrackeremailcontroller {
    public list<Payment_Tracker__c> dataList{get;set;}
    public string st {get;set;}
    public Paymenttrackeremailcontroller(){
        dataList = new list<Payment_Tracker__c>();
    }
    public void loadDataExcel(){ 
        datetime startDateTime = datetime.now().addHours(-24);
        datetime endDateTime = datetime.now();
        system.debug('startDateTime==>'+startDateTime+'endDateTime==>'+endDateTime);
        datalist = [select Name,RTGS_No__c,Cheque_No__c,Opportunity__r.RecordType.Name,AWB_Date__c,Opportunity__r.Quote_indent_No__c,Cheque_Date__c,Courier_Name__c,Location_of_The_Bank__c,Amount_Recieved__c,Opportunity__r.name,
                    Bank_Name__c,Payment_Type__c,Payment_Mode__c  from Payment_Tracker__c where (Opportunity__r.RecordType.Name ='Watches'  or Opportunity__r.RecordType.Name='Jewellery' OR Opportunity__r.RecordType.Name='Lifestyle') And (createddate>:startDateTime and createddate<:endDateTime)];
        for(Payment_Tracker__c pt :datalist){
            st = string.valueOf(pt.Cheque_Date__c);
        }
        system.debug('datalist==>'+datalist);
    }
}