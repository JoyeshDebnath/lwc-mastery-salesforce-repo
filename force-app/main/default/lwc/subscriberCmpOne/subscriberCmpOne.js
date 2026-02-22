import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class SubscriberCmpOne extends LightningElement {
    message;
    connectedCallback(){
        this.register();
    }

    register(){
        window.console.log('Event is Registered ..');
        pubsub.register('simpleEvnt',this.handleEvent.bind(this));
    }

    handleEvent(messageFromEvt){
        window.console.log('Event is handled ..',messageFromEvt);
        this.message=messageFromEvt ? JSON.stringify(messageFromEvt,null,"\t"):"no message Payload"
    }
}