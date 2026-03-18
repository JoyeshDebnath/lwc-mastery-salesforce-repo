import { LightningElement,wire,api } from 'lwc';

export default class Fetch_lwc extends LightningElement {
    characters = [];
    error;

    connectedCallback () { 
        this.fetchCharactersData();
    }

    fetchCharactersData () { 
        fetch('https://dragonball-api.com/api/characters')
            .then(response => { 
                if (!response.ok)
                { 
                    throw new Error('HTTP Error');
                }
                return response.json();
            })
            .then(data => { 
                this.characters = data.items;
                this.error = undefined;
                console.log('Data', this.characters);
            }).catch(err => { 
                this.error = err;
                this.characters = undefined;
                console.log('Failed to fetch the characters ... ', err);
            })
    }
}