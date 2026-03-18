import { LightningElement,api,wire} from 'lwc';
import {refreshApex} from '@salesforce/apex';
import getContactsList from '@salesforce/apex/ContactController2.getContactList';


const COLS=[
    {label:"First Name" , fieldName:"FirstName"},
    {label:"Last Name",fieldName:"LastName"},
    {label:"Contact Phone",fieldName:"Phone",type:"phone"},
    {label:"Contact Email",fieldName:"Email",type:"email"},
    {label:"Contact Title",fieldName:"Title"},
    {label:"Contact Picture",
        type:"customPictureType",
        typeAttributes:{
            pictureURL:{fieldName:"Picture__c"}
        },
        cellAttributes:{alignment:'center'}
    }
]
export default class DatatableWithCustomDatatatype extends LightningElement {
    columns=COLS;

    @wire(getContactsList)
    contacts;
}