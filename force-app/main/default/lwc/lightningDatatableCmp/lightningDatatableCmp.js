import { LightningElement, wire, api } from 'lwc';

const columns = [{ label: 'Opportunity Name', fieldName: 'OpportunityName', type: 'text' },
{
    label: 'Probability ', fieldName: 'Probability', type: 'percent',
    cellAttributes: {
        iconName: { fieldName: "TrendIcon" },
        iconPositionm: "right"
    }
},
{
    label: 'Amount', fieldName: 'Amount', type: 'currency',
    typeAttributes: {
        currencyCode: 'EUR',
        step: '0.001'
    }
},
{
    label: 'Contact Email', fieldName: 'Contact', type: 'email'

},
{
    label: 'Contact Phone', fieldName: 'Phone', type: 'phone'

}

]
const data = [
    {
        Id: '1',
        OpportunityName: 'Cloud 9',
        Probability: 0.2,
        Amount: 90333,
        Contact: 'joggers78@cloud9.com',
        Phone: '999848848',
        TrendIcon: 'utility:down'
    },
    {
        Id: '2',
        OpportunityName: 'Anthronic',
        Probability: 0.2,
        Amount: 90333,
        Contact: 'ShefaaliD@Anthronic.com',
        Phone: '8634826348634',
        TrendIcon: 'utility:up'
    }
]
export default class LightningDatatableCmp extends LightningElement {
    data = data;
    columns = columns

    getSelectedName(event){
        const selectedRows=event.detail.selectedRows;
        for(i=0;i<selectedRows.length;i++){
            alert('You Selected : '+selectedRows[i].OpportunityName);
        }
    }

}