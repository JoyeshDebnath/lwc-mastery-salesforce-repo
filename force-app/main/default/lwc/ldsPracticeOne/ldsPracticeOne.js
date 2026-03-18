import { LightningElement,api,wire } from 'lwc';
import {getRecord,getFieldValue} from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import NAME_FIELD  from '@salesforce/schema/Contact.Name';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
// Parents Data pulling 
import CONTACT_OWNER_NAME_FIELD from '@salesforce/schema/Contact.Owner.Name';

export default class LdsPracticeOne extends LightningElement {
    @api recordId;
    @api objectApiName;
    

    fields=["AccountId","Name","Title","Phone","Emmail"];

    @wire(getRecord,{recordId:'$recordId',fields:[NAME_FIELD,EMAIL_FIELD,CONTACT_OWNER_NAME_FIELD]})
    record;

    get nameValue(){
        return this.record.data? getFieldValue(this.record.data,NAME_FIELD):"BLANK!";
    }

    get emailValue(){
        return this.record.data ? getFieldValue(this.record.data,EMAIL_FIELD):"BLANK!"
    }
    get ownerNameValue(){
        return this.record.data?getFieldValue(this.record.data,CONTACT_OWNER_NAME_FIELD):"BLANK";
    }


}