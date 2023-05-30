/**************************************************
Created By :  Omprakash
Created Date : 22/09/2022
Company Name : KVP Business Solutions Pvt Ltd. 
Description : Rest Api Class Send MM Product To sap When A new Product is created.  
******************************************************/
public class TaneiraSendMMToSapApi {
    //The EndPoint url of SAP in Custom Label is "TaneriaMmSapEndpointURL".
    private Static final String taneriaMmSapEndpointURL = System.Label.TaneriaMmSapEndpointURL;
    // Wrapper Class to Convert MM detailes to Json
    Public class ResponceWrapper{
        public ItemHeaderWrapper ItemHeader;
    }    
    public class ItemHeaderWrapper {
        public String Plant;
        public String Profit_center;
        public String Storage_location;
        public ItemItemDetailWrapper ItemDetail; 
    }
    public class ItemItemDetailWrapper{
        public String Material_No;
        public String Material_Description;
        public String Material_Group;
        public String ECOM_Material;
        public String Control_code;
        public String Product_Hierarchy;
        public String UOM;
    }
    //This feature method Will get the record Id's From Trigger
    @future(callout=true)
    public Static Void sendMMToSap(Set<Id> pid){
        try{
            List<Product__c> pdList = [Select id,Cluster__c,SKU_Code__c,Material_Description__c,Order_Id__c,Product_Hierarchy__c,
                                       Product_Category_Taneira__c,Unit_of_Measure__c, Control_Code__c from Product__c where id =: pid];
            List<Product__c> productToUpdate = new List<Product__c>();
            for(Product__c pd : PDList)
            {   
                //Creating the Instance of Wrapper Class
                ResponceWrapper ress = new ResponceWrapper();
                ItemHeaderWrapper req = new ItemHeaderWrapper();
                ItemItemDetailWrapper ItemDetail = new ItemItemDetailWrapper();
                req.Plant = 'SIKA';			
                req.Profit_Center = 'SSSIKA';
                req.Storage_Location = '1008';
                ItemDetail.Material_No = pd.SKU_Code__c;
                ItemDetail.Material_Description = pd.Material_Description__c;
                ItemDetail.Material_Group = pd.Product_Category_Taneira__c;
                ItemDetail.ECOM_Material = pd.SKU_Code__c;
                ItemDetail.Control_code = pd.Control_Code__c;
                //ItemDetail.Control_Code = '2022';
                ItemDetail.Product_Hierarchy = pd.Product_Hierarchy__c;
                //ItemDetail.Product_Hierarchy = 'TA';
                ItemDetail.UOM = pd.Unit_of_Measure__c;
                req.ItemDetail = ItemDetail;
                ress.ItemHeader = req;
              //  System.debug(logginglevel.INFO, ress);
               // System.debug(logginglevel.INFO, 'JSON BODY' + ress);
                //String test = '{"ItemHeader":{"Plant":"SIKA","Profit_center":"SSSIKA","Storage_location":"1008","ItemDetail":{"Material_No":"SHT08A00777","Material_Description":"S-Rajko-Sil-Sil-Patola-GTZL","Material_Group":"SAREE","ECOM_Material":"SHT07FR712","Control_code":"5007","Product_Hierarchy":"TA","UOM":"NO"}}}';
                HttpRequest request = new HttpRequest();
                request.setEndpoint(taneriaMmSapEndpointURL);
                request.setBody(JSON.serialize(ress));
                //request.setBody(test);
                request.setMethod('POST');
                String username = System.label.TaneiraSapUserid;
                String password = System.label.TaneiraSapUserPassword;
                Blob headerValue = Blob.valueOf(username + ':' + password);
                String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
                request.setHeader('Authorization', authorizationHeader);
                Http http = new Http();
                HTTPResponse res = http.send(request);
               System.debug(logginglevel.INFO, res.getStatusCode()); 
                decimal statusCode = res.getStatusCode();
              //  System.debug(logginglevel.INFO, JSON.serialize(ress));
                //String test = JSON.serialize(resList);
                //System.debug(test);
                if(statusCode == 202 || statusCode == 200){
                    pd.MM_Sent__c = true;
                    productToUpdate.add(pd);
                }
            }
            update productToUpdate;
        }
        //Exception handling.
        catch(Exception ex){
            System.debug(logginglevel.ERROR, 'Message ouccure'+ex.getMessage());
            System.debug(logginglevel.ERROR, 'Message line number'+ex.getLineNumber());
        }
    }
}