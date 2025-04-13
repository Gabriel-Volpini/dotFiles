import { css } from "uebersicht"

export const command = "bash ./scripts/spotify.sh";

export const refreshFrequency = 1 * 60 * 1000; // 10 minutos

export const render = ({ output }) => {
    if (!output) return <NotPlaying />

    const { track, album, image, artist, is_playing } = JSON.parse(output)

    return (
        <div className={centralizedContainer}>
            <div className={box}>
                <div className={coverWrapper}>
                    <div className={coverVinilCenter} />
                    <img src={image} className={cover} />
                </div>
                <div className={description}>
                    <span>{truncate(track, 20)}</span>
                    <span className="artist">{truncate(artist, 20)}</span>
                </div>
                <div className={needle} />
            </div>
        </div>
    )
}

const NotPlaying = () => (
    <div className={centralizedContainer}>
        <div className={box}>
            <span>nada tocando</span>
        </div>
    </div>
)

const centralizedContainer = css`
    box-sizing: content-box;
    @font-face {
        font-family: "Antikor";
        src: url("Antikor.ttf");
    }
    font-family: "Antikor";
    
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    
    width: 60%;
    height: 80%;
`
const box = css`
    background: #181825;
    
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 16px; 

    height: 116px;
    width: calc(116px * 3 + 8px);
    overflow:hidden;
    
    position:absolute;
    top: calc(2 * 116px + 16px);
    left:0;
`

const coverWrapper = css`
    overflow:hidden;
    border-radius:50%;
    border: 6px solid #585b70;
    position:relative;
    width: 80px;
    height:80px;
    margin-left:16px;
`
const coverVinilCenter = css`
    border-radius:50%;
    border: 10px solid #585b70;
    height: 10px;
    width: 10px;

    position: absolute;
    top: 32%;
    left: 32%;
`
const description = css`
    display:flex;
    flex-direction:column;
    gap:8px;
    color:#cdd6f4;
    .artist {
        color:#a6adc8; 
    }
`
const cover = css`
    heigth: 82px;
    width: 82px;
`

const needle = css`
    background: #9399b2;
    width: 4px;
    height: 32px;
    position: absolute;
    bottom: 13px;
    left: 35px;
    transform: rotate(45deg);
`

function truncate(text, max) {
    return text.length > max ? text.slice(0, max - 1) + "…" : text;
}
