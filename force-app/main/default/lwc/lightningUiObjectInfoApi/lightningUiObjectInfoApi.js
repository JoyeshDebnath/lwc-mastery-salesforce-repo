import { LightningElement,wire,api } from 'lwc';
import {getObjectInfo} from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class LightningUiObjectInfoApi extends LightningElement {
        @wire(getObjectInfo,{objectApiName:ACCOUNT_OBJECT})
        accntObjectInfo({data,error}){
            if(data){
                console.log('Data===>'+data);
            }if(error){
                console.log('EROR==>'+error)
            }
        }

        


}