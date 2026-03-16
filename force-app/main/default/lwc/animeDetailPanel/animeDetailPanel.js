import { LightningElement,api } from 'lwc';

export default class AnimeDetailPanel extends LightningElement {
       @api anime;  // ← full AnimeWrapper object passed from parent

    get hasGenres()     { return this.anime.genres && this.anime.genres.length > 0; }
    get scoreDisplay()  { return this.anime.score != null ? this.anime.score : 'N/A'; }
    get episodeLabel()  { return this.anime.episodes ? `${this.anime.episodes} episodes` : 'Episodes unknown'; }

    handleClose() {
        // Fire event UP — parent sets selectedAnime = null which removes this component
        this.dispatchEvent(new CustomEvent('close'));
    }

    // Close when clicking outside the panel (on backdrop)
    handleBackdropClick() { this.handleClose(); }
    stopBubble(e)         { e.stopPropagation(); }

    openMAL() { window.open(this.anime.url, '_blank'); }

    handleImgError(e) {
        e.target.src = 'https://placehold.co/240x340/4f46e5/white?text=No+Image';
    }
}

 
