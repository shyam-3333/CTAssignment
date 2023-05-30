@isTest
public with sharing class IDICSVfileUplaodControllerTest {
      static testmethod void test1(){
          
          WapperClass ob = new WapperClass();
          ChildClass chOb = new ChildClass();
          ob.uploadingAction = 'Raw Material';
          chOb.filename= 'xyz.csv';
          chOb.baseDate = 'UUMgTVRMIENvbXBvbmVudCxSZXBvcnQgUmVmZXJlbmNlIE51bWJlcixTYW1wbGUgUmVjZWl2ZWQgRnJvbSxNVEwgVXNlciBFbWFpbCxSYXcgTWF0ZXJpYWwgVHlwZSxSYXcgTWF0ZXJpYWwgTmFtZSxUaXRhbiBTcGVjaWZpY2F0aW9uIFJlZmVyZW5jZSBOYW1lLFN1cHBsaWVyIEdyYWRlIEV4dGVybmFsIElkLFN1cHBsaWVyIE5hbWUgRXh0ZXJuYWwgSWQsSW52b2ljZS9EYy5ObyxSYXcgTWF0ZXJpYWwgU2l6ZSxIZWF0IE5vIC8gR3JhZGUsU3VwcGx5IFF1YW50aXR5LFNhbXBsZSBTaXplLFNhbXBsZSBUeXBlDQosLGlkaUB0aXRhbi5jby5pbixtdGxAdGl0YW4uY28uaW4sTW9kdWxlIFJhdyBNYXRlcmlhbCxMZWFkZWQgQnJhc3MgU3RyaXBzLFQ4MDc3LDk3LDEzNSx0ZXN0LDEwMCwxMDAsMTAwLDIsTmV3DQpFT0YsLCwsLCwsLCwsLCwsLA0K';
          ob.fileData = JSON.serialize(chOb);
          //System.debug(jsonObject.remove('\\'));
          IDICSVfileUplaodComponentApexController.uploadCSVFile(JSON.serialize(ob));
          ob = new WapperClass();
          chOb = new ChildClass();
          ob.uploadingAction = 'Plating';
          chOb.filename= 'xyz.csv';
          chOb.baseDate = 'UUMgTVRMIENvbXBvbmVudCxSZXBvcnQgUmVmZXJlbmNlIE51bWJlcixTYW1wbGUgUmVjZWl2ZWQgRnJvbSxNVEwgVXNlciBFbWFpbCxEZXBhcnRtZW50LFBhcnQgTmFtZSxUaXRhbiBTcGVjaWZpY2F0aW9uIFJlZmVyZW5jZSBOYW1lLFN1cHBsaWVyIE5hbWUgRXh0ZXJuYWwgSWQsQnJhbmQgTmFtZSBFeHRlcm5hbCBJZCxTb3VyY2UsTW9kZWwsRC5DLk51bWJlcixCYXRjaCBRdWFudGl0eSxCYXNlIG1hdGVyaWFsIG5hbWUsUGxhdGluZyBUeXBlLFNwZWNpZmljYXRpb24gcmV2aXNpb24sUmVxdWlyZWQgVGVzdCxTYW1wbGUgU2l6ZSxTYW1wbGUgVHlwZSxQbGF0ZXIgRXh0ZXJuYWwgSWQNCiwsYXNob2tuQHRpdGFuLmNvLmluLG10bEB0aXRhbi5jby5pbixDdXN0b21lciBBc3N1cmFuY2UsQnJhY2VsZXQsVDgwMjggVHlwZSAxNSwxNjEsMTQ5LElOSCwxMDAsMTAwLDEwLEJyYXNzLEJJIENPTE9SIFJPU0UgQVUsKixGdWxsIFRlc3QsMixOZXcsMTY0DQpFT0YsLCwsLCwsLCwsLCwsLCwsLCwsDQo=';
          ob.fileData = JSON.serialize(chOb);
          IDICSVfileUplaodComponentApexController.uploadCSVFile(JSON.serialize(ob));
          ob = new WapperClass();
          chOb = new ChildClass();
          ob.uploadingAction = 'Plating and Material Composition';
          chOb.filename= 'xyz.csv';
          chOb.baseDate = 'UUMgTVRMIENvbXBvbmVudCxSZXBvcnQgUmVmZXJlbmNlIE51bWJlcixTYW1wbGUgUmVjZWl2ZWQgRnJvbSxNVEwgVXNlciBFbWFpbCxEZXBhcnRtZW50LFBhcnQgTmFtZSxUaXRhbiBTcGVjaWZpY2F0aW9uIFJlZmVyZW5jZSBOYW1lLFN1cHBsaWVyIE5hbWUgRXh0ZXJuYWwgSWQsQnJhbmQgTmFtZSBFeHRlcm5hbCBJZCxTb3VyY2UsTW9kZWwsRC5DLk51bWJlcixCYXRjaCBRdWFudGl0eSxCYXNlIG1hdGVyaWFsIG5hbWUsUGxhdGluZyBUeXBlLFNwZWNpZmljYXRpb24gcmV2aXNpb24sUmVxdWlyZWQgVGVzdCxTYW1wbGUgU2l6ZSxTYW1wbGUgVHlwZSxQbGF0ZXIgRXh0ZXJuYWwgSWQNCiwsYXNob2tuQHRpdGFuLmNvLmluLG10bEB0aXRhbi5jby5pbixDdXN0b21lciBBc3N1cmFuY2UsQnJhY2VsZXQsVDgwMjggVHlwZSAxNSwxNjEsMTQ5LElOSCwxMDAsMTAwLDEwLEJyYXNzLEJJIENPTE9SIFJPU0UgQVUsKixGdWxsIFRlc3QsMixOZXcsMTY0DQpFT0YsLCwsLCwsLCwsLCwsLCwsLCwsDQo=';
          ob.fileData = JSON.serialize(chOb);
          IDICSVfileUplaodComponentApexController.uploadCSVFile(JSON.serialize(ob));
          String requestedJson = '[{"query":"Select Name,Report_Reference_Number__c,Sample_Received_From__c,MTL_User_Email__c,Raw_Material_Type__c,Raw_Material_Name__c,Titan_Specification_Reference_Name__c,Supplier_Grade_External_Id__c,Supplier_Name_External_Id__c,Invoice_Dc_No__c,RM_Size__c,Heat_No_Grade__c,Supply_Quantity__c,Sample_Size_Qty__c,Material_Sample_Type__c FROM QC_MTL_Component__c where  Testing_Type__c=\'Raw Material\' order by createdDate Desc limit 10"},{"requestedFields":"Name,Report_Reference_Number__c,Sample_Received_From__c,MTL_User_Email__c,Raw_Material_Type__c,Raw_Material_Name__c,Titan_Specification_Reference_Name__c,Supplier_Grade_External_Id__c,Supplier_Name_External_Id__c,Invoice_Dc_No__c,RM_Size__c,Heat_No_Grade__c,Supply_Quantity__c,Sample_Size_Qty__c,Material_Sample_Type__c "}]';
      	  IDICSVfileUplaodComponentApexController.fatchRecords(requestedJson);
          
      }
    public class WapperClass{
        String fileData;
        String uploadingAction;
    }
    public class ChildClass{
        String filename;
        String baseDate;
    }
}