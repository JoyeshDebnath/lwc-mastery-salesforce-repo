import { LightningElement,wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import {refreshApex} from '@salesforce/apex';
import {updateRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

// ---------------------------------Fields impprt -----------------------------------------

import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import ID_FIELD from '@salesforce/schema/Contact.Id';

const COLS=[
    {
        label:'First Name',
        fieldName:FIRST_NAME_FIELD.fieldApiName,
        editable:true
    },
     {
        label:'Last Name',
        fieldName:LAST_NAME_FIELD.fieldApiName,
        editable:true
    },
     {
        label:'Email',
        fieldName:EMAIL_FIELD.fieldApiName,
        type:"email",
        editable:true
    },
     {
        label:'Phone',
        fieldName:PHONE_FIELD.fieldApiName,
        type:"phone",
        editable:true
    },
     {
        label:'Title',
        fieldName:TITLE_FIELD.fieldApiName,
        editable:true
    }
]

export default class DatatableOne extends LightningElement {
    columns=COLS;
    draftValues=[];

    @wire(getContacts)
    contacts;

    async handleSave(event){
        const records=event.detail.draftValues.slice().map(draftValue=>{
            const fields=Object.assign({},draftValue);
            return {fields}
        })
        this.draftValues=[];
        try{
        const recordUpdatePromises=records.map(record=>{
            updateRecord(record);
        })
        await Promise.all(recordUpdatePromises);
        this.dispatchEvent(
            new ShowToastEvent({
                title:'Success',
                message:'Contacts Were Updated ',
                variant:'success'
            })
        )
        await refreshApex(this.contacts);
    }catch(error){
        this.dispatchEvent({
            title:'Error',
            message:'Error While Updating !',
            variant:'error'
        })
    }


    }
}