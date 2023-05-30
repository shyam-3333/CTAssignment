import { LightningElement,api,track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getPrimaryContact from '@salesforce/apex/EV_PrimaryContact_Handler.getPrimaryContact';
import contactsprimarycheckbox from '@salesforce/apex/EV_PrimaryContact_Handler.contactsprimarycheckbox'
export default class EV_PrimaryContactController extends LightningElement {

@api recordId;
@track contactData = [];
contactId = null;

connectedCallback() {
    // Retrieve the primary contact for the account
    getPrimaryContact({ accountId: this.recordId })
    .then(result => {
        this.contactData = result;
        console.log('this.contactData->'+ this.contactData);
    })
    .catch(error => {
        console.log('error'+ error);
    });
}
handleContactSelection(event){
    let Id = event.target.value;
    this.contactId = Id;
}
handleSave() {
    if(this.contactId == null){
        this.showToast('Error', 'This Contact is Already selected as primary Contact', 'error');
    }else{
        contactsprimarycheckbox({contactId: this.contactId, contactlist:this.contactData})
        .then(result => {
            console.log('result->' + result);
            if(result=='success')
            this.showToast('Success', 'Primary contact updated successfully.', 'success');
            else
            this.showToast('Error', 'Select atleast one contact', 'error');
        })
        .catch(error => {
            console.log('error'+ error);
            this.showToast('Error', 'Select atleast one contact', 'error');
        });
    }
}
    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({title,message,variant});
        this.dispatchEvent(toastEvent);
    }
}