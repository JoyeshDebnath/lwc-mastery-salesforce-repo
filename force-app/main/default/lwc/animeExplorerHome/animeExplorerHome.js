import { LightningElement } from 'lwc';
import searchAnime from '@salesforce/apex/AnimeExplorerController.searchAnime';
import getAnimeById from '@salesforce/apex/AnimeExplorerController.getAnimeById';

export default class AnimeExplorerHome extends LightningElement {
    animeList=[];
    selectedAnime=undefined;
    isLoading=false;
    errorMessage=undefined;
    //filter states 
    searchQuery='';
    selectedType='all';
    selectedStatus='all';
    selectedRating='all';
    //Pagination states
    currentPage=1;
    lastPage=1;
    totalcount=0;
    hasNextPage=false;
    hasSearched=false;

    //check if we have animes in the list 
    get hasAnimeResults(){
        return this.animeList && this.animeList.length > 0;
    }

    handleReset(){
        this.searchQuery='';
        this.selectedtype='all';
        this.selectedStatus='all';
        this.selectedRating='all';
        this.currentPage=1;
        this.animeList=[];
        this.errorMessage=undefined;
        this.hasSearched=false;
        this.totalcount=0;
        this.selectedAnime=undefined;

    }

    handleSearch(event){
        const {searchQuery,animeType,status,rating} = event.detail;
        this.searchQuery=searchQuery;
        this.selectedType=animeType;
        this.selectedStatus=status;
        this.selectedRating=rating;

        this.currentPage=1;
        this.hasSearched=true;
        this.fetchAnime();
    }

    async fetchAnime(){
        this.isLoading=true;
        this.errorMessage=undefined;
        this.animeList=[];
        try{
            const result=await searchAnime({
                searchQuery : this.searchQuery || '',
                animeType:this.animeType||'all',
                status:this.selectedStatus || 'all',
                rating : this.selectedRating || 'all',
                page : this.currentPage
            })
            this.animeList=result.data || [];
            this.lastPage=result.lastPage || 1;
            this.hasNextPage=result.hasNextPage || false;
            this.totalcount=result.totalCount || 0;

        }catch(error){
            this.errorMessage=error?.body?.message || 'Something Went Wrong';
        }finally{
            this.isLoading=false;
        }

    }

    async handleViewDetail(event){
        const malId=event.detail.malId;
           this.isLoading = true;
        try {
            this.selectedAnime = await getAnimeById({ malId });
        } catch (err) {
            this.errorMessage = 'Could not load anime details.';
        } finally {
            this.isLoading = false;
        }
    }

     handleCloseDetail() {
        this.selectedAnime = undefined;
    }

}