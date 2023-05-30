import { LightningElement,api } from 'lwc';
import displayFeedbackRecord from '@salesforce/apex/VisitFeedbackPopupController.displayFeedbackRecord';
import updateFeedBack from '@salesforce/apex/VisitFeedbackPopupController.updateFeedBack';
import { CloseActionScreenEvent } from 'lightning/actions';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';



export default class VisitFeedbackPopupComponent extends LightningElement {
    @api recordId;
    feedbackData = [];
    selectedIdFeedback = []
    @api  columns =[
        { label: 'Feedback Number', fieldName: 'Customer_Feedback_Number__c', type:'text'},
        { label: 'Feedback Status', fieldName: 'Feedback_Status__c',type:'text' },
        { label: 'Contact Name', fieldName: 'Name',type:'text' },
        { label: 'Email', fieldName: 'Email__c', type:'Email'}
        
               
    ];
  
    connectedCallback() {
        setTimeout(() => {
            displayFeedbackRecord({recordId:this.recordId})
            .then(result=>{
                this.feedbackData = result;

            })
            .catch(error=>{
                
            })

        }, 1);
        
    }

    getSelectedRec() {
        var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
        console.log(selectedRecords);
        this.selectedIdFeedback = [];
        console.log(JSON.stringify(selectedRecords));
        for(var key in selectedRecords){
            this.selectedIdFeedback.push(selectedRecords[key].Id);
        }          
      }


      handleSendEmail(){
        console.log(this.selectedIdFeedback);
        if(this.selectedIdFeedback.length>0){
            updateFeedBack({selectedIds : this.selectedIdFeedback, visitId : this.recordId})
        .then(result=>{
            this.selectedIdFeedback = [];
            console.log(JSON.stringify(result));

            const toastEventsuccess = new ShowToastEvent({
                title:'Success!',
                message:'Feedback email is sent successfully',
                variant:'success'
              });
              this.dispatchEvent(toastEventsuccess);

            this.dispatchEvent(new CloseActionScreenEvent());
            
 
        })
        .catch(error =>{
           
        });
        }else{
            const toastEvent = new ShowToastEvent({
                title:'Invalid!',
                message:'Please select record.',
                variant:'warning'
              });
              this.dispatchEvent(toastEvent);
        }
        
    }

    //Call this before init to get recordId



}