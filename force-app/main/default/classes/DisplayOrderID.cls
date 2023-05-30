/**
 * Created By: Priyanka Dumane
 * @description : This apex controller class will display the Order Id details and will insert the CSV file as records in RangePlan object with all the required validations and CSV file will be stored as an attachment in RangeplanCSVdata object.
 */
public with sharing class DisplayOrderID
{
    /**
     * @description Method used to fetch details of Order Id
     * @param  textkey
     * @return MasterDataWrapper
     */
    @AuraEnabled
    public static MasterDataWrapper fetchOrderId(String textkey)
    {
        textkey = textkey.trim();
        MasterDataWrapper masterData = new MasterDataWrapper();
        List<Master__c> orderIdList = [SELECT Id, Name,Source_Type__c,Product_Type__c,Expected_Arrival_at_WH__c,Total_Quantity__c,
                                       Total_Value__c FROM Master__c WHERE Name =: textkey and Name__c =: 'Order Id' and Active__c = true WITH SECURITY_ENFORCED limit 1]; 
        
        if(!orderIdList.isEmpty()){
            masterData.orderName = orderIdList[0].Name;
            masterData.orderId = orderIdList[0].Id;
            masterData.orderSourceType = orderIdList[0].Source_Type__c;
            masterData.orderProductType = orderIdList[0].Product_Type__c;
            masterData.orderExpectedArrival = orderIdList[0].Expected_Arrival_at_WH__c;
            masterData.orderTotalQuantity = orderIdList[0].Total_Quantity__c;
            masterData.orderTotalValue = orderIdList[0].Total_Value__c;
            return masterData; 
          
        }else{
            return masterData; 
             
        }
         
    }
    /**
     * @description Method used to update details of Order Id
     * @param  orderJSON
     * @return Boolean
     */  
    @AuraEnabled
    public static Boolean updateOrder(String orderJSON)
    {  
        MasterDataWrapper masterData = (MasterDataWrapper)JSON.deserialize(orderJSON, MasterDataWrapper.class);
        Master__c master = new Master__c();
        master.Id  = masterData.orderId;
        master.Source_Type__c = masterData.orderSourceType;
        master.Product_Type__c = masterData.orderProductType;
        master.Expected_Arrival_at_WH__c = masterData.orderExpectedArrival;
        if (Schema.sObjectType.Master__c.isUpdateable()) {
        update master;
        }
        return true;
    }
    /**
     * @description Method used to save details of Order Id
     * @param  base64Data,order_Id,nameOfFile
     * @return String
     */
    @AuraEnabled
    public static String saveFile(String base64Data,String order_Id,String nameOfFile)
    {
        String csvRow = '';
        //String csvRow2 = '';
        String errorMessage = '';
        //String orderIdRecordId = '';
        //String duplicateRow = '';
        List<String> csvRowList = new List<String>(); //this list contains all CSV Rows in a list
        //List<String> csvRowListwithoutHeader = new List<String>(); //this list contains all CSV Rows in a list
        Map<String,Integer> headerIndexMap = new Map<String,Integer>();
        List<RangePlan_Master__c> rangePlanMasterList = new List<RangePlan_Master__c>();
        List<String> correctHeaderList = new List<String>{'l1(ofc)','l2(ofc)','l3(ofc)','price band','l4(zari type)','cost band','average cost','total order quantity','order value','remarks\r'};
            
            // Upload CSV File
            String data = JSON.deserializeUntyped(base64Data).toString();
        data = data.replaceAll('[!@#$%^&*]','');
        Utility_RowIterator rowIterator = New Utility_RowIterator(data,'\n');
        while(rowIterator.hasNext()){
            csvRow = rowIterator.next();
            csvRowList.add(csvRow); //this list contains all CSV Rows in a list
        }
        //Check for Headers
        csvRowList[0] = csvRowList[0].toLowerCase(); //csvRowList[0] is the header
        list<String> csvheaderList = csvRowList[0].split(',');
        if(csvheaderList.size() > 10){ //check for header size ie columns should not be less than or greater than 10
            errorMessage = 'Please upload CSV in the format given below(Extra header)';
        }
        else if(csvheaderList.size() < 10){ //check for header size ie columns should not be less than or greater than 10
            errorMessage = 'Please upload CSV in the format given below(Missing header)';
        }
        else {
            errorMessage = '';
        }
        
        if(errorMessage == ''){
            for(String headers : correctHeaderList){//check for correct header spell
                if(!csvheaderList.contains(headers)){
                    errorMessage = 'Please upload CSV in the format given below (Header sequence incorrect)';
                }
            }
        }
        if(csvRowList.size() <= 1){
            errorMessage = 'CSV file is empty';
        }
        //Check for Duplicate Rows
        if(errorMessage == ''){
            Map<String,Integer> rowKeyMap = new Map<String,Integer>();
            for(Integer i = 1; i < csvRowList.size(); i++){
                list<String> csvRowData = csvRowList[i].split(',');
                String rowKey = ''; 
                for(String r : csvRowData){
                    rowKey = rowKey+''+r;
                }
                if(rowKeyMap.containsKey(rowKey)){
                    Integer f = rowKeyMap.get(rowKey)+1;
                    Integer l = i+1;
                    errorMessage = errorMessage+'CSV file contains duplicate row '+f+'-'+l+ ',';
                }
                else if(!String.isBlank(rowKey)){
                    rowKeyMap.put(rowKey,i);
                } 
            }
        }
        if(errorMessage == '' ){
            for(integer i = 0; i < csvheaderList.size(); i++){
                String head = csvheaderList[i];
                head = head.replace('\r', '');
                headerIndexMap.put(head, i);
            }
            for(Integer i = 1; i < csvRowList.size(); i++){
                list<String> csvRowData = CsvRowUtility.parseCSVRow(csvRowList[i]);
                integer row = i+1;
                //list<String> csvRowData = csvRowList[i].split(',');
                RangePlan_Master__c rangePlan = new RangePlan_Master__c(); 
                rangePlan.L1__c = csvRowData[headerIndexMap.get('l1(ofc)')];
                rangePlan.L2__c = csvRowData[headerIndexMap.get('l2(ofc)')];
                rangePlan.L3__c = csvRowData[headerIndexMap.get('l3(ofc)')];
                rangePlan.Price_Band__c = csvRowData[headerIndexMap.get('price band')];
                rangePlan.L4__c = csvRowData[headerIndexMap.get('l4(zari type)')];
                rangePlan.Cost_Band__c = csvRowData[headerIndexMap.get('cost band')];
                rangePlan.Average_Cost__c = csvRowData[headerIndexMap.get('average cost')].trim() != '' ? Decimal.ValueOf(csvRowData[headerIndexMap.get('average cost')]) : null;
                rangePlan.Total_Order_Quantity__c = csvRowData[headerIndexMap.get('total order quantity')].trim() != '' ? Decimal.ValueOf(csvRowData[headerIndexMap.get('total order quantity')]) : null;
                rangePlan.Order_Value__c = csvRowData[headerIndexMap.get('order value')].trim() != '' ? Decimal.ValueOf(csvRowData[headerIndexMap.get('order value')]) : null;
                rangePlan.Remark__c = csvRowData[headerIndexMap.get('remarks')];
                rangePlan.Active__c = True;
                rangePlan.Order_ID__c = order_Id;
                
                if(rangePlan.L1__c == '' && rangePlan.L2__c == '' && rangePlan.L3__c == '' && rangePlan.Price_Band__c == '' && rangePlan.L4__c == '' && rangePlan.Cost_Band__c == ''){
                    errorMessage = errorMessage+' Row number '+row+' is blank ,';
                }                
                else if(rangePlan.L1__c.contains(',') || rangePlan.L1__c .contains(';') || rangePlan.L2__c.contains(',') || rangePlan.L2__c .contains(';') || 
                        rangePlan.L3__c.contains(',') || rangePlan.L3__c .contains(';') || rangePlan.Price_Band__c.contains(',') || rangePlan.Price_Band__c .contains(';') ||
                        rangePlan.L4__c.contains(',') || rangePlan.L4__c .contains(';') || rangePlan.Cost_Band__c.contains(',') || rangePlan.Cost_Band__c .contains(';')){
                            errorMessage = errorMessage+' Row number '+row+' contains special character ,';
                        }
                else {
                    rangePlanMasterList.add(rangePlan);
                }
            }
            if( errorMessage == ''){
                Id Rectype = Schema.SObjectType.RangePlanCSVData__c.getRecordTypeInfosByName().get('Range Plan Master CSV').getRecordTypeId();
                RangePlanCSVData__c obj= new RangePlanCSVData__c();
                obj.RecordtypeId= Rectype;
                if (Schema.sObjectType.RangePlanCSVData__c.isCreateable()) {
                    insert obj;
                }
                ContentVersion Contver = new ContentVersion();
                Contver.ContentLocation = 'S';
                Contver.Title = nameOfFile+'_'+date.today().format();
                Contver.pathOnClient = nameOfFile;
                Contver.VersionData = Blob.valueOf(data);
                if (Schema.sObjectType.ContentVersion.isCreateable()) {
                insert Contver;
                }
                
                String versionId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :Contver.Id].ContentDocumentId;
                ContentDocumentLink cdl = new ContentDocumentLink();
                cdl.ContentDocumentId = versionId;
                cdl.LinkedEntityId = obj.Id;
                cdl.Sharetype = 'I';
                cdl.visibility = 'AllUsers';
                if (Schema.sObjectType.RangePlan_Master__c.isCreateable()) {
                insert rangePlanMasterList;
                }
                if (Schema.sObjectType.ContentDocumentLink.isCreateable()) {
                insert cdl;
                }              
            }
            return errorMessage;
        }
        else{
            return errorMessage;
        }
    }  
    /**
     * @description This is a wrapper class for Order Id table values
     */
    public class MasterDataWrapper
    {
        @AuraEnabled public String orderName;
        @AuraEnabled public String orderId;
        @AuraEnabled public String orderSourceType;
        @AuraEnabled public String orderProductType;
        @AuraEnabled public Date orderExpectedArrival;
        @AuraEnabled public Decimal orderTotalQuantity;
        @AuraEnabled public Decimal orderTotalValue;      
    }
}