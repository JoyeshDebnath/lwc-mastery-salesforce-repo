import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

export default class PubsubAssignmentContactCreatorCmp extends LightningElement {
    contactObj = CONTACT_OBJECT;
    firstname = FIRST_NAME_FIELD;
    lastname = LAST_NAME_FIELD;
    email = EMAIL_FIELD;
    phone = PHONE_FIELD;
    
    handleContactCreated (event) { 
        event.preventDefault();//stop form from submitting
        window.console.log(JSON.stringify(event.detail.fields));
        let newContact = event.detail.fields;
        pubsub.fire('newcontactcreated', newContact);
        this.template.querySelector('lightning-record-edit-form').submit(event.detail.fields);
    }

    handleSuccess (event) {
        const contactId = event.detail.id;
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'New Contact Created And Event fired , The Contact ID :'+contactId,
                variant:'success'
                
            })
        );
    }
}