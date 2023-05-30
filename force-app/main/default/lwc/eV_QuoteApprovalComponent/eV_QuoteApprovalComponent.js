import { LightningElement,track,api } from 'lwc';
import quoteApproval from '@salesforce/apex/EV_QuoteApprovalController.quoteApproval';
import saveEmail from '@salesforce/apex/EV_QuoteApprovalController.saveEmail';
export default class EV_QuoteApprovalComponent extends LightningElement {
    @api recordId;
    @api recordIdOfQuote;
    @track isModalOpen;
    @track noRecordFound;
    @track recipientEmail;
    @track emailAddress;
    @track showSearchComponent = false;
    
    showSearch() {
      this.showSearchComponent = true;
      this.noRecordFound = '';
    }
    connectedCallback(){
        quoteApproval({quoteRecordId: this.recordId})
        .then(result => {
            this.recipientEmail = result;
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
                this.noRecordFound = 'Please enter email address in proper format';
            }
            else if(result == 'same email'){
                this.noRecordFound = 'Old and new email address are same';
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
      }
}