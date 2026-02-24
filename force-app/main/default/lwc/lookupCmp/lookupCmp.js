import { LightningElement,wire,api } from 'lwc';
import searchRecords from '@salesforce/apex/LookupUtility.searchRecords';


export default class LookupCmp extends LightningElement {
    @api objectApiName;
    @api fieldApiName;
    @api searchKey='';
    records;

    handleChange(event){
        this.searchKey=event.target.value;

        searchRecords({
            objectApiName:this.objectApiName,
            fieldApiName:this.fieldApiName,
            searchKey:this.searchKey
        }).then(res=>{
            this.records=res;
        }).catch(err=>{
            console.log(err);
        })

    }

    handleSelect(event){
        const recordID=event.currentTarget.dataset.id;
        const selectedEvent= new CustomEvent('lookupevt',{
            detail:recordID
        })
        this.dispatchEvent(selectedEvent);
    }
}