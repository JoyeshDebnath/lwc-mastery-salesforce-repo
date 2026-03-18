import { LightningElement,api,wire } from 'lwc';
import {getRecord,getFieldValue} from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import OWNER_EMAIL_FIELD from "@salesforce/schema/Account.Owner.Email";

export default class SalesforceDataTesting extends LightningElement {
    @api recordId;
    @api objectApiName='Account';
    @api fields;
   
    accountObject=ACCOUNT_OBJECT;
    @wire(getRecord,{ recordId:"$recordId",fields:[NAME_FIELD,RATING_FIELD,OWNER_EMAIL_FIELD]})
    accRecord;

    get name(){
        return getFieldValue(this.accRecord.data,NAME_FIELD);
    }
        get rating(){
        return getFieldValue(this.accRecord.data,RATING_FIELD);
    }
    get owner(){
        return this.accRecord.data?getFieldValue(this.accRecord.data,OWNER_EMAIL_FIELD):'';
    }

    handleReset(event){
        event.preventDefault();
        const inputFields=this.template.querySelectorAll('lightning-input-field');
        if(inputFields){
            inputFields.forEach((field)=>{field.reset()})
        }
    }


    fields=['AccountId','Name','Phone','Rating'];
}