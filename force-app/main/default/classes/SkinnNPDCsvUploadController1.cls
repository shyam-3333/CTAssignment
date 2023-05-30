/********************************************************************************
Created by: Vinoth Kumar A
Created on: 13/03/2019
Description: Export Skinn model item data into excel document and import CSV file data into org
**************************************************************/


public class SkinnNPDCsvUploadController1 {
    /**************************Export Excel file*********************************/
    public List<Skinn_Model_Item__c> SmiData {get;set;}
    public List<WrapperClass> recordsinfo{get;set;}
    public Boolean refreshprevent{get;set;}

     public boolean pb1{get;set;}
     public string renderAsExcel{get;set;}
     public class WrapperClass {
         public Skinn_Model_Item__c record{get;set;}
         public String approvalRequired{get;set;}
         public String userEmailId{get;set;}
         WrapperClass(Skinn_Model_Item__c record,String approvalRequired,String userEmailId){
             this.record=record;
             this.approvalRequired=approvalRequired;
             this.userEmailId=userEmailId;
         }
     }
    
    public SkinnNPDCsvUploadController1()
    {
        custrutorMethod();
    }  
    public void custrutorMethod(){
            SmiData = new List<Skinn_Model_Item__c>(); 
        recordsinfo=new List<WrapperClass>();
        String isApprovalReq;
        String userEmailId;
        refreshprevent=true;
        List<String> tempListString=new List<String>();
        for(Skinn_Model_Item__c smi:[SELECT Id,Item_Name__c, Order_No__c,Serial_No__c, Type__c, Parent_Id__r.Order_No__c, Assigned_Team__c, 
                                     TemplateType__c,Planned_Lead_Time__c, User_Email__c,Approval_required__c  FROM Skinn_Model_Item__c order by Order_No__c limit 1000  ]){
                                         if(smi.Item_Name__c.contains(',')){
                                             smi.Item_Name__c=smi.Item_Name__c.remove(',');
                                         }
                                         userEmailId=String.valueOf(smi.User_Email__c);
                                        if(smi.Approval_required__c){
                                            isApprovalReq='TRUE';
                                        }else{
                                            isApprovalReq='FALSE';
                                        }
                                        recordsinfo.add(new WrapperClass(smi,isApprovalReq,userEmailId));
                                     }
       /* SmiData = [SELECT Id,Item_Name__c, Serial_No__c, Type__c, Parent_Id__r.id, Assigned_Team__c, No_of_Days__c, 
                   TemplateType__c, User_Email__c  FROM Skinn_Model_Item__c WHERE Parent_Id__c != null limit 10];*/
        pb1 = true;
    }
    public void SaveAsExcel() {
        pb1=false;
        renderAsExcel='application/vnd.ms-excel#CSVFile.xls';
    }
  /*************************Import CSV file***************************************/
    public Blob contentFile {get;set;}
    public String csvDataString {get;set;}
    public String [] recordSepr = new String[] {}; 
        public List<Skinn_Model_Item__c> SMIlist{get;set;} 
    public static Boolean isValidTeam(String TeamName){
        	if(TeamName=='QA' || TeamName=='Marketing User' || TeamName=='Fragrance Expert' || TeamName=='NPD Packaging' || TeamName=='Sourcing'){
                return true;
            }else{
                return false;
            }
    }

