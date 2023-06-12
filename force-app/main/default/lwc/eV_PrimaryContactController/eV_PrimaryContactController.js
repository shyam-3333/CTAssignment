import { LightningElement,api,track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import getPrimaryContact from '@salesforce/apex/EV_PrimaryContact_Handler.getPrimaryContact';
import contactsprimarycheckbox from '@salesforce/apex/EV_PrimaryContact_Handler.contactsprimarycheckbox'
export default class EV_PrimaryContactController extends NavigationMixin(LightningElement) {

@api recordId;
@track contactData = [];
selectedContactId;
contactId = null;
showbutton = true;
showhelptext = false;

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

    if(this.contactData.find(contact=> contact.Primary_Contact__c)){
        this.selectedContactId = Id;
        this.showbutton = true;
        //this.showhelptext = true;

    }else{
        this.selectedContactId = '';
        this.showbutton = false;
       // this.showhelptext = false;
    }
}

handleSave() {
    if(this.contactId == null){
        this.showToast('Error', 'This Contact is Already selected as primary Contact', 'error');
    }else{
        contactsprimarycheckbox({contactId: this.contactId, contactlist:this.contactData})
        .then(result => {
            console.log('result->' + result);
            if(result=='success'){
                this.showToast('Success', 'Primary contact updated successfully.', 'success');
                for(var key in this.contactData){
                    if(this.contactData[key].Id == this.contactId){
                        this.contactData[key].Primary_Contact__c = true;
                    }else{
                        this.contactData[key].Primary_Contact__c = false;
                }
            }
            console.log('this.contactData[key]'+this.contactData[key]);
                this.showbutton = false;
                //this.showhelptext = true;
            }
            else{
                this.showToast('Error', 'Select atleast one contact', 'error');

            }
            
        })
        .catch(error => {
            console.log('error'+ error);
            this.showToast('Error', 'Select atleast one contact', 'error');
        });
    }
}
//getContactUrl(contactId) {
    //return `/lightning/r/Contact/${contactId}/view`;
//}
    showToast(title, message, variant) { 
        const toastEvent = new ShowToastEvent({title,message,variant});
        this.dispatchEvent(toastEvent);
    }

    navigateToRecord(event) {
        const recsordId = event.currentTarget.dataset.recordId;
        this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
        recordId: recsordId,
        objectApiName: 'Contact',
        actionName: 'view'
        }
        });
        }
}