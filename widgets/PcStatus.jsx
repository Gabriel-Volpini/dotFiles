import { css } from "uebersicht"

export const command = "bash ./scripts/PcStatus.sh";

export const refreshFrequency = 60 * 1000;
export const render = ({ output }) => {
    const { ram, volume, bateria, cpu } = JSON.parse(output)

    return (
        <div className={centralizedContainer}>
            <div className={box}>
                <Data value={cpu} type="cpu" />
                <Data value={ram} type="ram" />
                <Data value={volume} type="volume" />
                <Data value={bateria} type="battery" />
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
    justify-content: space-evenly;
    
    height: calc(116px * 2 + 16px);
    width: calc(116px * 3 + 8px);
    overflow:hidden;
    
    position:absolute;
    top: calc(116px * 2 + 16px);
    left:0;
`

const Item = css`
    width: 85%;
    height: 28px;

    display: flex;
    align-items: center;
    justify-content: space-between;
`

const OutterBar = css`
    width: 85%;
    height: 8px;
    border-radius: 4px;
    overflow: hidden;
    background:#585b70;
`
const InnerBar = css`
    height: 100%;
    transition: width 0.3s ease;
    border-radius: 4px;
`

const Data = ({ value, type }) => (
    <div className={Item}>
        <svg width="28" height="28" viewBox="0 0 512 512" >
            {Icons[type]}
        </svg>
        <div className={OutterBar} >
            <div className={InnerBar} style={{
                width: `${value}%`,
                background: IconColors[type]
            }}>
            </div >
        </div >
    </div >

)

const IconColors = {
    cpu: "#a6e3a1",
    ram: "#fab387",
    volume: "#74c7ec",
    battery: "#cba6f7"
}

const Icons = {
    cpu: <path fill={IconColors.cpu} d="M176 24c0-13.3-10.7-24-24-24s-24 10.7-24 24l0 40c-35.3 0-64 28.7-64 64l-40 0c-13.3 0-24 10.7-24 24s10.7 24 24 24l40 0 0 56-40 0c-13.3 0-24 10.7-24 24s10.7 24 24 24l40 0 0 56-40 0c-13.3 0-24 10.7-24 24s10.7 24 24 24l40 0c0 35.3 28.7 64 64 64l0 40c0 13.3 10.7 24 24 24s24-10.7 24-24l0-40 56 0 0 40c0 13.3 10.7 24 24 24s24-10.7 24-24l0-40 56 0 0 40c0 13.3 10.7 24 24 24s24-10.7 24-24l0-40c35.3 0 64-28.7 64-64l40 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-40 0 0-56 40 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-40 0 0-56 40 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-40 0c0-35.3-28.7-64-64-64l0-40c0-13.3-10.7-24-24-24s-24 10.7-24 24l0 40-56 0 0-40c0-13.3-10.7-24-24-24s-24 10.7-24 24l0 40-56 0 0-40zM160 128l192 0c17.7 0 32 14.3 32 32l0 192c0 17.7-14.3 32-32 32l-192 0c-17.7 0-32-14.3-32-32l0-192c0-17.7 14.3-32 32-32zm192 32l-192 0 0 192 192 0 0-192z" />,
    ram: <path fill={IconColors.ram} d="M64 64C28.7 64 0 92.7 0 128l0 7.4c0 6.8 4.4 12.6 10.1 16.3C23.3 160.3 32 175.1 32 192s-8.7 31.7-21.9 40.3C4.4 236 0 241.8 0 248.6L0 320l576 0 0-71.4c0-6.8-4.4-12.6-10.1-16.3C552.7 223.7 544 208.9 544 192s8.7-31.7 21.9-40.3c5.7-3.7 10.1-9.5 10.1-16.3l0-7.4c0-35.3-28.7-64-64-64L64 64zM576 352L0 352l0 64c0 17.7 14.3 32 32 32l48 0 0-32c0-8.8 7.2-16 16-16s16 7.2 16 16l0 32 96 0 0-32c0-8.8 7.2-16 16-16s16 7.2 16 16l0 32 96 0 0-32c0-8.8 7.2-16 16-16s16 7.2 16 16l0 32 96 0 0-32c0-8.8 7.2-16 16-16s16 7.2 16 16l0 32 48 0c17.7 0 32-14.3 32-32l0-64zM192 160l0 64c0 17.7-14.3 32-32 32s-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32s32 14.3 32 32zm128 0l0 64c0 17.7-14.3 32-32 32s-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32s32 14.3 32 32zm128 0l0 64c0 17.7-14.3 32-32 32s-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32s32 14.3 32 32z" />,
    volume: <path fill={IconColors.volume} d="M301.1 34.8C312.6 40 320 51.4 320 64l0 384c0 12.6-7.4 24-18.9 29.2s-25 3.1-34.4-5.3L131.8 352 64 352c-35.3 0-64-28.7-64-64l0-64c0-35.3 28.7-64 64-64l67.8 0L266.7 40.1c9.4-8.4 22.9-10.4 34.4-5.3zM412.6 181.5C434.1 199.1 448 225.9 448 256s-13.9 56.9-35.4 74.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C393.1 284.4 400 271 400 256s-6.9-28.4-17.7-37.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5z" />,
    battery: <path fill={IconColors.battery} d="M96 0C78.3 0 64 14.3 64 32l0 96 64 0 0-96c0-17.7-14.3-32-32-32zM288 0c-17.7 0-32 14.3-32 32l0 96 64 0 0-96c0-17.7-14.3-32-32-32zM32 160c-17.7 0-32 14.3-32 32s14.3 32 32 32l0 32c0 77.4 55 142 128 156.8l0 67.2c0 17.7 14.3 32 32 32s32-14.3 32-32l0-67.2C297 398 352 333.4 352 256l0-32c17.7 0 32-14.3 32-32s-14.3-32-32-32L32 160z" />
}
