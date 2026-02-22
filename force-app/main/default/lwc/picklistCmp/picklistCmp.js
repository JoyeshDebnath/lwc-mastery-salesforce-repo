import { LightningElement,api,wire } from 'lwc';
import {getObjectInfo,getPicklistValues } from 'lightning/uiObjectInfoApi';



export default class PicklistCmp extends LightningElement {
    accountRecordTypeId;
    ratings;
    error;
    @api objectApiName;
    @api fieldApiName; 
    
    picklistValue;
    picklistLabel;
    picklistPlaceholder;
    picklistOptions=[];
    picklistName;



    @wire(getObjectInfo,{objectApiName:'$objectApiName'})
    results({data,error}){
        if(data){
            this.accountRecordTypeId=data.defaultRecordTypeId;
            this.error=undefined;
        }else if(error){
            this.accountRecordTypeId=undefined;
            this.error=error;
        }
    }

    @wire(getPicklistValues,{recordTypeId:'$accountRecordTypeId',fieldApiName:'$fieldApiName'})
    picklistResults({data,error}){
        if(data){
            this.picklistOptions=data.values.map(item=>{
                return{
                    label:item.label,
                    value:item.value
                }
            });
            this.error=undefined;
        }else if(error){
            this.ratings=undefined;
            this.error=error;
        }
    }

    handleChange(event){
        this.picklistValue=event.detail.value;
        this.dispatchEvent(new CustomEvent('valuechange',{
            detail:{value:this.picklistValue}
        }))
    }
}