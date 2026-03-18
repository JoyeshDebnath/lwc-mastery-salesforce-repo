import { LightningElement,wire,api } from 'lwc';
import getContactsList from "@salesforce/apex/ContactController2.getContactList";
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';


import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

const COLS=[
    {
        label:"First Name",
        fieldName:FIRSTNAME_FIELD.fieldApiName,
        editable:true
    },
    {
        label:"Last Name",
        fieldName:LASTNAME_FIELD.fieldApiName,
        editable:true
    },
    {
        label:"Title",
        fieldName:TITLE_FIELD.fieldApiName,
        editable:true
    },
    {
        label:"Email",
        fieldName:EMAIL_FIELD.fieldApiName,
        editable:true,
        type:"email"
    },{
        label:"Phone",
        fieldName:PHONE_FIELD.fieldApiName,
        editable:true,
        type:"phone"
    }
]
export default class PracticeDatatableInlineEditWithUiApi extends LightningElement {
    cols=COLS;
    draftValues=[];

    @wire(getContactsList)
    contacts;

    async handleSave(event){
        const recordsToBeUpdated=event.detail.draftValues.slice().map(draftValue=>{
            const fields=Object.assign({},draftValue);
            return { fields }
        })
       // console.log(recordsToBeUpdated);

        this.draftValues=[];
        try{
            const recordUpdatePromises=recordsToBeUpdated.map(record=>{
                updateRecord(record);
            })
            
            await Promise.all(recordUpdatePromises);
            this.dispatchEvent(
                new ShowToastEvent({
                    title:"Success",
                    message:"Updated Contacts",
                    variant:"success"
                })
            )

            await refreshApex(this.contacts);

        }catch(error){
            this.dispatchEvent(
                new ShowToastEvent({
                    title:"Error",
                    message:error.body.message,
                    variant:"error"
                })
            )
        }

    }



}