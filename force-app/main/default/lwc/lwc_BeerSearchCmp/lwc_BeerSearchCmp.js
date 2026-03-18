import { LightningElement } from 'lwc';

export default class Lwc_BeerSearchCmp extends LightningElement {
    searchValue = '';

    handleChange (event) { 
        const value = event.target.value;
        console.log(value);

        const searchEvent = new CustomEvent('search', {
            detail:value
        })
        this.dispatchEvent(searchEvent);
    }
}