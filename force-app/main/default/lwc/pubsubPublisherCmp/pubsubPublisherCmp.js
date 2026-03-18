import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';
//import {fire} from 'c/pubsub';


export default class PubsubPublisherCmp extends LightningElement {


    handleClick () { 
        window.console.log('Event is Firing .....');
        let message = {
            "message": 'Hello Pub Sub ',
            "name": 'Joyesh Debnath',
            "channel":'SFDCDebnath'
        }

        pubsub.fire('simpleEvt', message);
        window.console.log('Event Fired !');
    }
}