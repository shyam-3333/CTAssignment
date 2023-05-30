/***********************************************************************************************
 * Created by: Vinoth Kumar A
 * Created on: 13/05/2019
 * Description: Email sample recieved from requires to accept multiple emails so created 3 email fields and text area field which accepts
 * 				multiple emails with comma separated. These email address should be captured automatically by 3 email fields.
 * *********************************************************************************************/
public class ComponentEmailSampleReceivedFromHandler {
    public static void MultipleEmailAdd(List<QC_Components__c> compList){
        List<string> EmailList = new List<string>();
        for(QC_Components__c comp : compList){
            if(comp.Additional_email_address__c != NULL){
                EmailList.addAll(comp.Additional_email_address__c.split(','));
                if(EmailList.size() == 1){
                    comp.Email_Sample_Received_From_1__c = EmailList[0];
                } else if(EmailList.size() == 2){
                    comp.Email_Sample_Received_From_1__c = EmailList[0];
                    comp.Email_Sample_Received_From_2__c = EmailList[1];
                } else if(EmailList.size() == 3){
                    comp.Email_Sample_Received_From_1__c = EmailList[0];
                    comp.Email_Sample_Received_From_2__c = EmailList[1];
                    comp.Email_Sample_Received_From_3__c = EmailList[2]; 
                } else {
                    comp.addError('Only 3 additional emails are allowed');
                }
            }
        }
    }
}