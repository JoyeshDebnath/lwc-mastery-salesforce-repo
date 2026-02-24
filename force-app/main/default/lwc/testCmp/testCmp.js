import { LightningElement } from 'lwc';

export default class TestCmp extends LightningElement {

    handleSelectedEvt(evt){
        alert(evt.detail)
    }
}