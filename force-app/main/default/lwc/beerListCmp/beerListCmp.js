import { LightningElement,wire,api } from 'lwc';
import searchBeers from '@salesforce/apex/BeerController.searchBeers';
import  getCartId from '@salesforce/apex/BeerController.getCartId';

export default class BeerListCmp extends LightningElement {

    beers=[];
    error='';
    cartId;


    isLoading=false;
    connectedCallback(){
        this.defaultCartId();
    }

    defaultCartId(){
        getCartId()
        .then(res=>{
            console.log('Cart ID=>'+res)
            this.cartId=res;
        })
        .catch(err=>{
            this.cartId=undefined;
        })
    }


    handleBeerSearch(event){
        console.log(event)
        const searchQuery=event.detail;
        console.log('inside beer search ....',searchQuery)
        this.searchBeersFunc(searchQuery);
    }

    async searchBeersFunc(searchQuery){
        this.isLoading=true;
        this.error=undefined;
        try{
            const result=await searchBeers({searchParam:searchQuery});
            this.beers=result;
            console.log(this.beers)
        }catch(err){
            this.error=err;
            this.beers=[];
            console.error('Search beer error:',err);
        }
        finally{
            this.isLoading=false;
        }
    }

}