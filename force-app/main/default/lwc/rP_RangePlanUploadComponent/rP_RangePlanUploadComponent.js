import { LightningElement, track, api } from 'lwc';
import fetchOrderId from '@salesforce/apex/DisplayOrderID.fetchOrderId';
import updateOrder from '@salesforce/apex/DisplayOrderID.updateOrder';
import saveFile from '@salesforce/apex/DisplayOrderID.saveFile';
import RangePlanMasterUploadFormat from '@salesforce/resourceUrl/RangePlanMasterUploadFormat';

export default class RP_RangePlanUploadComponent extends LightningElement {

@track isDialogVisible = false;
@track originalMessage;
@track displayMessage = 'Click on the \'Open Confirmation\' button to test the dialog.';

orderId = {
  'orderName':undefined,
  'orderId':undefined,
  'orderSourceType':undefined,
  'orderProductType':undefined,
  'orderExpectedArrival':undefined
}
@api recordId;
@track noRecordFound;
@track data;
@track expval;
@track editdata;
@track fileExtension = '';
@track fileName = '';
@track validationError = '';
@track nameOfFile = '';
@track showLoadingSpinner = false;
@track isTrue = true;
@track visible = false;  
@track value = '';
searchKey;
selectedRecords;
filesUploaded = [];
file;
fileContents;
fileReader;
content;
MAX_FILE_SIZE = 1500000;

connectedCallback(){
  var today = new Date();
  this.date=today.toISOString();
  console.log(today.toISOString())
}

handelSearchKey(event){ //Order Id search input
  this.searchKey = event.target.value;
}

SearchAccountHandler(){ //search button
  if(this.searchKey != null )
  {
    fetchOrderId({textkey: this.searchKey})
    .then(data =>
    {
      this.orderId = {
        'orderName':undefined,
        'orderId':undefined,
        'orderSourceType':undefined,
        'orderProductType':undefined,
        'orderExpectedArrival':undefined
      }

      this.orderId.orderName = data.orderName;
      this.orderId.orderId = data.orderId;
      this.orderId.orderSourceType = data.orderSourceType;
      this.orderId.orderProductType = data.orderProductType;
      this.orderId.orderExpectedArrival = data.orderExpectedArrival;
      this.orderId.orderTotalQuantity = data.orderTotalQuantity;
      this.orderId.orderTotalValue = data.orderTotalValue;
     
      console.log('data'+JSON.stringify(data));
  if(this.orderId.orderId == undefined || this.orderId.orderId == '' || this.orderId.orderId == null){
    this.noRecordFound = 'No record found';
    this.visible = false;
    this.validationError = ' ';
    this.isTrue = true;
    

  }else{
    this.noRecordFound = ' ';
    this.validationError = ' ';
    this.visible = true;
    this.isTrue = false;
    this.editdata = false;
    
  }
  
    })
}
  else if(this.searchKey == null){
    this.noRecordFound = 'Please enter Order Id';
    this.validationError = ' ';
    this.isTrue = true;
  }
}
 

changeOfSourceType(event){
  console.log(event.target.value);
  this.orderId.orderSourceType = event.target.value;
  console.log('this.orderId'+JSON.stringify(this.orderId));
}

changeOfProductType(event){
  console.log(event.target.value);
  this.orderId.orderProductType = event.target.value;
  console.log('this.orderId'+JSON.stringify(this.orderId));
}

changeOfExpectedArrival(event){
  console.log(event.target.value);
  this.orderId.orderExpectedArrival = event.target.value;
  if(this.orderId.orderExpectedArrival < this.date){
    console.log('Date-------->')
    this.template.querySelector('c-custom-toast-message-component').showToast('error','Expected Arrival Date should not be past date');
    //this.isTrue = true;
    this.expval =true;
  }
  else this.expval =false;
  
  console.log('this.orderId'+JSON.stringify(this.orderId));
}  

downloadCSV(event){ //CSV file download
  const resourcePath = RangePlanMasterUploadFormat;
  window.open(resourcePath,'_blank');
    return null;
}

handleedit(){
  if(this.searchKey == null){
    this.noRecordFound = 'Please enter Order Id';
  }
  else{
    this.editdata = true;
    this.visible = false;
    //this.isTrue = false;
  }
  
}

handleClick(event){     //save button
  this.showLoadingSpinner = true;
  console.log('this.orderId'+JSON.stringify(this.orderId));
  updateOrder({orderJSON: JSON.stringify(this.orderId)})
    .then(data => {
        this.template.querySelector('c-custom-toast-message-component').showToast('success','Record saved successfully');
        //this.isTrue = false;
        this.editdata = false;
        this.visible = true;
        this.showLoadingSpinner = false;
    })
  }

handleFilesChange(event){
  if(this.orderId.orderId == null || this.orderId.orderId == ''){
    this.validationError = 'Please search for Order Id before file upload';
    this.noRecordFound = ' ';
    this.fileName = ' ';
  }
  else if(event.target.files.length > 0){
    this.filesUploaded = event.target.files;
    this.fileName = event.target.files[0].name;
    this.nameOfFile = event.target.files[0].name;
    this.validationError = ' ';
    this.template.querySelector('c-custom-toast-message-component').showToast('info', 'Please click on Upload CSV File button to upload the selected file');
  } 
}

handleSave(){
  if(this.orderId.orderId == undefined || this.orderId == '' || this.orderId == null){
    this.validationError = 'Please search for Order Id before file upload';
    this.fileName = ' ';
  }
  else if((this.orderId.orderId != undefined || this.orderId != '' || this.orderId != null) && this.filesUploaded.length > 0) {
    this.uploadHelper(); 
  }
  else{
  this.validationError = 'Please select a CSV file to upload';
  this.fileName = ' ';
}
}

uploadHelper(){
  this.file = this.filesUploaded[0]; 
    if (this.file.size > this.MAX_FILE_SIZE) {
      this.template.querySelector('c-custom-toast-message-component').showToast('error', 'File size is too large.');
    return ; 
    }
  this.showLoadingSpinner = true;
  this.fileReader= new FileReader();
  this.fileReader.onloadend = (() => {
  this.fileContents = this.fileReader.result;
  this.saveToFile();
  });
  this.fileReader.readAsText(this.file);
} 

saveToFile(){
  saveFile({ base64Data: JSON.stringify(this.fileContents), cdbId: this.recordid, order_Id: this.orderId.orderId,nameOfFile:this.nameOfFile})
    .then(result => {
      if(result ==''){
        window.console.log('result ====> ');
        window.console.log(result);
        this.template.querySelector('c-custom-toast-message-component').showToast('success', this.fileName + ' - Uploaded Successfully');
        this.validationError = ' '; 
        this.showLoadingSpinner = false;
        this.filesUploaded = [];//make fileuploaded array as empty after one file upload
        //var passid = window.location.href.substring(window.location.href.lastIndexOf('/') + 1);
         window.location.href ='https://titanlightningapps.my.salesforce.com/'+this.orderId.orderId;
      }
      else{
        this.showLoadingSpinner = false;
        window.console.log('result ====> ');
        window.console.log(result);
      if(result =='Please upload CSV in the format given below(Extra header)'){
        this.validationError = result;
        this.fileName = ' ';
      }
      else if(result =='Please upload CSV in the format given below(Missing header)'){
        this.validationError = result;
        this.fileName = ' ';
      }
      else if(result =='Please upload CSV in the format given below (Header sequence incorrect)'){
      this.validationError = result;
      this.fileName = ' ';
      } 
      else{
        this.validationError = ' ';
        this.originalMessage = result.split(',');
        this.isDialogVisible = true;
        this.fileName = ' ';
    }
    this.filesUploaded = [];
  }   
})

.catch(error => {
  window.console.log(error);
    this.validationError = 'File is improper';
    this.fileName = ' ';
    this.template.querySelector('c-custom-toast-message-component').showToast('warning', 'Please check the file you have selected.');
    this.showLoadingSpinner = false;
  }); 
}
get options() {
    return [
             { label: 'Saree', value: 'Saree' },
             { label: 'Stole', value: 'Stole' },
             { label: 'Dupatta', value: 'Dupatta' },
             { label: 'Yardage', value: 'Yardage' },
             { label: 'Shawl', value: 'Shawl' },
             { label: 'Scarf', value: 'Scarf' },
             { label: 'Multi Piece Saree', value: 'Multi Piece Saree' },
             { label: 'Pavadai', value: 'Pavadai' },
             { label: 'USKD', value: 'USKD' },
             { label: 'SSKD', value: 'SSKD' }
           ];
}
handleChange(event) {
    //hides the component
    this.isDialogVisible = false;
 }
 navigateToListView() {
  // Navigate to the Contact object's Recent list view.
  this[NavigationMixin.Navigate]({
      type: 'standard__objectPage',
      attributes: {
          objectApiName: 'RangePlan_Master__c',
          actionName: 'list'
      },
      state: {
          // 'filterName' is a property on the page 'state'
          // and identifies the target list view.
          // It may also be an 18 character list view id.
          filterName: 'Recent' // or by 18 char '00BT0000002TONQMA4'
      }
  });
}

}