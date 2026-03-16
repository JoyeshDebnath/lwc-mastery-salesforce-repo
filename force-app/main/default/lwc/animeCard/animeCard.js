import { LightningElement,api } from 'lwc';

export default class AnimeCard extends LightningElement {
    @api anime;

    connectedCallback(){
        console.log(this.anime)
    }
     get displayTitle() {
        const t = this.anime.titleEnglish || this.anime.title || 'Unknown';
        return t.length > 38 ? t.substring(0, 35) + '...' : t;
    }

    get displayScore() {
        return this.anime.score != null ? this.anime.score : 'N/A';
    }

    get episodeLabel() {
        return this.anime.episodes ? `${this.anime.episodes} eps` : '? eps';
    }

    get statusClass() {
        const map = {
            'airing' : 'status-pill airing',
            'complete'  : 'status-pill finished',
            'upcoming'    : 'status-pill upcoming',
        };
        return map[this.anime.status] || 'status-pill';
    }

    // ── Events ────────────────────────────────────────────────────────────────

    handleAnimeClick() {
        // KEY CONCEPT: bubbles: true means this event travels up through
        // animeGrid WITHOUT animeGrid needing to handle or re-fire it.
        // animeExplorer catches it directly.
        this.dispatchEvent(new CustomEvent('viewdetail', {
            detail  : { malId: this.anime.malId },
            bubbles : true,   // ← climbs the component tree
            composed: true    // ← crosses shadow DOM boundaries
        }));
    }

    handleImgError(e) {
        e.target.src = 'https://placehold.co/200x280/4f46e5/white?text=No+Image';
    }


}