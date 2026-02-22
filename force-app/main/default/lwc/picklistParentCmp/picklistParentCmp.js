import { LightningElement } from 'lwc';


export default class PicklistParentCmp extends LightningElement {


    handleRatingChange(event){
        alert(event.detail.value)
    }

    handleLeadSourceChange(event){
        alert(event.detail.value)
    }
}