import { LightningElement, track, api, wire } from 'lwc';
import fetchRangePlan from '@salesforce/apex/RangePlanSummary.fetchRangePlan';

export default class RangeplanLWC extends LightningElement {
searchKey;
@track noRecordFound;
@track isTrue = true;
@track orderId;
@track conatctData = [{}];
columnHeader = ['L1(OFC)','L1(OFC)','L1(OFC)','Price Band','L4(Zari Type)','Cost Band','Average Cost','Total Order Quantity','Actual Procured','Balance','Order Value','Actual Procured Value','Balance','Remarks']
orderId = [{
  'orderId':undefined,
  'l1':undefined,
  'l2':undefined,
  'l3':undefined,
  'priceBand':undefined,
  'l4':undefined,
  'costBand':undefined,
  'averageCost':undefined,
  'totalOrderQuantity':undefined,
  'orderValue':undefined,
  'remarks':undefined,
  'actualProcured':undefined,
  'actualProcuredValue':undefined,
  'balance_Quantity': '',
  'balance_Cost': ''
}]
@api recordId;
@track data;
@track showLoadingSpinner = false;
@track visible = false;  
@track value = '';
selectedRecords;
@wire(fetchRangePlan) masterDataList;

@wire(fetchRangePlan)
wiredData({ error, data }) {
    if (data) {
        console.log('Data', data);
        this.conatctData = data;
    } else if (error) {
        console.error('Error:', error);
    }
}

downloadTableDataExtra(){
  let doc = '';
  // Add the data coloums
  this.columnHeader.forEach(element => {
  doc += element +','
  });
  doc += '\n';
  // Add the data rows
  this.orderId.forEach(data => {
  // doc += ”;
  doc += data.l1+',';
  doc += data.l2+',';
  doc += data.l3+',';
  doc += data.priceBand+',';
  doc += data.l4+',';
  doc += data.costBand+',';
  doc += data.averageCost+',';
  doc += data.totalOrderQuantity+',';
  doc += data.actualProcured+',';
  doc += data.balance_Quantity+',';
  doc += data.orderValue+',';
  doc += data.actualProcuredValue+',';
  doc += data.balance_Cost+',';
  doc += data.remarks+',';
  doc += '\n';
  });
  var element = 'data:text/csv;charset=utf-8,' + encodeURIComponent(doc);
  let downloadElement = document.createElement('a');
  downloadElement.href = element;
  downloadElement.target = '_self';
  // use .csv as extension on below line if you want to export data as csv
  downloadElement.download = 'RangePlan Summary_'+this.searchKey+'.csv';
  document.body.appendChild(downloadElement);
  downloadElement.click();
  }

downloadTableData(){
// Prepare a html table
let doc = '<table>';
// Add styles for the table
doc += '<style>';
doc += 'table, th, td {';
doc += '    border: 1px solid black;';
doc += '    border-collapse: collapse;';
doc += '}';          
doc += '</style>';
// Add all the Table Headers
doc += '<tr>';
this.columnHeader.forEach(element => {            
    doc += '<th>'+ element +'</th>'           
});
doc += '</tr>';
// Add the data rows
this.orderId.forEach(record => {
    doc += '<tr>';
    doc += '<th style="font-weight: normal;">'+(record.l1!=undefined?record.l1:'')+'</th>'; 
    doc += '<th style="font-weight: normal;">'+(record.l2!=undefined?record.l2:'')+'</th>'; 
    doc += '<th style="font-weight: normal;">'+(record.l3!=undefined?record.l3:'')+'</th>';
    doc += '<th style="font-weight: normal;">'+(record.priceBand!=undefined?record.priceBand:'')+'</th>'; 
    doc += '<th style="font-weight: normal;">'+(record.l4!=undefined?record.l4:'')+'</th>';
    doc += '<th style="font-weight: normal;">'+(record.costBand!=undefined?record.costBand:'')+'</th>';
    doc += '<th style="font-weight: normal;">'+(record.averageCost!=undefined?record.averageCost:'')+'</th>';
    doc += '<th style="font-weight: normal;">'+(record.totalOrderQuantity!=undefined?record.totalOrderQuantity:'')+'</th>';
    doc += '<th style="font-weight: normal;">'+(record.actualProcured!=undefined?record.actualProcured:'')+'</th>';
    if(record.balance_Quantity<0){
      doc += '<th style="color: red;font-weight: normal;">'+(record.balance_Quantity!=undefined?record.balance_Quantity:'')+'</th>';
    }else{
      doc += '<th style="font-weight: normal;">'+(record.balance_Quantity!=undefined?record.balance_Quantity:'')+'</th>';
    }
    doc += '<th style="font-weight: normal;">'+(record.orderValue!=undefined?record.orderValue:'')+'</th>';
    doc += '<th style="font-weight: normal;">'+(record.actualProcuredValue!=undefined?record.actualProcuredValue:'')+'</th>';
    if(record.balance_Cost<0){
      doc += '<th style="color: red;font-weight: normal;">'+(record.balance_Cost!=undefined?record.balance_Cost:'')+'</th>';
    }else{
      doc += '<th style="font-weight: normal;">'+(record.balance_Cost!=undefined?record.balance_Cost:'')+'</th>';
    }
    doc += '<th style="font-weight: normal;">'+(record.remarks!=undefined?record.remarks:'')+'</th>';
    doc += '</tr>';
});
doc += '</table>';
var element = 'data:application/vnd.ms-excel,' + encodeURIComponent(doc);
let downloadElement = document.createElement('a');
downloadElement.href = element;
downloadElement.target = '_self';
// use .csv as extension on below line if you want to export data as csv
downloadElement.download = 'RangePlan Summary_'+this.searchKey+'.xls';
document.body.appendChild(downloadElement);
downloadElement.click();

}

handelSearchKey(event){ //Order Id search input
    this.searchKey = event.target.value;
}
SearchRangePlanHandler(){ //search button

    if(this.searchKey != null)
    {
        fetchRangePlan({textkey: this.searchKey})
      .then(data =>
      {
        this.orderId = data;
        this.orderId.orderId = data.orderId;
        this.orderId.l1 = data.l1;
        this.orderId.l2 = data.l2;
        this.orderId.l3 = data.l3;
        this.orderId.priceBand = data.priceBand;
        this.orderId.l4 = data.l4;
        this.orderId.costBand = data.costBand;
        this.orderId.averageCost = data.averageCost;
        this.orderId.totalOrderQuantity = data.totalOrderQuantity;
        this.orderId.actualProcured = data.actualProcured;
        this.orderId.balance_Quantity = data.balance_Quantity;
        this.orderId.orderValue = data.orderValue;
        this.orderId.actualProcuredValue = data.actualProcuredValue;
        this.orderId.balance_Cost = data.balance_Cost;
        this.orderId.remarks = data.remarks;
      
        console.log('data'+JSON.stringify(data));
    if(this.orderId == '' || this.orderId == null || this.orderId == undefined){
      this.noRecordFound = 'No record found';
      this.visible = false;
      this.isTrue = true;
  
    }else{
      this.noRecordFound = ' ';
      this.visible = true;
      this.isTrue = false;
    }
      })
  }
  else if(this.searchKey == null || this.searchKey == ''){
      this.noRecordFound = 'Please enter Order Id';
      this.isTrue = true;
    }
  }
  get redIndicator() {
    return `slds-col slds-size_1-of-3 ${
      this.orderId.balance_Cost < 0 ? "blue" : "red",
      this.orderId.balance_Quantity < 0 ? "red" : "blue"
    }`;
  }  
}