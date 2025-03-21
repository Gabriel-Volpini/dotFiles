import { css } from "uebersicht"

let lastDay = null

export const command = "date +'%d,%b'"

export const refreshFrequency = 3 * 60 * 60 * 1000;
export const render = ({ output }) => {
    const [day, month] = output.trim().split(",")
    const currentDay = day

    return (
        <div className={centralizedContainer}>
            <div className={container}></div>
        </div>
    )
}
//const box = css``
const centralizedContainer = css`
    @font-face {
        font-family: "Antikor";
        src: url("Antikor.ttf");
    }
    font-family: "Antikor";
    font-size:38px;

    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);

    width: 60%;
    height: 80%;
`

const container = css`
    background: rgba(255, 0, 0, 0.7);
    opacity:0.5;
    width:100%;
    height:100%;
    position:relative;
`

const box = css`
    background: #1e1e2e;
    opacity:0.9;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    width: 15%;
    height: 15%;

    border-radius: 20%;
`

