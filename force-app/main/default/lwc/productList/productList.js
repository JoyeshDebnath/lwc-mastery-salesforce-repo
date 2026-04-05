import { LightningElement, wire } from 'lwc';
import PRODUCT_CHANNEL from '@salesforce/messageChannel/ProductChannel__c';
import { publish, subscribe, unsubscribe, MessageContext, APPLICATION_SCOPE } from 'lightning/messageService';

const PRODUCTS = [
    { id: 'p-001', name: '💻MacBook PRO 14', category: 'Laptops', price: 199999, inStock: true, lowStock: false },
    { id: 'p-002', name: '🔊Sony WH-10000XM5', category: 'Audio', price: 45000, inStock: true, lowStock: true },
    { id: 'p-003', name: '📲IPAD Pro 12.9', category: 'Tablets', price: 78000, inStock: false, lowStock: false },
    { id: 'p-004', name: '🎧Logitech MX Master', category: 'Peripherals', price: 98000, inStock: true, lowStock: false },
    { id: 'p-005', name: '🖥️Samsung 4k Ultra monitor', category: 'Display', price: 34000, inStock: true, lowStock: true },
    { id: 'p-006', name: '⌨️Keyboard Asus', category: 'Peripherals', price: 12000, inStock: true, lowStock: false },
    { id: 'p-007', name: '🏏Hero Bat', category: 'Sports', price: 8900, inStock: false, lowStock: true },
    { id: 'p-008', name: '🚲Deklathon Cycle', category: 'Cycle', price: 25000, inStock: false, lowStock: false },
]

export default class ProductList extends LightningElement {
    @wire(MessageContext) messageContext;
    searchTerm = '';
    selectedProductId = null;
    subscription = null;
    delayTimeout;//debouncing purpose ... 


    connectedCallback() {
        this.subscription = subscribe(
            this.messageContext,
            PRODUCT_CHANNEL,
            (msg) => this.handleInboundMessage(msg),
            { scope: APPLICATION_SCOPE }
        )
    }
    disconnectedCallback() {
        unsubscribe(this.subscription)
        this.subscription = null;
    }
    //called when productDetail published a 'clear' action -> unselected Button is Clicked 
    handleInboundMessage(message) {
        console.log('JD'+JSON.stringify(message))
        if (message.action === 'clear') {
            this.selectedProductId = null;
        }
    }

    handleSearch(event) {
        // clearTimeout(this.delayTimeout);
        // this.delayTimeout = setTimeout(() => {
            this.searchTerm = event.target.value;
        // }, 300);

    }

    get filteredProducts() {
        const term = this.searchTerm.toLowerCase();
        return PRODUCTS.filter((product) => {
           return  product.name.toLocaleLowerCase().includes(term) || product.category.toLocaleLowerCase().includes(term)
        }).map(p => {
            return {
                ...p,
                rowClass: `product-row ${p.id === this.selectedProductId}?'selected' : ''`,
                stockLabel: p.inStock ? (p.lowStock ? 'Low Stock' : 'In Stock') : 'Out Of Stock',
                stockClass: p.inStock ? (p.lowStock ? 'slds-theme_warning' : 'slds-theme_success') : 'slds-theme_error'
            }
        })
    }

    handleProductClick(event){
        const {id,name,price,category} =event.currentTarget.dataset;
        this.selectedProductId=id;
        publish(this.messageContext,PRODUCT_CHANNEL,{
            productId:id,
            productName:name,
            productCategory:category,
            productPrice:price,
            action:'select'
        })
    }

    handleClear(){
        this.selectedProductId=null;
        publish(this.messageContext,PRODUCT_CHANNEL,{
            productId:null,
            productName:null,
            productCategory:null,
            productPrice:null,
            action:'clear'
        })
    }



}