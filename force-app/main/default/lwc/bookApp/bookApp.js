import { LightningElement } from 'lwc';

const BOOK_URL='https://www.googleapis.com/books/v1/volumes?q=';

export default class BookApp extends LightningElement {
    searchKey='Man';
    books;
    connectedCallback(){
        this.fetchBooksDetails();
    }

    async fetchBooksDetails(){
            try{
                    const response=await fetch(BOOK_URL+this.searchKey);
                    if(!response.ok){
                        throw new Error('Something went Wrong !');
                    }
                    const data =await response.json();
                    this.books=data;
                    console.log(this.books);

            }catch(error){
                console.log('Something went Wrong !'+error);
            }
    }



}