@RestResource(urlMapping='/Account')
global with sharing class AccountViewApi{
    @HttpGet
    global static void  doGet() {
        //Id vendorRecType = Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<vendor__c> accountList = new List<vendor__c>();
        
        if(!Test.isRunningTest()){
        accountList = [SELECT Id, Name,TIN_CST_Number__c, Category__c,Email_Id_Vendor__c,Vendor_Code__c,Type__c,Title__c,Name_1__c,Name_2__c,Mobile_Phone__c,Country__c,Postal_code__c,Mail_ID__c,Phone_No__c 
                            FROM vendor__c where Active__c = true limit 49999];
        }else{
            accountList = [SELECT Id, Name,TIN_CST_Number__c, Category__c,Email_Id_Vendor__c,Vendor_Code__c,Type__c,Title__c,Name_1__c,Name_2__c,Mobile_Phone__c,Country__c,Postal_code__c,Mail_ID__c,Phone_No__c 
                            FROM vendor__c where Active__c = true];
        }
        
        List<accWrapper> accList = new List<accWrapper>();
            for(vendor__c acc : accountList){
            accWrapper wrap = new accWrapper();
            wrap.Vendor_Name= acc.name;
            wrap.Vendor_Id= acc.Id;
            wrap.Vendor_Code = acc.Vendor_Code__c;
            wrap.Category= acc.Category__c;
            wrap.Type= acc.Type__c;
            wrap.Title= acc.Title__c;
            wrap.Name1= acc.Name_1__c;
            wrap.Name2= acc.Name_2__c;
            wrap.Mobile_Phone= acc.Mobile_Phone__c;
            wrap.Country= acc.Country__c;
            wrap.Postal_Code= acc.Postal_code__c;
            wrap.Mail_Id= acc.Email_Id_Vendor__c;
            wrap.Phone_No = acc.Phone_No__c;
            wrap.GST_Num = acc.TIN_CST_Number__c;
            wrap.Owner_Email = acc.Mail_ID__c;
           
            accList.add(wrap);
        }
        String jsonResponse =  JSON.serialize(accList);
        if(!Test.isRunningTest()){
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(jsonResponse);
        }
        
    }
    @HttpPost
    global static void doPost(){
        RestContext.response.addHeader('Content-Type', 'text/plain');
        String bodyOfReq = RestContext.request.requestBody.toString();
        system.debug('**bodyOfReq**'+bodyOfReq);
        List<accWrapper> accDetails= new  List<accWrapper> ();
        List<vendor__c> accList = new List<vendor__c>();
        set<String>setOfUsrName = new set<string>();
        map<String,Id> mapOfUser = new map<string,Id>();
        //Id VendorRecType= [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id; 
        accDetails=(List<accWrapper>)System.JSON.deserialize(bodyOfReq,List<accWrapper>.class);
         for(accWrapper eachAcc : accDetails){
            setOfUsrName.add(eachAcc.Owner_Name);
        }
        system.debug('setOfUsrName==>'+setOfUsrName);
        for(User usr : [Select Id,UserName from user Where Username in : setOfUsrName]){
            mapOfUser.put(usr.UserName,usr.Id);
        }
        for(accWrapper wrap : accDetails){
            vendor__c acc = new vendor__c();
            acc.name = wrap.Vendor_Name;
           // acc.recordTypeId = VendorRecType;
            acc.Category__c= wrap.Category;
            acc.Vendor_Code__c = wrap.Vendor_Code;
            acc.Type__c = wrap.Type;
            acc.Title__c = wrap.Title;
            acc.Name_1__c = wrap.Name1;
            acc.Name_2__c = wrap.Name2;
            acc.Mobile_Phone__c = wrap.Mobile_Phone;
            acc.Country__c = wrap.Country;
            acc.Postal_code__c = wrap.Postal_Code;
            acc.Mail_ID__c = wrap.Owner_Email;
            acc.Email_Id_Vendor__c = wrap.Mail_Id;
            acc.Phone_No__c = wrap.Phone_No;
            acc.OwnerId = mapOfUser.get(wrap.Owner_Name);
            acc.TIN_CST_Number__c = wrap.GST_Num;
            accList.add(acc);
        }
        try{
            if(accList.size()>0){
                insert accList;
                RestResponse res = RestContext.response;
                RestContext.response.addHeader('Content-Type', 'application/json');
                Map<String,String> recList = new Map<String,String>();    
                recList.put('Message','Vendor Created');
                String msg = json.serialize(recList);
                RestContext.response.responseBody = Blob.valueOf(msg);
            }
        }
        catch(Exception ex){
            system.debug('***Exception***'+ex);
        }
        
    }
    public class accWrapper{
        public String Vendor_Name{get;set;}
        public String Vendor_Id{get;set;}
        public string Vendor_Code {get;set;}
        public String Category{get;set;}
        public String Type{get;set;}
        public String Title{get;set;}
        public String Name1{get;set;}
        public String Name2{get;set;}
        public String Mobile_Phone{get;set;}
        public String Country{get;set;}
        public String Postal_Code{get;set;}
        public String Mail_Id{get;set;}
        public String Phone_No{get;set;}
        public String GST_Num{get;set;}
        public string Owner_Name {get;set;}
        public string Owner_Email {get;set;}

    }

}

/*
[
  {
    "Vendor_Name": "ABC test",
    "Vendor_Id": "",
    "Vendor_Code": "123",
    "Category": "",
    "Type": "",
    "Title": "",
    "Name1": "",
    "Name2": "",
    "Mobile_Phone": "",
    "Country": "",
    "Postal_Code": "256324",
    "Mail_Id": "",
    "Phone_No": "",
    "GST_Num": "",
    "Owner_Name": "",
    "Owner_Email": ""
  }
]
 */