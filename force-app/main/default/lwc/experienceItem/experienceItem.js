import { LightningElement,api } from 'lwc';

export default class ExperienceItem extends LightningElement {
    @api company='';
    @api role='';
    @api period='';
    @api description='';
    @api isLast=false;
}