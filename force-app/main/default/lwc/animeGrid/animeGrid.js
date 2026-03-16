import { LightningElement,api } from 'lwc';


export default class AnimeGrid extends LightningElement {
    @api animeList=[];
    @api isLoading=false;
    @api hasSearched=false; //has user ever searched
    
    get hasAnime(){
        return this.animeList && this.animeList.length>0
    }

    get showEmpty(){
        return !this.hasSearched && !this.hasAnime && !this.isLoading ; 
    }

    get showWelcome(){
        return !this.isLoading && !this.hasSearched
    }
}