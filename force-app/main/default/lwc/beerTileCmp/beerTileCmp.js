import { LightningElement,api,wire } from 'lwc';
import beerImage from '@salesforce/resourceUrl/beerImg';
export default class BeerTileCmp extends LightningElement {
    beerImage=beerImage;
    @api beerRecord;

    handleAddToCart(event){

    }
}