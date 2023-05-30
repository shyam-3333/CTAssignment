/***********
Developed By    : Anindwita Raj
Created Date    : 16/5/2018.
Purpose         : This class is use to capture the updated payment details and send the file as text to the users on every 3 hrs.
related class   : PaymentDetailsUpdateTest(test class), schedulePaymentDetails(scheduler class), schedulePaymentDetailsTest(scheduler test class)

***********/
public class PaymentDetailsUpdate{
    public list<wrapPayment> wrapPaymentList{get;set;}
    public String newLine {get;set;}

    public PaymentDetailsUpdate(){
        //wrapPaymentList = new list<wrapPayment>();
    }
    {
      newLine = '\r\n';
    }
    
    public void fetchPaymentDetails(){
        newLine = '\r\n';
        wrapPaymentList = new list<wrapPayment>();
        Map<Id,List<Payment_Tracker__History>> mapOfPaymentId = new Map<Id,List<Payment_Tracker__History>>();
        List<Payment_Tracker__History> paymentTrackerHistList= new List<Payment_Tracker__History>();
        map<Id,Payment_Tracker__c> oppIdvsPaymentMap = new map<Id,Payment_Tracker__c>();
        map<Id,list<Quote>> oppIdvsQuoteMap = new map<Id,list<Quote>>();
        list<Quote> quoteLst = new list<Quote>();
        list<Payment_Tracker__c> paymentTrackerLst = new list<Payment_Tracker__c>();
        //list<wrapPayHist> wrapPaymntHistLst = new list<wrapPayHist>();
        DateTime dt = System.now().addHours(5).addMinutes(30);
        long d = dt.hourGMT();
        String fromDate1 = calculateDateString(system.today(),'T01:30:00.000Z'); //passing server time as parameter i.e -5:30 from current time
        String toDate1 = calculateDateString(system.today(),'T05:30:00.000Z'); 
        
        String fromDate2 = calculateDateString(system.today(),'T05:30:00.000Z'); //11AM
        String toDate2 = calculateDateString(system.today(),'T08:30:00.000Z'); //2pm
        
        String fromDate3 = calculateDateString(system.today(),'T08:30:00.000Z'); //2pm
        String toDate3 = calculateDateString(system.today(),'T10:30:00.000Z'); //4pm
        
        String fromDate4 = calculateDateString(system.today(),'T10:30:00.000Z'); //4pm
        String toDate4 = calculateDateString(system.today(),'T14:30:00.000Z'); //8PM
        //datetime dat = datetime.valueOfGmt(fromDate4);
        system.debug('----------fromDate4--------------'+fromDate4);
        system.debug('----------toDate4--------------'+toDate4);
        
        system.debug('-------today-4pm---------'+ calculateDateString(system.today(),'T10:30:00.000Z'));
        system.debug('-------yesterda-8pm---------'+ calculateDateString(system.today(),'T14:30:00.000Z'));
        
        String fromDate5 = calculateDateString(system.today().addDays(-1),'T14:30:00.000Z'); //8pm
        String toDate5 = calculateDateString(system.today(),'T01:30:00.000Z'); //7AM
               
        system.debug('-------today-7am---------'+calculateDateString(system.today(),'T07:00:00.000Z'));
        system.debug('-------yesterda-8pm---------'+calculateDateString(system.today().addDays(-1),'T20:00:00.000Z'));
        
       /* String localTime = dTime.format('h:mm a');
        if(localTime == String.valueOf(Time.newInstance(07,0, 0, 0))){
           updatedTime = dTime.addHours(-11); //to fetch the time from 8PM to 7AM
        }else{
           updatedTime = dTime.addHours(-3); 
        }
         
        System.debug('------------updatedTime---------'+updatedTime); */
        String queryString = '';
        queryString = 'SELECT Id,Field,OldValue,NewValue,ParentId FROM Payment_Tracker__History WHERE (Field =\'Amount_Recieved__c\' OR Field =\'Payment_Type__c\' OR Field =\'created\' OR Field =\'Payment_Mode__c\' OR Field =\'RTGS_No__c\' OR Field =\'Cheque_No__c\' OR Field =\'Cheque_Date__c\')';
        if(d >= 7 && d < 11){
            queryString += 'AND (CreatedDate >='+fromDate5+ ' AND CreatedDate <= '+toDate5+')'; //based on the scheduler timing the query will execute
        }
        if(d >= 11 && d < 14   && !test.isrunningTEST()  ){
            queryString += 'AND (CreatedDate >=' +fromDate1+ ' AND CreatedDate <=' +toDate1+')';
        }
        if(d >= 14 && d< 16){
            queryString += 'AND (CreatedDate >=' +fromDate2+ ' AND CreatedDate <=' +toDate2+')';
        }
        if(d >= 16 && d<20 ){
            queryString += 'AND (CreatedDate >=' +fromDate3+ ' AND CreatedDate <=' +toDate3+')';
        }
        if(d >= 20 && d< 24){
            queryString += 'AND (CreatedDate >=' +fromDate4+ ' AND CreatedDate <=' +toDate4+')';
        }
       
        system.debug('-----------queryString--------'+queryString);
        paymentTrackerHistList = Database.query(queryString);                     
        System.debug('-------paymentTrackerHistList------->'+paymentTrackerHistList);
        if(!paymentTrackerHistList.isEmpty() ){
            for(Payment_Tracker__History payTrackHist : paymentTrackerHistList){
                if(mapOfPaymentId.get(payTrackHist.ParentId)!= NULL && mapOfPaymentId.containsKey(payTrackHist.ParentId) && !mapOfPaymentId.isEmpty()){
                    mapOfPaymentId.get(payTrackHist.ParentId).add(payTrackHist);
                }
                else{
                    mapOfPaymentId.put(payTrackHist.ParentId,new List<Payment_Tracker__History>{payTrackHist});
                }
            }
            system.debug('-------mapOfPaymentId--------'+ mapOfPaymentId);
        }
        paymentTrackerLst = [SELECT Id, Name, Amount_Recieved__c,LastModifiedDate ,Cheque_Date__c,Cheque_No__c,Opportunity__c,Opportunity__r.Opportunity_Tracking_ID__c,Payment_Mode__c,Payment_Type__c,RTGS_No__c 
                                                      FROM Payment_Tracker__c WHERE Id IN :mapOfPaymentId.keySet() LIMIT 10000 ];
        system.debug('------paymentTrackerLst------'+ paymentTrackerLst);
        
        for(Payment_Tracker__c payment : paymentTrackerLst){
            if(payment.Opportunity__c != null){
                oppIdvsPaymentMap.put(payment.Opportunity__c,payment);
            }               
        }
        system.debug('------oppIdvsPaymentMap------'+ oppIdvsPaymentMap);
        if(oppIdvsPaymentMap.keySet() != null){
            quoteLst = [Select Id, OpportunityId,INSTI_Order_Reference__c FROM Quote WHERE OpportunityId IN : oppIdvsPaymentMap.keySet() ORDER BY createdDate DESC ];
        }
        system.debug('----------quoteLst....------------'+quoteLst);
        for(Quote q : quoteLst){
            if(q.OpportunityId != null && !oppIdvsQuoteMap.isEmpty() && oppIdvsQuoteMap.containsKey(q.OpportunityId)){
                oppIdvsQuoteMap.get(q.OpportunityId).add(q);
            }
            else{
                oppIdvsQuoteMap.put(q.OpportunityId,new List<Quote> {q});
            }
        }
        system.debug('----**-----oppIdvsPaymentMap----**------' + oppIdvsPaymentMap);
        
        
        for(Payment_Tracker__c payTrack : paymentTrackerLst){
            wrapPayment wrap = new wrapPayment();
            wrap.year = payTrack.LastModifiedDate.year();
            wrap.oppTrackId = payTrack.Opportunity__r.Opportunity_Tracking_ID__c;
            wrap.paymentTrackNo = payTrack.Name;
            if(!oppIdvsPaymentMap.isEmpty() && oppIdvsPaymentMap.containsKey(payTrack.Opportunity__c) && !oppIdvsQuoteMap.isEmpty() && oppIdvsQuoteMap.containsKey(payTrack.Opportunity__c) && oppIdvsPaymentMap.containsKey(payTrack.Opportunity__c) == oppIdvsQuoteMap.containsKey(payTrack.Opportunity__c)){
                wrap.instRefNo = oppIdvsQuoteMap.get(payTrack.Opportunity__c)[0].INSTI_Order_Reference__c;  
            }
             
            list<wrapPayHist> wrapPaymntHistLst = new list<wrapPayHist>();
            if(mapOfPaymentId.containsKey(payTrack.Id) && mapOfPaymentId.get(payTrack.Id)!= null){
                
                wrapPayHist wrapParent = new wrapPayHist();
                wrapParent.RTGSNo =  payTrack.RTGS_No__c;
                wrapParent.chequeNo =  payTrack.Cheque_No__c;
                wrapParent.amountRecv =  payTrack.Amount_Recieved__c;
                wrapParent.paymentMode =  payTrack.Payment_Mode__c;
                wrapParent.chequeDate =  payTrack.Cheque_Date__c;
                wrapPaymntHistLst.add(wrapParent);
                for(Payment_Tracker__History pay : mapOfPaymentId.get(payTrack.Id)){
                    wrapPayHist wrapHist = new wrapPayHist();
                    if(pay.Field != null && pay.Field != 'created'){
                        if(pay.Field != null && pay.Field == 'RTGS_No__c' && pay.NewValue != null){
                            wrapHist.RTGSNo =  (pay.NewValue).toString();
                        }
                        if(pay.Field != null && pay.Field == 'Cheque_No__c' && pay.NewValue != null){
                            wrapHist.chequeNo =  (pay.NewValue).toString();
                        }
                        if(pay.Field != null && pay.Field == 'Amount_Recieved__c' && pay.NewValue != null){
                            wrapHist.amountRecv =  double.valueOf(pay.NewValue);
                        }
                        if(pay.Field != null && pay.Field == 'Payment_Mode__c' && pay.NewValue != null){
                            wrapHist.paymentMode =  (pay.NewValue).toString();
                        }
                        if(pay.Field != null && pay.Field == 'Cheque_Date__c' && pay.NewValue != null){
                            wrapHist.chequeDate =  Date.valueOf(pay.NewValue);
                        }
                        wrapPaymntHistLst.add(wrapHist);
                    }
                    
                }
                system.debug('---------wrapPaymntHistLst-----------' + wrapPaymntHistLst);
            }
            if(wrapPaymntHistLst.size()>0){
                wrap.wrapHistLst = wrapPaymntHistLst;
            }
            wrapPaymentList.add(wrap);           
            //newLine = '\n';
        }
       system.debug('--------wrapPaymentList------->'+wrapPaymentList+'wrapPaymentList'+wrapPaymentList.size()); 
    }
    
    public String calculateDateString (Date dateIns, String TimeString){
        String YearStr = String.valueOf(dateIns.year());
        String MonthStr = String.valueOf(dateIns.month());
        if(MonthStr.length() == 1){
            MonthStr = '0'+MonthStr;
        }
        String DayStr = String.valueOf(dateIns.day());
        if(DayStr.length() == 1){
            DayStr = '0'+DayStr;
        }
        
        return YearStr+'-'+MonthStr+'-'+DayStr+TimeString;


    }
    
    //wrapper class
    public class wrapPayment{
        public Integer year{get;set;}
        public String oppTrackId {get;set;}
        public String paymentTrackNo{get;set;}
        public String instRefNo{get;set;}
        public list<wrapPayHist> wrapHistLst{get;set;}
    }
    public class wrapPayHist{
        public String RTGSNo{get;set;}
        public String chequeNo{get;set;}
        public Decimal amountRecv{get;set;}
        public String paymentMode{get;set;}
        public Date chequeDate{get;set;}
    }               
        
        
}