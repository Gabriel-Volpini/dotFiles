import { css } from "uebersicht"

export const command = `date "+%A|%H:%M"`; // separa dia e hora com um pipe

export const refreshFrequency = 60 * 1000; // 10 minutos

export const render = ({ output }) => {
    const [dia, hora] = output.trim().split("|");

    return (
        <div className={centralizedContainer}>
            <div className={box}>
                <div className={dataWrapper}>
                    <span className={tempStyle}>{hora}</span>
                </div>
                <span className={rawStyle}>{dia}</span>
            </div>
        </div>
    )
}

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
    flex-direction: column;
    align-items: center;
    justify-content: center;
    
    height: 116px;
    width: calc(116px * 3 + 8px);
    overflow:hidden;
    
    position:absolute;
    top: calc(116px + 8px);
    left:0;
`

const tempStyle = css`
    font-size: 38px;
    color: #89b4fa;
    padding-top: 10px
`

const dataWrapper = css`
    display:flex;
    align-items:center;
    justify-content:center;
    flex-direction: row;
    gap:20px;
`
const rawStyle = css`
    font-size: 18px;
    color:#cdd6f4;
`
