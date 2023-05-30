@isTest
public class QC_Material_Testing_FormClassTest {
    public static testmethod void createData(){
        QC_Material_Testing_FormClass.getSchemaValue();
        QC_MTL_Component__c qcmtlobj = new QC_MTL_Component__c();
        qcmtlobj.RecordTypeId =Schema.SObjectType.QC_MTL_Component__c.getRecordTypeInfosByName().get('Raw Material Testing').getRecordTypeId();
          qcmtlobj.Testing_Type__c = 'Raw Material';
          qcmtlobj.Raw_Material_Type__c='Module Raw Material';
            qcmtlobj.Material_Sample_Type__c = 'New';
            qcmtlobj.Report_Reference_Number__c = 'RM/0019/19-20';
            qcmtlobj.Record_Status__c = 'Active';
            qcmtlobj.Sample_Size_Qty__c= 4;
            qcmtlobj.Document_Status__c = 'Submitted for Approval';
            qcmtlobj.Sample_Received_From__c = 'sameer.ranjan@kvpcorp.com';
            insert qcmtlobj;
      	 QC_Material_Testing_FormClass.getRecordInformation(qcmtlobj.Id);
        	QC_Material_Testing_FormClass.submitForAppProcess(qcmtlobj.Id);
        
    }

}