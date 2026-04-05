import { LightningElement } from 'lwc';

export default class PortfolioContact extends LightningElement {
    formName    = '';
    formEmail   = '';
    formMessage = '';
    submitSuccess = false;

    contactLinks = [
        { id: 1, icon: '@',  label: 'Email',    value: 'itsmejoyeshdebnath26@email.com',         href: 'mailto:itsmejoyeshdebnath26@email.com' },
        { id: 2, icon: 'in', label: 'LinkedIn', value: '/in/JoyeshDebnath',           href: 'https://linkedin.com/in/joyeshdebnath' },
        { id: 3, icon: 'gh', label: 'GitHub',   value: 'github.com/JoyeshDebnath',   href: 'https://github.com/JoyeshDebnath' }
    ];

    handleName(e)    { this.formName    = e.target.value; }
    handleEmail(e)   { this.formEmail   = e.target.value; }
    handleMessage(e) { this.formMessage = e.target.value; }

    handleSubmit() {
        // Wire up to an Apex EmailService or Salesforce Web-to-Lead here
        // For now we just show a success message
        if (this.formName && this.formEmail && this.formMessage) {
            this.submitSuccess = true;
            this.formName = this.formEmail = this.formMessage = '';
            setTimeout(() => { this.submitSuccess = false; }, 4000);
        }
    }
}