import { LightningElement } from 'lwc';

export default class PortfolioApp extends LightningElement {
    isDark=true;

    get themeClass(){
        return this.isDark ? 'portfolio-wrapper' : 'portfolio-wrapper theme--light';
    }
    
    handleThemeToggle(){
        this.isDark=!this.isDark;
        if(this.isDark){
            this.template.host.classList.remove('theme--light');
        }else{
            this.template.host.classList.add('theme--light');
        }
    }
}