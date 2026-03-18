import { LightningElement } from 'lwc';
export default class LwcScenerioOne extends LightningElement {
    value="Show Input 1";
    get options(){
        return [
            {label:"Show Input 1",value:"Show Input 1"},
            {label:"Show Input 2",value:"Show Input 2"},
            {label:"Show Input 3",value:"Show Input 3"}
        ]
    }

    handleChange(evt){
        this.value=evt.detail.value;
    }

}