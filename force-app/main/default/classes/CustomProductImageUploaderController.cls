public class CustomProductImageUploaderController {
    
    @AuraEnabled                            
    public static Id saveTheChunkFile(Id parentId, String fileName, String base64Data, String contentType, String fileId){
        
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        if ( String.isBlank(fileId) ) {
            fileId = saveFiles(parentId, fileName, base64Data );
        } else {
            appendToFile(fileId, base64Data);
        }
        
        return Id.valueOf(fileId);
    }
    
    @AuraEnabled
    public static Id saveFiles(Id recordId, String fileName, String base64Data )  { 
        
        ContentVersion contentToInsert =new ContentVersion(); 
        contentToInsert.Title =fileName; 
        contentToInsert.VersionData=EncodingUtil.base64Decode(base64Data);
        contentToInsert.PathOnClient='/' + fileName ;
        contentToInsert.IsMajorVersion = false;
        insert contentToInsert; 
        
        contentToInsert = [select id, ContentDocumentId from ContentVersion WHERE Id =: contentToInsert.Id];
        ContentDocumentLink cl = new ContentDocumentLink();
        cl.ContentDocumentId = contentToInsert.ContentDocumentId;
        cl.LinkedEntityId = recordId; 
        cl.ShareType = 'V';
        cl.Visibility = 'AllUsers';
        insert cl;
        
        ContentDistribution cdl = new ContentDistribution();
        cdl.ContentVersionId = contentToInsert.Id;
        cdl.Name = 'PublicShare';
        insert cdl;
        String publicURl = [SELECT DistributionPublicUrl, ContentDownloadUrl FROM ContentDistribution WHERE Id = :cdl.Id LIMIT 1].ContentDownloadUrl;
        
        System.debug('publicURl--->'+publicURl);
        
        /*Attachment attachment = new Attachment();
        attachment.Body = EncodingUtil.base64Decode(base64Data);
        attachment.Name = fileName;
        attachment.ParentId = recordId; 
        insert attachment;*/
        
        Product_Master__c master = new Product_Master__c();
        master.All_Images__c = publicURl;
        master.Images__c = publicURl;
        
        master.Images__c = publicURl;
        master.Id = recordId;
        master.Is_Custom_Image__c = true;

        update master;
        return contentToInsert.id;
        
    }
    
    
    @AuraEnabled
    public static void appendToFile(Id contentDocumentId, String base64Data) {
        //base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        ContentVersion versionData = [
            SELECT Id, VersionData,ContentDocumentId
            FROM ContentVersion
            WHERE Id = :contentDocumentId
        ];
        
        String existingBody     = EncodingUtil.base64Encode(versionData.VersionData);
        versionData.VersionData = EncodingUtil.base64Decode(existingBody + base64Data); 
        
        update versionData;
    } 
    
}