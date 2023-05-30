/*Created By:-Rahul Mukherji
*Taneira Phase:-3
*@Description:This method is written in order to Upload the CSV Data from OfflineProductPage(VF), in order to restrict
*user from Uploading data via Data Loader.
*/

public class UploadUpdatedProdData {
    public Blob contentFile {get;set;}
    public String csvDataString {get;set;}
    public String [] recordSepr = new String[] {} ;
    public List<Product__c> prodListUpload {get;set;} 
    
    public UploadUpdatedProdData(){
        
       
    }
    
    public void uploadOfflineData(){
        String[] recordValues=new String[]{};
        prodListUpload= new List<Product__c>();
        List<Product__c> prodList= new List<Product__c>();
        csvDataString = contentFile.toString();
        //system.debug('csvDataString before:'+csvDataString);
        //csvDataString = csvDataString.replaceAll('(\r\n|\r)','\n');
		//system.debug('csvDataString before:'+csvDataString);
         recordSepr=csvDataString.split('\r\n');
        /*if(test.isRunningTest()){
           csvDataString='a185B0000011YzF,0125B0000000CHZ,SHT03H00845,Saree,arsenal,New,Trading,Test,Banaras,Test,Isha Sahu_0,2000,3500,Silk,Silk,Design Story,Story 1,Story 2,Design Description,Lt Green,White,2,Georgette,NIL,Handloom,Party,Yes,Ikat,Yes,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border,Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,'+'"These are miniature blocks of PARCHA.'+ 
'PARCHA is a combination of old border blocks. These saris are in combination with full body, intricate motifs incorporating 7 to 10 coloured blocks. It means incorporation of those many DATTA blocks in these set of blocks.It takes alot of effort to register these blocks and to match each one of them.'+ 
'Moreover not just the block printing is very tedious, but the block making process for these are also a craftsmanship story to add on to the look of the saree.'+ 
'These designs date back to 300 years ago, when Sanganer was only known for its Natural dye printing....",'+'20,10,10';
        	 recordSepr=csvDataString.split('\r\n');
        }*/
        //system.debug('-----------recordSepr------------------'+recordSepr);
        Product__c prod;
        String csvLine, prevLine;
        Integer startIndex;
        Integer endIndex;
        String sub;
        
        try{
            for(Integer j=1;j<recordSepr.size();j++){
                System.debug('---recordSepr size==>'+recordSepr.size());
                
                csvLine = recordSepr[j];
                System.debug('=====csvLine====>> '+csvLine);
                prevLine = csvLine;
                System.debug('======prevLine====>>'+prevLine);
                
                if(startIndex == null){
                    startIndex = csvLine.indexOf('"');
                    System.debug('startIndex:'+startIndex);
					if(startIndex != -1){
                    csvLine = csvLine.substring(0, startIndex) + ':quotes:' + csvLine.substring(startIndex+1, csvLine.length());
					}
                    System.debug('====csvLine if(startIndex == null)===>>'+csvLine);
                }
                
                if(endIndex == null){
                    
                    endIndex = csvLine.indexOf('"');
                    System.debug('endIndex:'+endIndex);
					if(endIndex != -1){
                    csvLine = csvLine.substring(0, endIndex) + ':quotes:' + csvLine.substring(endIndex+1, csvLine.length());
					}
                    System.debug('====csvLine if(endIndex == null)===>>'+csvLine);
                }
                
                if((startIndex != null && startIndex != -1) && (endIndex != null && endIndex != -1)){
                    sub = csvLine.substring(startIndex, endIndex);
                    System.debug('=====sub=====>>>>>!!!'+sub);
                    sub = sub.replaceAll(',', ':comma:');
                    System.debug('=====sub after comma replace====>>'+sub);
                    csvLine = csvLine.substring(0, startIndex) + sub + csvLine.substring(endIndex, csvLine.length());
                   
                    startIndex = null;
                    endIndex = null;
                }
                
                //System.debug('prevLine:::'+prevLine);
                System.debug('csvLine:>>>:>>>:'+csvLine);
                
                recordValues = csvLine.split(',');
                System.debug('recordValues size:::'+recordValues.size());
                prod= new Product__c();
                if(recordValues.size() >= 1 && String.valueOf(recordValues[0]) !=NULL){
                    
                    prod.Id=recordValues[0].trim();
                    System.debug('ProdID-->'+prod.Id);
                }
                if(recordValues.size() >= 2 && recordValues[1] !=NULL){
                    //prod.RecordTypeId=recordValues[1].trim();
                }
                if(recordValues.size() >= 6 && String.isNotBlank(recordValues[5])){
                    prod.Name=recordValues[5];
                }
                if(recordValues.size() >= 8 && String.isNotBlank(recordValues[7])){
                    prod.Proc_Source__c=recordValues[7];
                }
                if(recordValues.size() >= 9 && String.isNotBlank(recordValues[8])){
                    prod.Cluster__c=recordValues[8];
                }
                if(recordValues.size() >= 10 && String.isNotBlank(recordValues[9])){
                    prod.PO_Number__c=recordValues[9];
                }
                if(recordValues.size() >= 11 && String.isNotBlank(recordValues[10])){
                    prod.Offline_Username__c=recordValues[10];
                }
                if(recordValues.size() >= 12 && String.isNotBlank(recordValues[11])){
                    prod.Suggested_MRP__c=Decimal.valueOf(recordValues[11]);
                }
                if(recordValues.size() >= 13 && String.isNotBlank(recordValues[12])){
                    prod.Cost__c=Decimal.valueOf(recordValues[12]);
                }
                if(recordValues.size() >= 14 && String.isNotBlank(recordValues[13])){
                    prod.Material_Wrap__c=recordValues[13];
                }
                if(recordValues.size() >= 15 && String.isNotBlank(recordValues[14])){
                    prod.Taneira_Material_Weft__c=recordValues[14];
                }
                if(recordValues.size() >= 16 && String.isNotBlank(recordValues[15])){
                    prod.Design_Story__c=recordValues[15];
                }
                if(recordValues.size() >= 17 && String.isNotBlank(recordValues[16])){
                    recordValues[16] = recordValues[16].replaceAll(':quotes:', '').replaceAll(':comma:', ',');
                    prod.Story_1__c=recordValues[16];
                }
                if(recordValues.size() >= 18 && String.isNotBlank(recordValues[17])){
                    recordValues[17] = recordValues[17].replaceAll(':quotes:', '').replaceAll(':comma:', ',');
                    prod.Story_2__c=recordValues[17];
                }
                if(recordValues.size() >= 19 && String.isNotBlank(recordValues[18])){
                    prod.Design_Description__c=recordValues[18];
                }
                if(recordValues.size() >= 20 && String.isNotBlank(recordValues[19])){
                    prod.Base_Colour__c=recordValues[19];
                }
                if(recordValues.size() >= 21 && String.isNotBlank(recordValues[20])){
                    prod.Detailed_Colour__c=recordValues[20];
                }
                if(recordValues.size() >= 22 && String.isNotBlank(recordValues[21])){
                    prod.Quantity__c=Decimal.valueOf(recordValues[21]);
                }
                if(recordValues.size() >= 24 && String.isNotBlank(recordValues[23])){
                    prod.Zari_Type__c=recordValues[23];
                }
                if(recordValues.size() >= 26 && String.isNotBlank(recordValues[25])){
                    prod.Occasion__c =recordValues[25];
                }
                if(recordValues.size() >= 27 && String.isNotBlank(recordValues[26])){
                    prod.Blouse_Size__c =recordValues[26];
                }
                if(recordValues.size() >= 28 && String.isNotBlank(recordValues[27])){
                    prod.Blouse_Type__c=recordValues[27];
                }
                if(recordValues.size() >= 29 && String.isNotBlank(recordValues[28])){
                    prod.Workmanship__c=recordValues[28];
                }
                if(recordValues.size() >= 30 && String.isNotBlank(recordValues[29])){
                    prod.Fold__c=recordValues[29];
                }
                if(recordValues.size() >= 32 && String.isNotBlank(recordValues[31])){
                    prod.Collection__c=recordValues[31];
                }
                if(recordValues.size() >= 33 && String.isNotBlank(recordValues[32])){
                    prod.Body_Pattern__c=recordValues[32];
                }
                if(recordValues.size() >= 34 && String.isNotBlank(recordValues[33])){
                    prod.Body_Des_Element__c=recordValues[33];
                }
                if(recordValues.size() >= 35 && String.isNotBlank(recordValues[34])){
                    prod.Body_Des_Material__c=recordValues[34];
                }
                if(recordValues.size() >= 36 && String.isNotBlank(recordValues[35])){
                    prod.Body_Des_Density__c=recordValues[35];
                }
                if(recordValues.size() >= 37 && String.isNotBlank(recordValues[36])){
                    prod.Border_Pattern__c=recordValues[36];
                }
                if(recordValues.size() >= 38 && String.isNotBlank(recordValues[37])){
                    prod.Border_Des_Element__c=recordValues[37];
                }
                if(recordValues.size() >= 39 && String.isNotBlank(recordValues[38])){
                    prod.Border_Des_Material__c=recordValues[38];
                }
                if(recordValues.size() >= 40 && String.isNotBlank(recordValues[39])){
                    prod.Border_Size__c=recordValues[39];
                }
                if(recordValues.size() >= 41 && String.isNotBlank(recordValues[40])){
                    prod.Pallu_Pattern__c=recordValues[40];
                }
                if(recordValues.size() >= 42 && String.isNotBlank(recordValues[41])){
                    
                    prod.Pallu_Design__c=recordValues[41];
                }
                if(recordValues.size() >= 43 && String.isNotBlank(recordValues[42])){
                    prod.Pallu_Des_Material__c=recordValues[42];
                }
                if(recordValues.size() >= 44 && String.isNotBlank(recordValues[43])){
                    prod.Pallu_Des_Density__c=recordValues[43];
                }
                if(recordValues.size() >= 45 && String.isNotBlank(recordValues[44])){
                    prod.Pallu_Size__c=recordValues[44];
                }
                if(recordValues.size() >= 46 && String.isNotBlank(recordValues[45])){
                    
                    recordValues[45] = recordValues[45].replaceAll(':quotes:', '').replaceAll(':comma:', ',');
                    prod.Comments__c=recordValues[45];
                }
                if(recordValues.size() >= 48 && String.isNotBlank(recordValues[47])){
                    prod.Warehouse_Stock__c=Double.valueOf(recordValues[47]);
                }
                if(recordValues.size() >= 49 && String.isNotBlank(recordValues[48])){
                    prod.Sold_Stock__c=Double.valueOf(recordValues[48]);
                }
                if(recordValues.size() >= 50 && String.isNotBlank(recordValues[49])){
                    prod.Store_Stock__c=Double.valueOf(recordValues[49]);
                }
                
                prodListUpload.add(prod);       
            }//end of for loop.
            if(!prodListUpload.isEmpty()){
                update prodListUpload;
                ApexPages.Message errormsg= new ApexPages.Message(ApexPages.Severity.INFO,'Records have been updated Successfully!');
                ApexPages.addMessage(errormsg);
            }
        }//end of try block
        catch(Exception e){
            ApexPages.Message errormsg= new ApexPages.Message(ApexPages.Severity.ERROR,'Error in Records updation,Please verify data and try again!');
            ApexPages.addMessage(errormsg);
            System.debug('===Error at line======'+e.getLineNumber() +'======error message======'+e.getMessage());
        }
        
        /*else{
        ApexPages.Message errormsg= new ApexPages.Message(ApexPages.Severity.ERROR,'Error in Records updation,Please verify data and try again!');
        }*/
    }//end of method
}