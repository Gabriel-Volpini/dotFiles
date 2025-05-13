import { run, css, } from 'uebersicht'

export const refreshFrequency = false

const data = [
    {
        name: "Fairfax",
        dir: "~/Documents/stere/CLIENTS/fairfax"
    }
];

export const render = ({ output }, dispatch) => {
    return (
        <div className={centralizedContainer}>
            <div className={box}>
                {
                    data.map(i => (
                        <div
                            key={i.dir}
                            className={listItem}
                            onClick={() => run(`/opt/homebrew/bin/wezterm start --cwd "${i.dir}" -- zsh -lic '/opt/homebrew/bin/nvim; exec zsh'`).then(() => run(`osascript -e 'tell application "WezTerm" to activate'`))}
                        >
                            {i.name}
                        </div>
                    ))
                }
            </div>
        </div>
    );
};

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
    align-items: start;
    justify-content: space-around;
    
    height: calc(116px * 5 + 40px);
    width: calc(116px * 3 + 24px);
    overflow:hidden;
    
    position:absolute;
    top:0;
    left: calc(116px * 3 + 16px);
`

const listItem = css`
    color:#cdd6f4;
    margin-left:24px;
`
const monthStyle = css`
    font-size:18px;
    color:#cdd6f4;
`
