import { LightningElement,track,api,wire } from 'lwc';
import sendVerification from '@salesforce/apex/EV_AddEmailAddressController.sendVerification';
import fieldUpdate from '@salesforce/apex/EV_AddEmailAddressController.fieldUpdate';
import {CurrentPageReference} from 'lightning/navigation';

export default class EV_AddEmailAddressComponent extends LightningElement {
    @api recordId;
    @track isModalOpen;
    @track noRecordFound;
    @track emailAddress;
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;
            console.log(this.recordId);
        }
    }
    connectedCallback(){
        fieldUpdate({accountRecordId: this.recordId})
        .then(result => {
            if(result == 'No error'){
                this.isModalOpen = true;
            }
            if(result == 'Please enter recipient email address'){
              this.isModalOpen = false;  
              this.template.querySelector('c-custom-toast-message-component').showToast('error', 'Please enter recipient email address');
           }
           if(result == 'Email verification link is already sent. Please try again after 24 hours'){
            this.isModalOpen = false;  
            this.template.querySelector('c-custom-toast-message-component').showToast('error', 'Email verification link is already sent. Please try again after 24 hours');
         }
         if(result == 'Email is already verified'){
            this.isModalOpen = false;  
            this.template.querySelector('c-custom-toast-message-component').showToast('error', 'Email is already verified');
         }
        })
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }
    handleEmailAddress(event){ //Order Id search input
        this.emailAddress = event.target.value;
        console.log(this.emailAddress);
      }
    handleSendButton(){ //search button
        if(this.emailAddress == '' || this.emailAddress == null){
            this.noRecordFound = 'Please enter email address';
        }  
        else if(this.emailAddress != '' || this.emailAddress != null)
        {
            sendVerification({otherEmails: this.emailAddress,accountRecordId: this.recordId})
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
      }
      }
}