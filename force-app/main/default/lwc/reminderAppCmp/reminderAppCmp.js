import { LightningElement, wire } from 'lwc';
import getDynamicPicklistValues from '@salesforce/apex/PicklistUtil.getDynamicPicklistValues';
import createTodoItem from '@salesforce/apex/ReminderApplicationUtil.createTodoItem';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';




export default class ReminderAppCmp extends LightningElement {
    statusOptions = [];
    priorityOptions = [];
    isLoading = false;
    recordToCreate = {
        "Subject": '',
        "ActivityDate": null,
        "Status": '',
        "Priority": '',
        "Description": ''
    }

    @wire(getDynamicPicklistValues, {
        objectApiName: "Task",
        fieldName: "Status"
    })
    wiredStatusOptions ({ data, error }) {
        if (data)
        {
            this.statusOptions = data;
            console.log("Status Data \n", this.statusOptions)
        }
    }

    @wire(getDynamicPicklistValues, {
        objectApiName: "Task",
        fieldName: "Priority"
    })
    wiredPriorityOptions ({ data, error }) {
        if (data)
        {
            this.priorityOptions = data;
            console.log("Priority  Data \n", this.priorityOptions)

        }
    }



    handleChange (event) {
        event.preventDefault();
        var value = event.target.value;
        var name = event.target.name;
        this.recordToCreate[name] = value;
    }


    handleSubmit (event) {
        event.preventDefault();
        if (this.validateInput())
        {
            this.isLoading = true;
            console.log("Record To create = ", JSON.stringify(this.recordToCreate));
            createTodoItem({
                taskStr: JSON.stringify(this.recordToCreate)
            }).then(data => {
                console.log("Successful ");
                let successToastMsg = new ShowToastEvent({
                    'title': 'Success',
                    'message': 'The Todo is successfully Created !',
                    'variant':'success'
                })

                this.dispatchEvent(successToastMsg);
            }).catch(err => {
                console.log('Failed to insert record ', JSON.stringify(err))
                let errorToastMsg = new ShowToastEvent({
                    'title': 'Error',
                    'message': JSON.stringify(err),
                    'variant':'error'
                })

                this.dispatchEvent(errorToastMsg);
            }).finally(() => {
                this.isLoading = false;
            })
        }
    }

    validateInput () {
        const allValid = [
            ...this.template.querySelectorAll('lightning-input'),
        ].reduce((validSoFar, inputCmp) => {
            inputCmp.reportValidity();
            return validSoFar && inputCmp.checkValidity();
        }, true);
        if (allValid)
        {
            alert('All form entries look valid. Ready to submit!');
        } else
        {
            alert('Please update the invalid form entries and try again.');
        }


        const allValidCombobox = [
            ...this.template.querySelectorAll('lightning-combobox'),
        ].reduce((validSoFar, inputCmp) => {
            inputCmp.reportValidity();
            return validSoFar && inputCmp.checkValidity();
        }, true);
        if (allValid)
        {
            alert('All form entries look valid. Ready to submit!');
        } else
        {
            alert('Please update the invalid form entries and try again.');
        }

        return allValid && allValidCombobox
    }


}