import { LightningElement,wire,api } from 'lwc';
import {refreshApex} from '@salesforce/apex';
import {ShowToastEvent} from  'lightning/platformShowToastEvent';
import getContactList from '@salesforce/apex/ContactController2.getContactList';
import updateContactsInfo  from '@salesforce/apex/ContactController2.updateContactsInfo';

const COLS=[
    {label:"First Name",fieldName:"FirstName",type:"text",editable:true},
    {label:"Last Name",fieldName:"FirstName",type:"text",editable:true},
    {label:"Contact Phone",fieldName:"Phone",type:"phone",editable:true},
    {label:"Contact Email",fieldName:"Email",type:"email",editable:true},
    {label:"Title",fieldName:"Title",type:"text",editable:true},
]


export default class DatatableWithInlineEditInApexTwo extends LightningElement {
     columns=COLS;
     draftValues=[];

     @wire(getContactList)
     contacts;

     //handleSave 
     async handleSave(event){
        try{        
            const updatedValues= event.detail.draftValues;//edited records 
        this.draftValues=[];//empty 
        console.log('Darft Values Printed ',JSON.stringify(updatedValues))
        await updateContactsInfo({contactListToUpdate:updatedValues});
        this.dispatchEvent(new ShowToastEvent({
            title:"Success",
            message:"Updated Succesfully!",
            variant:"success"
        }))
        await refreshApex(this.contacts);
    }catch(err){
        this.dispatchEvent(new ShowToastEvent({
            title:"Error",
            message:"Error Occured!",
            variant:"error"
        }))
    }
     }


}