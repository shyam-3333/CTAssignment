import { LightningElement,track,api,wire } from 'lwc';
import sendEmail from '@salesforce/apex/EV_AddEmailAddressController.sendEmail';
import sendVerification from '@salesforce/apex/EV_AddEmailAddressController.sendVerification';
import {CurrentPageReference} from 'lightning/navigation';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';



export default class EV_AddEmailAddressComponent extends LightningElement {
    @api recordId;
    @track isModalOpen;
    @track noRecordFound;
    @track emailAddress;
    spinnerStatus = false;
    isModalOpen = false;


    isWarning = false;
    warningMessage = '';

    accountData = {
        'toastError':undefined,
        'recipientEmail':undefined
    }

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;
            console.log(this.recordId);
        }
    }
    connectedCallback(){
        this.spinnerStatus = true;
        sendVerification({accountRecordId: this.recordId})      
        .then(result => {
            this.accountData = {
                'toastError':undefined,
                'recipientEmail':undefined
            }        
            this.accountData.recipientEmail = result.recipientEmail;
            console.log(this.accountData.recipientEmail);
            console.log(result.recipientEmail);
            this.spinnerStatus = false;
            if(result.toastError == 'No error'){
                this.isModalOpen = true;
                this.isWarning = false;
            }
            else if(result.toastError == 'Please enter recipient email address'){
              this.isWarning =  true;
              this.isModalOpen = false;
              this.warningMessage = 'Please enter recipient email address';
            }
           else if(result.toastError == 'Email verification link is already sent. Please try again after 24 hours'){
              this.isWarning =  true;
              this.isModalOpen = false;
              this.warningMessage = 'Email verification link is already sent. Please try again after 24 hours';
         }
         if(result.toastError == 'Email is already verified'){
            this.isWarning =  true;
            this.isModalOpen = false;
            this.warningMessage = 'Email is already verified';
        }
        })
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.dispatchEvent(new CloseActionScreenEvent());

        //this.isModalOpen = false;
    }
    handleEmailAddress(event){ //Order Id search input
        this.emailAddress = event.target.value;
        console.log(this.emailAddress);
      }
    handleSendButton(){ //search button
        // if(this.emailAddress == '' || this.emailAddress == null){
        //     this.noRecordFound = 'Please enter email address';
        // }  
        //if(this.emailAddress != '' || this.emailAddress != null)
        //{
            sendEmail({otherEmails: this.emailAddress,accountRecordId: this.recordId})
          .then(result => {
            if(result == false){
                this.noRecordFound = 'Please enter email address in proper format';
            }
            else if(result == true){
                this.noRecordFound = ' ';
                this.isModalOpen = false;
                window.location.href = 'https://titanlightningapps--npdskdev.sandbox.lightning.force.com/'+this.recordId;
        }
        })   
      //}   
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