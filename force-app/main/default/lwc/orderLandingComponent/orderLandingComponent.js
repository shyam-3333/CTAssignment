/*Created By : KVP- Chakresh Verma
* Name : orderLandingComponent
* Created on : 25 Nov 2021
* Description : This Component is a Landing page of Proposal Tool Tab And Used to Select The Business Type Of the Titan Products and Pass the Filters Value Based On Business Type
*/
import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import fetchFitersData from '@salesforce/apex/Proposal_Tool_LandingPageController.fetchFiltersValues';
import titanLogo from '@salesforce/resourceUrl/ProposalLogo';
import titanEyewearLogo from '@salesforce/resourceUrl/ProposalToolEyewearThumbnail';
import titanWatchesLogo from '@salesforce/resourceUrl/ProposalToolWatchesThumbnail';
import titanJewelleryLogo from '@salesforce/resourceUrl/ProposalToolJewelleryThumbnail';

export default class OrderLandingComponent extends NavigationMixin(LightningElement)
{
  //Titan Main Logo from Static Resource
  propsalTitanLogo = titanLogo;
  //Eyewear Thumbnail Image from Static Resource
  propsaltitanEyewearLogo = titanEyewearLogo;
  //Eyewear Watches And Accessories Image from Static Resource
  propsaltitanWatchesLogo = titanWatchesLogo;
  //Eyewear Jewellery Image from Static Resource
  propsaltitanJewelleryLogo = titanJewelleryLogo;

  @track displayMainPage = true;
  @track displayProductListingPage = false;
  @track selectedValueFinal;
  @track filtersValueFinal = [];
  loadSpinner = false;

  //Method on Selecton Of Business Type And Call Child handleValueChange Method and Pass Parameters
  openProductPage(event) {
    this.loadSpinner = true;
    var selectedCategory = event.target.title;
    fetchFitersData({ selectedFilters: selectedCategory })
      .then(result => {
        this.selectedValueFinal = selectedCategory;
        this.filtersValueFinal = result;

        this.displayProductListingPage = true;
        this.displayMainPage = false;
        this.loadSpinner = false;

        const mainCall = this.template.querySelector("c-order-product-listing-component");
        mainCall.handleValueChange(selectedCategory, result);
      })
      .catch(error => {
        this.loadSpinner = false;

      })

  }

  //Method On Click Of Back Button Calling from Event from Child Product Listing Component
  fetchValue(event) {
    this.displayMainPage = true;
  }
}