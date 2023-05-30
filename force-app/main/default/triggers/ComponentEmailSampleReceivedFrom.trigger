/***********************************************************************************************
 * Created by: Vinoth Kumar A
 * Created on: 13/05/2019
 * Description: Email sample recieved from requires to accept multiple emails so created 3 email fields and text area field which accepts
 * 				multiple emails with comma separated. These email address should be captured automatically by 3 email fields.
 * *********************************************************************************************/
trigger ComponentEmailSampleReceivedFrom on QC_Components__c (before insert,before update) {
    //
}