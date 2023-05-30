@RestResource(urlMapping='/PaymentTracker')
global class IndentAPIClass {
    @HttpPost
    global static void doPost(){
        
        RestContext.response.addHeader('Content-Type', 'text/plain');
        String body = RestContext.request.requestBody.toString();
        List<Payment_Tracker__c> paymentList = new List<Payment_Tracker__c>();
        set<String> indent = new set<string>();
        Map<String,Object> respMap = new Map<String,Object>();    
        Id oppId;
        
        List<PaymentWrapper> paymentDetails = new List<PaymentWrapper>();
        paymentDetails=(List<PaymentWrapper>)System.JSON.deserialize(body,List<PaymentWrapper>.class);
        System.debug('Payment Details : '+paymentDetails);
        for(PaymentWrapper pw : paymentDetails){
            if(pw.Indent_Number != Null || pw.Indent_Number != ''){  //2021/57781 or 57781
                indent.add(pw.Indent_Number);
                System.debug('indent : '+indent);
            }
        }
        if(!indent.isEmpty()){
            for(Quote opp : [Select Id,Name,OpportunityId from Quote Where (Insti_ref__c in : indent OR INSTI_Order_Reference__c in : indent)]){
                oppId = opp.OpportunityId;
                System.debug('oppId : '+oppId);
            }}
        
        for(PaymentWrapper pw : paymentDetails){
            Payment_Tracker__c pt = new Payment_Tracker__c();
            if(oppId != Null || oppId != ''){
                pt.Opportunity__c = oppId;
            }
            pt.Account_Number__c = pw.Account_Number;
            pt.Party_Name__c = pw.Party_Name;
            pt.Bank_Name__c = pw.Bank_Name;
            pt.Bank_Location__c = pw.Bank_Location;
            pt.Payment_Type__c = pw.Payment_Type;
            pt.Payment_Mode__c = pw.Payment_Mode;
            pt.Amount_Recieved__c = pw.Amount;
            pt.Receipt_Number__c = pw.Receipt_Number;
            pt.Receipt_Date__c = pw.Receipt_Date;
            pt.RTGS_No__c = pw.RTGS_No;
            pt.Cheque_No__c = pw.Cheque_No;
            pt.Cheque_Date__c = pw.Cheque_Date;
            pt.Reversal_Date__c = pw.Reversal_Date;
            pt.Reversal_Category__c = pw.Reversal_Category;
            pt.Reversal_Reason_Code__c = pw.Reversal_Reason_Code;
            pt.Reversal_Comment__c = pw.Reversal_Comment;
            pt.Indent_Number__c = pw.Indent_Number;
            pt.Reference_Number__c = pw.Reference_Number;
            pt.Region__c = pw.Region;
            pt.Comment__c = pw.Comment;
            paymentList.add(pt);
        }
        try{
            if(paymentList.size()>0){
                insert paymentList;
                RestResponse res = RestContext.response;
                RestContext.response.addHeader('Content-Type', 'application/json');
                respMap.put('Status Message','Payment Details are created');
                respMap.put('Response','Success');
                respMap.put('Status Code','200');
            }
        }
        catch(Exception ex){
            system.debug('Exception : '+ex);
            System.debug('error at line: '+ex.getLineNumber());
            System.debug('error message: '+ex.getMessage());
            respMap.put('Status Message',ex.getMessage());
            respMap.put('Response','Failure');  
            respMap.put('Status Code','500');
        }  
        
        if(respMap!=null && !respMap.isEmpty()){
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(respMap));  
        }
    }    
    
    
    public class PaymentWrapper {
        public String Account_Number;
        public String Party_Name;
        public String Bank_Name;
        public String Bank_Location;
        public String Payment_Type;
        public String Payment_Mode;
        public Decimal Amount;
        public String Receipt_Number;
        public Date Receipt_Date;
        public String RTGS_No;
        public String Cheque_No;
        public Date Cheque_Date;
        public Date Reversal_Date;
        public String Reversal_Category;
        public String Reversal_Reason_Code;
        public String Reversal_Comment;
        public String Indent_Number;
        public String Reference_Number;
        public String Region;
        public String Comment;
    }    
}
/*
[{
"Account_Number": "5003739",
"Party_Name": "Vouchagram India Private Limited",
"Bank_Name": "SBI",
"Bank_Location": "North",
"Payment_Type": "Advance",
"Payment_Mode": "RTGS",
"Amount": "12345",
"Receipt_Number": "12345",
"Receipt_Date": "2021-08-16",
"RTGS_No": "1010ABC",
"Cheque_No": "0012",
"Cheque_Date": "2021-08-16",
"Reversal_Date": "2021-08-16",
"Reversal_Category": "Test Category",
"Reversal_Reason_Code": "HP007",
"Reversal_Comment": "This is test reversal comment",
"Indent_Number": "2021/57781",
"Reference_Number": "01020304",
"Region": "North",
"Comment": "This is test comment"
}]       
*/