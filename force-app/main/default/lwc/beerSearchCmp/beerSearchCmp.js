import { LightningElement, wire, api } from 'lwc';

export default class BeerSearchCmp extends LightningElement {
    searchValue = "";


    handleChange(event) {
        this.searchValue = event.target.value;
        console.log('inside search cnp',this.searchValue)
        this.dispatchEvent(
            new CustomEvent('beersearch', {
                detail: this.searchValue
            }
            )
        )
    }
}