import { css } from "uebersicht"

export const command = "date +'%d,%b'"

export const refreshFrequency = 3 * 60 * 60 * 1000;
export const render = ({ output }) => {
    const [day, month] = output.trim().split(",")

    return (
        <div className={centralizedContainer}>
            <div className={box}>
                <span className={dayStyle}>{day}</span>
                <span className={monthStyle}>{month}</span>
            </div>
        </div>
    )
}

const centralizedContainer = css`
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
    //opacity:0.8;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    position:fixed;
    padding:18px 32px;

    border-radius: 20%;
    border: 5px solid #b4befe;
`

const dayStyle = css`
    font-size:48px;
    color:#eba0ac;
`
const monthStyle = css`
    font-size:18px;
    color:#f5e0dc;
`
