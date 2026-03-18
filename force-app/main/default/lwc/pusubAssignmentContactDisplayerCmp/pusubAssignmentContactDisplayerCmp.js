import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';


export default class PusubAssignmentContactDisplayerCmp extends LightningElement {

    contactList = [];

    connectedCallback () { 
        this.register();
    }

    register () { 
        window.console.log('Event is regsitered ');
        pubsub.register('newcontactcreated', this.handleNewContactsCreatedDisplay.bind(this));
    }

    handleNewContactsCreatedDisplay (newContact) { 
        this.contactList = [...this.contactList, newContact];
        window.console.log('The information : ',JSON.stringify (this.contactList));

    }
}