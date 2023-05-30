public with sharing class FetchGiftCardsRedemptionDetails implements Database.Batchable<sObject>,Database.AllowsCallouts{
    private static final String giftCardRedeem = 'GIFT CARD REDEEM';
    private static final String giftCardCancelRedeem = 'GIFT CARD CANCEL REDEEM';
    private static final String giftCardActivate = 'GIFT CARD ACTIVATE';
    private static final String giftCardCancelActivate = 'GIFT CARD CANCEL ACTIVATE';
    
    Gift_Cards__c gift;
    Redemption_Details__c redem;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id from User LIMIT 1');
    }
    public void execute(Database.BatchableContext bc, List<sObject> scope){
        fetchFileFromS3();
    }
    public void finish(Database.BatchableContext bc){
        
    }
    
    public void fetchFileFromS3(){
        List<Gift_Cards__c> giftList = new list<Gift_Cards__c>();
        List<Redemption_Details__c> redemList = new list<Redemption_Details__c>();
        Set<String> existingGiftCards = new Set<String>();
        Map<String,Gift_Cards__c> mapOfExistingGiftCards = new Map<String,Gift_Cards__c>();
        Map<String,Gift_Cards__c> mapOfCardNumber = new Map<String,Gift_Cards__c>();
        List<Redemption_Details__c> redemtionForNewGiftCards = new List<Redemption_Details__c>();
        List<Redemption_Details__c> redemtionForExistingGiftCard = new List<Redemption_Details__c>();
        
        try{
            String contentType='application/Json';
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            //String urlExtension = 'Titan_Gift_Card_'+String.valueOf(System.today()-2)+'.csv';
            String urlExtension = Label.Quikcilver_GiftCards;
            req.setEndpoint('callout:Amazon_S3/Production/' + urlExtension);
            req.setTimeout(60000);            
            req.setHeader('Content-type', contentType);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            
            System.debug(res.getStatusCode());
            String responseBody = res.getBody();
            Utility_RowIterator rowIterator = New Utility_RowIterator(responseBody,'\n'); //Replace \n with whatever delineates your row
            List<String> mainList = new List<String>();
            String firstRow;
            while(rowIterator.hasNext()){
                firstRow = rowIterator.next();
                //System.debug('firstRow-->'+firstRow);
                mainList.add(firstRow);
            }
            System.debug('mainList--->'+mainList.size());
            for(String main: mainList){
                System.debug(main);
            }
            
            for(String eachRow : mainList){
                String[] csvRecordData = eachRow.split(',');
                if((csvRecordData[9]==giftCardActivate || csvRecordData[9]==giftCardCancelActivate) && csvRecordData[0] != null && csvRecordData[0] != ''){
                    giftList.add(createGiftCards(csvRecordData));
                    
                }else if((csvRecordData[9]==giftCardRedeem || csvRecordData[9]==giftCardCancelRedeem) && csvRecordData[0] != null && csvRecordData[0] != ''){
                    existingGiftCards.add(csvRecordData[0]);
                    //System.debug('csvRecordData[0]'+csvRecordData[0]);
                    redemList.add(createRedemptions(csvRecordData));
                    
                }
            }
            if(!existingGiftCards.isEmpty()){
                mapOfExistingGiftCards = fetchExistingGiftCards(existingGiftCards);
                // System.debug('existingGiftCards-->'+existingGiftCards);
                // System.debug('mapOfExistingGiftCards-->'+mapOfExistingGiftCards);
                
            }
            
            if(!giftList.isEmpty()){
               insert giftList;
            }
            
            
            if(! giftList.isEmpty()){
                mapOfCardNumber = createGiftCardIdsMapping(giftList);
            }
            List<Gift_Cards__c> giftCardTransaction = new List<Gift_Cards__c>();
            Map<id,Gift_Cards__c> giftCardTransactionMap = new Map<id,Gift_Cards__c>();
            if(!redemList.isEmpty()){  
                for(Redemption_Details__c redeem: redemList){
                    if(redeem.Card_Number__c != null && redeem.Card_Number__c != '' ){
                        if(mapOfCardNumber.containsKey(redeem.Card_Number__c) && mapOfCardNumber.get(redeem.Card_Number__c) != null){
                            redeem.Gift_Card__c = mapOfCardNumber.get(redeem.Card_Number__c).Id;
                            redemtionForNewGiftCards.add(redeem);
                            if(redeem.Transaction_Date__c != null && mapOfCardNumber.get(redeem.Card_Number__c).Id != null && mapOfCardNumber.get(redeem.Card_Number__c).Transaction_Date__c != null){
                                Date firstRedemtionDate = redeem.Transaction_Date__c;
                                Date giftCardDate = mapOfCardNumber.get(redeem.Card_Number__c).Transaction_Date__c;
                                Integer noOfDays = giftCardDate.daysBetween(giftCardDate);
                                giftCardTransaction.add(new Gift_Cards__c(Id = mapOfCardNumber.get(redeem.Card_Number__c).Id,Days_before_first_Redemption__c=noOfDays));
                                
                            }
                            
                        }
                        else if(mapOfExistingGiftCards.containsKey(redeem.Card_Number__c) && mapOfExistingGiftCards.get(redeem.Card_Number__c) != null){
                            redeem.Gift_Card__c = mapOfExistingGiftCards.get(redeem.Card_Number__c).Id;
                            redemtionForExistingGiftCard.add(redeem);
                            if(redeem.Transaction_Date__c != null && mapOfExistingGiftCards.get(redeem.Card_Number__c).Id != null && mapOfExistingGiftCards.get(redeem.Card_Number__c).Transaction_Date__c != null){
                                Date firstRedemtionDate = redeem.Transaction_Date__c;
                                Date giftCardDate = mapOfExistingGiftCards.get(redeem.Card_Number__c).Transaction_Date__c;
                                Integer noOfDays = giftCardDate.daysBetween(firstRedemtionDate);
                                giftCardTransaction.add(new Gift_Cards__c(Id = mapOfExistingGiftCards.get(redeem.Card_Number__c).Id,Days_before_first_Redemption__c=noOfDays));
                            }
                        }
                    }
                }
                System.debug('redemtionForExistingGiftCard'+redemtionForExistingGiftCard.size());
                System.debug('redemtionForNewGiftCards'+redemtionForNewGiftCards);
                
                if(!redemtionForNewGiftCards.isEmpty()){
                    insert redemtionForNewGiftCards;
                }
                if(!redemtionForExistingGiftCard.isEmpty()){
                    insert redemtionForExistingGiftCard;
                }
                
                if(!giftCardTransaction.isEmpty()){
                    giftCardTransactionMap.putall(giftCardTransaction);
                    //update giftCardTransaction;
                    update giftCardTransactionMap.values();
                    System.debug('giftCardTransaction-->'+giftCardTransaction);
                }
            }
            
        }catch(Exception exp){
            System.debug('Message-->'+ exp.getMessage());
            System.debug('Line Number--->'+exp.getLineNumber());
        }       
    }
    
    private Gift_Cards__c createGiftCards(String[] csvRecordData){
        gift = new Gift_Cards__c();
        gift.Card_Number__c = csvRecordData[0];
        gift.Merchant__c = csvRecordData[1];
        gift.Outlet__c = csvRecordData[2];
        gift.Issuer__c = csvRecordData[3];
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
        gift.Pre_Transaction_Card_Balance__c = Integer.valueOf(csvRecordData[15]);
        gift.Card_Balance__c = Integer.valueOf(csvRecordData[16]);
        String expiryDate = csvRecordData[17];
        expiryDate = expiryDate.trim();
        if(expiryDate != null && expiryDate != ''){
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
    
    private Redemption_Details__c createRedemptions(String[] csvRecordData){
        redem = new Redemption_Details__c();
        redem.Card_Number__c = csvRecordData[0];
        redem.Merchant__c = csvRecordData[1];
        redem.Outlet__c = csvRecordData[2];
        redem.Issuer__c = csvRecordData[3];
        redem.Transaction_Date__c =date.parse(csvRecordData[4]);
        List<String> tran_Time = csvRecordData[5].split(':');
        redem.Transaction_Time__c = Time.newInstance(Integer.valueOf(tran_Time[0]),
                                                     Integer.valueOf(tran_Time[1]),
                                                     Integer.valueOf(tran_Time[2]),
                                                     0);
        redem.POS_Name__c =csvRecordData[6];
        redem.Initiated_by__c = csvRecordData[7];
        redem.Program_Group__c = csvRecordData[8];
        redem.Transaction_Type__c = csvRecordData[9];
        
        String giftCardAmount  = csvRecordData[10];
        redem.Gift_Card_Amount__c = Integer.valueof(giftCardAmount);
        
        String billAmount  = csvRecordData[11];
        if(billAmount != null && billAmount != ''){
            redem.Bill_Amount__c = Integer.valueof(billAmount);
        }
        redem.Invoice_Number__c = csvRecordData[12];
        redem.Response_Message__c =csvRecordData[13];
        redem.Reason_of_Cancel__c = csvRecordData[14];
        redem.Pre_Transaction_Card_Balance__c = Integer.valueOf(csvRecordData[15]);
        redem.Card_Balance__c = Integer.valueOf(csvRecordData[16]);
        redem.Expiry_Date__c =date.parse(csvRecordData[17]);
        redem.Reference_Number__c = Integer.valueof(csvRecordData[18]);
        redem.Card_Entry_Mode__c = csvRecordData[19];
        redem.Batch_Number__c =Integer.valueof(csvRecordData[20]);
        redem.Note__c =csvRecordData[21];
        redem.Approval_Code__c = csvRecordData[22];
        return redem;
    }
    
    private Map<String,Gift_Cards__c> createGiftCardIdsMapping(List<Gift_Cards__c> giftList){
        Map<String, Gift_Cards__c> mapOfCardNumber = new Map<String,Gift_Cards__c>();
        
        for(Gift_Cards__c activateGift :giftList){
            if(activateGift.Card_Number__c != null && activateGift.Card_Number__c != '' && activateGift.Id != null){
                mapOfCardNumber.put(activateGift.Card_Number__c,activateGift);
            }
        }
        return mapOfCardNumber;
    }
    
    
    private Map<String,Gift_Cards__c> fetchExistingGiftCards(Set<String> cardNumbers){
        System.debug('cardNumbers--->'+cardNumbers);
        
        Map<String,Gift_Cards__c> mapOfExistingGiftCards = new Map<String,Gift_Cards__c>();
        for(Gift_Cards__c giftCards : [Select Id,Card_Number__c,Transaction_Date__c from Gift_Cards__c where Card_Number__c In : cardNumbers]){
            System.debug('giftCards'+giftCards);
            if(giftCards.Card_Number__c != null && Gift_Cards__c.Id != null){
                mapOfExistingGiftCards.put(giftCards.Card_Number__c,giftCards); 
            }
        }
        System.debug('mapOfExistingGiftCards-->'+mapOfExistingGiftCards);
        return mapOfExistingGiftCards;
    }
    
}