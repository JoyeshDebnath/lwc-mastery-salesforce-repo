import { LightningElement, api } from 'lwc';

export default class Lwc_BeerTileCmp extends LightningElement {
    @api beerRecord;

    handleAddToCart () {
        const addToCartEvt = new CustomEvent('addtocart', {
            detail: this.beerRecord.Id
        })

        this.dispatchEvent(addToCartEvt);
    }
}