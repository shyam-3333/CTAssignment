/*Created By : KVP- Chakresh Verma
*Name : FetchRedemptionDetailsFromAWS
*Created on : 11 Jul 2021
*Description : This Batch Class is Fetching the Data from S3 AWS(Quickcilver Bucket) and Creating only the Redemptions Records and Mapping with the Gift Cards
*/

public class FetchRedemptionDetailsFromAWS implements Database.Batchable<Object>,Database.AllowsCallouts,Database.Stateful {
    private static final String giftCardRedeem = 'GIFT CARD REDEEM';
    private static final String giftCardCancelRedeem = 'GIFT CARD CANCEL REDEEM';
    Public Set<String> giftCardsNumbers = new Set<String>();
    
    
    Gift_Cards__c gift;
    Redemption_Details__c redem;
    public Iterable<Object> start(Database.BatchableContext bc){
        String contentType='application/Json';
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        String urlExtension = 'Titan_Gift_Card_'+String.valueOf(System.today().addDays(-1))+'.csv';
        //String urlExtension = Label.Quikcilver_GiftCards;
        //String urlExtension=  'Titan_Gift_Card_2021-10-27.csv';
        
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
            if((csvRecordData[9]==giftCardRedeem || csvRecordData[9]==giftCardCancelRedeem) && csvRecordData[0] != null && csvRecordData[0] != ''){
                mainList.add(firstRow);
            }
        }
        return mainList;
        
    }
    public void execute(Database.BatchableContext bc, List<Object> scope){
        try{
            List<String> data = new List<String>();
            data = (List<String>)JSON.deserialize(JSON.serialize(scope),List<String>.class);
            Set<String> giftCardNumbers = new Set<String>();
            Map<String,String> mapOfGiftCards = new Map<String,String>();
            List<Redemption_Details__c> redemList = new list<Redemption_Details__c>();
            List<Gift_Cards__c> giftCardsToUpdate = new List<Gift_Cards__c>();
            Map<String,Date> mapOfTransactionDate = new Map<String,Date>();
            
            Redemption_Details__c redeem;
            
            for(String eachRow : data){
                String[] csvRecordData = eachRow.split(',');
                if(csvRecordData[0] != '' && csvRecordData[0] != null && (csvRecordData[9]==giftCardRedeem || csvRecordData[9]==giftCardCancelRedeem) && csvRecordData[0] != null && csvRecordData[0] != ''){
                    giftCardNumbers.add(csvRecordData[0]);
                    if(csvRecordData[4] !='' && csvRecordData[4] != null){
                        mapOfTransactionDate.put(csvRecordData[0],Date.parse(csvRecordData[4]));
                    }
                }
            }
            
            for(Gift_Cards__c giftCard : [Select Id,Card_Number__c,Transaction_Date__c from Gift_Cards__c where Card_Number__c In : giftCardNumbers]){
                if(giftCard.Card_Number__c != '' && giftCard.Card_Number__c != null){
                    mapOfGiftCards.put(giftCard.Card_Number__c,giftCard.Id);
                    if(!mapOfTransactionDate.isEmpty() && mapOfTransactionDate.containsKey(giftCard.Card_Number__c)){
                        if(mapOfTransactionDate.get(giftCard.Card_Number__c) != null && giftCard.Transaction_Date__c != null){
                            Date firstRedemtionDate = mapOfTransactionDate.get(giftCard.Card_Number__c);
                            Date giftCardDate = giftCard.Transaction_Date__c;
                            Integer noOfDays = giftCardDate.daysBetween(firstRedemtionDate);
                            giftCard.Days_before_first_Redemption__c = noOfDays;
                            giftCardsToUpdate.add(giftCard);
                        }
                    }
                }
                
            }
            Redemption_Details__c redemForGiftCard;
            for(String eachRow : data){
                String[] csvRecordData = eachRow.split(',');
                if(csvRecordData[0] != '' && csvRecordData[0] != null && (csvRecordData[9]==giftCardRedeem || csvRecordData[9]==giftCardCancelRedeem) && csvRecordData[0] != null && csvRecordData[0] != ''){
                    if(mapOfGiftCards.containsKey(csvRecordData[0])){
                        if(mapOfGiftCards.get(csvRecordData[0]) != null && mapOfGiftCards.get(csvRecordData[0]) !=''){
                            //redemForGiftCard = createRedemptions(csvRecordData,mapOfGiftCards.get(csvRecordData[0]).Id);
                            redemList.add(createRedemptions(csvRecordData,mapOfGiftCards.get(csvRecordData[0])));
                        }
                    }
                }
            }
            
            if(!redemList.isEmpty()){
                
                Database.SaveResult[] resultlist = Database.insert(redemList, false);
                //Check which records got successfully inserted and which got failed
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
                            System.debug('Gift Card Error-->'+SRError.getStatusCode()+' : '+SRError.getMessage());     
                            
                            
                            //Know which fields are affected
                            System.debug('Fields of Invoice object which are affected : '+SRError.getFields());
                        }
                    }
                }
            }
            
            if(!giftCardsToUpdate.isEmpty()){
                Database.SaveResult[] resultlist = Database.update(giftCardsToUpdate, false);
                //Check which records got successfully inserted and which got failed
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
        System.debug('giftCardsNumbers'+giftCardsNumbers.size());
        Database.executeBatch(new GiftcardQuoteBatch(), 2000);
    }
    
    private Redemption_Details__c createRedemptions(String[] csvRecordData,String giftCardId){
        redem = new Redemption_Details__c();
        redem.Card_Number__c = csvRecordData[0];
        redem.Merchant__c = csvRecordData[1];
        redem.Gift_Card__c = giftCardId;
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
            redem.Bill_Amount__c = Double.valueof(billAmount);
        }
        redem.Invoice_Number__c = csvRecordData[12];
        redem.Response_Message__c =csvRecordData[13];
        redem.Reason_of_Cancel__c = csvRecordData[14];
        if(csvRecordData[15] != '' && csvRecordData[15] != null){
            redem.Pre_Transaction_Card_Balance__c = Double.valueOf(csvRecordData[15].trim());
        }
        
        if(csvRecordData[16] != '' && csvRecordData[16] != null){
            redem.Card_Balance__c = Double.valueOf(csvRecordData[16]);
        }
        String expiryDate = csvRecordData[17];
        expiryDate = expiryDate.trim();
        if(expiryDate != null && expiryDate != '' && expiryDate != 'NULL'){
            redem.Expiry_Date__c =date.valueOf(date.parse(expiryDate));
        }
        redem.Reference_Number__c = Integer.valueof(csvRecordData[18]);
        redem.Card_Entry_Mode__c = csvRecordData[19];
        redem.Batch_Number__c =Integer.valueof(csvRecordData[20]);
        redem.Note__c =csvRecordData[21];
        redem.Approval_Code__c = csvRecordData[22];
        return redem;
    }
    
    
    
    
}