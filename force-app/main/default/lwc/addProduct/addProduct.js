import { LightningElement,api,wire } from 'lwc';

export default class AddProduct extends LightningElement {
    @api recordId;
    @api objectApiName;
    records=[];
    objectName="Product2";
    iconName="standard:product"
    fields=["Name","Family","ProductCode"];
    displayFields='Name, Family, ProductCode';
    
    
    connectedCallback(){
        if(this.objectApiName==='Opportunity'){

        }else if(this.objectApiName==='Order'){

        }else if(this.objectApiName==='Quote'){

        }

        this.addRow();
    }

    addRow(event){
        // event.preventDefault();
        let record={
            Description:'',
            Quantity:null,
            UnitPrice:null,
            ServiceDate:null
        }
      this.records=[...this.records,record];
    //   console.log("rec "+this.records)

    }

    handleLookup(event){

    }
}