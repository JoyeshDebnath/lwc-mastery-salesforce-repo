import { LightningElement,api } from 'lwc';

export default class ProjectCard extends LightningElement {
     @api icon        = '';
    @api title       = '';
    @api description = '';
    @api url         = '#';
    @api tags        = '[]'; // Passed as JSON string from parent
 
    get parsedTags() {
        if (Array.isArray(this.tags)) return this.tags;
        try {
            return JSON.parse(this.tags);
        } catch (e) {
            return [];
        }
    }
}