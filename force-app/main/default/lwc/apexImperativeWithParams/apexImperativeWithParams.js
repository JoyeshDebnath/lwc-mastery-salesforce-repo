import { LightningElement,wire } from 'lwc';
import searchContacts from '@salesforce/apex/ContactController2.findContacts';

export default class ApexImperativeWithParams extends LightningElement {
    searchKey='';
    contacts;
    error;

    handleKeyChage(event){
        this.searchKey=event.target.value;
    }

   async handleSearch(){
     try{
        this.contacts=await searchContacts({searchKey:this.searchKey});
        this.error=undefined;
     }catch(err){
        this.error=err;
        this.contacts=undefined;
     }
    }
}