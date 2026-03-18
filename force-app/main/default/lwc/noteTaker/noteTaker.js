import { LightningElement,wire } from 'lwc';
import createNoteRecord from '@salesforce/apex/NoteTakerController.createNoteRecord';
import fetchNotes from '@salesforce/apex/NoteTakerController.fetchNotes';
import updateNote from '@salesforce/apex/NoteTakerController.updateNote';
import deleteNote from '@salesforce/apex/NoteTakerController.deleteNote';

import {refreshApex} from '@salesforce/apex';

const DEFAULT_NOTE_FORM={
    Name:"",
    Note_Description__c:""
}

export default class NoteTaker extends LightningElement {
       formats = [
        'font',
        'size',
        'bold',
        'italic',
        'underline',
        'strike',
        'list',
        'indent',
        'align',
        'link',
        'clean',
        'table',
        'header',
        'color',
    ];
    showModal=false;
    noteRecord=DEFAULT_NOTE_FORM;
    wiredNotesResult;
    allNotes;
    selectedRecordId;

    get actionHeaderName(){
        return (this.selectedRecordId)?'Edit Note ':"Add Note"
    }

    @wire(fetchNotes)
    noteListInfo(result){
        this.wiredNotesResult=result;
        if(this.wiredNotesResult.data){
                
                this.allNotes=this.wiredNotesResult.data.map(item=>{
                    let formattedDate=new Date(item.LastModifiedDate).toDateString();//converting the date to formttaed string format 
                    return {...item,formattedDate};
                })
                console.log(JSON.stringify(this.allNotes));
        }if(this.wiredNotesResult.error){
            // console.log(error.message.body);
        }
    }

 
    
    get isFormInvalid(){
           return !(this.noteRecord && this.noteRecord.Name && this.noteRecord.Note_Description__c); 
    }
    

    createNoteModalHandler(){
        this.showModal=true;
        this.noteRecord=DEFAULT_NOTE_FORM;//empty the note record ......
    }

    closeModalHandler(){
        this.showModal=false;
        this.selectedRecordId=null
    }

    changeHandler(event){
        event.preventDefault();
        const {name,value}=event.target;
        this.noteRecord={...this.noteRecord,[name]:value};
        

    }
//called on click of submit btn  in modal 
    formSubmitHandler(event){
        event.preventDefault();
        if(this.selectedRecordId){
            this.updateNoteHandler();
        }else{
            this.createNoteHandler();
        }
       }

    showToastMsg(message,variant){
        const ele=this.template.querySelector('c-toast-cmp');
        ele?.showToastNotification(message,variant);
    }

    onEditNote(event){
        let {recordid}=event.target.dataset;
        const filteredNote=this.allNotes.find(note=>note.Id===recordid)
        this.noteRecord={
            Name:filteredNote.Name,
            Note_Description__c:filteredNote.Note_Description__c
        }
        this.selectedRecordId=recordid;
        this.showModal=true;
    }
    //this is for creating note .....
    createNoteHandler(){
         createNoteRecord(
            {
                title:this.noteRecord.Name,
                description:this.noteRecord.Note_Description__c
            }
        ).then((res)=>{
            // console.log('Note created Successfully !',res);
            this.showModal=false;
            this.showToastMsg('Note created Successfully !','success');
            refreshApex(this.wiredNotesResult);
        }).catch(err=>{
            // console.error("error=>",err.message.body);
           this.showToastMsg(err.message.body,'error');
        })
    }

    //this is for updating note 
    updateNoteHandler(){
        
        updateNote({
            recordId:this.selectedRecordId,
            name:this.noteRecord.Name,
            description:this.noteRecord.Note_Description__c
        }).then(res=>{
            this.showModal=false;
            this.showToastMsg('Note updated Successfully !','success');
            this.selectedRecordId=null;
            refreshApex(this.wiredNotesResult)
            
        }).catch(err=>{
            this.showModal=false;
            this.showToastMsg(err.message.body,'error');
        })
    }

    onDeleteNote(event){
        deleteNote({
            recordId:event.target.dataset.recordid
        }).then(res=>{
            this.showToastMsg('Note got deleted !','success');
            refreshApex(this.wiredNotesResult);
        }).catch(err=>{

        })
    }

}