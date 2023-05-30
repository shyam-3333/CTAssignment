/*Created By : KVP- Chakresh Verma/Gaurav Singh
*Name : FetchGiftCardsDetailsFromAWS
*Created on : 11 Jul 2021
*Description : This Batch Class is Fetching the Data from S3 AWS(Quickcilver Bucket) and Creating only the Gift Card Records and in Finish Method 
Calling the FetchRedemptionDetailsFromAWS Batch for Redemptions Data
*/
public class FetchGiftCardsDetailsFromAWS implements Database.Batchable<Object>,Database.AllowsCallouts,Database.Stateful, Schedulable{
    private static final String giftCardActivate = 'GIFT CARD ACTIVATE';
    private static final String giftCardCancelActivate = 'GIFT CARD CANCEL ACTIVATE';
    Public Set<String> giftCardsNumbers = new Set<String>();
    public String cardNumbersWithError = '';
    
    Gift_Cards__c gift;
    Redemption_Details__c redem;
    public Iterable<Object> start(Database.BatchableContext bc){
        String contentType='application/Json';
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        String urlExtension = 'Titan_Gift_Card_'+String.valueOf(System.today().addDays(-1))+'.csv';
        //String urlExtension = Label.Quikcilver_GiftCards;
        //String urlExtension=  'Titan_Gift_Card_2021-12-30.csv';
        
        req.setEndpoint('callout:Amazon_S3/Production/' + urlExtension);
        req.setTimeout(120000);            
        req.setHeader('Content-type', contentType);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        System.debug(res.getStatusCode());
        String responseBody = res.getBody();
        Utility_RowIterator rowIterator = new Utility_RowIterator(responseBody,'\n'); //Replace \n with whatever delineates your row
        List<Object> mainList = new List<Object>();
        String firstRow;
        while(rowIterator.hasNext()){
            firstRow = rowIterator.next();
            String[] csvRecordData = firstRow.split(',');
            if((csvRecordData[9]==giftCardActivate || csvRecordData[9]==giftCardCancelActivate) && csvRecordData[0] != null && csvRecordData[0] != ''){
                mainList.add(firstRow);
            }
        }
        return mainList;
        
    }
    public void execute(Database.BatchableContext bc, List<Object> scope){
        try{
            List<String> data = new List<String>();
            List<Gift_Cards__c> giftCards = new List<Gift_Cards__c>();
            data = (List<String>)JSON.deserialize(JSON.serialize(scope),List<String>.class);
            Set<String> invoiceNumber = new Set<String>();
            Map<string, string> quoteMap = new Map<string, string>();
            
            for(String eachRow : data){
                String[] csvRecordData = eachRow.split(',');
                System.debug('eachRow-->'+eachRow);
                System.debug('csvRecordData[0]-->'+csvRecordData[0]+',csvRecordData[15]-->'+csvRecordData[15]);
                //System.debug('csvRecordData[15]-->'+csvRecordData[15]);
                if((csvRecordData[9]==giftCardActivate || csvRecordData[9]==giftCardCancelActivate) && csvRecordData[0] != null && csvRecordData[0] != ''){
                    if(csvRecordData[12] != null && csvRecordData[12] != ''){
                        invoiceNumber.add(csvRecordData[12]);
                    }
                }
            }
            for(Quote quo :[Select Id, INSTI_Order_Reference__c from Quote where INSTI_Order_Reference__c in:invoiceNumber]){
                if(quo.INSTI_Order_Reference__c != null && quo.INSTI_Order_Reference__c != '' && quo.Id != null){
                    quoteMap.put(quo.INSTI_Order_Reference__c, quo.Id);
                }
            }
            
            for(String eachRow : data){
                String[] csvRecordData = eachRow.split(',');
                if((csvRecordData[9]==giftCardActivate || csvRecordData[9]==giftCardCancelActivate) && csvRecordData[0] != null && csvRecordData[0] != ''){
                    //giftCards.add(createGiftCards(csvRecordData,null));
                    if(quoteMap.containsKey(csvRecordData[12])){
                        if(quoteMap.get(csvRecordData[12])!= null){
                            System.debug('csvRecordData[0]-->'+csvRecordData[0]);
                            System.debug('csvRecordData[15]-->'+csvRecordData[15]);
                            giftCards.add(createGiftCards(csvRecordData,quoteMap.get(csvRecordData[12])));
                        }
                    }else{
                        giftCards.add(createGiftCards(csvRecordData,null));
                    }
                }
            }
            
            if(!giftCards.isEmpty()){
                //Database.insert(giftCards);
                Database.SaveResult[] resultlist = Database.insert(giftCards, false);
                //Check which records got successfully inserted and which got failed
                Integer i = 0;
                
                for(Database.SaveResult SR : resultlist)
                {
                    //Successful records
                    If(SR.isSuccess())
                    {
                        System.debug('Successfully inserted these records: '+SR.getID());
                    }
                    //Failed records
                    else
                    {
                        for(Database.Error SRError : SR.getErrors())
                        {
                            System.debug('Following error has occured');            
                            //Get error status code and message
                            System.debug(SRError.getStatusCode()+' : '+SRError.getMessage());   
                            System.debug('Card Number-->'+giftCards[i].Card_Number__c);       
                            cardNumbersWithError += giftCards[i].Card_Number__c+',';
                            //Know which fields are affected
                            System.debug('Fields of Invoice object which are affected : '+SRError.getFields());
                        }
                    }
                }
            }
        }catch(Exception exp){
            System.debug('Message-->'+ exp.getMessage());
            System.debug('Line Number--->'+exp.getLineNumber());
        }        
    }
    public void finish(Database.BatchableContext bc){
        System.debug('cardNumbersWithError-->'+cardNumbersWithError);
        System.debug('giftCardsNumbers'+giftCardsNumbers.size());
        
        FetchRedemptionDetailsFromAWS redeemBatch = new FetchRedemptionDetailsFromAWS();
        Database.executeBatch(redeemBatch,1000);
    }
    
