import { LightningElement,api,wire } from 'lwc';
import fetchTodos from '@salesforce/apex/ReminderApplicationUtil.fetchTodos';

export default class Reminders extends LightningElement {
    reminderList = [];
    errors;

    @wire(fetchTodos)
    wiredTodoFetchResponse ({ data, error }) { 
        if (data)
        {
            this.reminderList = data;
            this.errors = undefined;
        }
        else if (error)
        { 
            this.errors=error
        }
    }


}