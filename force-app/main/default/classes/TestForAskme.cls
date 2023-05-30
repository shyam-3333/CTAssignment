@isTest(seealldata=true)
public class TestForAskme{

    public Static user toCreateUser(string profileName,String usrName){
    
        Profile prf  =   [SELECT Id FROM Profile WHERE Name=:profileName LIMIT 1]; 
        
        User    usr  =  new User(Alias = 'unittest', Email='testuser@testorg.com',EmailEncodingKey='UTF-8', 
                        LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = prf.Id,
                        TimeZoneSidKey='America/Los_Angeles', UserName=usrName);
        
        return usr;
    }
    


    public Static List<Product__c> productRecord(integer numToCreateProducts){
    
        List<product__c> prdList= new List<product__c>();
        id productRecordType = [SELECT DeveloperName,Id,Name,SobjectType FROM RecordType WHERE DeveloperName = 'Master' AND SobjectType = 'Product__c' limit 1].id;
            //Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Master').getRecordTypeId();
        system.debug('---productRecordType--'+productRecordType);
        for(integer each=0;each<numToCreateProducts;each++){    
            product__c prd         =      new product__c();
                  prd.name         =      '1234'+each;
                  prd.gender__c    =      'Gents';
                  prd.brand__c     =      'Titan';
                  prd.material__c  =      'Brass';
            	  prd.RecordTypeId =	  productRecordType;
                  prd.Suggested_MRP__c=6;
                  prd.Cluster__c ='Assam';
                  prdList.add(prd);
          }
        return prdList;
    }
    
    public Static List<Variant__c>  variantRecord(list<product__c>  productList,Integer numToCreatePerParent){
        
        List<Variant__c>  variantList   =  new List<Variant__c>();
        
        for(Product__c prd:productList){
        
            for(Integer each=0;each<numToCreatePerParent;each++){
                    variant__c vrnt      =   new variant__c();
                          vrnt.name      =   '1234vj01'+each;
                          vrnt.model__c  =   prd.id;
                      variantList.add(vrnt);
            }
            
        }
        return variantList;
    }
    
    public Static List<product_file__c>  createPrductfileToProduct(List<product__c>  prodcutList,String fileType,Integer numToCreateProdcutfiles){
    
        List<product_file__c>  prfList  =   new List<product_file__c>();
     
        for(product__c prd:prodcutList){
        
            for(Integer each=0;each<numToCreateProdcutfiles;each++){
            
                Product_file__c prf      =   new product_file__c();
                       prf.file_type__c  =   fileType;
                       prf.product__c    =   prd.id;
                       prf.name          =   'productfile'+each;
                       prfList.add(prf);
            
            }
        
        
        } 
        
        return prfList; 
    
    
    }
    
    public Static List<product_file__c>  createPrductfileToVariant(List<Variant__c>  prodcutList,String filetype,Integer numToCreateProdcutfiles){
    
        List<product_file__c>  prfList  =   new List<product_file__c>();
     
        for(variant__c vrnt:prodcutList){
        
            for(Integer each=0;each<numToCreateProdcutfiles;each++){
            
                Product_file__c prf     =   new product_file__c();
                       prf.Variant__c   =   vrnt.id;
                       prf.file_type__c =  filetype;
                       prf.name         =   'productfile'+each;
                       prfList.add(prf);
            }
        
        
        } 
        
        return prfList; 
    
    }
    
    Public Static List<Attachment> createAttachments(list<id> parentIdList,Integer numToCreateAttachments){
    
        List<Attachment> attchlist  =  new List<attachment>();
        for(id eachId:parentIdList){
            
            for(Integer each=1;each<=numToCreateAttachments;each++){
                
                
                Attachment  attach            =   new Attachment();               
                            attach.Name       =   'Unit Test Attachment.'+each;
                            attach.body       =   Blob.valueOf('Unit Test Attachment Body');
                            attach.parentId   =   eachId;
               
               attchlist.add(attach);
                           
            }
        }
        
        return attchlist;
    }
    
}