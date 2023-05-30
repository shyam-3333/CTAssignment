import { LightningElement,track,api,wire } from 'lwc';
import sendVerification from '@salesforce/apex/EV_AddEmailAddressController.sendVerification';
import fieldUpdate from '@salesforce/apex/EV_AddEmailAddressController.fieldUpdate';
import {CurrentPageReference} from 'lightning/navigation';

export default class EvChangeEmailComponent extends LightningElement {
    @api recordId;
    @track showSearchComponent = true;
    @track noRecordFound;
    @track emailAddress;
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;
            console.log(this.recordId);
        }
    }

    closeModal() {
    // to close modal set isModalOpen tarck value as false
    this.showSearchComponent = false;
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