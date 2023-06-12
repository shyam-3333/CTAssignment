import { LightningElement,track,api,wire } from 'lwc';
import quoteApproval from '@salesforce/apex/EV_QuoteApprovalController.quoteApproval';
import saveEmail from '@salesforce/apex/EV_QuoteApprovalController.saveEmail';
import startApproval from '@salesforce/apex/EV_QuoteApprovalController.approvalInit';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EV_QuoteApprovalComponent extends LightningElement {
    
    @api recordId;
    @api recordIdOfQuote;
    @track isModalOpen;
    @track noRecordFound;
    @track recipientEmail;
    @track emailAddress;
    @track showSearchComponent = false;
    @track showVerifiedGreenText = false;
    @track showVerifiedRedText = false;
    @track buttonDisable;

    quoteFields = {
        'recipientEmail':undefined,
        'verified':undefined
    }

    // onclick button handler
    submitForApproval() {
        startApproval({ accId: this.recordId})
        .then(result =>{
            if(result == 'success'){
            this.showToast('Success','Quote is submitted for Approval','success');
            //window.alert('Success'); 
         }   
         else {
            this.showToast('Error','No applicable approval process found','error');

            //window.alert('Error'); 
         }
    })
    }
    showSearch() {
      this.showSearchComponent = true;
      this.noRecordFound = '';
    }
    connectedCallback(){
        quoteApproval({quoteRecordId: this.recordId})
        .then(result => {
            this.quoteFields = {
                'recipientEmail':undefined,
                'verified':undefined
            }        
            this.quoteFields.recipientEmail = result.recipientEmail;
            if(result.verified == 'True'){
                this.showVerifiedGreenText = true;
                this.quoteFields.verified = 'Email Verified';
                this.buttonDisable = false;
            }
            else if(result.verified == 'False'){
                this.showVerifiedRedText = true;
                this.quoteFields.verified = 'Email Not Verified';
                this.buttonDisable = true;
            }
            // this.recipientEmail = result;
            console.log(this.recordId);
            console.log(this.recipientEmail);
            this.recordIdOfQuote = this.recordId;

        })
    }
    handleEmailAddress(event){ //Order Id search input
        this.emailAddress = event.target.value;
        console.log(this.emailAddress);
      }
    handleSaveButton(){ //search button
        if(this.emailAddress == '' || this.emailAddress == null){
            this.noRecordFound = 'Please enter email address';
        }  
        else if(this.emailAddress != '' || this.emailAddress != null)
        {
            saveEmail({newEmail: this.emailAddress,quoteRecordId: this.recordId})
          .then(result => {
            if(result == 'format error'){
                this.noRecordFound = 'Please enter one valid email';
            }
            else if(result == 'comma not allowed'){
                this.noRecordFound = 'Please enter one valid email';
            }
            else if(result == 'same email'){
                this.noRecordFound = 'Email address is same';
            }
            else if(result == 'No error'){
                this.noRecordFound = ' ';
                this.showSearchComponent = false;
                window.location.href = 'https://titanlightningapps--npdskdev.sandbox.lightning.force.com/'+this.recordId;
        }
        })
      }
      }
      handleCloseButton(){
        this.showSearchComponent = false;
        this.emailAddress = '';
      }

      showToast(messageTitle,message,typeOfMessage) {
        const event = new ShowToastEvent({
            title: messageTitle,
            message: message,
            variant: typeOfMessage,
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}