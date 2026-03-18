import { LightningElement } from 'lwc';
import fetchAccountWithContact from '@salesforce/apex/AccountWrapperController.getAccountWithContactsData';

export default class AccountWrapperlwc extends LightningElement { 
    accountWrapperDataList = [];

    connectedCallback () { 
        this.fetchWrapperData();
    }

    fetchWrapperData () { 
        fetchAccountWithContact().then((result) => {
            this.accountWrapperDataList = result;
            console.log('Result \n',result);
        }).catch((err) => { 
            console.error('Error while fetching accounts records ',err);
        })
    }
}