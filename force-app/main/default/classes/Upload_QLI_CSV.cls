/*******************************************************************
Created by: Vinoth Kumar A
Created on:16/07/2019
Description: Class to import quote line item records from CSV file.
********************************************************************/
Global class Upload_QLI_CSV {
    public blob contentFile{get;set;} // csv file content
    public string CSVDataString{get;set;} 
    public List<QuoteLineItem> QLIList{get;set;}
    public id QuoteId{get;set;}
    
    public void ImportCSVFile(){
        //try{
        QuoteId = ApexPages.currentPage().getParameters().get('id');
        system.debug('QuoteId:'+QuoteId);
        List<string> recordSepr = new List<string>();
        List<string> recordValues = new List<string>();
        QLIList = new List<QuoteLineItem>();
        CSVDataString = contentFile.toString(); // CSV file content is converted as one string
        system.debug('QuoteId'+QuoteId);
        recordSepr.addAll(CSVDataString.split('\n')); // CSV data string is split into separate records
        system.debug('recordSepr:'+recordSepr);
        integer i = 0;
        for(string rs:recordSepr){
            system.debug('rs:'+rs);
            if(!rs.contains(',,,,')){
                List<string> qlirecord = rs.split(','); // each record is split into field values
                system.debug('qlirecord:'+qlirecord);
                if(i == 1){
                    system.debug('I value:'+i);
                    Quote qobj = [SELECT Id, Pricebook2Id FROM Quote WHERE Id=:QuoteId limit 1];
                    system.debug('Quote obj:'+qobj);
                    system.debug('Quote Pricebook2Id:'+qobj.Pricebook2Id);
                    if(qobj.Pricebook2Id == NULL){
                        system.debug('Quote Pricebook2Id not null:'+qobj.Pricebook2Id);
                        id pbeId = Id.ValueOf(qlirecord[2]);
                        system.debug('Quote Pricebook2Id query'+[SELECT Id,Pricebook2Id FROM PricebookEntry WHERE Id=:pbeId].Pricebook2Id);
                        Quote qt = new Quote();
                        qt.id = QuoteId;
                        qt.Pricebook2Id = [SELECT Id,Pricebook2Id FROM PricebookEntry WHERE Id=:qlirecord[2]].Pricebook2Id;
                        system.debug('Qt:'+qt);
                        update qt;
                    }
                }
                if(i>0 && qlirecord[1] != ''){
                    QuoteLineItem QLI =  new QuoteLineItem();
                    QLI.Product2Id = qlirecord[1];
                    QLI.QuoteId = QuoteId;
                    QLI.PricebookEntryId = qlirecord[2];
                    QLI.Sales_Price_c__c = Decimal.ValueOf(qlirecord[3]);
                    QLI.Discount_c__c = Decimal.ValueOf(qlirecord[4]);
                    QLI.UnitPrice = Decimal.ValueOf(qlirecord[5]);
                    QLI.Quantity = Integer.ValueOf(qlirecord[6].trim());
                    QLIList.add(QLI);
                    system.debug('inside for QLI:'+QLI);
                }
                i++;
            }
            
        }
       
        system.debug('qliList:'+QLIList);
        if(!QLIList.isEmpty()){
            insert QLIList;
            /*     }
					}
					catch (Exception e){
					ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error occured while importing data');
					ApexPages.addMessage(errorMessage);*/
        }
    }
}