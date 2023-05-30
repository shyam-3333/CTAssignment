/*******************************************
Created By : Vindya Achar
@description: This apex class will insert the CSV file as records in L1-L5 Master object with all the required validations and CSV file will be stored as an attachment in RangeplanCSVdata object.
**********************************************/
public with sharing class L1_L4_Master_Insert {
    @AuraEnabled
    /* @description: This method will insert the L1-L5 master records from CSV*/
    public static string  csvFileRead(String base64Data){
        String fabric='';
        String origin='';
        String craft='';
        String zariType='';
        String data  = JSON.deserializeUntyped(base64Data).toString();
        system.debug('Data: '+ data);
        data = data.replaceAll('[!@#$%^&*]','');
        List<L1_L5_Master__c> masterInsertlist = new List<L1_L5_Master__c>();
        Map<String,Integer> Prodcatvalmap = new Map<String,Integer>();
        Set<String>precedenceSet = new Set<String>();
        list<String> csvRowslst = new list<String>();
        Map<String,Integer> blankRowKeyMap = new Map<String,Integer>();
        Utility_RowIterator rowIterator = New Utility_RowIterator(data,'\n'); //Replace \n with whatever delineates your row
        String firstRow;
        while(rowIterator.hasNext()){
            firstRow = rowIterator.next();
            csvRowslst.add(firstRow);
        }
        list<String> expectedHeaders = new list<string>{'rule','product category 1','product category values 1','product category 2','product category values 2','product category 3','product category values 3','product category 4','product category values 4','l1','l2','l3','l4','l5\r'};
            csvRowslst[0] = csvRowslst[0].toLowerCase();
        list<String> headerRow = csvRowslst[0].split(',');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
        String missingheaders = '';
        boolean blank = false;
        if(headerRow.size() > 14){
            missingheaders = 'Please upload CSV in the format given below(Extra header).';
        }
        else{
            missingheaders = '';
        }
        Map<string,integer> headerIndexMap = new Map<string,integer>();
        if(missingheaders ==''){
            missingheaders = missingheaders + (((!headerRow.contains('rule')) && (!headerRow.contains('rule\r')) ) ?'Please upload CSV in the format given below (Missing header-Rule)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('product category 1')) && (!headerRow.contains('product category 1\r')) ) ?'Please upload CSV in the format given below (Missing header-Product category 1)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('product category values 1')) && (!headerRow.contains('product category values 1\r')) ) ?'Please upload CSV in the format given below (Missing header-Product category values 1)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('product category 2')) && (!headerRow.contains('product category 2\r')) ) ?'Please upload CSV in the format given below (Missing header-Product category 2)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('product category values 2')) && (!headerRow.contains('product category values 2\r')) ) ? 'Please upload CSV in the format given below (Missing header-Product category values 2)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('product category 3')) && (!headerRow.contains('product category 3\r')) ) ? 'Please upload CSV in the format given below (Missing header-Product category 3)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('product category values 3')) && (!headerRow.contains('product category values 3\r')) ) ? 'Please upload CSV in the format given below (Missing header-Product category values 3)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('product category 4')) && (!headerRow.contains('product category 4\r')) ) ? 'Please upload CSV in the format given below (Missing header-Product category 4)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('product category values 4')) && (!headerRow.contains('product category values 4\r')) ) ?'Please upload CSV in the format given below (Missing header-Product category values 4)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('l1')) && (!headerRow.contains('l1\r')) ) ? 'Please upload CSV in the format given below'+('Missing header-L1'+' ,'):'');
            missingheaders = missingheaders + (((!headerRow.contains('l2')) && (!headerRow.contains('l2\r')) ) ?'Please upload CSV in the format given below (Missing header-L2)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('l3')) && (!headerRow.contains('l3\r')) ) ? 'Please upload CSV in the format given below (Missing header-L3)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('l4')) && (!headerRow.contains('l4\r')) ) ? 'Please upload CSV in the format given below (Missing header-L4)'+' ,':'');
            missingheaders = missingheaders + (((!headerRow.contains('l5')) && (!headerRow.contains('l5\r')) ) ? 'Please upload CSV in the format given below (Missing header-L5)'+' ,':'');
        }
        if(missingheaders == ''){
            for(Integer i = 1; i < csvRowslst.size(); i++){
                integer row = i+1;
                String[] inputvaluesFile = new String[] {};
                    inputvaluesFile = csvRowslst[i].split(',');
                if((string.isBlank(inputvaluesFile[0]) && string.isBlank(inputvaluesFile[1]) && string.isBlank(inputvaluesFile[2]) && string.isBlank(inputvaluesFile[3]) &&string.isBlank(inputvaluesFile[4]) && string.isBlank(inputvaluesFile[5]) &&string.isBlank(inputvaluesFile[6]) && string.isBlank(inputvaluesFile[7]) && string.isBlank(inputvaluesFile[8]) && string.isBlank(inputvaluesFile[9]) && string.isBlank(inputvaluesFile[10]) && string.isBlank(inputvaluesFile[11]) && string.isBlank(inputvaluesFile[12]) && string.isBlank(inputvaluesFile[13]))){
                    missingheaders =missingheaders+ 'CSV file contains blank row at : '+row+' ,' ;
                }
            }
        }
        if(missingheaders ==''){
            Map<String,Integer> rowKeyMap = new Map<String,Integer>();
            for(Integer i = 1; i < csvRowslst.size(); i++){
                list<String> csvRowData = csvRowslst[i].split(',');
                String rowKey = ''; 
                for(String r : csvRowData){
                    rowKey = rowKey+''+r;
                }
                if(rowKeyMap.containsKey(rowKey)){
                    Integer dupRow1 = rowKeyMap.get(rowKey)+1;
                    Integer dupRow2 = i+1;
                    missingheaders =missingheaders+ 'CSV file contains duplicate row'+'-'+dupRow1+'&'+dupRow2+' ,';
                }
                else{
                    rowKeyMap.put(rowKey,i); 
                } 
            }
        }
        
        if(missingheaders == ''){
            Map<String,Integer> RuleNo = new Map<String,Integer>();
            for(Integer i = 1; i < csvRowslst.size(); i++){ 
                integer row = i+1;
                String[] inputvaluesFile = new String[] {};
                    inputvaluesFile = csvRowslst[i].split(',');
                if(RuleNo.containsKey(inputvaluesFile[0])){
                    missingheaders =missingheaders+ 'CSV file contains duplicate rule number '+ inputvaluesFile[0] +' at row number : '+RuleNo.get(inputvaluesFile[0] )+' & '+row+' ,' ;
                }else if(inputvaluesFile[0] != ''){
                    RuleNo.put(inputvaluesFile[0],row);
                }
            }
        }
        
        
        if(missingheaders == '' ){
            for(integer i=0; i<headerRow.size();i++){
                string head = headerRow[i];
                head = head.replace('\r', '');
                headerIndexMap.put(head, i);
            }
            for(Integer i = 1; i < csvRowslst.size(); i++){
                list<string>csvRowData = CsvRowUtility.parseCSVRow(csvRowslst[i]);
                integer row = i+1;
                L1_L5_Master__c l1l4Master = new L1_L5_Master__c(); 
                l1l4Master.Precedence__c = csvRowData[headerIndexMap.get('rule')];
                l1l4Master.Product_Category_1__c = csvRowData[headerIndexMap.get('product category 1')];
                l1l4Master.Product_category_value_1__c = csvRowData[headerIndexMap.get('product category values 1')];
                l1l4Master.Product_Category_2__c = csvRowData[headerIndexMap.get('product category 2')];
                l1l4Master.Product_category_value_2__c = csvRowData[headerIndexMap.get('product category values 2')];
                l1l4Master.Product_Category_3__c = csvRowData[headerIndexMap.get('product category 3')];
                l1l4Master.Product_category_value_3__c = csvRowData[headerIndexMap.get('product category values 3')];
                l1l4Master.Product_Category_4__c = csvRowData[headerIndexMap.get('product category 4')];
                l1l4Master.Product_category_value_4__c = csvRowData[headerIndexMap.get('product category values 4')];
                l1l4Master.L1__c = csvRowData[headerIndexMap.get('l1')];
                l1l4Master.L2__c = csvRowData[headerIndexMap.get('l2')];
                l1l4Master.L3__c = csvRowData[headerIndexMap.get('l3')];
                l1l4Master.L4__c = csvRowData[headerIndexMap.get('l4')];
                l1l4Master.L5__c = csvRowData[headerIndexMap.get('l5')];
                masterInsertlist.add(l1l4Master);
                precedenceSet.add(l1l4Master.Precedence__c);
                
                if(l1l4Master.Precedence__c == ''){
                    missingheaders = missingheaders+'CSV file contains empty rule number at row number'+' '+row+' ,';
                }
                
                // empty product category value validation
                if(l1l4Master.Product_category_value_1__c =='' || l1l4Master.Product_category_value_2__c=='' || l1l4Master.Product_category_value_3__c =='' || l1l4Master.Product_category_value_4__c==''){
                    missingheaders =missingheaders+ 'CSV file contains empty product category value in row number. '+row+' ,';
                }
                // special character validation
                if(l1l4Master.Product_category_value_1__c .contains(',') || l1l4Master.Product_category_value_1__c .contains(';')||l1l4Master.Product_category_value_2__c .contains(',') || l1l4Master.Product_category_value_2__c .contains(';') ||
                   l1l4Master.Product_category_value_3__c .contains(',') || l1l4Master.Product_category_value_3__c .contains(';')||l1l4Master.Product_category_value_4__c .contains(',') || l1l4Master.Product_category_value_4__c .contains(';') ||
                   l1l4Master.L1__c .contains(',') || (l1l4Master.L1__c .contains(';')) || (l1l4Master.L2__c .contains(',')) || (l1l4Master.L2__c .contains(';')) || (l1l4Master.L3__c .contains(',')) || (l1l4Master.L3__c .contains(';')) ||
                   l1l4Master.L4__c .contains(',') || l1l4Master.L4__c .contains(';') || l1l4Master.L5__c .contains(',') || l1l4Master.L5__c .contains(';')){
                       missingheaders =missingheaders+ 'CSV file contains special characters in row number. '+row+' ,';
                   }
                // Incorect Product category validation(fabric,craft,zaritype,origin)
                if((l1l4Master.Product_Category_1__c != null && l1l4Master.Product_Category_1__c != 'Fabric'  && l1l4Master.Product_Category_1__c != 'Origin' && l1l4Master.Product_Category_1__c != 'Craft'&& l1l4Master.Product_Category_1__c != 'Zari type') ||
                   (l1l4Master.Product_Category_2__c != null && l1l4Master.Product_Category_2__c != 'Fabric' && l1l4Master.Product_Category_2__c != 'Origin'  && l1l4Master.Product_Category_2__c != 'Craft' && l1l4Master.Product_Category_2__c != 'Zari type')||
                   (l1l4Master.Product_Category_3__c != null && l1l4Master.Product_Category_3__c != 'Fabric' &&  l1l4Master.Product_Category_3__c != 'Origin' && l1l4Master.Product_Category_3__c != 'Craft'&& l1l4Master.Product_Category_3__c != 'Zari type')||
                   (l1l4Master.Product_Category_4__c != null && l1l4Master.Product_Category_4__c != 'Fabric'  && l1l4Master.Product_Category_4__c != 'Origin' && l1l4Master.Product_Category_4__c != 'Craft'&& l1l4Master.Product_Category_4__c != 'Zari type')){
                       missingheaders =missingheaders+ 'Incorrect product category  entry at row number '+row+' ,';
                   }   
            } // for loop close
            
            if( missingheaders == ''){
                Id recType = Schema.SObjectType.RangePlanCSVData__c.getRecordTypeInfosByName().get('L1L5 Master CSV').getRecordTypeId();
                RangePlanCSVData__c obj= new RangePlanCSVData__c();
                obj.RecordtypeId= recType;
                if(RangePlanCSVData__c.SObjectType.getDescribe().isAccessible()){
                    insert obj;
                }
                ContentVersion contVer = new ContentVersion();
                contVer.ContentLocation = 'S';
                contVer.Title = 'L1L5Data.csv';
                contVer.pathOnClient ='L1L5Data.csv';
                contVer.VersionData = Blob.valueOf(data);
                if(ContentVersion.SObjectType.getDescribe().isAccessible()){
                    insert contVer;
                }
                string versionId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :contVer.Id].ContentDocumentId;
                ContentDocumentLink cdl = 
                    new ContentDocumentLink(
                        ContentDocumentId=versionId,
                        LinkedEntityId=obj.Id,
                        Sharetype ='I',
                        visibility = 'AllUsers'
                    );
                if(L1_L5_Master__c.SObjectType.getDescribe().isAccessible()){
                    insert masterInsertlist;
                }
                if(ContentDocumentLink.SObjectType.getDescribe().isAccessible()){
                    insert cdl;  
                }
            }
            return missingheaders;
        } //if close       
        else{
            return missingheaders;
        }
    }
    /* @description: This method will delete the L1L5 Master records from CSV*/
    @AuraEnabled
    public static string  deleteCSVdata(String base64Data){
        String data  = JSON.deserializeUntyped(base64Data).toString();
        data = data.replaceAll('[!@#$%^&*]','');
        data = data.replaceAll('"','');
        list<L1_L5_Master__c>masterdeleteList = new list<L1_L5_Master__c>();
        list<String> csvRowslst = new list<string>();
        Utility_RowIterator rowIterator = New Utility_RowIterator(data,'\n'); //Replace \n with whatever delineates your row
        String firstRow;
        while(rowIterator.hasNext()){
            firstRow = rowIterator.next();
            csvRowslst.add(firstRow);
        }
        list<string> expectedHeaders = new list<string>{'L1-L5 Master: ID','Rule','Product Category 1','Product category value 1','Product Category 2','Product category value 2','Product Category 3','Product category value 3','Product Category 4','Product category value 4','L1','L2','L3','L4','L5\r'};
            list<string> headerRow = csvRowslst[0].split(',');
        String validationerror = '';
        
        if(csvRowslst.size() <= 1){
            validationerror = 'CSV file is empty';
        }
        if(validationerror == ''){
            for(Integer i = 1; i < csvRowslst.size(); i++){
                integer row = i+1;
                String[] inputvaluesFile = new String[] {};
                    inputvaluesFile = csvRowslst[i].split(',');
                if((string.isBlank(inputvaluesFile[0]) && string.isBlank(inputvaluesFile[1]) && string.isBlank(inputvaluesFile[2]) && string.isBlank(inputvaluesFile[3]) &&string.isBlank(inputvaluesFile[4]) && string.isBlank(inputvaluesFile[5]) &&string.isBlank(inputvaluesFile[6]) && string.isBlank(inputvaluesFile[7]) && string.isBlank(inputvaluesFile[8]) && string.isBlank(inputvaluesFile[9]) && string.isBlank(inputvaluesFile[10]) && string.isBlank(inputvaluesFile[11]) && string.isBlank(inputvaluesFile[12]) && string.isBlank(inputvaluesFile[13])  && string.isBlank(inputvaluesFile[14]))){
                    validationerror =validationerror+ 'CSV file contains blank row at : '+row+' ,' ;
                }
            }
        }
        if(validationerror == '' ){
            for(Integer i = 1; i < csvRowslst.size(); i++){
                list<string>csvRowData = csvRowslst[i].split(',');
                L1_L5_Master__c l1l4Master = new L1_L5_Master__c(); 
                l1l4Master.Id =csvRowData[0] ;
                l1l4Master.Precedence__c =csvRowData[1] ;
                l1l4Master.Product_Category_1__c = csvRowData[2];
                l1l4Master.Product_category_value_1__c = csvRowData[3];
                l1l4Master.Product_Category_2__c = csvRowData[4];
                l1l4Master.Product_category_value_2__c = csvRowData[5];
                l1l4Master.Product_Category_3__c = csvRowData[6];
                l1l4Master.Product_category_value_3__c = csvRowData[7];
                l1l4Master.Product_Category_4__c = csvRowData[8];
                l1l4Master.Product_category_value_4__c = csvRowData[9];
                l1l4Master.L1__c = csvRowData[10];
                l1l4Master.L2__c = csvRowData[11];
                l1l4Master.L3__c = csvRowData[12];
                l1l4Master.L4__c = csvRowData[13];
                l1l4Master.L5__c = csvRowData[14];                
                masterdeleteList.add(l1l4Master);
            }
            Id recType = Schema.SObjectType.RangePlanCSVData__c.getRecordTypeInfosByName().get('L1L5 Master CSV').getRecordTypeId();
            RangePlanCSVData__c obj= new RangePlanCSVData__c();
            obj.RecordtypeId= recType;
            if(RangePlanCSVData__c.SObjectType.getDescribe().isAccessible()){
                insert obj;
            }
            
            ContentVersion contVer = new ContentVersion();
            contVer.ContentLocation = 'S';
            contVer.Title = 'L1L5deletedData.csv';
            contVer.pathOnClient ='L1L5deletedData.csv';
            contVer.VersionData = Blob.valueOf(data);
            if(ContentVersion.SObjectType.getDescribe().isAccessible()){
                insert contVer;
            }
            string versionId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :contVer.Id].ContentDocumentId;
            ContentDocumentLink cdl = 
                new ContentDocumentLink(
                    ContentDocumentId=versionId,
                    LinkedEntityId=obj.Id,
                    Sharetype ='I',
                    visibility = 'AllUsers'
                );
            if(L1_L5_Master__c.SObjectType.getDescribe().isDeletable()){
                delete masterdeleteList;
            }
            
            if(ContentDocumentLink.SObjectType.getDescribe().isAccessible()){
                insert cdl;
            }
            return validationerror;
        }
        else{
            return validationerror;
        }
    }
  /* @description: This method will check for the Precedence in the CSV file, if Precedence is already exists im master it will show popup else it will be calling the csvFileread method */
    @AuraEnabled
    public static string  precedenceCheck(String base64Data){
        String data  = JSON.deserializeUntyped(base64Data).toString();
        Map<string,integer> headerIndexMap = new Map<string,integer>();
        List<L1_L5_Master__c> MasterinsertList = new List<L1_L5_Master__c>();
        Map<String,Integer> Prodcatvalmap = new Map<String,Integer>();
        Set<String>precedenceSet = new Set<String>();
        list<String> csvRowslst = new list<String>();
        Map<String,Integer> blankRowKeyMap = new Map<String,Integer>();
        Utility_RowIterator rowIterator = New Utility_RowIterator(data,'\n'); //Replace \n with whatever delineates your row
        String firstRow;
        while(rowIterator.hasNext()){
            firstRow = rowIterator.next();
            csvRowslst.add(firstRow);
        }
        list<String> expectedHeaders = new list<string>{'rule','product category 1','product category values 1','product category 2','product category values 2','product category 3','product category values 3','product category 4','product category values 4','l1','l2','l3','l4','l5\r'};
            csvRowslst[0] = csvRowslst[0].toLowerCase();
        list<String> headerRow = csvRowslst[0].split(',');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
        String precedencechech = '';
        boolean blank = false;
        if(csvRowslst.size() <= 1){
            precedencechech = 'CSV file is empty';
        }
        if(precedencechech == '' ){
            for(Integer i = 1; i < csvRowslst.size(); i++){
                integer row = i+1;
                String[] inputvaluesFile = new String[] {};
                    inputvaluesFile = csvRowslst[i].split(',');
                if((string.isBlank(inputvaluesFile[0]) && string.isBlank(inputvaluesFile[1]) && string.isBlank(inputvaluesFile[2]) && string.isBlank(inputvaluesFile[3]) &&string.isBlank(inputvaluesFile[4]) && string.isBlank(inputvaluesFile[5]) &&string.isBlank(inputvaluesFile[6]) && string.isBlank(inputvaluesFile[7]) && string.isBlank(inputvaluesFile[8]) && string.isBlank(inputvaluesFile[9]) && string.isBlank(inputvaluesFile[10]) && string.isBlank(inputvaluesFile[11]) && string.isBlank(inputvaluesFile[12]) && string.isBlank(inputvaluesFile[13]))){
                    precedencechech =precedencechech+ 'CSV file contains blank row at : '+row+' ,' ;
                }
            }
        }
        if(precedencechech == '' ){
            for(integer i=0; i<headerRow.size();i++){
                string head = headerRow[i];
                head = head.replace('\r', '');
                headerIndexMap.put(head, i);
            }
            for(Integer i = 1; i < csvRowslst.size(); i++){
                list<string>csvRowData = CsvRowUtility.parseCSVRow(csvRowslst[i]);                
                integer row = i+1;
                L1_L5_Master__c l1l4Master = new L1_L5_Master__c(); 
                l1l4Master.Precedence__c = csvRowData[headerIndexMap.get('rule')];
                MasterinsertList.add(l1l4Master);               
                precedenceSet.add(l1l4Master.Precedence__c);
            } // for loop close
            list<L1_L5_Master__c>precedenceList = [Select id, Precedence__c,Active__c From L1_L5_Master__c where Precedence__c in :precedenceSet and Active__c = true ];
            set<String>precSet = new set<String>();
            for(L1_L5_Master__c plist:precedenceList){
                precSet.add(plist.Precedence__c);
            }
            if(precedenceList.size()>0){
                precedencechech ='Below shown precedence is already exists in salesforce';
            }
            else{
                precedencechech = csvFileRead(base64Data);				  
            }
            return precedencechech;
        }
        else {
            return precedencechech;
        }
    }
}