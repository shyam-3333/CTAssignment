import { LightningElement, api } from 'lwc';

export default class SkinnViewOnlyComp extends LightningElement {
    @api skinnCollectionRecords;
    @api productLaunchDate;
    @api tentativeLaunchDate;
}