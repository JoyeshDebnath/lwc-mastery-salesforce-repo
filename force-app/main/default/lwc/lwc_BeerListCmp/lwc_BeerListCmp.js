import { LightningElement,api,wire } from 'lwc';
import searchBeer from '@salesforce/apex/LWC_BeerController.searchParams';
import getCartId from '@salesforce/apex/LWC_BeerController.getCartId';
import cartIcon from '@salesforce/resourceUrl/CartLogo';
import createCartItems from '@salesforce/apex/LWC_BeerController.createCartItems';

export default class Lwc_BeerListCmp extends LightningElement {
    beerRecords;
    errors;
    cartId;
    cart = cartIcon;
    itemsInCart = 0;

    connectedCallback () { 
        this.defaultCartId();
    }
    //imperative call for apex 
    defaultCartId () { 
        getCartId()
            .then(data => { 
                this.cartId = data;
                console.log('Data received = ' + data);
            }).catch(err => { 
                this.cartId = undefined;
                console.log(err);
            })
    }

    @wire(searchBeer)
    wiredRecords ({ error, data }) { 
        console.log('Data',data)
        this.beerRecords = data;
        this.errors = error;
    } 

    


    handleSearch (event) { 
        let value = event.detail.value;
        searchBeer({
            searchParam:value
        }).then(res => { 
            console.log(res);
        }).catch(err => { 
                console.log(err);
        })

    }

    handleAddToCart (event) {
        const beerId = event.detail.value;
        const selectedBeerRecord=this.beerRecords.find(beer => beer.Id === beerId);
        

        createCartItems({
            cartId:this.cartId,
            beerId: selectedBeerRecord.Id,
            amount:selectedBeerRecord.Price__c
        })
            .then(data => { 
                console.log('cart item id :'+data);
                this.itemsInCart++;
            }).catch(err => { 
                console.log(err);
            })
    }
}