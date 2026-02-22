import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';


export default class PublisherCmp extends LightningElement {


    handlePublish(event){
        window.console.log('Event is Firing ....');
        let message={
            "message":"Hello PubSub !!!",
            "name":"Joyesh Debnath",
            "channel":"SFDC_Debnath"
        }
        pubsub.fire("simpleEvnt",message);
        pubsub.fire("simple_Evnt",message);
        window.console.log('Event is Fired!!!');
    }
}