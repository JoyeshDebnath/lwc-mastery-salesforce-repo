import { LightningElement,api } from 'lwc';

export default class AnimeSearchBar extends LightningElement {
    @api searchQuery;
    @api selectedType;
    @api selectedStatus;
    @api selectedRating;
    @api isLoading=false;

    localQuery='';
    localType='all';
    localStatus='all';
    localRating='all';
    // type Options ..
    
    typeOptions =[
        {label:'All Types',value:'all'},
        {label:'TV',value:'tv'},
        {label:'Movie',value:'ova'},
        {label:'Special',value:'special'},
        {label:'ONA',value:'ona'},
        {label:'Music',value:'music'},
        {label:'CM',value:'cm'},
        {label:'PV',value:'pv'},
        {label:'TV Special',value:'tv_special'}
    ]
    
    // status options ...
    statusOptions=[
        {label:'All Status',value:'all'},
        {label:'Airing',value:'airing'},
        {label:'Complete',value:'complete'},
        {label:'UpComing',value:'upcoming'}
    ]
    
    //rating options 
    ratingOptions=[
        {label:'All Ratings',value:'all'},
        {label:'PG - Children',value:'pg'},
        {label:'PG-13 - Teens 13 or older',value:'pg13'},
        {label:'R - 17+ (violence & profanity)',value:'r17'},
        {label:'R+ - Mild Nudity',value:'r'},
        {label:'Hentai',value:'rx'},
        {label:'G-All Ages',value:'g'},
        {label:'PV',value:'pv'},
        {label:'TV Special',value:'tv_special'}
    ]

    connectedCallaback(){
        this.localQuery=this.searchQuery || '';
        this.localStatus=this.selectedStatus || 'all';
        this.localType=this.selectedType || 'all';
        this.localRating=this.selectedRating || 'all';
    }

    fireSearch(){
        this.dispatchEvent(new CustomEvent('search',{
            detail:{
                searchQuery:this.localQuery,
                animeType:this.localType,
                status:this.localStatus,
                rating:this.localRating
            }
        }))
    }

    fireReset(){
        this.localQuery='';
        this.localRating='all';
        this.localStatus='all';
        this.localType='all';
        this.dispatchEvent(new CustomEvent('reset'))
    }

    handleQueryChange(e){
        this.localQuery=e.target.value;
    }
    handleTypeChange(e){
        this.localType=e.target.value;

    }
    handleStatusChange(e){
        this.localStatus=e.target.value;
    }
    handleRatingChange(e){
        this.localRating=e.target.value;
    }


    
}