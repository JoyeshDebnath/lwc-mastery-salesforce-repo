import { LightningElement,api } from 'lwc';

export default class SkillBar extends LightningElement {
    @api name  = '';
    @api level = ''; // 'Expert' | 'Advanced' | 'Intermediate' | 'Beginner'
    @api pct   = 0;  // 0-100
 
    // Inline style is the only safe way to set a dynamic width in LWC
    get fillStyle() {
        const clamped = Math.min(100, Math.max(0, Number(this.pct)));
        return `width: ${clamped}%`;
    }
}