import { LightningElement,wire,api } from 'lwc';
import {refreshApex} from '@salesforce/apex';
import { deleteRecord } from 'lightning/uiRecordApi';
import getLatestAccounts from '@salesforce/apex/AccountController.getAccountList';
import updateAccountRecord from '@salesforce/apex/AccountController.updateAccountRecord';

// datatable 
const columns=[
    {label:'Name',fieldName:'Name',type:'text'},
    {label:'Phone',fieldName:'Phone',type:'text'},
    {label:'Rating',fieldName:'Rating',type:'text'},
    {label:'Industry',fieldName:'Industry',type:'text'}
]
export default class LwcApexDemo extends LightningElement {
  columns=columns;
  selectedRecord;
  errors;
  accountList=[];
  wiredAccountList=[];

  @wire(getLatestAccounts)
  accList(result){
    this.wiredAccountList=result;
    if(result.data){
        this.accountList=result.data;
        this.errors=undefined;
    }
    else{
        this.errors=result.error;
        this.accountList=[];
    }
  }

  handleRowSelection(event){
    if(event.detail.selectedRows.length>0){
        this.selectedRecord=event.detail.selectedRows[0].Id;
    }
  }

  handleDelete(){
    deleteRecord(this.selectedRecord)
    .then(()=>{
      refreshApex(this.wiredAccountList)
    }).catch(err=>{
      alert('Something went wrong !!!')
    })
  }

  updateRecord(){
    updateAccountRecord({recordId:this.selectedRecord})
    .then(result=>{
      console.log(result);
      refreshApex(this.wiredAccountList);
    }).catch(err=>{
      console.log('Error : '+err);
    })
  }

}