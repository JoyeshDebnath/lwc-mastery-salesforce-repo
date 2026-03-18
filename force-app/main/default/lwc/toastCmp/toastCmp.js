import { LightningElement,api } from 'lwc';

export default class ToastCmp extends LightningElement {
    showNotification=false;
    message;
    variant;
    //getter for the class 
    get notifyClasses(){
        return `slds-notify slds-notify_toast slds-theme_${this.variant}`;
    
    }
    //globlally exposed method 
    @api showToastNotification(message,variant){
        this.message=message;
        this.variant=variant;
        this.showNotification=true;
        setTimeout(()=>{
            this.showNotification=false;
        },5000);
    }
}