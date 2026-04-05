import { LightningElement } from 'lwc';

export default class PortfolioExperience extends LightningElement {
       experiences = [
        {
            id: 1,
            company: 'Infosys',
            role: 'Senior Associate Consultant (Salesforce Developer)',
            period: '2024 — Present',
            description: 'Built solutions in Salesforce Platform for Clients like GE Vernova ' +
                         'to solve business problems and usecases using LWC,Apex, Triggers, Flows etc.',
            isLast: false
        },
        {
            id: 2,
            company: 'GE Vernova',
            role: 'Front End Engineer|Salesforce Developer',
            period: '2023 — 2024',
            description: 'Delivered CRM customisations and automated complex business processes ' +
                         'using Flow, Process Builder, and Apex triggers.'+
                         'Worked on Frontend development on internal application using Angular JS and React ',
            isLast: false
        },
        {
            id: 3,
            company: 'HighRadius',
            role: 'Junior Developer',
            period: '2022 — 2023',
            description: 'Worked on internal B2B application using tech stacks :' +
                         'React Js, Java - Spring Boot,MySQL,and Python to solve business'
                          +'problems and usecases.',
            isLast: true
        }
    ];
}