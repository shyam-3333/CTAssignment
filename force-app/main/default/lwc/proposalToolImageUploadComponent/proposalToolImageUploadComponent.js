import { LightningElement, track, api } from 'lwc';
import contentVersionProcessToAttachments from '@salesforce/apex/ProposalToolProductFetchController.contentVersionProcessToAttachments';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ProposalToolImageUploadComponent extends LightningElement {

  @api recordId;
  @api selectedProductId;
  @track uploadedImages = [];
  get acceptedFormats() {
    return ['.pdf', '.png', '.jpg', '.jpeg'];
  }
  handleUploadFinished(event) {
    // Get the list of uploaded files
    let arrayOfFiles = [];
    const uploadedFiles = event.detail.files;
    let uploadedFileNames = '';
    for (let i = 0; i < uploadedFiles.length; i++) {
      uploadedFileNames += uploadedFiles[i].name + ', ';
      console.log(uploadedFiles[i]);
      let temp = uploadedFiles[i].documentId;
      //temp = temp.substring(0, temp.indexOf('.'));
      arrayOfFiles.push(temp);
      this.uploadedImages.push(uploadedFiles[i]);
    }
    console.log(uploadedFileNames);

    //alert(arrayOfFiles);
    contentVersionProcessToAttachments({ filesIds: arrayOfFiles, parentId: this.recordId, selectedProduct: this.selectedProductId })
      .then(result => {
        console.log('result-->' + result);

      })
      .catch(error => {

      });
    this.dispatchEvent(
      new ShowToastEvent({
        title: 'Success',
        message: uploadedFiles.length + ' Files uploaded Successfully: ' + uploadedFileNames,
        variant: 'success',
      }),
    );
  }

}