import { css } from "uebersicht"

export const command = `date "+%A|%H:%M"`; // separa dia e hora com um pipe

export const refreshFrequency = 10 * 60 * 1000; // 10 minutos

export const render = ({ output }) => {
    const [dia, hora] = output.trim().split("|");

    return (
        <div className={centralizedContainer}>
            <div className={container}>
                <div className={box}>
                    <div className={dataWrapper}>
                        <span className={tempStyle}>{hora}</span>
                    </div>
                    <span className={rawStyle}>{dia}</span>
                </div>
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

const container = css`
width:100%;
height:100%;
position:relative;
`
const box = css`
background: #181825;
max-width: 35%;
min-width: 35%;
overflow:hidden;
//opacity:0.8;

display: flex;
flex-direction: column;
align-items: center;
justify-content: center;
gap:10px;

position:absolute;
top: 122px;
left: 0px;

height:80px;
padding:18px;
overflow:hidden;
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
color:#f5e0dc;
`
