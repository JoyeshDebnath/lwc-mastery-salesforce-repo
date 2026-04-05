import { LightningElement,wire } from 'lwc';
import PRODUCT_CHANNEL from '@salesforce/messageChannel/ProductChannel__c';
import {subscribe,publish,unsubscribe,
    APPLICATION_SCOPE,MessageContext} from 'lightning/messageService';

export default class ProductDetail extends LightningElement {
    @wire(MessageContext) messagecontext;
    selectedProduct=null;
    subscription=null;

    connectedCallback(){
        this.subscribeToChannel();
    }
    disconnectedCallback(){
        unsubscribe(this.messagecontext);
        this.subscription=null;
    }

    subscribeToChannel(){
        if(this.subscription) return ;

        this.subscription=subscribe(
            this.messagecontext,
            PRODUCT_CHANNEL,
            (message)=>this.handleMessage(message),
            {scope:APPLICATION_SCOPE}
        )
    }
     
    get todayDate() {
        return new Date().toLocaleDateString('en-US', {
            year: 'numeric', month: 'short', day: 'numeric'
        });
    }

    handleUnselect(){
        this.selectedProduct=null;
        publish(this.messagecontext,
            PRODUCT_CHANNEL,
            {
                productId:null,
                productName:null,
                productPrice:null,
                productCategory:null,
                action:'clear'
        })
    }

    handleMessage(message){
        if(message.action==='select'){
            this.selectedProduct={
                id:message.productId,
                name:message.productName,
                category:message.productCategory,
                price:message.productPrice,

            }
        }else if(message.action==='clear'){
            this.selectedProduct=null
        }
        console.log('selected'+this.selectedProduct)
    }

}