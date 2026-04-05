import { LightningElement } from 'lwc';

export default class PortfolioSkills extends LightningElement {
     skillGroups = [
        {
            id: 1,
            title: 'Salesforce Platform',
            skills: [
                { name: 'Lightning Web Components', level: 'Advanced',       pct: 85 },
                { name: 'Apex',                     level: 'Advanced',       pct: 90 },
                { name: 'Flow Builder',             level: 'Advanced',     pct: 80 },
                { name: 'SOQL / SOSL',              level: 'Advanced',     pct: 85 },
                { name: 'Salesforce CRM',            level: 'Amateur',     pct: 60 }
            ]
        },
        {
            id: 2,
            title: 'Development',
            skills: [
                { name: 'JavaScript',        level: 'Advanced',     pct: 82 },
                { name: 'HTML & CSS',               level: 'Advanced',     pct: 80 },
                { name: 'REST / SOAP APIs',         level: 'Intermediate', pct: 70 },
                { name: 'Git & SFDX CLI',           level: 'Advanced',     pct: 80 },
                { name: 'Integration',        level: 'Intermediate', pct: 65 }
            ]
        }
    ];
 
    certifications = [
        'Platform Developer I',
        'Agentforce Specialist',
        'Javascript Developer'
    ];
}