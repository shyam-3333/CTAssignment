import { LightningElement, wire, api, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { deleteRecord } from 'lightning/uiRecordApi';
import getL1L5Master from '@salesforce/apex/RP_L1L5EditDeleteComponentController.getL1L5Master';
//import delSelectedRec from '@salesforce/apex/RP_L1L5EditDeleteComponentController.deleteMaster';
import deleteL1L5Master from '@salesforce/apex/RP_L1L5EditDeleteComponentController.deleteL1L5Master';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    {
        label: 'Name',
        fieldName: 'nameUrl',
        type: 'url',
        typeAttributes: {label: { fieldName: 'name' }, target: '_blank'}
    },
    { label: 'Rule No', fieldName: 'ruleNo', type: 'text',editable :false },
    { label: 'Product Catergory 1', fieldName: 'productCategory1', type: 'text',editable :false },
    { label: 'Product Catergory 1 Value', fieldName: 'productCategoryValue1', type: 'text',editable :false },

    { label: 'Product Catergory 2', fieldName: 'productCategory2', type: 'text',editable :false },
    { label: 'Product Catergory 2 Value', fieldName: 'productCategoryValue2', type: 'text',editable :false },

    { label: 'Product Catergory 3', fieldName: 'productCategory3', type: 'text',editable :false },
    { label: 'Product Catergory 3 Value', fieldName: 'productCategoryValue3', type: 'text',editable :false },

    { label: 'Product Catergory 4', fieldName: 'productCategory4', type: 'text',editable :false },
    { label: 'Product Catergory 4 Value', fieldName: 'productCategoryValue4', type: 'text',editable :false} ,
    { label: 'L1', fieldName: 'l1', type: 'text',editable :false },
    { label: 'L2', fieldName: 'l2', type: 'text',editable :false },

    { label: 'L3', fieldName: 'l3', type: 'text',editable :false},

    { label: 'L4', fieldName: 'l4', type: 'text',editable :false },
    { label: 'L5', fieldName: 'l5', type: 'text',editable :false },
    { label: 'Active', fieldName: 'active',type:'boolean',editable :false },
    

 ];

export default class L1L5EditDeleteComponent extends LightningElement {
   
@track selection;
    @track loader = false;
    @api recordId;
    @track isModalOpen = false;
    @track value;
    @track error;
    @track data;
    @track Name;
    @track selected;
    @api sortedDirection = 'asc';
    @api sortedBy = 'Name';
    searchKey;
    result;
    @track allSelectedRows =[];
    @track page = 1;
    items = [];
    @track data = [];
    @track columns;
    @track startingRecord = 1;
    @track endingRecord = 0;
    @track pageSize = '100';
    @track totalRecountCount = 0;
    @track totalPage = 0;
    isPageChanged = false;
    initialLoad = true;
    mapAccount = new Map();

    records;
    wiredRecords;
    error;
    columns = columns;
    draftValues = [];
    

    selectedRecords = [];

    allRecords = [];
    numberOfRecordsSelected = 0;

    get options() {
        return [
            { label: '5', value: '5' },
            { label: '10', value: '10' },
            { label: '15', value: '15' },
        ];
    }


    connectedCallback(){
        console.log('In connected call back function....');
        this.loader = true;

        getL1L5Master()
        .then((result) => {
            //this.wiredRecords = result;
            this.allRecords = result;
            this.loader = false;
            this.processRecords(result);
            this.error = undefined;
            if(this.selected == true){
            this.template.querySelector('c-custom-toast-message-component').showToast('success', 'Record deleted successfully.');
            }
        })
        .catch((error) => {
            this.loader = false;
            this.error = error;
            this.data = undefined;
        });
    }
    /*handelSearchKey(event){ //Order Id search input
        this.searchKey = event.target.value;
      }
    searchMasterdata(){
        serachData({searchKeyword: this.searchKey})
        .then(result => {
                this.data = result;
                console.log(this.data);
        })
      }*/
    closeModal(){
        this.isModalOpen = false;
    }
    showPopup(){
        this.countSelectedRecords();
       // console.log( this.selected);
        if( this.numberOfRecordsSelected > 0){
            this.isModalOpen = true; 
            for(var key in this.items){
                console.log(this.items[key].isDelete);
                if(this.items[key].isDelete){
                    console.log(this.items[key]);
                    if(!this.allSelectedRows.includes(this.items[key])){
                        this.allSelectedRows.push(this.items[key]);
                    }
                 console.log(this.allSelectedRows.length);
                }                
            }
        }
        else{
            this.template.querySelector('c-custom-toast-message-component').showToast('info', 'Please select record to delete.');
        }    
    }
    processRecords(data) {
        this.items = data;     
        this.totalRecountCount = data.length;
        this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
        this.data = this.items.slice(0, this.pageSize);
        this.endingRecord = this.pageSize;
        this.columns = columns;
    }
    

    //clicking on previous button this method will be called
    previousHandler() {
        this.isPageChanged = true;
        if (this.page > 1) {
            this.page = this.page - 1; //decrease page by 1
            this.displayRecordPerPage(this.page);
        }
       
    }

    //clicking on next button this method will be called
    nextHandler() {
        this.isPageChanged = true;
        if ((this.page < this.totalPage) && this.page !== this.totalPage) {
            this.page = this.page + 1; //increase page by 1
            this.displayRecordPerPage(this.page);
        }
    }
    

    //Method to displays records page by page
    displayRecordPerPage(page) {
        this.startingRecord = ((page - 1) * this.pageSize);
        this.endingRecord = (this.pageSize * page);
        this.endingRecord = (this.endingRecord > this.totalRecountCount) ? this.totalRecountCount : this.endingRecord;
        this.data = this.items.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord + 1;
    }


    
    handleSelect(event){
        this.data[event.currentTarget.dataset.index].isDelete = event.target.checked;
        console.log('Data-->'+JSON.stringify(this.data));
       // this.selected = this.data[event.currentTarget.dataset.index].isDelete;
          //  console.log( this.selected);
        for(var key in this.items){
            if(this.items[key].recordId == this.data[event.currentTarget.dataset.index].recordId){
                    console.log('Coming'+this.items[key].recordId);
                    this.items[key].isDelete = event.target.checked;
                    console.log(this.items[key]);                 
                }
            }          
        }

    countSelectedRecords(){
        this.numberOfRecordsSelected = 0;
        for(var key in this.items){
            if(this.items[key].isDelete){
                this.numberOfRecordsSelected++;
            }
        }
    }    

    handleDelete(){
        let dataToDelete = [];
        for(var key in this.items){
            if(this.items[key].isDelete){
                dataToDelete.push(this.items[key]);
            }
        }
        deleteL1L5Master({'jsonData' : JSON.stringify(dataToDelete)})
        .then((result) => {
             //this.wiredRecords = result;
            this.connectedCallback();
            this.isModalOpen = false;
            this.allSelectedRows = [];
            this.selected = true;
            //this.template.querySelector('c-custom-toast-message-component').showToast('success', 'Record deleted successfully.');
           console.log('Calles'+result);
        })
        .catch((error) => {
            
        });
        }
 }