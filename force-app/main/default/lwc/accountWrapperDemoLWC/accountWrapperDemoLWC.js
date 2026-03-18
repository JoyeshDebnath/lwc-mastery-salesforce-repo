import { LightningElement,wire } from 'lwc';
import getAccountWithContact from '@salesforce/apex/AccountWrapperDemo.getAccountWithContacts';
export default class AccountWrapperDemoLWC extends LightningElement {
    @wire(getAccountWithContact) wrapperList;
}