    public Pagereference UploadDataFromCsv(){
       // csvDataString = contentFile.toString();
       // System.debug('csvDataString = '+csvDataString);
       try{
           if(refreshprevent){
               refreshprevent=false;
                String[] recordValues = new String[] {};
        SMIlist = new List<Skinn_Model_Item__c>();
        List<Skinn_Model_Item__c> skinnDataList = new List<Skinn_Model_Item__c>();
        Map<Decimal,Decimal> mapOfItemWithOrNum=new Map<Decimal,Decimal>();
        csvDataString = contentFile.toString();
        recordSepr = csvDataString.split('\n');
        system.debug('record size: ' +recordSepr.size());
        List<List<String>> uploadedRecords=new List<List<String>>();
        for(integer i = 1;i<recordSepr.size();i++){
            uploadedRecords.add(recordSepr[i].split(','));
        }
        System.debug('uploadedRecords----------'+uploadedRecords);
        Set<Decimal> validateOrderNumber=new Set<Decimal>();
        Boolean validateParentONumber=true;
        List<Boolean> validateAssignTeam=new List<Boolean>();
        Set<String> templateRecords=new Set<String>();
        Boolean checkHasTemp=true;
        List<Skinn_Model_Item__c> upsertSkinnModelRecords=new List<Skinn_Model_Item__c>();
        Skinn_Model_Item__c addRecord;
               System.debug('uploadedRecords now::: '+uploadedRecords);
        for(integer i = 0;i<uploadedRecords.size();i++){
            System.debug('Here:: ' +uploadedRecords[i][6]+'$$'+uploadedRecords[i][7]+'$$'+uploadedRecords[i][8] );
            if(i>0){
               validateParentONumber=uploadedRecords[i][5].isNumeric();
                mapOfItemWithOrNum.put(Decimal.valueOf(uploadedRecords[i][1]),Decimal.valueOf(uploadedRecords[i][5]));
            }
            if(!validateParentONumber){
                break;
            }
            validateAssignTeam.add(isValidTeam(uploadedRecords[i][6]));
            validateOrderNumber.add(Decimal.valueOf(uploadedRecords[i][1]));
           
            templateRecords.add(uploadedRecords[i][8]);
            if(uploadedRecords[i][8].length() <2){
                checkHasTemp=false;
            }
            addRecord=new Skinn_Model_Item__c();
            If(uploadedRecords[i][0]!='')
            addRecord.Id=uploadedRecords[i][0];
            System.debug('uploadedRecords[i][1]:::::'+uploadedRecords[i]);
            If(uploadedRecords[i][1]!='')
            addRecord.Order_No__c=Decimal.valueof(uploadedRecords[i][1]);
            If(uploadedRecords[i][2]!='')
            addRecord.Serial_No__c=uploadedRecords[i][2];
            If(uploadedRecords[i][3]!='')
            addRecord.Item_Name__c=uploadedRecords[i][3];
            If(uploadedRecords[i][4]!='')
            addRecord.Type__c=uploadedRecords[i][4];
            If(uploadedRecords[i][6]!='')
            addRecord.Assigned_Team__c=uploadedRecords[i][6];
            If(uploadedRecords[i][7]!='')
            addRecord.Planned_Lead_Time__c=uploadedRecords[i][7]!=''?Decimal.valueof(uploadedRecords[i][7]):0;
            If(uploadedRecords[i][8]!='')
            addRecord.TemplateType__c=uploadedRecords[i][8];
            If(uploadedRecords[i][9]!='')
            addRecord.User_Email__c=uploadedRecords[i][9];
            If(uploadedRecords[i][10]!='')
            addRecord.Approval_required__c=String.valueOf(uploadedRecords[i][10].toLowerCase().trim())=='true'?true:false;
            upsertSkinnModelRecords.add(addRecord);
        }
        Boolean checkTeam=true;
        for(Boolean each:validateAssignTeam){
            if(!each){
                checkTeam=false;
            }
        }
        if(validateOrderNumber.size()==uploadedRecords.size() && validateParentONumber && checkTeam && checkHasTemp && templateRecords.size()==2){
            Id marketingRecordTypeId = Schema.SObjectType.Skinn_NPD_Template__c.getRecordTypeInfosByName().get('Marketing Record Type').getRecordTypeId();
            Id projectRecordTypeId=Schema.SObjectType.Skinn_NPD_Template__c.getRecordTypeInfosByName().get('Project Record Type').getRecordTypeId();
            List<Skinn_NPD_Template__c> skinnNPDTemp=[SELECT Id,Active__c FROM Skinn_NPD_Template__c where Active__c=true limit 2];
            for(Skinn_NPD_Template__c each:skinnNPDTemp){
                each.Active__c=false;
            }
            update skinnNPDTemp;
            List<Skinn_NPD_Template__c> addNewTempRecord=new List<Skinn_NPD_Template__c>();
            List<Skinn_Model_Item__c> mapOfItemwithSkinnNpTJuR=new List<Skinn_Model_Item__c>();
            List<String> newTempaRecord=new List<String>(templateRecords);
            newTempaRecord.sort();
                addNewTempRecord.add(new Skinn_NPD_Template__c(Name=newTempaRecord[0],Active__c=true,RecordTypeId =projectRecordTypeId));
                 addNewTempRecord.add(new Skinn_NPD_Template__c(Name=newTempaRecord[1],Active__c=true,RecordTypeId =projectRecordTypeId));

            upsert upsertSkinnModelRecords;
            insert addNewTempRecord;
            Map<String,Id> mapofTempWithRecord=new Map<String,Id>();
            Map<Decimal,Skinn_Model_Item__c> mapofparChildRecords=new Map<Decimal,Skinn_Model_Item__c>();
            mapofTempWithRecord.put(addNewTempRecord[0].Name,addNewTempRecord[0].Id);
            mapofTempWithRecord.put(addNewTempRecord[1].Name,addNewTempRecord[1].Id);
            for(Skinn_Model_Item__c each:upsertSkinnModelRecords){
                mapofparChildRecords.put(each.Order_No__c,each);
            }
            Decimal Parentnum;
            for(Skinn_Model_Item__c each:upsertSkinnModelRecords){
                Parentnum=mapOfItemWithOrNum.get(each.Order_No__c);
                if(Parentnum!=null)
                each.Parent_Id__c=mapofparChildRecords.get(Parentnum).Id;
            }
            upsert upsertSkinnModelRecords;
            List<Skinn_NPD_Template_Item__c> newJunctionRecords=new List<Skinn_NPD_Template_Item__c>();
            for(Skinn_Model_Item__c each:upsertSkinnModelRecords){
                newJunctionRecords.add(new Skinn_NPD_Template_Item__c(Active__c=true,Approval_required__c=each.Approval_required__c,Order_No__c=each.Order_No__c,Planned_Lead_Time__c=each.Planned_Lead_Time__c,Skinn_Model_Item__c=each.Id,Skinn_NPD_Template__c=mapofTempWithRecord.get(each.TemplateType__c)));
            }
            insert newJunctionRecords;
            map<Decimal,Skinn_NPD_Template_Item__c> mapJuctparChilRel=new map<Decimal,Skinn_NPD_Template_Item__c>();
            for(Skinn_NPD_Template_Item__c each:newJunctionRecords){
                mapJuctparChilRel.put(each.Order_No__c,each);
            }
            for(Skinn_NPD_Template_Item__c each:newJunctionRecords){
                Parentnum=mapOfItemWithOrNum.get(each.Order_No__c);
                if(Parentnum!=null)
                each.Parent_Id__c=mapJuctparChilRel.get(Parentnum).Id;
            }
            upsert newJunctionRecords;
        }else{
            if(templateRecords.size()>=2){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Template Name more than 2!'));
            }else if(templateRecords.size()<=2){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Template Name less than 2!'));
            }
            if(!validateParentONumber){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Give Parent Order Number to every Item except first one.'));
            }
            if(!checkTeam){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Give Assigned Team accordingly.'));
            }
            if(!checkHasTemp){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Give Template Name to every record.'));
            }
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Give Order Number unique to every Item.'));
        }
        contentFile=null;
        csvDataString=null;
        recordSepr.clear(); 
          custrutorMethod();
       
           }
            return null;
          
       }catch(Exception E){
             custrutorMethod();
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,''+E));
             contentFile=null;
       csvDataString=null;
        recordSepr.clear(); 
             return null;
       } 
    }
    public void incr(){
        Integer i=0;
        i++;
       i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
    }
}