    public void execute(SchedulableContext SC) {
        Database.executebatch(new FetchGiftCardsDetailsFromAWS(),1000);
    }
    
    private Gift_Cards__c createGiftCards(String[] csvRecordData,String invoiceNumber){
        gift = new Gift_Cards__c();
        System.debug('csvRecordData[0]'+csvRecordData[0]);
        gift.Card_Number__c = csvRecordData[0];
        gift.Merchant__c = csvRecordData[1];
        gift.Outlet__c = csvRecordData[2];
        gift.Issuer__c = csvRecordData[3];
        if(invoiceNumber != null && invoiceNumber !=''){
            gift.Quote__c  = invoiceNumber;
        }
        gift.Transaction_Date__c =date.parse(csvRecordData[4]);
        List<String> tran_Time = csvRecordData[5].split(':');
        gift.Transaction_Time__c = Time.newInstance(Integer.valueOf(tran_Time[0]),
                                                    Integer.valueOf(tran_Time[1]),
                                                    Integer.valueOf(tran_Time[2]),
                                                    0);         
        gift.POS_Name__c =csvRecordData[6];
        gift.Initiated_by__c = csvRecordData[7];
        gift.Program_Group__c = csvRecordData[8];
        gift.Transaction_Type__c = csvRecordData[9];
        String giftCardAmount  = csvRecordData[10];
        gift.Gift_Card_Amount__c = Integer.valueof(giftCardAmount);
        gift.Invoice_Number__c = csvRecordData[12];
        gift.Response_Message__c =csvRecordData[13];
        gift.Reason_of_Cancel__c = csvRecordData[14];
        if(csvRecordData[15] != '' && csvRecordData[15] != null){
            gift.Pre_Transaction_Card_Balance__c = Double.valueOf(csvRecordData[15].trim());
        }
        
        if(csvRecordData[16] != '' && csvRecordData[16] != null){
            gift.Card_Balance__c = Double.valueOf(csvRecordData[16]);
        }
        String expiryDate = csvRecordData[17];
        expiryDate = expiryDate.trim();
        if(expiryDate != null && expiryDate != '' && expiryDate != 'NULL'){
            //system.debug(csvRecordData[0]+'-->'+csvRecordData[17]);
            gift.Expiry_Date__c =date.valueOf(date.parse(expiryDate));
            
            //system.debug('parse_date'+date.parse(csvRecordData[17]));
            //system.debug('date.valueOf'+date.valueOf(date.parse(csvRecordData[17])));
        }
        gift.Reference_Number__c = Integer.valueof(csvRecordData[18]);//
        gift.Card_Entry_Mode__c = csvRecordData[19];
        gift.Batch_Number__c =Integer.valueof(csvRecordData[20]);//
        gift.Note__c =csvRecordData[21];
        gift.Approval_Code__c = csvRecordData[22];
        return gift;
    }
}