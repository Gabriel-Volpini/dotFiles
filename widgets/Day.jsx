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
    pointer-events: none;
`

const box = css`
    background: #181825;
    
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    
    height: 116px;
    width: 116px;
    overflow:hidden;
    
    position:absolute;
    top:0;
    left:0;
    
    border-top-left-radius: 40px;
`

const dayStyle = css`
    font-size:48px;
    color:#eba0ac;
`
const monthStyle = css`
    font-size:18px;
    color:#cdd6f4;
`
