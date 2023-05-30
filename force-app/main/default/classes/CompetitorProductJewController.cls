/*
Written By : Deepak Singh G
created date : 14/1/2021
Description : Controller for all 4 Lightning components of Comepetitor Product Jew Object detail and edit pages

*/
public class CompetitorProductJewController {
    
    @AuraEnabled
    public static list<recordType> getRecordType(){
        list<recordType> recList = [Select Id, name from recordType where sobjectType='Competitor_Product_Jew__c'];
        return recList;
    }
    @AuraEnabled
    public static List<String> getPickListValue(string objectApiName, string pickListFieldApiName) {
        system.debug('fieldName==>'+pickListFieldApiName);
        List<String> returnValueList = new List<String>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectApiName); //From the Object Api name retrieving the SObject
        Sobject objectName = targetType.newSObject();
        Schema.sObjectType sobjectType = objectName.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobjectDescribe = sobjectType.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> fieldMap = sobjectDescribe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> schemaPickListValues = fieldMap.get(pickListFieldApiName).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        for (Schema.PicklistEntry var :schemaPickListValues) {
            returnValueList.add(var.getValue());
        }
        system.debug('returnValueList==>'+returnValueList);
        return returnValueList;
    }
    @AuraEnabled
    public static string saveRecord(string recTypeName,String comProdStr){
        system.debug('comProdStr'+comProdStr);
        Competitor_Product_Jew__c comProd = (Competitor_Product_Jew__c) JSON.deserialize(comProdStr,Competitor_Product_Jew__c.class);
        id recTypeId = Schema.SObjectType.Competitor_Product_Jew__c.getRecordTypeInfosByName().get(recTypeName).getRecordTypeId();
        comProd.RecordTypeId = recTypeId;
        insert comProd;
        Competitor_Product_Jew__c temp = new Competitor_Product_Jew__c();
                string returnStr;
        if( comProd.Id != null){
            temp = [select id, name from Competitor_Product_Jew__c where id = :comProd.Id limit 1];
        }
        String Id = comProd.Id;
        returnStr = temp.Id+','+temp.Name;
        system.debug('comProd.name==>'+returnStr);
        return returnStr;
    }
    @AuraEnabled
    public static string getRecodTypeName(id recId){
        string recTypeName;
        system.debug('recId==>'+recId);
        if(recId != null){
            recTypeName = ([select recordType.name from Competitor_Product_Jew__c where id = :recId limit 1]).recordType.name;
        }
        system.debug('in it');
        return recTypeName;
    }
    @AuraEnabled
    public static Competitor_Product_Jew__c fetchProduct(id recId){
        Competitor_Product_Jew__c comProd = new Competitor_Product_Jew__c();
        if(recId != null){
            comProd = [SELECT Id, Name,gold_price_remarks__c, Product_Group__c, Manufacturing_route__c,City__c,Competitor_name__c, Date_of_purchase__c, Product_Category__c,
                       Metal__c, Purchased_Department__c, Purchased_by__c, Remarks__c, Workmenship_Aesthetics__c, Authenticity__c, Other_observation_Special_features__c,
                       Attachment__c, Ovearall_Comment__c, Investigated_by__c, Approved_by__c, Investigated_date__c, Approved_date__c, Color_of_the_metal__c,
                       Color_of_the_metal_Physical_analysis__c, Purity_Physical_analysis__c, Purity_Competitor_Billing__c, Gross_Weight_Physical_analysis__c,
                       Net_Weight_Physical_analysis__c, Stone_Detail__c, Stone_Quality_Physical_analysis__c, Stone_Detail_Competitor_Billing__c, Color__c,
                       Weight_in_Carat__c, Stone_Quality_Competitor_Billing__c, Prong_thickness_Physical_analysis__c, Colour__c, Setting_Type__c,Setting_Type_PA__c,
                       Stone_Visibility_Physical_analysis__c, Setting_Type_Competitor_Billling__c, Finish_Physical_analysis1__c, Plating_Physical_analysis__c,
                       Marking_Competitor_Billing__c, Findings_used_Competitor_Billing__c, Marking_Physical_analysis__c, Findings_used_Physical_analysis__c,
                       Gold_Rate_Gram_Competitor_Billing__c, Gold_Rate_per_Gram_Equalent_at_Tanishq__c, Stone_Rate_per_Carat_Competitor__c, Gold_price_Competitor__c,
                       Stone_Rate_per_Carat_Equalent_at_Tanishq__c, Stone_price_Competitor__c, Gold_price_Equalent_at_Tanishq__c, Making_charges_Competitor__c,
                       Stone_price_Equalent_at_Tanishq__c, Total_amount_paid_Competitor__c, Making_charges_Equalent_at_Tanishq__c, Total_amount_paid_Equalent_at_Tanishq__c,
                       Difference_Equalent_at_Tanishq__c, Difference_Competitor__c, Gross_Weight_Competitor_Billing__c, Net_Weight_Competito_Billing__c, Prong_thickness_in_mm_Competitor_Bill__c,
                       Weight_in_Carat_Competitor_Billing__c, Color_of_the_metal_Remarks__c, Purity_remarks__c, Gross_Weight_Remarks__c, Net_Weight_Remarks__c, Stone_detail_Remarks__c,
                       Stone_quantity_Remarks__c, Color_Remarks__c, Weight_in_Carat_Remarks__c, Prong_thickness_Remarks__c, Setting_Type_Remarks__c, Stone_Visibility_Remarks__c, Finish_Remarks__c,
                       Plating_Remarks__c, Marking_Remarks__c, Findings_used_Remarks__c, Gold_Rate_per_Gram_Remarks__c, Gold_Rate_per_Gram_Conclusion__c, Stone_Rate_per_Carat_Remarks__c,
                       Stone_Rate_per_Carat_Conclusion__c, Gold_price_Conclusion__c, Stone_price_Remarks__c, Stone_price_Conclusion__c, Making_charge_Remarks__c, Making_charge_Conclusion__c,
                       Total_amount_paid_Remarks__c,Email__c, Total_amount_paid_Conclusion__c, Difference_Remarks__c, Difference_Conclusion__c, LastModifiedDate, CreatedDate, Finish_Competitor_Billing__c, Plating_Competitor_Billing__c FROM Competitor_Product_Jew__c
                       where id = :recId limit 1];
        }
        system.debug('comProd====>'+comProd);
        
        return comProd;  
    }
    
    @AuraEnabled
    public static void updateCompRec(string compRec){
        Competitor_Product_Jew__c compProd = (Competitor_Product_Jew__c) JSON.deserialize(compRec,Competitor_Product_Jew__c.class);
        system.debug('Id-'+ compProd.Id);
        system.debug('finish'+ compProd.Finish_Competitor_Billing__c);
        if(compProd != null){
            update compProd;
        }
    }
    @AuraEnabled
    public static List<ContentDocument> getContentDocs(Id arecordId)
    {   
        system.debug('back end');
        List<ContentDocumentLink> CDLs = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :arecordId];
        if (CDLs.size() < 1) return new List<ContentDocument>(); 
        
        // Make a List of ContentDocument IDs
        List <Id> CDIdList = new List <Id> ();
        for (ContentDocumentLink nextCDL : CDLs) {
            CDIdList.add(nextCDL.ContentDocumentId); }        
        
        List<ContentDocument> entries = [SELECT Id, Title, FileType FROM ContentDocument WHERE ContentDocument.Id IN :CDIdList];
        system.debug('entries===>'+entries);
        return entries;
    }
    
    @AuraEnabled
    public static void sendEmailTo(String recId,string emailAddress,string recTypeName){
        system.debug('recId===>'+recId);
        system.debug('email===>'+emailAddress);
        system.debug('recTypeName===>'+recTypeName);
        PageReference ref;
        if(recTypeName == 'Plain'){
            ref = Page.competitorProdJewPDFPlain;
        }
        else{
            ref = Page.competitorProdJewPDF;
        }
        ref.getParameters().put('id',recId);
        Blob b;
        if(Test.isRunningTest()){
            b = blob.valueOf('Test');
        }else{
            b = ref.getContentAsPDF();
        }
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        List<Messaging.EmailFileAttachment> emailAttchmentList = new List<Messaging.EmailFileAttachment>();
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName('Competitor_product_Report.pdf');
        efa1.setBody(b);
        emailAttchmentList.add( efa1 );
        
        List<id> ContentDocumentids = new List<id>();
        for(contentDocumentLink CDLink : [SELECT LinkedEntityid, ContentDocumentid FROM contentDocumentLink WHERE LinkedEntityid=:recId])
        {
            ContentDocumentids.add(CDLink.ContentDocumentid);  
        }
        for ( ContentVersion cversion : [SELECT title,PathOnClient, FileExtension,versiondata  FROM contentversion  WHERE ContentDocumentId IN :ContentDocumentids And (FileExtension='PDF' OR FileExtension='DOCX' OR FileExtension= 'XLSX' OR FileExtension= 'CSV') ])
        {
            blob WOCFbody = cversion.versiondata;
            system.debug('body : '+WOCFbody+'-----------'+cversion.title);
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
            efa.setFileName(cversion.title+'.'+cversion.FileExtension);
            efa.setBody(WOCFbody);
            emailAttchmentList.add(efa); 
        }
        
        list<string> EmailIds = new list<string>();
        EmailIds.add(emailAddress);
        system.debug('EmailIds==>'+EmailIds);
        email.setSubject('Competitor Product Analysis Report');
        email.setToAddresses(EmailIds);
        //email.setPlainTextBody('Hi,<br/> PFA');
        email.setHtmlBody('Hi Team, <br/><br/> Please find the following competitor product analysis document (system generated) attached in the email.');
        if(emailAttchmentList.size()> 0)
        	email.setFileAttachments(emailAttchmentList);
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
    
}