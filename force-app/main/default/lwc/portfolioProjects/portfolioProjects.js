import { LightningElement } from 'lwc';

export default class PortfolioProjects extends LightningElement {
      get projects() {
        return [
            {
                id: 1,
                icon: '🎥',
                title: 'Bioscope',
                description: 'Fullstack Web app  where users can login and search movies and TV shows . Implemented voice search feature and wishlist feature',
                tagsJson: '["Javascript","React JS","Firebase"]',
                url: 'https://github.com/JoyeshDebnath/Bioscope-OTT-platform'
            },
            {
                id: 2,
                icon: '🔗',
                title: 'CFE (GE Vernova)',
                description: 'Worked on Internal application development named CFE where I worked as a front end developer building the UI with Angular JS and implemented features like Resuable Datatables , Navigation and Routing, Authentication , Dynamic Design and also integrated intenal APIs ',
                tagsJson: '["Java","CSS","Angular JS"]',
                url: '#'
            },
            {
                id: 3,
                icon: '📊',
                title: 'Analytics Dashboard',
                description: 'Worked on interanl Aero application in GE Vernova where I built custom UI solutions for business using LWC and Aura and impemented business soln using Apex triggers , Apex classes and Flows',
                tagsJson: '["Aura","LWC","Apex","SOQL","FLOWS","Salesforce"]',
                url: '#'
            },
           
        ];
    }
}