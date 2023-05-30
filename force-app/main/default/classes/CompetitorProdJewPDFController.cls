public class CompetitorProdJewPDFController {
    
    public Competitor_Product_Jew__c comProd{get;set;}
    public string dateOfPurchase{get;set;}
    public string investigatedByDate{get;set;}
    public string approvedByDate{get;set;}
    public List<String> imageURLlist{get;set;}
    public String finish{get;set;}
    public string recId;
    public ContentVersion files;
    public  CompetitorProdJewPDFController(){
        recId = apexpages.currentPage().getParameters().get('id');
        imageURLlist= new List<string>();
        system.debug('recId==>'+recId);
        comProd = new Competitor_Product_Jew__c();
        if(recId != null){
            comProd = [SELECT Id, Name,RecordType.Name,Email__c,gold_price_remarks__c,Setting_Type_PA__c,City__c,Competitor_name__c,  Product_Group__c, Manufacturing_route__c, Date_of_purchase__c, Product_Category__c,
                       Metal__c, Purchased_Department__c, Purchased_by__c, Remarks__c, Workmenship_Aesthetics__c, Authenticity__c, Other_observation_Special_features__c,
                       Attachment__c, Ovearall_Comment__c, Investigated_by__c, Approved_by__c, Investigated_date__c, Approved_date__c, Color_of_the_metal__c,
                       Color_of_the_metal_Physical_analysis__c, Purity_Physical_analysis__c, Purity_Competitor_Billing__c, Gross_Weight_Physical_analysis__c,
                       Net_Weight_Physical_analysis__c, Stone_Detail__c, Stone_Quality_Physical_analysis__c, Stone_Detail_Competitor_Billing__c, Color__c,
                       Weight_in_Carat__c, Stone_Quality_Competitor_Billing__c, Prong_thickness_Physical_analysis__c, Colour__c, Setting_Type__c,
                       Stone_Visibility_Physical_analysis__c,Setting_Type_Competitor_Billling__c, Finish_Physical_analysis1__c, Plating_Physical_analysis__c,
                       Marking_Competitor_Billing__c, Findings_used_Competitor_Billing__c, Marking_Physical_analysis__c, Findings_used_Physical_analysis__c,
                       Gold_Rate_Gram_Competitor_Billing__c, Gold_Rate_per_Gram_Equalent_at_Tanishq__c, Stone_Rate_per_Carat_Competitor__c, Gold_price_Competitor__c,
                       Stone_Rate_per_Carat_Equalent_at_Tanishq__c, Stone_price_Competitor__c, Gold_price_Equalent_at_Tanishq__c, Making_charges_Competitor__c,
                       Stone_price_Equalent_at_Tanishq__c, Total_amount_paid_Competitor__c, Making_charges_Equalent_at_Tanishq__c, Total_amount_paid_Equalent_at_Tanishq__c,
                       Difference_Equalent_at_Tanishq__c, Difference_Competitor__c, Gross_Weight_Competitor_Billing__c, Net_Weight_Competito_Billing__c, Prong_thickness_in_mm_Competitor_Bill__c,
                       Weight_in_Carat_Competitor_Billing__c, Color_of_the_metal_Remarks__c, Purity_remarks__c, Gross_Weight_Remarks__c, Net_Weight_Remarks__c, Stone_detail_Remarks__c,
                       Stone_quantity_Remarks__c, Color_Remarks__c, Weight_in_Carat_Remarks__c, Prong_thickness_Remarks__c, Setting_Type_Remarks__c, Stone_Visibility_Remarks__c, Finish_Remarks__c,
                       Plating_Remarks__c, Marking_Remarks__c, Findings_used_Remarks__c, Gold_Rate_per_Gram_Remarks__c, Gold_Rate_per_Gram_Conclusion__c, Stone_Rate_per_Carat_Remarks__c,
                       Stone_Rate_per_Carat_Conclusion__c, Gold_price_Conclusion__c, Stone_price_Remarks__c, Stone_price_Conclusion__c, Making_charge_Remarks__c, Making_charge_Conclusion__c,
                       Total_amount_paid_Remarks__c, Total_amount_paid_Conclusion__c, Difference_Remarks__c, Difference_Conclusion__c, LastModifiedDate, CreatedDate, Finish_Competitor_Billing__c, Plating_Competitor_Billing__c FROM Competitor_Product_Jew__c
                       where id = :recId limit 1];
            finish = comProd.Finish_Competitor_Billing__c;
            System.debug('finish : '+finish);
            System.debug('Finish_Competitor_Billing__c : '+comProd.Finish_Competitor_Billing__c);
            if( comProd.Date_of_purchase__c != null){
                dateOfPurchase = string.valueOf(comProd.Date_of_purchase__c);
                dateOfPurchase = dateOfPurchase.substring(8, 10)+'-'+dateOfPurchase.substring(5, 7)+'-'+dateOfPurchase.substring(0, 4);
            }
            if( comProd.Investigated_date__c != null){
                investigatedByDate = string.valueOf(comProd.Investigated_date__c);
                investigatedByDate = investigatedByDate.substring(8, 10)+'-'+investigatedByDate.substring(5, 7)+'-'+investigatedByDate.substring(0, 4);
            }
            if(comProd.Approved_date__c != null){
                approvedByDate =  string.valueOf(comProd.Approved_date__c);
                approvedByDate = approvedByDate.substring(8, 10)+'-'+approvedByDate.substring(5, 7)+'-'+approvedByDate.substring(0, 4);
            }
            
            imageAttachment();
        }
        
    }
    public void imageAttachment(){
        List<id> ContentDocumentids = new List<id>();
        List<ContentDocumentLink> CDLs = [SELECT LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId=:recId];
        for(contentDocumentLink CDLink : CDLs)
        {
            ContentDocumentids.add(CDLink.ContentDocumentid);  
        }
        String imageURL='/sfc/servlet.shepherd/version/download/';
        for ( ContentVersion cversion : [SELECT Id,title,PathOnClient, FileExtension,versiondata,ContentDocumentId  FROM contentversion  WHERE ContentDocumentId IN :ContentDocumentids And (FileExtension='PNG' OR FileExtension='JPG' OR FileExtension= 'JPEG') ])
        {
            blob WOCFbody = cversion.versiondata;
            string dipslaytable = EncodingUtil.base64Encode(WOCFbody);
            //imageURLlist.add(dipslaytable);
            system.debug('body : '+WOCFbody+'-----------'+cversion.title);
            imageURLlist.add( imageURL +''+cversion.Id );
            system.debug( imageURL +''+ cversion.Id );
        }
    }       
    
}