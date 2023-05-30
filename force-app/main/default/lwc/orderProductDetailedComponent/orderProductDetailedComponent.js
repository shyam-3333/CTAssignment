/*Created By : KVP- Chakresh Verma
* Name : orderProductDetailedComponent
* Created on : 25 Nov 2021
* Description : This Component is used to Show the Product Details and Multiple Images Of the Selected Product
*/

import { LightningElement, api, track } from 'lwc';
import fetchProductDetail from '@salesforce/apex/ProposalProductDetailFetch.fetchProductDetail'

export default class OrderProductDetailedComponent extends LightningElement {
  slides = []
  slideIndex = 1
  @api slidesData;
  @api selectedProductId;
  @api hidePrice;
  @track detailsOfProduct = [];

  //Calling Method On Page Load for Fetching the Detials Of the Selected Product
  connectedCallback() {
    fetchProductDetail({ productId: this.selectedProductId, hidePriceFromDetail: this.hidePrice })
      .then(result => {
        this.detailsOfProduct = result;
      })
      .catch(error => {

      });
  }

  //Method For Redirect on the Full View Of The Image in New Tab(On Click Of Image Div)
  goToImagesFullView(event) {
    var imageURL = event.target.src;
    window.open(imageURL, '_blank');
  }
}