import { css } from "uebersicht"

export const command = "date +'%d,%b'"

export const refreshFrequency = 3 * 60 * 60 * 1000;
export const render = ({ output }) => {
    const [day, month] = output.trim().split(",")

    return (
        <div className={centralizedContainer}>
            <div className={container}>
                <div className={box}>
                    <span className={dayStyle}>{day}</span>
                    <span className={monthStyle}>{month}</span>
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
    //opacity:0.8;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    position:absolute;
    top:0;
    left:0;

    height:80px;
    width:80px;
    padding:18px;
    overflow:hidden;

    border-radius: 20px;
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
