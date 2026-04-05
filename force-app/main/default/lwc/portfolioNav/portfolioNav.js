import { LightningElement, api } from 'lwc';

export default class PortfolioNav extends LightningElement {
    // LWC rule LWC1099: Boolean @api properties must default to false
    @api isDark = false;
    handleToggle(){
        this.dispatchEvent(new CustomEvent('themetoggle',{
            bubbles:true,
            composed:true
        }))
    }
}