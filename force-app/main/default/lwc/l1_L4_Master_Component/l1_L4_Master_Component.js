import { LightningElement , track, api} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import L1L5MasterUploadFormat from '@salesforce/resourceUrl/L1L5MasterUploadFormat';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import csvFileRead from '@salesforce/apex/L1_L4_Master_Insert.csvFileRead';
import deleteCSVdata from '@salesforce/apex/L1_L4_Master_Insert.deleteCSVdata';
import precedenceCheck from '@salesforce/apex/L1_L4_Master_Insert.precedenceCheck';
export default class L1_L4_Master_Component extends LightningElement {
@track isDialogVisible = false;
@track originalMessage;
@track displayMessage = 'Click on the \'Open Confirmation\' button to test the dialog.';
@api recordid;
@track loaded = true ;
@track isModalOpen = false;
@track data;
@track showmessage;
@track message;
@track errormessage;
@track fileName = '';
@track UploadFile = 'Upload';
textValue = 'Please click on Upload button to upload the selected file!!!';
filesUploaded = [];
file;
fileContents;
fileReader;
content;
MAX_FILE_SIZE =  5000000;

downloadCSV(event){
const resourcePath = L1L5MasterUploadFormat;
window.open(resourcePath,'_blank');
return null;
}
connectedCallback(){
    this.accountHomePageRef = {
        type: 'standard__navItemPage',
           attributes: {
               apiName: this.L1_L5_Mapping_Summary,
        }
    };
}

uploadFileHandler(event) {
if(event.target.files.length > 0 ) {
this.filesUploaded = event.target.files;
this.errormessage = '';
this.fileName = 'Selected file - '+ event.target.files[0].name;
}

this.template.querySelector('c-custom-toast-message-component').showToast('info', 'Please click on the upload button to upload the selected file.');

}
uploadFileHandlerforDelete(event){
if(event.target.files.length > 0 ) {
    this.filesUploaded = event.target.files;
    this.errormessage = '';
    
    this.showmessage = 'Selected file - '+ event.target.files[0].name;
    }
    this.template.querySelector('c-custom-toast-message-component').showToast('info', 'Please click on the delete button to delete the selected file.');
}

handleSave() {
if(this.filesUploaded.length > 0) {
this.loaded = false;
this.uploadHelper();

}
else {
this.template.querySelector('c-custom-toast-message-component').showToast('error', 'Please select CSV file to upload.');
}
}
handledelete() {   
    if(this.filesUploaded.length > 0) {   
    this.loaded = false;
    this.uploadHelperfordelete();
    
    }
    else {
    this.template.querySelector('c-custom-toast-message-component').showToast('error', 'Please select CSV file to delete.');
    }
    }
uploadHelper() {
this.file = this.filesUploaded[0];
if (this.file.size > this.MAX_FILE_SIZE) {
    this.template.querySelector('c-custom-toast-message-component').showToast('error', 'File size is too large.');
return ;
}
this.fileReader= new FileReader();
this.fileReader.onloadend = (() => {
this.fileContents = this.fileReader.result;
    this.saveToFile();
});
this.fileReader.readAsText(this.file);
}
uploadHelperfordelete() {
    console.log(this.savevar);
    console.log(this.deletevar);
this.file = this.filesUploaded[0];
if (this.file.size > this.MAX_FILE_SIZE) {
    this.template.querySelector('c-custom-toast-message-component').showToast('error', 'File size is too large.');
return ;
}
this.fileReader= new FileReader();
this.fileReader.onloadend = (() => {
this.fileContents = this.fileReader.result;
    this.Deletefiledata();
});
this.fileReader.readAsText(this.file);
}
saveToFile() {
precedenceCheck({ base64Data: JSON.stringify(this.fileContents)})
.then(result => {
    if(result == 'Below shown precedence is already exists in salesforce'){
        this.loaded = true;
        this.isModalOpen = true;  
    }
   else if(result ==''){
        this.loaded = true;
        this.isModalOpen = false;
        window.console.log('result ====> ');
        window.console.log(result);
        this.template.querySelector('c-custom-toast-message-component').showToast('success', 'File Uploaded Successfully !');
        this.filesUploaded = 0;
        this.fileName = '';
        window.location.href = 'https://titanlightningapps.my.salesforce.com/a4f';
    }
    else{
        this.loaded = true;
window.console.log('result ====> ');
window.console.log(result);
//this.template.querySelector('c-custom-toast-message-component').showToast('warning','' +result);
this.filesUploaded = 0;
this.isModalOpen = false;
    this.originalMessage = result.split(',');
    this.isDialogVisible = true;
    this.fileName = ' ';
    }
})
.catch(error => {
window.console.log(error);
this.fileName = 'File is incorrect';
this.loaded = true;
this.template.querySelector('c-custom-toast-message-component').showToast('warning', 'Please check the file you have selected !');
});
}
handleClick(event){
    //hides the component
    this.isDialogVisible = false;
}

viewReport( event ) {
    window.location.href = window.open('https://titanlightningapps.my.salesforce.com/00O5Y00000BoGFXUA3')  ;

}
Deletefiledata(){
    console.log(this.fileContents);
    deleteCSVdata({ base64Data: JSON.stringify(this.fileContents)}) 
.then(result => {  
    if(result ==''){
        this.loaded = true;
        window.console.log('result ====> ');
        window.console.log(result);
        this.template.querySelector('c-custom-toast-message-component').showToast('success', 'The records have been deleted successfully!');
        this.filesUploaded = 0;
        this.showmessage = '';
           }
    else{
        this.loaded = true;
        this.originalMessage = result.split(',');
        this.isDialogVisible = true;
        this.fileName = ' ';
window.console.log('result ====> ');
window.console.log(result);
//this.template.querySelector('c-custom-toast-message-component').showToast('warning','' +result);
//this.template.querySelector('c-custom-toast-message-component').showToast('warning','' +result);
this.filesUploaded = 0;
//this.errormessage = result;
this.showmessage = '';
    }
})

.catch(error => {
window.console.log(error);
this.showmessage = 'File is incorrect';
this.loaded = true;
this.template.querySelector('c-custom-toast-message-component').showToast('warning', 'Please check the file you have selected !');
});
}
handleyes(){
    csvFileRead({ base64Data: JSON.stringify(this.fileContents)})
    .then(result => {
        if(result ==''){
            this.loaded = true;
            this.isModalOpen = false;
            window.console.log('result ====> ');
            window.console.log(result);
            this.template.querySelector('c-custom-toast-message-component').showToast('success', 'File Uploaded Successfully !');
            this.filesUploaded = 0;
            this.fileName = '';
            window.location.href = 'https://titanlightningapps.my.salesforce.com/a4f';
        }
        else{
            this.loaded = true;
    window.console.log('result ====> ');
    window.console.log(result);
    //this.template.querySelector('c-custom-toast-message-component').showToast('warning','' +result);
    this.filesUploaded = 0;
    this.isModalOpen = false;

        this.originalMessage = result.split(',');
        this.isDialogVisible = true;
        this.fileName = ' ';
        
      
    this.fileName ='';
        }
    })
    
    .catch(error => {
    window.console.log(error);
    this.fileName = 'File is incorrect';
    this.loaded = true;
    
    this.template.querySelector('c-custom-toast-message-component').showToast('warning', 'Please check the file you have selected !');
    });
    }

handleno(){
    this.isModalOpen = false;
}
}