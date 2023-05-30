import { LightningElement, wire, track } from 'lwc';
//import { refreshApex } from '@salesforce/apex';
import getCollctionRecords from '@salesforce/apex/skinnPDMSViewOnlyController.getcollectionRecords';
import ModelRecords from '@salesforce/apex/skinnPDMSViewOnlyController.getModelRecords';
import skinnCollectiontempRecords from '@salesforce/apex/skinnPDMSViewOnlyController.getskinnCollectiontempRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';



export default class SkinnPDMSViewOnly extends LightningElement {
    
    @track CollectionValue = '';
    @track ProcessItems;
    @track OwnerValue = '';
    @track modelRecord;
    @track models;
    @track error;
    @track isLoading = false;
    @track visibleSkinnCollectionRecords = false;
    @track visibleModelRecords = false;
    @track collectionTempRecord;
    @track childCompDesb = false;
    @track productLaunchDateParent;
    @track parentTentativeLaunchDate;

    @wire(getCollctionRecords) collectionRecords;

    handleChangeCollectionOwnerPickList(event){
        this.isLoading = true;
        if(event.target.name === 'Owner'){
            this.OwnerValue = event.target.value;
        }
        if(event.target.name === 'Collection'){
            this.CollectionValue = event.target.value;
        }
        if(this.CollectionValue !== '' ){
            this.visibleModelRecords = true;
            this.visibleSkinnCollectionRecords = false;
                ModelRecords( {
                    collectionId : this.CollectionValue
                }).then(result => {
                    this.models = result;
                }).catch(error => {
                    this.error = error;
                    this.showTostMessage(error.body.message);
                });
                this.isLoading = false;
                this.ProcessItems = [];
                
        } else {
            this.visibleModelRecords = false;
            this.isLoading = false;
        }
       
    }
    showTostMessage(message){
        const eventTost = new ShowToastEvent({
                        title: 'Error',
                        message: message,
                        variant: 'error',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(eventTost);
    }
    modelHandleClick(event){
        var selectModelInfo = this.models.filter((row) =>{
           return row.Id === event.target.name;
        });
        var launchDate = JSON.parse(JSON.stringify(selectModelInfo))[0].Product_Launch_Date__c;
        var tentativeDate = JSON.parse(JSON.stringify(selectModelInfo))[0].Skinn_Collection__r.Tentative_Launch_Date__c
        if(launchDate !== undefined){
            this.productLaunchDateParent = ""+launchDate.split("-")[2]+"-"+launchDate.split("-")[1]+"-"+launchDate.split("-")[0];
        } else {
            this.productLaunchDateParent = undefined;
        }
        if(tentativeDate !== undefined){
            this.parentTentativeLaunchDate = ""+tentativeDate.split("-")[2]+"-"+tentativeDate.split("-")[1]+"-"+tentativeDate.split("-")[0];
        } else {
            this.parentTentativeLaunchDate = undefined;
        }
        this.visibleSkinnCollectionRecords = true;
        this.isLoading = true;
        this.childCompDesb = true;
        
            skinnCollectiontempRecords({
                collectionId : this.CollectionValue,
                modelId : event.target.name,
                ownerId : this.OwnerValue
            }).then(result => {
                this.ProcessItems = result;
                this.isLoading = false;
                
            }).catch(error => {
                this.error = error;
                this.showTostMessage(error.body.message);
                this.isLoading = false;
            });
    }
}