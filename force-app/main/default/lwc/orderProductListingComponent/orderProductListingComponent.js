import { LightningElement, api, track } from 'lwc';
import fetchProducts from '@salesforce/apex/ProposalToolProductFetchController.fetchProducts'
import generateProposal from '@salesforce/apex/ProposalToolProductFetchController.generateProposal'
import createImageUniqueRecord from '@salesforce/apex/ProposalToolProductFetchController.createImageUniqueRecord'
import emptyCart from '@salesforce/resourceUrl/ProposalEmptyCartLogo';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class OrderProductListingComponent extends NavigationMixin(LightningElement) {
  emptyCartURL = emptyCart;
  //Public Variables from Main Page
  @api selectedValue;
  @api filtersValue;

  isSpinner = false;


  //Cart Images
  uniqueKey = '';
  @track proposalCustomImageId = '';



  //Hiding Main Data
  @track openHideMainPage = true;

  @track hideShowPrice = true;

  @track hidePriceData = false;

  @track hidePriceFromCart = true;


  //Cart Relaited
  selectedProductForCart;
  @track productAddedForCart = [];
  objectOfProductToCart;
  cartSize = 0;
  @track selectedOpportunityId = '';


  //Main Data For product
  mainProductData = [];

  filtersValues = [];


  //Variable for Filters Creation
  productCategoryValues = [];
  genderValues = [];
  colorValues = [];
  productBrandValueToShow = [];
  priceFiltersValues = [];

  //Variables for Selected Filters
  @track searchValue = '';
  genderSelectedvalue = [];
  colorSelectedValue = [];
  brandSelectedValue = [];
  productCategorySelectedvalue = '';
  @track selectedPriceFilterValue = '';
  @track selectedSortValue = '';


  //Bag Filters

  bagType = [];
  bagMaterialBody = [];
  bagMaterialLining = [];
  bagClosureType = [];
  bagGender = [];
  bagBrand = [];
  bagColor = [];
  bagCollection = [];
  bagOccassion = [];

  //Belt Filters
  beltType = [];
  beltGender = [];
  beltBrand = [];
  beltColor = [];
  beltDressCode = [];
  beltLength = [];

  //Wallet Filters
  walletType = [];
  walletGender = [];
  walletBrand = [];
  walletColor = [];
  walletDressCode = [];

  //Fragrances Filters
  fragranceType = [];
  fragranceGender = [];
  fragranceBrand = [];
  fragranceFamily = [];
  fragranceCollection = [];
  fragranceQuantity = [];

  //EarPhone Filters
  earPhoneGender = [];
  earPhoneBrand = [];
  earPhoneColor = [];
  earPhoneCollection = [];

  //Clocks Filters
  clockGender = [];
  clockBrand = [];
  clockColor = [];
  clockCollection = [];
  clockFunction = [];

  //Sunglasses Filters
  sunglassGender = [];
  sunglassBrand = [];
  sunglassColor = [];
  sunglassCollection = [];


  //Watches Filters
  watchGender = [];
  watchBrand = [];
  watchStrapColor = [];
  watchStrapMaterial = [];
  watchDialColor = [];
  watchCollection = [];
  watchMovements = [];

  //Eyewear Filters 
  //Sunglasses Eyewera Filters
  sunglassEyewearGender = [];
  sunglassEyewearRIM = [];
  sunglassEyewearBrand = [];
  sunglassEyewearCategory = [];
  sunglassEyewearShape = [];
  sunglassEyewearFrameMaterial = [];
  sunglassEyewearLensColour = [];
  sunglassEyewearSize = [];
  sunglassEyewearColour = [];
  sunglassEyewearCollection = [];






  //Selected Bag Filters Values
  selectedBagType = [];
  selectedBagMaterialBody = [];
  selectedBagMaterialLining = [];
  selectedBagClosureType = [];
  selectedBagGender = [];
  selectedBagBrand = [];
  selectedBagColor = [];
  selectedBagCollection = [];
  selectedBagOccassion = [];

  //Selected Belt Filters Values
  selectedBeltType = [];
  selectedBeltGender = [];
  selectedBeltBrand = [];
  selectedBeltColor = [];
  selectedBeltDressCode = [];
  selectedBeltLength = [];

  //Selected Wallet Filters Values
  selectedWalletType = [];
  selectedWalletGender = [];
  selectedWalletBrand = [];
  selectedWalletColor = [];
  selectedWalletDressCode = [];

  //Selected Fragrances Filters Values
  selectedFragranceType = [];
  selectedFragranceGender = [];
  selectedFragranceBrand = [];
  selectedFragranceFamily = [];
  selectedFragranceCollection = [];
  selectedFragranceQuantity = [];

  //Selected Earphone Filters Values
  selectedEarPhoneGender = [];
  selectedEarPhoneBrand = [];
  selectedEarPhoneColor = [];
  selectedEarPhoneCollection = [];

  //Selected Clock Filters Values
  selectedClockGender = [];
  selectedClockBrand = [];
  selectedClockColor = [];
  selectedClockCollection = [];
  selectedClockFunction = [];

  //Selected Sunglasses Filters Values
  selectedSunglassGender = [];
  selectedSunglassBrand = [];
  selectedSunglassColor = [];
  selectedSunglassCollection = [];


  //Selected Watches Filters Values
  selectedWatchGender = [];
  selectedWatchBrand = [];
  selectedWatchStrapColor = [];
  selectedWatchStrapMaterial = [];
  selectedWatchDialColor = [];
  selectedWatchCollection = [];
  selectedWatchMovements = [];

  //Eyewear Filters 

  //Sunglasses Eyewera Filters
  selectedSunglassEyewearGender = [];
  selectedSunglassEyewearRIM = [];
  selectedSunglassEyewearBrand = [];
  selectedSunglassEyewearCategory = [];
  selectedSunglassEyewearShape = [];
  selectedSunglassEyewearFrameMaterial = [];
  selectedSunglassEyewearLensColour = [];
  selectedSunglassEyewearSize = [];
  selectedSunglassEyewearColour = [];
  selectedSunglassEyewearCollection = [];



  //HideShowDynamicFilters
  dynamicFiltersHideShow = {
    'isBagType': false,
    'isBeltType': false,
    'isWalletType': false,
    'isFragranceType': false,
    'isEarphoneType': false,
    'isClockType': false,
    'isSunGlasseType': false,
    'isWatchType': false,
    'isEyewearSunglasses': false
  }







  //Pagination Track Variables
  @track data = [];
  @track error;
  @track loader = false;
  @track pageSize = 60;
  @track pageNumber = 1;
  @track totalRecords = 0;
  @track totalPages = 0;
  @track recordEnd = 0;
  @track recordStart = 0;
  @track isPrev = true;
  @track isNext = true;

  //Product Slides Values in Detail Page
  productSlides = [];
  selectedProductIdForDetailPage = '';

  //order Summary
  orderSummary = {
    'totalItems': 0,
    'totalPrice': 0,
    'totalDiscount': 0,
    'totalOrderValue': 0,
    'totalQuantity': 0
  }

  filtersHideShow = {
    'gender': true,
    'color': true,
    'category': true,
    'brand': true,
    'price': true
  }



  @track isModalOpen = false;
  @track openCart = false;


  @api recordsPerPage = 5;

  @track accounts = [];
  @track selectedRecords = [];

  elements = [];
  dataMap = [];
  count = 0;
  accName;


  @track quantityValue = 0;

  offsetTopValue = 0;

  customProductHeightAndWidth = '';

  /*async connectedCallback() {
    this.filterCreation();
    await this.fetchProducts();
  }*/

  @api handleValueChange(testValue, filter) {
    if (testValue == 'Eyewear') {
      this.filtersHideShow.gender = false;
      this.filtersHideShow.color = false;
      this.filtersHideShow.brand = false;
      this.filtersHideShow.price = true;
      this.customProductHeightAndWidth = 'customEyewear';

    } else if (testValue == 'Watches') {
      this.filtersHideShow.gender = false;
      this.filtersHideShow.color = false;
      this.filtersHideShow.price = true;
      this.filtersHideShow.brand = false;
      this.customProductHeightAndWidth = 'customWatchAndJewellery';


    } else if (testValue == 'Jewellery') {
      this.filtersHideShow.gender = false;
      this.filtersHideShow.color = true;
      this.filtersHideShow.brand = true;
      this.filtersHideShow.price = true;
      this.customProductHeightAndWidth = 'customWatchAndJewellery';

    }

    this.selectedValue = testValue;
    this.filtersValue = filter;
    this.productCategorySelectedvalue = 'All';
    this.filterCreation();
    this.fetchProducts();
    var divblock = this.template.querySelector('[data-id="divblock"]');
    if (divblock) {
      this.template.querySelector('[data-id="divblock"]').className = 'slds-show';
    }

  }


  fetchProducts() {
    this.loader = true;
    let wrapperObject;
    wrapperObject = {
      'selectedValue': this.selectedValue,
      'pageSize': this.pageSize,
      'pageNumber': this.pageNumber,
      'searchName': this.searchValue,
      'selectedGender': this.genderSelectedvalue,
      'selectedColor': this.colorSelectedValue,
      'selectedProductCategory': this.productCategorySelectedvalue,
      'selectedBrand': this.brandSelectedValue,
      'sortBy': this.selectedSortValue,
      'selectedPriceValue': this.selectedPriceFilterValue,
      'selectedBagTypeData': this.selectedBagType,
      'selectedBagMaterialBodyData': this.selectedBagMaterialBody,
      'selectedBagMaterialLiningData': this.selectedBagMaterialLining,
      'selectedBagClosureTypeData': this.selectedBagClosureType,
      'selectedBagGenderData': this.selectedBagGender,
      'selectedBagBrandData': this.selectedBagBrand,
      'selectedBagColorData': this.selectedBagColor,
      'selectedBagCollectionData': this.selectedBagCollection,
      'selectedBagOccassionData': this.selectedBagOccassion,
      'selectedBeltTypeData': this.selectedBeltType,
      'selectedBeltGenderData': this.selectedBeltGender,
      'selectedBeltBrandData': this.selectedBeltBrand,
      'selectedBeltColorData': this.selectedBeltColor,
      'selectedBeltDressCodeData': this.selectedBeltDressCode,
      'selectedBeltLengthData': this.selectedBeltLength,
      'selectedWalletTypeData': this.selectedWalletType,
      'selectedWalletGenderData': this.selectedWalletGender,
      'selectedWalletBrandData': this.selectedWalletBrand,
      'selectedWalletColorData': this.selectedWalletColor,
      'selectedWalletDressCodeData': this.selectedWalletDressCode,
      'selectedFragranceTypeData': this.selectedFragranceType,
      'selectedFragranceGenderData': this.selectedFragranceGender,
      'selectedFragranceBrandData': this.selectedFragranceBrand,
      'selectedFragranceFamilyData': this.selectedFragranceFamily,
      'selectedFragranceCollectionData': this.selectedFragranceCollection,
      'selectedFragranceQuantityData': this.selectedFragranceQuantity,
      'selectedEarPhoneGenderData': this.selectedEarPhoneGender,
      'selectedEarPhoneBrandData': this.selectedEarPhoneBrand,
      'selectedEarPhoneColorData': this.selectedEarPhoneColor,
      'selectedEarPhoneCollectionData': this.selectedEarPhoneCollection,
      'selectedClockGenderData': this.selectedClockGender,
      'selectedClockBrandData': this.selectedClockBrand,
      'selectedClockColorData': this.selectedClockColor,
      'selectedClockCollectionData': this.selectedClockCollection,
      'selectedClockFunctionData': this.selectedClockFunction,
      'selectedSunglassGenderData': this.selectedSunglassGender,
      'selectedSunglassBrandData': this.selectedSunglassBrand,
      'selectedSunglassColorData': this.selectedSunglassColor,
      'selectedSunglassCollectionData': this.selectedSunglassCollection,
      'selectedWatchGenderData': this.selectedWatchGender,
      'selectedWatchBrandData': this.selectedWatchBrand,
      'selectedWatchStrapColorData': this.selectedWatchStrapColor,
      'selectedWatchStrapMaterialData': this.selectedWatchStrapMaterial,
      'selectedWatchDialColorData': this.selectedWatchDialColor,
      'selectedWatchCollectionData': this.selectedWatchCollection,
      'selectedWatchMovementsData': this.selectedWatchMovements,
      'selectedSunglassEyewearGenderData': this.selectedSunglassEyewearGender,
      'selectedSunglassEyewearRIMData': this.selectedSunglassEyewearRIM,
      'selectedSunglassEyewearBrandData': this.selectedSunglassEyewearBrand,
      'selectedSunglassEyewearCategoryData': this.selectedSunglassEyewearCategory,
      'selectedSunglassEyewearShapeData': this.selectedSunglassEyewearShape,
      'selectedSunglassEyewearFrameMaterialData': this.selectedSunglassEyewearFrameMaterial,
      'selectedSunglassEyewearLensColourData': this.selectedSunglassEyewearLensColour,
      'selectedSunglassEyewearSizeData': this.selectedSunglassEyewearSize,
      'selectedSunglassEyewearColourData': this.selectedSunglassEyewearColour,
      'selectedSunglassEyewearCollectionData': this.selectedSunglassEyewearCollection
    };

    console.log('this.selectedValue-->' + this.selectedValue);
    console.log('this.pageSize-->' + this.pageSize);
    console.log('JSON.stringify(wrapperObject)-->' + JSON.stringify(wrapperObject));

    fetchProducts({ selectedValue: this.selectedValue, pageSize: this.pageSize, pageNumber: this.pageNumber, wrapperObject: JSON.stringify(wrapperObject) })
      .then(result => {
        this.loader = false
        //console.log('filtersValue-->', this.filtersValue);
        this.error = undefined;
        var resultData = JSON.parse(result);
        this.data = resultData.productWrapper;
        this.mainProductData = resultData.productWrapper;
        this.pageNumber = resultData.pageNumber;
        this.totalRecords = resultData.totalRecords;
        this.recordStart = resultData.recordStart;
        this.recordEnd = resultData.recordEnd;
        this.totalPages = Math.ceil(resultData.totalRecords / this.pageSize);
        this.isNext = (this.pageNumber == this.totalPages || this.totalPages == 0);
        this.isPrev = (this.pageNumber == 1 || this.totalRecords < this.pageSize);
        console.log(this.data.length);
        console.log('Data-->' + JSON.stringify(this.data));

        if (this.uniqueKey == '') {
          this.uniqueKey = (Date.now().toString(36) + Math.random().toString(36).substr(2, 5)).toUpperCase();
          console.log('uniqueKey--->' + this.uniqueKey);
        }

      })
      .catch(error => {
        this.error = error;
        this.loader = false;

      });

  }


  //handle next
  handleNext() {
    this.pageNumber = this.pageNumber + 1;
    this.fetchProducts();
    let scrollOptions = {
      left: 0,
      top: 0,
      behavior: 'auto'
    }
    window.scrollTo(scrollOptions);
  }

  //handle prev
  handlePrev() {
    this.pageNumber = this.pageNumber - 1;
    this.fetchProducts();


    let scrollOptions = {
      left: 0,
      top: 0,
      behavior: 'auto'
    }
    window.scrollTo(scrollOptions);
  }


  //display no records
  get isDisplayNoRecords() {
    var isDisplay = true;
    if (this.data) {
      if (this.data.length == 0) {
        isDisplay = true;
      } else {
        isDisplay = false;
      }
    }
    return isDisplay;
  }


  //display no records
  get isCartIsEmpty() {
    var isDisplayCart = true;
    if (this.productAddedForCart) {
      if (this.cartSize == 0) {
        isDisplayCart = true;
      } else {
        isDisplayCart = false;
      }
    }
    return isDisplayCart;
  }
  //Search By Name of Product
  handleChangeSearchValue(event) {
    this.searchValue = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();

  }

  //Gender Filters Function
  handleChangeGenderFilters(event) {
    this.genderSelectedvalue = event.detail.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  //Colors Filters Function
  handleChangeColorFilters(event) {
    this.colorSelectedValue = event.detail.value
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleChangeBrandFilters(event) {
    this.brandSelectedValue = event.detail.value
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  //Product Category Filters Function
  handleChangeProductCategory(event) {
    this.productCategorySelectedvalue = event.detail.value
    let productType = event.detail.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
    if (productType == 'Bags') {
      this.dynamicFiltersHideShow.isBagType = true;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;

      this.clearDynamicFilters();

    } else if (productType == 'Belts') {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = true;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;

      this.clearDynamicFilters();

    } else if (productType == 'Wallets') {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = true;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;

      this.clearDynamicFilters();

    } else if (productType == 'Fragrances') {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = true;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;

      this.clearDynamicFilters();

    } else if (productType == 'Earphones') {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = true;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;

      this.clearDynamicFilters();

    } else if (productType == 'Clocks') {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = true;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;

      this.clearDynamicFilters();

    } else if (productType == 'Sunglasses' && this.selectedValue == 'Watches') {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = true;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;

      this.clearDynamicFilters();

    } else if (productType == 'Watches') {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = true;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;

      this.clearDynamicFilters();

    } else if (productType == 'Sunglasses' && this.selectedValue == 'Eyewear') {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = true;

      this.clearDynamicFilters();

    } else if (productType == 'All') {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;

      this.clearDynamicFilters();

    } else {
      this.dynamicFiltersHideShow.isBagType = false;
      this.dynamicFiltersHideShow.isBeltType = false;
      this.dynamicFiltersHideShow.isWalletType = false;
      this.dynamicFiltersHideShow.isFragranceType = false;
      this.dynamicFiltersHideShow.isEarphoneType = false;
      this.dynamicFiltersHideShow.isClockType = false;
      this.dynamicFiltersHideShow.isSunGlasseType = false;
      this.dynamicFiltersHideShow.isWatchType = false;
      this.dynamicFiltersHideShow.isEyewearSunglasses = false;


      /*this.filtersHideShow.gender = true;
      this.filtersHideShow.color = true;
      this.filtersHideShow.brand = true;
      this.filtersHideShow.price = true;*/
      this.clearDynamicFilters();
    }


    //alert(event.detail.value);
  }

  handleChangePriceFilters(event) {
    this.selectedPriceFilterValue = event.target.value;
    console.log(this.selectedPriceFilterValue);
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();

  }

  //Product Sort Function

  handleSortFeature(event) {
    this.selectedSortValue = event.target.value;
    console.log(this.selectedSortValue);
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  //Bags Functions
  handleBagGender(event) {
    this.selectedBagGender = event.target.value;
    console.log(this.selectedBagGender);
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleBagBrand(event) {
    this.selectedBagBrand = event.target.value;
    console.log(this.selectedBagBrand);
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleBagColor(event) {
    this.selectedBagColor = event.target.value;
    console.log(this.selectedBagColor);
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleBagCollection(event) {
    this.selectedBagCollection = event.target.value;
    console.log(this.selectedBagCollection);
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleBagOccassion(event) {
    this.selectedBagOccassion = event.target.value;
    console.log(this.selectedBagOccassion);
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleBagType(event) {
    this.selectedBagType = event.target.value;
    console.log(this.selectedSortValue);
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleBagMaterialBody(event) {
    this.selectedBagMaterialBody = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleBagMaterialLining(event) {
    this.selectedBagMaterialLining = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleBagClosureType(event) {
    this.selectedBagClosureType = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  //Belt Functions
  handleBeltType(event) {
    this.selectedBeltType = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleBeltGender(event) {
    this.selectedBeltGender = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleBeltBrand(event) {
    this.selectedBeltBrand = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleBeltColor(event) {
    this.selectedBeltColor = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleBeltDressCode(event) {
    this.selectedBeltDressCode = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleBeltLength(event) {
    this.selectedBeltLength = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  //Wallet Functions
  handleWalletType(event) {
    this.selectedWalletType = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWalletGender(event) {
    this.selectedWalletGender = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWalletBrand(event) {
    this.selectedWalletBrand = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWalletColor(event) {
    this.selectedWalletColor = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWalletDressCode(event) {
    this.selectedWalletDressCode = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  //Fragnance Functions
  handleFragnancetType(event) {
    this.selectedFragranceType = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleFragnanceGender(event) {
    this.selectedFragranceGender = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleFragnanceBrand(event) {
    this.selectedFragranceBrand = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleFragnanceFamily(event) {
    this.selectedFragranceFamily = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleFragnanceCollection(event) {
    this.selectedFragranceCollection = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleFragnanceQuantlty(event) {
    this.selectedFragranceQuantity = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }


  //EarPhones Functions
  handleEarPhoneGender(event) {
    this.selectedEarPhoneGender = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleEarPhoneBrand(event) {
    this.selectedEarPhoneBrand = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleEarPhoneColor(event) {
    this.selectedEarPhoneColor = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleEarPhoneCollection(event) {
    this.selectedEarPhoneCollection = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  //Clock Functions
  handleClockGender(event) {
    this.selectedClockGender = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleClockBrand(event) {
    this.selectedClockBrand = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleClockColor(event) {
    this.selectedClockColor = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleClockCollection(event) {
    this.selectedClockCollection = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleClockFunction(event) {
    this.selectedClockFunction = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  //Sunglasses Functions
  handleSunglassGender(event) {
    this.selectedSunglassGender = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleSunglassBrand(event) {
    this.selectedSunglassBrand = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleSunglassColor(event) {
    this.selectedSunglassColor = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleSunglassCollection(event) {
    this.selectedSunglassCollection = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }


  //Wtaches Functions
  handleWatchGender(event) {
    this.selectedWatchGender = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWatchBrand(event) {
    this.selectedWatchBrand = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWatchStrapColor(event) {
    this.selectedWatchStrapColor = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWatchStrapMaterial(event) {
    this.selectedWatchStrapMaterial = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWatchDialColor(event) {
    this.selectedWatchDialColor = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWatchCollection(event) {
    this.selectedWatchCollection = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleWatchMovement(event) {
    this.selectedWatchMovements = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  //EyeWear Sunglasses
  handleSunglassEyewearGender(event) {
    this.selectedSunglassEyewearGender = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }


  handleSunglassEyewearBrand(event) {
    this.selectedSunglassEyewearBrand = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }


  handleSunglassEyewearRIM(event) {
    this.selectedSunglassEyewearRIM = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }
  handleSunglassEyewearCategory(event) {
    this.selectedSunglassEyewearCategory = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleSunglassEyewearShape(event) {
    this.selectedSunglassEyewearShape = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }


  handleSunglassEyewearFrameMaterial(event) {
    this.selectedSunglassEyewearFrameMaterial = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleSunglassEyewearLensColour(event) {
    this.selectedSunglassEyewearLensColour = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }




  handleSunglassEyewearSize(event) {
    this.selectedSunglassEyewearSize = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }

  handleSunglassEyewearColour(event) {
    this.selectedSunglassEyewearColour = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }


  handleSunglassEyewearCollection(event) {
    this.selectedSunglassEyewearCollection = event.target.value;
    this.pageSize = 60;
    this.pageNumber = 1;
    this.fetchProducts();
  }




  //Filters Creation Based On Selected Type
  filterCreation() {
    let mainFilterData = JSON.parse(this.filtersValue);
    console.log(mainFilterData);


    //Gender Filter Data Creation
    let genderData = [];
    genderData = mainFilterData.GenderLabel;
    let optionsGenders = [];
    for (var key in genderData) {
      optionsGenders.push({ label: genderData[key], value: genderData[key] });
    }
    this.genderValues = optionsGenders;

    //Product Category Filter Data Creation
    let productCategory = [];
    productCategory = mainFilterData.ProductCategoryLabel;
    let productCategoryValuesData = [];
    productCategoryValuesData.push({ label: 'All', value: 'All' });
    for (var key in productCategory) {
      productCategoryValuesData.push({ label: productCategory[key], value: productCategory[key] });
    }
    this.productCategoryValues = productCategoryValuesData;

    //Colors Filter Data Creation
    let colors = [];
    colors = mainFilterData.ColorLabel;
    let colorsValuesData = [];
    for (var key in colors) {
      colorsValuesData.push({ label: colors[key], value: colors[key] });
    }
    this.colorValues = colorsValuesData;

    //Brand Filter Data Creation
    let productBrand = [];
    productBrand = mainFilterData.BrandLabel;
    let productBrandLabel = [];
    for (var key in productBrand) {
      productBrandLabel.push({ label: productBrand[key], value: productBrand[key] });
    }
    this.productBrandValueToShow = productBrandLabel;

    //Price Filters

    let priceFilters = [];
    //priceFilters = mainFilterData.BrandLabel;
    //let productBrandLabel = [];
    priceFilters.push({ label: 'Rs. 1 to Rs. 499', value: '1,499' });
    priceFilters.push({ label: 'Rs. 500 to Rs. 999', value: '500,999' });
    priceFilters.push({ label: 'Rs. 1000 to Rs. 1999', value: '1000,1999' });
    priceFilters.push({ label: 'Rs. 2000 to Rs. 4999', value: '2000,4999' });
    priceFilters.push({ label: 'Rs. 5000 to Rs. Above', value: '5000,Above' });
    this.priceFiltersValues = priceFilters;

    //Sort Values
    let sortBy = [];
    sortBy.push({ label: 'Price -- Low to High', value: 'LowtoHigh' });
    sortBy.push({ label: 'Price -- High to Low', value: 'HightoLow' });

    this.sortByFeatureToShow = sortBy;


    //Dynamic Filters Value
    if (this.selectedValue == 'Watches') {
      //Bag Type
      let bagTypeData = [];
      bagTypeData = mainFilterData.BagType;
      let bagTypeLabel = [];
      for (var key in bagTypeData) {
        bagTypeLabel.push({ label: bagTypeData[key], value: bagTypeData[key] });
      }
      this.bagType = bagTypeLabel;

      //Bag Material Lining
      let bagMaterialLiningData = [];
      bagMaterialLiningData = mainFilterData.BagMaterialLining;
      let bagMaterialLiningLabel = [];
      for (var key in bagMaterialLiningData) {
        bagMaterialLiningLabel.push({ label: bagMaterialLiningData[key], value: bagMaterialLiningData[key] });
      }
      this.bagMaterialLining = bagMaterialLiningLabel;

      //Bag Material Body
      let bagMaterialBodyData = [];
      bagMaterialBodyData = mainFilterData.BagMaterialBody;
      let bagMaterialBodyLabel = [];
      for (var key in bagMaterialBodyData) {
        bagMaterialBodyLabel.push({ label: bagMaterialBodyData[key], value: bagMaterialBodyData[key] });
      }
      this.bagMaterialBody = bagMaterialBodyLabel;

      //Bag Closure Type
      let bagClosureTypeData = [];
      bagClosureTypeData = mainFilterData.BagClosureType;
      let bagClosureTypeLabel = [];
      for (var key in bagClosureTypeData) {
        bagClosureTypeLabel.push({ label: bagClosureTypeData[key], value: bagClosureTypeData[key] });
      }
      this.bagClosureType = bagClosureTypeLabel;

      //Bag Gender Data
      let bagGenderData = [];
      bagGenderData = mainFilterData.BagsGender;
      let bagGenderLabel = [];
      for (var key in bagGenderData) {
        bagGenderLabel.push({ label: bagGenderData[key], value: bagGenderData[key] });
      }
      this.bagGender = bagGenderLabel;

      //Bag Brand
      let bagBrandData = [];
      bagBrandData = mainFilterData.BagsBrand;
      let bagBrandLabel = [];
      for (var key in bagBrandData) {
        bagBrandLabel.push({ label: bagBrandData[key], value: bagBrandData[key] });
      }
      this.bagBrand = bagBrandLabel;

      //Bag Color
      let bagColorData = [];
      bagColorData = mainFilterData.BagsColor;
      let bagColorLabel = [];
      for (var key in bagColorData) {
        bagColorLabel.push({ label: bagColorData[key], value: bagColorData[key] });
      }
      this.bagColor = bagColorLabel;

      //Bag Collection
      let bagCollectionData = [];
      bagCollectionData = mainFilterData.BagsCollection;
      let bagCollectionLabel = [];
      for (var key in bagCollectionData) {
        bagCollectionLabel.push({ label: bagCollectionData[key], value: bagCollectionData[key] });
      }
      this.bagCollection = bagCollectionLabel;

      //Bag Occassion
      let bagOccassionData = [];
      bagOccassionData = mainFilterData.BagsOccassion;
      let bagOccassionLabel = [];
      for (var key in bagOccassionData) {
        bagOccassionLabel.push({ label: bagOccassionData[key], value: bagOccassionData[key] });
      }
      this.bagOccassion = bagOccassionLabel;


      //Belt Gender
      let beltGenderData = [];
      beltGenderData = mainFilterData.BeltsGender;
      console.log('mainFilterData.BeltsGender' + mainFilterData.BeltsGender);
      let beltGenderLabel = [];
      for (var key in beltGenderData) {
        beltGenderLabel.push({ label: beltGenderData[key], value: beltGenderData[key] });
      }
      this.beltGender = beltGenderLabel;

      //Belt Brand
      let beltBrandData = [];
      beltBrandData = mainFilterData.BeltsBrand;
      let beltBrandLabel = [];
      for (var key in beltBrandData) {
        beltBrandLabel.push({ label: beltBrandData[key], value: beltBrandData[key] });
      }
      this.beltBrand = beltBrandLabel;


      //Belt Colors
      let beltColorData = [];
      beltColorData = mainFilterData.BeltsColor;
      console.log('mainFilterData.BeltsColor' + mainFilterData.BeltsColor);
      let beltColorLabel = [];
      for (var key in beltColorData) {
        beltColorLabel.push({ label: beltColorData[key], value: beltColorData[key] });
      }
      this.beltColor = beltColorLabel;


      //Belt Dress Code
      let beltsDressData = [];
      beltsDressData = mainFilterData.BeltsDressCode;
      let beltDressCodeLabel = [];
      for (var key in beltsDressData) {
        beltDressCodeLabel.push({ label: beltsDressData[key], value: beltsDressData[key] });
      }
      this.beltDressCode = beltDressCodeLabel;

      //Belt Length
      let beltLenghthData = [];
      beltLenghthData = mainFilterData.BeltsLength;
      let beltLengthLabel = [];
      for (var key in beltLenghthData) {
        beltLengthLabel.push({ label: beltLenghthData[key], value: beltLenghthData[key] });
      }
      this.beltLength = beltLengthLabel;

      //Belt Type
      let beltTypeData = [];
      beltTypeData = mainFilterData.BeltsType;
      let beltTypeLabel = [];
      for (var key in beltTypeData) {
        beltTypeLabel.push({ label: beltTypeData[key], value: beltTypeData[key] });
      }
      this.beltType = beltTypeLabel;

      //Wallet Gender
      let walletGenderData = [];
      walletGenderData = mainFilterData.WalletsGender;
      let walletGenderLabel = [];
      for (var key in walletGenderData) {
        walletGenderLabel.push({ label: walletGenderData[key], value: walletGenderData[key] });
      }
      this.walletGender = walletGenderLabel;

      //Wallet Brand
      let walletBrandData = [];
      walletBrandData = mainFilterData.WalletsBrand;
      let walletBrandLabel = [];
      for (var key in walletBrandData) {
        walletBrandLabel.push({ label: walletBrandData[key], value: walletBrandData[key] });
      }
      this.walletBrand = walletBrandLabel;

      //Wallet Color
      let walletColorData = [];
      walletColorData = mainFilterData.WalletsColor;
      let walletColorLabel = [];
      for (var key in walletColorData) {
        walletColorLabel.push({ label: walletColorData[key], value: walletColorData[key] });
      }
      this.walletColor = walletColorLabel;

      //Wallet Dress Code
      let walletDressCodeData = [];
      walletDressCodeData = mainFilterData.WalletsDressCode;
      let walletDressCodeLabel = [];
      for (var key in walletDressCodeData) {
        walletDressCodeLabel.push({ label: walletDressCodeData[key], value: walletDressCodeData[key] });
      }
      this.walletDressCode = walletDressCodeLabel;

      //Wallet Type
      let walletTypeData = [];
      walletTypeData = mainFilterData.WalletsType;
      let walletTypeLabel = [];
      for (var key in walletTypeData) {
        walletTypeLabel.push({ label: walletTypeData[key], value: walletTypeData[key] });
      }
      this.walletType = walletTypeLabel;

      //Fragance Gender
      let fragranceGenderData = [];
      fragranceGenderData = mainFilterData.FragrancesGender;
      let fragnanceGenderLabel = [];
      for (var key in fragranceGenderData) {
        fragnanceGenderLabel.push({ label: fragranceGenderData[key], value: fragranceGenderData[key] });
      }
      this.fragranceGender = fragnanceGenderLabel;

      //Fragance Brand
      let fragranceBrandData = [];
      fragranceBrandData = mainFilterData.FragrancesBrand;
      let fragranceBrandLabel = [];
      for (var key in fragranceBrandData) {
        fragranceBrandLabel.push({ label: fragranceBrandData[key], value: fragranceBrandData[key] });
      }
      this.fragranceBrand = fragranceBrandLabel;

      //Fragance Collection
      let fragranceCollectionData = [];
      fragranceCollectionData = mainFilterData.FragrancesCollection;
      let fragranceCollectionLabel = [];
      for (var key in fragranceCollectionData) {
        fragranceCollectionLabel.push({ label: fragranceCollectionData[key], value: fragranceCollectionData[key] });
      }
      this.fragranceCollection = fragranceCollectionLabel;

      //Fragance Type
      let fragranceTypeData = [];
      fragranceTypeData = mainFilterData.FragrancesFragranceType;
      let fragranceTypeLabel = [];
      for (var key in fragranceTypeData) {
        fragranceTypeLabel.push({ label: fragranceTypeData[key], value: fragranceTypeData[key] });
      }
      this.fragranceType = fragranceTypeLabel;

      //Fragance Family
      let fragranceFamilyData = [];
      fragranceFamilyData = mainFilterData.FragrancesFamily;
      let fragranceFamilyLabel = [];
      for (var key in fragranceFamilyData) {
        fragranceFamilyLabel.push({ label: fragranceFamilyData[key], value: fragranceFamilyData[key] });
      }
      this.fragranceFamily = fragranceFamilyLabel;

      //Fragance Quantity
      let fragranceQuantityData = [];
      fragranceQuantityData = mainFilterData.FragrancesQuantity;
      let fragranceQuantityLabel = [];
      for (var key in fragranceQuantityData) {
        fragranceQuantityLabel.push({ label: fragranceQuantityData[key], value: fragranceQuantityData[key] });
      }
      this.fragranceQuantity = fragranceQuantityLabel;

      //Earphone Gender
      let earPhonesGenderData = [];
      earPhonesGenderData = mainFilterData.EarphonesGender;
      let earPhonesGenderLabel = [];
      for (var key in earPhonesGenderData) {
        earPhonesGenderLabel.push({ label: earPhonesGenderData[key], value: earPhonesGenderData[key] });
      }
      this.earPhoneGender = earPhonesGenderLabel;

      //Earphone Brand
      let earPhonesBrandData = [];
      earPhonesBrandData = mainFilterData.EarphonesBrand;
      let earPhonesBrandLabel = [];
      for (var key in earPhonesBrandData) {
        earPhonesBrandLabel.push({ label: earPhonesBrandData[key], value: earPhonesBrandData[key] });
      }
      this.earPhoneBrand = earPhonesBrandLabel;

      //Earphone Color
      let earPhonesColorData = [];
      earPhonesColorData = mainFilterData.EarphonesColor;
      let earPhonesColorLabel = [];
      for (var key in earPhonesColorData) {
        earPhonesColorLabel.push({ label: earPhonesColorData[key], value: earPhonesColorData[key] });
      }
      this.earPhoneColor = earPhonesColorLabel;

      //Earphone Collection
      let earPhonesCollectionData = [];
      earPhonesCollectionData = mainFilterData.EarphonesCollection;
      let earPhonesCollectionLabel = [];
      for (var key in earPhonesCollectionData) {
        earPhonesCollectionLabel.push({ label: earPhonesCollectionData[key], value: earPhonesCollectionData[key] });
      }
      this.earPhoneCollection = earPhonesCollectionLabel;

      //Clock Gender
      let clockGenderData = [];
      clockGenderData = mainFilterData.ClocksGender;
      let clockGenderLabel = [];
      for (var key in clockGenderData) {
        clockGenderLabel.push({ label: clockGenderData[key], value: clockGenderData[key] });
      }
      this.clockGender = clockGenderLabel;

      //Clock Brand
      let clockBrandData = [];
      clockBrandData = mainFilterData.ClocksBrand;
      let clockBrandLabel = [];
      for (var key in clockBrandData) {
        clockBrandLabel.push({ label: clockBrandData[key], value: clockBrandData[key] });
      }
      this.clockBrand = clockBrandLabel;

      //Clock Color
      let clockColorData = [];
      clockColorData = mainFilterData.ClocksColor;
      let clockColorLabel = [];
      for (var key in clockColorData) {
        clockColorLabel.push({ label: clockColorData[key], value: clockColorData[key] });
      }
      this.clockColor = clockColorLabel;

      //Clock Collection
      let clockCollectionData = [];
      clockCollectionData = mainFilterData.ClocksCollection;
      let clockCollectionLabel = [];
      for (var key in clockCollectionData) {
        clockCollectionLabel.push({ label: clockCollectionData[key], value: clockCollectionData[key] });
      }
      this.clockCollection = clockCollectionLabel;

      //Clock Fucntion
      let clockFunctionData = [];
      clockFunctionData = mainFilterData.ClocksFunction;
      let clockFunctionLabel = [];
      for (var key in clockFunctionData) {
        clockFunctionLabel.push({ label: clockFunctionData[key], value: clockFunctionData[key] });
      }
      this.clockFunction = clockFunctionLabel;

      //SunGlass Gender
      let sunglassGenderData = [];
      sunglassGenderData = mainFilterData.SunGlassesGender;
      let sunglassGenderLabel = [];
      for (var key in sunglassGenderData) {
        sunglassGenderLabel.push({ label: sunglassGenderData[key], value: sunglassGenderData[key] });
      }
      this.sunglassGender = sunglassGenderLabel;

      //SunGlass Brand
      let sunglassBrandData = [];
      sunglassBrandData = mainFilterData.SunGlassesBrand;
      let sunglassBrandLabel = [];
      for (var key in sunglassBrandData) {
        sunglassBrandLabel.push({ label: sunglassBrandData[key], value: sunglassBrandData[key] });
      }
      this.sunglassBrand = sunglassBrandLabel;

      //SunGlass Collection
      let sunglassCollectionData = [];
      sunglassCollectionData = mainFilterData.SunGlassesCollection;
      let sunglassCollectionLabel = [];
      for (var key in sunglassCollectionData) {
        sunglassCollectionLabel.push({ label: sunglassCollectionData[key], value: sunglassCollectionData[key] });
      }
      this.sunglassCollection = sunglassCollectionLabel;

      //Watch Gender
      let watchGenderData = [];
      watchGenderData = mainFilterData.WatchesGender;
      let watchGenderLabel = [];
      for (var key in watchGenderData) {
        watchGenderLabel.push({ label: watchGenderData[key], value: watchGenderData[key] });
      }
      this.watchGender = watchGenderLabel;

      //Watch Brand
      let watchBrandData = [];
      watchBrandData = mainFilterData.WatchesBrand;
      let watchBrandLabel = [];
      for (var key in watchBrandData) {
        watchBrandLabel.push({ label: watchBrandData[key], value: watchBrandData[key] });
      }
      this.watchBrand = watchBrandLabel;

      //Watch Collection
      let watchCollectionData = [];
      watchCollectionData = mainFilterData.WatchesCollection;
      let watchCollectionLabel = [];
      for (var key in watchCollectionData) {
        watchCollectionLabel.push({ label: watchCollectionData[key], value: watchCollectionData[key] });
      }
      this.watchCollection = watchCollectionLabel;

      //Watch StrapColor
      let watchStrapColorData = [];
      watchStrapColorData = mainFilterData.WatchesStrapColor;
      let watchStrapColorLabel = [];
      for (var key in watchStrapColorData) {
        watchStrapColorLabel.push({ label: watchStrapColorData[key], value: watchStrapColorData[key] });
      }
      this.watchStrapColor = watchStrapColorLabel;

      //Watch StrapMaterial
      let watchStrapMaterialData = [];
      watchStrapMaterialData = mainFilterData.WatchesStrapMaterial;
      let watchStrapMaterialLabel = [];
      for (var key in watchStrapMaterialData) {
        watchStrapMaterialLabel.push({ label: watchStrapMaterialData[key], value: watchStrapMaterialData[key] });
      }
      this.watchStrapMaterial = watchStrapMaterialLabel;

      //Watch Dial Color
      let watchDialColorData = [];
      watchDialColorData = mainFilterData.WatchesDialColor;
      let watchDialColorLabel = [];
      for (var key in watchDialColorData) {
        watchDialColorLabel.push({ label: watchDialColorData[key], value: watchDialColorData[key] });
      }
      this.watchDialColor = watchDialColorLabel;

      //Watch Movements
      let watchMovementData = [];
      watchMovementData = mainFilterData.WatchesMovements;
      let watchMovementLabel = [];
      for (var key in watchMovementData) {
        watchMovementLabel.push({ label: watchMovementData[key], value: watchMovementData[key] });
      }
      this.watchMovements = watchMovementLabel;





    } else if (this.selectedValue == 'Eyewear') {
      //alert(mainFilterData.SunGlassesEyewearGender)

      //Watch Movements
      let sunGlassesEyewearGenderData = [];
      sunGlassesEyewearGenderData = mainFilterData.SunGlassesEyewearGender;
      let sunGlassesEyewearGenderLabel = [];
      for (var key in sunGlassesEyewearGenderData) {
        sunGlassesEyewearGenderLabel.push({ label: sunGlassesEyewearGenderData[key], value: sunGlassesEyewearGenderData[key] });
        console.log(sunGlassesEyewearGenderData[key]);
      }
      this.sunglassEyewearGender = sunGlassesEyewearGenderLabel;

      //Watch Movements
      let sunGlassesEyewearRIMData = [];
      sunGlassesEyewearRIMData = mainFilterData.SunGlassesEyewearRIM;
      let sunGlassesEyewearRIMLabel = [];
      for (var key in sunGlassesEyewearRIMData) {
        sunGlassesEyewearRIMLabel.push({ label: sunGlassesEyewearRIMData[key], value: sunGlassesEyewearRIMData[key] });
      }
      this.sunglassEyewearRIM = sunGlassesEyewearRIMLabel;


      //Watch Movements
      let sunGlassesEyewearBrandData = [];
      sunGlassesEyewearBrandData = mainFilterData.SunGlassesEyewearBrand;
      let sunGlassesEyewearBrandLabel = [];
      for (var key in sunGlassesEyewearBrandData) {
        sunGlassesEyewearBrandLabel.push({ label: sunGlassesEyewearBrandData[key], value: sunGlassesEyewearBrandData[key] });
      }
      this.sunglassEyewearBrand = sunGlassesEyewearBrandLabel;


      //Watch Movements
      let sunGlassesEyewearCategoryData = [];
      sunGlassesEyewearCategoryData = mainFilterData.SunGlassesEyewearCategory;
      let sunGlassesEyewearCategoryLabel = [];
      for (var key in sunGlassesEyewearCategoryData) {
        sunGlassesEyewearCategoryLabel.push({ label: sunGlassesEyewearCategoryData[key], value: sunGlassesEyewearCategoryData[key] });
      }
      this.sunglassEyewearCategory = sunGlassesEyewearCategoryLabel;

      //Watch Movements
      let sunGlassesEyewearShapeData = [];
      sunGlassesEyewearShapeData = mainFilterData.SunGlassesEyewearShape;
      let sunGlassesEyewearShapeLabel = [];
      for (var key in sunGlassesEyewearShapeData) {
        sunGlassesEyewearShapeLabel.push({ label: sunGlassesEyewearShapeData[key], value: sunGlassesEyewearShapeData[key] });
      }
      this.sunglassEyewearShape = sunGlassesEyewearShapeLabel;

      //Watch Movements
      let sunGlassesEyewearCollectionData = [];
      sunGlassesEyewearCollectionData = mainFilterData.SunGlassesEyewearCollection;
      let sunGlassesEyewearCollectionLabel = [];
      for (var key in sunGlassesEyewearCollectionData) {
        sunGlassesEyewearCollectionLabel.push({ label: sunGlassesEyewearCollectionData[key], value: sunGlassesEyewearCollectionData[key] });
      }
      this.sunglassEyewearCollection = sunGlassesEyewearCollectionLabel;


      //Watch Movements
      let sunGlassesEyewearEyewearFrameMaterialData = [];
      sunGlassesEyewearEyewearFrameMaterialData = mainFilterData.SunGlassesEyewearEyewearFrameMaterial;
      let sunGlassesEyewearEyewearFrameMaterialLabel = [];
      for (var key in sunGlassesEyewearEyewearFrameMaterialData) {
        sunGlassesEyewearEyewearFrameMaterialLabel.push({ label: sunGlassesEyewearEyewearFrameMaterialData[key], value: sunGlassesEyewearEyewearFrameMaterialData[key] });
      }
      this.sunglassEyewearFrameMaterial = sunGlassesEyewearEyewearFrameMaterialLabel;

      //Watch Movements
      let sunGlassesEyewearLensColourData = [];
      sunGlassesEyewearLensColourData = mainFilterData.SunGlassesEyewearLensColour;
      let sunGlassesEyewearLensColourLabel = [];
      for (var key in sunGlassesEyewearLensColourData) {
        sunGlassesEyewearLensColourLabel.push({ label: sunGlassesEyewearLensColourData[key], value: sunGlassesEyewearLensColourData[key] });
      }
      this.sunglassEyewearLensColour = sunGlassesEyewearLensColourLabel;

      //Watch Movements
      let sunGlassesEyewearSizeData = [];
      sunGlassesEyewearSizeData = mainFilterData.SunGlassesEyewearSize;
      let sunGlassesEyewearSizeLabel = [];
      for (var key in sunGlassesEyewearSizeData) {
        sunGlassesEyewearSizeLabel.push({ label: sunGlassesEyewearSizeData[key], value: sunGlassesEyewearSizeData[key] });
      }
      this.sunglassEyewearSize = sunGlassesEyewearSizeLabel;

      //Watch Movements
      let sunGlassesEyewearColourData = [];
      sunGlassesEyewearColourData = mainFilterData.SunGlassesEyewearColour;
      let sunGlassesEyewearColourLabel = [];
      for (var key in sunGlassesEyewearColourData) {
        sunGlassesEyewearColourLabel.push({ label: sunGlassesEyewearColourData[key], value: sunGlassesEyewearColourData[key] });
      }
      this.sunglassEyewearColour = sunGlassesEyewearColourLabel;



    }



  }



  //Open Product Detail Page Component in Modal
  openModal(event) {
    //console.log(this.template.querySelector('[id=' + event.currentTarget.id + ']').offsetTop);
    this.offsetTopValue = this.template.querySelector('[id=' + event.currentTarget.id + ']').offsetTop;
    console.log(this.offsetTopValue);
    //this.openHideMainPage = false;


    this.scrollingPage(0, 'auto');

    let selectedProductId = event.currentTarget.id;
    selectedProductId = selectedProductId.substring(0, selectedProductId.indexOf('-'));  // Returns "ell"
    //alert(selectedProductId);
    this.selectedProductForCart = selectedProductId;
    var largeGroup = this.mainProductData.filter(activity => (activity.productId == selectedProductId));
    //console.log(JSON.stringify(largeGroup));
    var productsImages = [];
    var dataOfImages = largeGroup[0].productImages;
    //console.log('dataOfImages-->' + dataOfImages);
    let nameOfProduct = largeGroup[0].productShortDescription;

    if (nameOfProduct.length >= 12) {
      nameOfProduct = nameOfProduct.substring(0, 11);

    }
    this.objectOfProductToCart = {
      'productId': largeGroup[0].productId,
      'productIdForCart': largeGroup[0].productId + 'Cart',
      'productImage': largeGroup[0].productDisplayImage,
      'quantity': 0,
      'productName': largeGroup[0].productShortDescription,
      'productBrand': largeGroup[0].productBrand,
      'productFullName': largeGroup[0].productShortDescription,
      'productListPrice': this.hidePriceData ? undefined : largeGroup[0].productListPrice,
      'productOfferPrice': this.hidePriceData ? undefined : largeGroup[0].productOfferPrice,
      'percentageValue': this.hidePriceData ? undefined : largeGroup[0].percentageValue,
      'sellebleSKU': largeGroup[0].sellebleSKU,
      'customOfferPrice': undefined

    }

    for (var key in dataOfImages) {
      productsImages.push({
        images: dataOfImages[key],
        heading: largeGroup[0].productBrand,
        description: largeGroup[0].productShortDescription
      });
    }
    this.productSlides = productsImages;
    this.selectedProductIdForDetailPage = selectedProductId;
    this.isModalOpen = true;
  }

  //This Function for Close the Detail Modal
  closeModal() {
    this.scrollingPage(this.offsetTopValue, 'auto');
    this.isModalOpen = false;
    this.quantityValue = 0;
  }


  submitDetails() {
    this.openHideMainPage = true;

    // to close modal set isModalOpen tarck value as false
    //Add your code to call apex method or do some processing
    this.isModalOpen = false;
  }

  ooenCartModal() {
    console.log('uniqueKey-->' + this.uniqueKey);
    this.openCart = true;
    this.scrollingPage(0, 'auto');

    if (this.uniqueKey != '') {
      this.createUniqueImageRecord(this.uniqueKey);
    }
  }

  closeCart() {
    //this.generateProposal();
    //this.scrollingPage(this.offsetTopValue, 'auto');
    this.openCart = false;
  }


  //Generate Proposal PDF
  generateProposalAndCloseCart() {
    let validateOfferPrice = false;
    let productName = '';
    if (this.cartSize == 0) {
      this.showToast('', 'Please Add Products To Generate Proposal', 'error');

    } else if (this.selectedOpportunityId == '' || this.selectedOpportunityId == undefined) {
      this.showToast('', 'Please Select Opportunity', 'error');

    } else if (this.cartSize > 0) {
      console.log('Coming');
      for (var key in this.productAddedForCart) {
        console.log('this.productAddedForCart[key].productOfferPrice' + this.productAddedForCart[key].productOfferPrice);
        if (this.productAddedForCart[key].productOfferPrice > this.productAddedForCart[key].productListPrice) {
          productName = this.productAddedForCart[key].productName;
          console.log('this.productAddedForCart[key].productOfferPrice' + this.productAddedForCart[key].productOfferPrice);
          console.log('this.productAddedForCart[key].productListPrice' + this.productAddedForCart[key].productListPrice);

          validateOfferPrice = true;
          break;
        }
      }
      if (validateOfferPrice) {
        this.showToast('', 'Please Give Offer Price Below List Price for the product ' + productName, 'error');
      } else {
        this.generateProposal();
      }

    }

  }

  //Product Add To Cart
  addToCart(event) {
    let validateCartProducts = this.productAddedForCart;
    let productExisting = false;
    for (var key in validateCartProducts) {
      if (validateCartProducts[key].productId == this.objectOfProductToCart.productId) {
        productExisting = true;
        break;
      }

    }

    if (productExisting) {
      this.showToast('', 'Product Already Exist', 'error');
      this.quantityValue = 0;

    } else {
      if (this.quantityValue > 0 && this.quantityValue != undefined) {
        this.objectOfProductToCart.quantity = this.quantityValue;
        this.productAddedForCart.push(this.objectOfProductToCart);
        this.quantityValue = 0;
        this.cartSize = this.productAddedForCart.length;
        console.log(JSON.stringify(this.productAddedForCart));
        this.prepareOrderSummary();
        this.closeModal();
        this.showToast('', 'Item is added to cart', 'success');
      } else {
        this.showToast('', 'Please Add Valid Quantity', 'error');

      }
    }


  }

  //Prepare Order Summary After Addition And Updation Of Product
  prepareOrderSummary() {
    let totalItems = this.productAddedForCart.length;
    let totalPrice = 0;
    let totalDiscount = 0;
    let totalQuantity = 0;
    let totalOrderValue = 0;


    for (let key in this.productAddedForCart) {
      if (this.productAddedForCart[key].productListPrice != undefined) {
        totalPrice = totalPrice + (this.productAddedForCart[key].productListPrice * this.productAddedForCart[key].quantity);
        totalQuantity = totalQuantity + this.productAddedForCart[key].quantity;
      } else {
        totalPrice = totalPrice + 0;
        totalQuantity = totalQuantity + this.productAddedForCart[key].quantity;
      }

      if (this.productAddedForCart[key].productOfferPrice != undefined) {
        let discount = this.productAddedForCart[key].productOfferPrice * this.productAddedForCart[key].quantity;
        totalOrderValue = totalOrderValue + discount;
        totalDiscount = totalPrice - totalOrderValue;
      } else {
        let discount = 0 * this.productAddedForCart[key].quantity;
        totalOrderValue = totalOrderValue + discount;
        totalDiscount = totalPrice - totalOrderValue;
      }
    }
    this.orderSummary.totalItems = totalItems;
    this.orderSummary.totalPrice = totalPrice;
    this.orderSummary.totalOrderValue = totalOrderValue;
    this.orderSummary.totalDiscount = totalDiscount;
    this.orderSummary.totalQuantity = totalQuantity;
    this.cartSize = this.productAddedForCart.length;

  }

  //Back Button to Main Page
  goBackToMainPage(event) {
    //Clear Filters On Back
    this.clearFilters();
    this.clearDynamicFilters();
    this.hideDynamicFilters();

    var divblock = this.template.querySelector('[data-id="divblock"]');
    if (divblock) {
      this.template.querySelector('[data-id="divblock"]').className = 'slds-hide';
    }
    this.dispatchEvent(new CustomEvent('pass', {
      detail: JSON.stringify(this.productAddedForCart)
    }));
  }

  // - Quantity from AddToCart
  minusQuantity(event) {
    const element = this.template.querySelector('[data-id=' + event.target.name + ']');
    this.quantityValue = (parseInt(element.value) - 1) > 0 ? parseInt(element.value) - 1 : 0;
  }

  // + Quantity from AddToCart
  addtionQuantity(event) {
    const element = this.template.querySelector('[data-id=' + event.target.name + ']');
    this.quantityValue = parseInt(element.value) + 1;

  }

  // Quantity Changefrom AddToCart
  valueQtyHandle(event) {
    console.log(event.target.value);
    let trimmedValue = event.target.value;
    trimmedValue = trimmedValue.replace(/^0+/, '');
    console.log(parseInt(trimmedValue));

    this.quantityValue = parseInt(trimmedValue);
  }

  // - Quantity from Cart Update
  minusQuantityCart(event) {

    let nameOf = String(event.target.name);
    for (let key in this.productAddedForCart) {
      let tempCartId = this.productAddedForCart[key];

      if (tempCartId.productIdForCart == nameOf) {
        tempCartId.quantity = (tempCartId.quantity - 1) >= 1 ? tempCartId.quantity - 1 : tempCartId.quantity;
      }

    }
    this.prepareOrderSummary();

  }

  // + Quantity from Cart Update
  addtionQuantityCart(event) {
    let nameOf = String(event.target.name);
    for (let key in this.productAddedForCart) {
      let tempCartId = this.productAddedForCart[key];

      if (tempCartId.productIdForCart == nameOf) {
        tempCartId.quantity = tempCartId.quantity + 1;
      }

    }
    this.prepareOrderSummary();
    //this.hidePricingFromCart();

  }

  // Value Change Quantity from Cart Update
  valueQtyHandleCart(event) {
    let quantityValue = +parseInt(event.target.value);
    let nameOf = String(event.target.name);
    for (let key in this.productAddedForCart) {
      let tempCartId = this.productAddedForCart[key];
      if (tempCartId.productIdForCart == nameOf) {
        tempCartId.quantity = quantityValue <= 1 ? 1 : quantityValue;
      }

    }
    this.prepareOrderSummary();


  }

  //Remove product from Cart
  removeProductFromCart(event) {
    this.productAddedForCart = this.productAddedForCart.filter(item => item.productIdForCart !== event.target.name)
    this.prepareOrderSummary();
  }

  openNav() {

    this.scrollingPage(0, 'auto');

    //alert(document.getElementById("mySidenav"));
    var divblock = this.template.querySelector('[data-id="mySidenav"]');
    if (divblock) {
      this.template.querySelector('[data-id="mySidenav"]').className = 'class1';
      //this.template.body.style.backgroundColor = "rgba(0,0,0,0.4)";

      //this.template.querySelector('sidenav').style.width = "250px";
    }
    //document.getElementById("mySidenav").style.width = "250px";
    //document.getElementById("main").style.marginLeft = "250px";
    //document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
  }

  closeNav() {

    var divblock = this.template.querySelector('[data-id="mySidenav"]');
    if (divblock) {
      this.template.querySelector('[data-id="mySidenav"]').className = 'sidenav';
      //window.open("https://titanlightningapps--propdev--c.visualforce.com/apex/proposal_Tool_Pdf")

      //this.template.body.style.backgroundColor = "rgba(0,0,0,0.4)";

      //this.template.querySelector('sidenav').style.width = "250px";
    }
    /*document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
    document.body.style.backgroundColor = "white";*/
  }

  clearFilters() {
    this.searchValue = '';
    this.genderSelectedvalue = [];
    this.colorSelectedValue = [];
    this.brandSelectedValue = [];
    this.productCategorySelectedvalue = '';

    this.productCategoryValues = [];
    this.genderValues = [];
    this.colorValues = [];
    this.productBrandValueToShow = [];
    this.sortByFeatureToShow = [];
    this.selectedSortValue = '';
    this.selectedPriceFilterValue = '';

    //Bags Filters
    this.bagType = [];
    this.bagMaterialBody = [];
    this.bagMaterialLining = [];
    this.bagClosureType = [];

    this.selectedBagType = [];
    this.selectedBagMaterialBody = [];
    this.selectedBagMaterialLining = [];
    this.selectedBagClosureType = [];


    this.pageSize = 60;
    this.pageNumber = 1;


    this.mainProductData = [];
    this.data = [];
  }

  clearAllFilters() {
    this.searchValue = '';
    this.genderSelectedvalue = [];
    this.colorSelectedValue = [];
    this.brandSelectedValue = [];
    this.productCategorySelectedvalue = 'All';

    this.selectedBagType = [];
    this.selectedBagMaterialBody = [];
    this.selectedBagMaterialLining = [];
    this.selectedBagClosureType = [];



    this.selectedSortValue = '';
    this.selectedPriceFilterValue = '';
    this.pageSize = 60;
    this.pageNumber = 1;
    this.hidePriceData = false;
    this.clearDynamicFilters();
    this.hideDynamicFilters();
    this.fetchProducts();
    if (this.selectedValue == 'Watches') {
      this.filtersHideShow.gender = false;
      this.filtersHideShow.color = false;
      this.filtersHideShow.price = true;
      this.filtersHideShow.brand = false;
    }

  }

  clearDynamicFilters() {
    //Selected Bag Filters Values
    this.selectedBagType = [];
    this.selectedBagMaterialBody = [];
    this.selectedBagMaterialLining = [];
    this.selectedBagClosureType = [];
    this.selectedBagGender = [];
    this.selectedBagBrand = [];
    this.selectedBagColor = [];
    this.selectedBagCollection = [];
    this.selectedBagOccassion = [];

    //Selected Belt Filters Values
    this.selectedBeltType = [];
    this.selectedBeltGender = [];
    this.selectedBeltBrand = [];
    this.selectedBeltColor = [];
    this.selectedBeltDressCode = [];
    this.selectedBeltLength = [];

    //Selected Wallet Filters Values
    this.selectedWalletType = [];
    this.selectedWalletGender = [];
    this.selectedWalletBrand = [];
    this.selectedWalletColor = [];
    this.selectedWalletDressCode = [];

    //Selected Fragrances Filters Values
    this.selectedFragranceType = [];
    this.selectedFragranceGender = [];
    this.selectedFragranceBrand = [];
    this.selectedFragranceFamily = [];
    this.selectedFragranceCollection = [];
    this.selectedFragranceQuantity = [];

    //Selected Earphone Filters Values
    this.selectedEarPhoneGender = [];
    this.selectedEarPhoneBrand = [];
    this.selectedEarPhoneColor = [];
    this.selectedEarPhoneCollection = [];

    //Selected Clock Filters Values
    this.selectedClockGender = [];
    this.selectedClockBrand = [];
    this.selectedClockColor = [];
    this.selectedClockCollection = [];
    this.selectedClockFunction = [];

    //Selected Sunglasses Filters Values
    this.selectedSunglassGender = [];
    this.selectedSunglassBrand = [];
    this.selectedSunglassColor = [];
    this.selectedSunglassCollection = [];


    //Selected Watches Filters Values
    this.selectedWatchGender = [];
    this.selectedWatchBrand = [];
    this.selectedWatchStrapColor = [];
    this.selectedWatchStrapMaterial = [];
    this.selectedWatchDialColor = [];
    this.selectedWatchCollection = [];
    this.selectedWatchMovements = [];

    //Sunglasses Eyewera Filters
    this.selectedSunglassEyewearGender = [];
    this.selectedSunglassEyewearRIM = [];
    this.selectedSunglassEyewearBrand = [];
    this.selectedSunglassEyewearCategory = [];
    this.selectedSunglassEyewearShape = [];
    this.selectedSunglassEyewearFrameMaterial = [];
    this.selectedSunglassEyewearLensColour = [];
    this.selectedSunglassEyewearSize = [];
    this.selectedSunglassEyewearColour = [];
    this.selectedSunglassEyewearCollection = [];

  }

  hideDynamicFilters() {
    this.dynamicFiltersHideShow.isBagType = false;
    this.dynamicFiltersHideShow.isBeltType = false;
    this.dynamicFiltersHideShow.isWalletType = false;
    this.dynamicFiltersHideShow.isFragranceType = false;
    this.dynamicFiltersHideShow.isEarphoneType = false;
    this.dynamicFiltersHideShow.isClockType = false;
    this.dynamicFiltersHideShow.isSunGlasseType = false;
    this.dynamicFiltersHideShow.isWatchType = false;
    this.dynamicFiltersHideShow.isEyewearSunglasses = false;

  }

  hidePricing(event) {
    console.log(event.target.checked);
    if (event.target.checked === true) {
      this.hidePriceData = true;

    } else {
      this.hidePriceData = false;

    }
  }

  hidePricingFromCart(event) {
    if (event.target.checked == true) {

      this.hidePriceFromCart = false;
    } else {
      this.hidePriceFromCart = true;

    }

  }


  changeHandleOfferPrice(event) {
    console.log('value' + event.target.value);
    console.log('Value-->' + event.currentTarget.dataset.id);
    console.log('Access key2:' + event.target.accessKey);
    let indexOfCartArray = event.currentTarget.dataset.id;
    this.productAddedForCart[indexOfCartArray].productOfferPrice = parseFloat(event.target.value);
    this.productAddedForCart[indexOfCartArray].productOfferPrice = isNaN(this.productAddedForCart[indexOfCartArray].productOfferPrice) || this.productAddedForCart[indexOfCartArray].productOfferPrice == undefined ? 0 : this.productAddedForCart[indexOfCartArray].productOfferPrice;



    if (this.productAddedForCart[indexOfCartArray].productListPrice >= this.productAddedForCart[indexOfCartArray].productOfferPrice) {
      let difference = (this.productAddedForCart[indexOfCartArray].productOfferPrice / this.productAddedForCart[indexOfCartArray].productListPrice);
      difference = parseFloat(difference);
      let percentage = (difference * 100);
      this.productAddedForCart[indexOfCartArray].percentageValue = Math.round(100 - percentage);
      //this.productAddedForCart[indexOfCartArray].productOfferPrice = event.target.value;

      //console.log('percentage-->' + (this.productAddedForCart[indexOfCartArray].productListPrice - event.target.value) / 100);

    } else {

    }
    this.prepareOrderSummary();
  }

  changeHandleOfferPercentage(event) {
    console.log('value' + event.target.value);
    console.log('Value-->' + event.currentTarget.dataset.id);
    let indexOfCartArray = event.currentTarget.dataset.id;
    console.log('Access key2:' + event.target.accessKey);
    if (event.target.value != undefined && event.target.value >= 0 && event.target.value <= 100) {
      let calculatedOfferPrice = this.productAddedForCart[indexOfCartArray].productListPrice * (event.target.value / 100);
      calculatedOfferPrice = Math.ceil(calculatedOfferPrice);
      this.productAddedForCart[indexOfCartArray].productOfferPrice = this.productAddedForCart[indexOfCartArray].productListPrice - calculatedOfferPrice;
      this.productAddedForCart[indexOfCartArray].percentageValue = event.target.value;

    }
    this.prepareOrderSummary();
  }

  changeHandleMRPPrice(event) {
    console.log('value' + event.target.value);
    console.log('Value-->' + event.currentTarget.dataset.id);
    console.log('Access key2:' + event.target.accessKey);
    let indexOfCartArray = event.currentTarget.dataset.id;
    if (event.target.value != undefined) {
      this.productAddedForCart[indexOfCartArray].productListPrice = parseFloat(event.target.value);
    }


    this.prepareOrderSummary();
  }



  createUniqueImageRecord(uniqueValue) {
    createImageUniqueRecord({ uniqueValueKey: uniqueValue })
      .then(result => {
        this.proposalCustomImageId = result;
        console.log('result-->' + result);

      })
      .catch(error => {

      });

  }

  generateProposal() {
    this.isSpinner = true;

    this.loader = true;
    var finanJSONfromProposal = JSON.stringify(this.productAddedForCart);
    console.log('productsFromCart' + finanJSONfromProposal);
    console.log('uniqueIdOfProductImages' + this.proposalCustomImageId);
    console.log('isHidePrice' + this.hidePriceData);



    generateProposal({ productsFromCart: finanJSONfromProposal, opportunityId: this.selectedOpportunityId, uniqueIdOfProductImages: this.proposalCustomImageId, isHidePrice: this.hidePriceData })
      .then(result => {
        console.log('result-->' + result);
        setTimeout(() => {
          this.callFuctionOnTime(result);
        }, 7000)


      })
      .catch(error => {

      });
  }

  lookupRecord(event) {
    console.log(event.detail.selectedRecord);
    if (event.detail.selectedRecord != undefined) {
      this.selectedOpportunityId = event.detail.selectedRecord.Id;

    } else {
      this.selectedOpportunityId = '';

    }
    //alert('Selected Record Value on Parent Component is ' + JSON.stringify(event.detail.selectedRecord.Id));
  }

  scrollingPage(top, behavior) {
    let scrollOptions = {
      left: 0,
      top: top,
      behavior: behavior
    }
    window.scrollTo(scrollOptions);
  }


  showToast(tilte, message, variant) {
    const event = new ShowToastEvent({
      title: tilte,
      message: message,
      variant: variant
    });
    this.dispatchEvent(event);
  }

  async callFuctionOnTime(result) {
    this.uniqueKey = '';
    this.goBackToMainPage();
    this.showToast('', 'Proposal Created Successfully', 'success');
    this.productAddedForCart = [];
    this.cartSize = 0;
    this.openCart = false;
    this.loader = false;
    this.isSpinner = false;

    this[NavigationMixin.Navigate]({
      type: 'standard__recordPage',
      attributes: {
        recordId: result,
        objectApiName: 'Proposal__c',
        actionName: 'view'
      },
    });
    //window.location.reload();

  }




}