import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class SubscriberCmpTwo extends LightningElement {
    message;

    connectedCallback(){
        this.register();
    }

    register(){
        window.console.log('Event is Registered ....');
        pubsub.register('simple_Evnt',this.handleEvent.bind(this));
    }

    handleEvent(messageFromEvt){
        this.message=messageFromEvt? JSON.stringify(messageFromEvt,null,"\t"):"no message from Event was Recived "
    }
}