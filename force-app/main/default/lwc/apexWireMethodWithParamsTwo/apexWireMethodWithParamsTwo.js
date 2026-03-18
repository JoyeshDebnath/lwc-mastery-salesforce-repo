import { LightningElement,wire } from 'lwc';
import findContacts from '@salesforce/apex/ContactController2.findContacts';

const DELAY=300;

export default class ApexWireMethodWithParamsTwo extends LightningElement {
    searchKey='';
    //delayTimeout;

    @wire(findContacts,{searchKey:"$searchKey"})
    contacts;

    handleKeyChange(event){
        window.clearTimeout(this.delayTimeout);
        const searchKey=event.target.value;
        this.delayTimeout=setTimeout(()=>{
            this.searchKey=searchKey;
        },DELAY);
    }
}