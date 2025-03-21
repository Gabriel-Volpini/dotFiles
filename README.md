# Dotfiles Setup

Este repositório contém os arquivos de configuração para otimizar e personalizar seu ambiente de desenvolvimento e trabalho. Os programas configurados incluem ferramentas de terminal, gerenciadores de janelas e outros utilitários essenciais.

## Programas Configurados

- **Neovim**: Um editor de texto altamente extensível baseado no Vim, focado em modernidade e desempenho. Usado principalmente para edição de código.
- **WezTerm**: Um emulador de terminal GPU-accelerated, multiplaforma, focado em velocidade e flexibilidade.
- **SketchyBar**: Uma barra de status altamente customizável para macOS, que permite criar e organizar widgets e informações de sistema. **yabai**: Um gerenciador de janelas em mosaico para macOS que oferece controle total sobre as janelas, suportando atalhos de teclado e layouts automáticos.
- **eza**: Um substituto moderno para o comando `ls`, oferecendo uma visualização mais rica e informativa dos arquivos.
- **zsh**: Um shell poderoso que melhora a produtividade no terminal, suportando complementos como `oh-my-zsh` e `zoxide`.
- **zoxide**: Um substituto rápido para `cd` que melhora a navegação no terminal através de diretórios mais utilizados.

Quando for usar Übersicht , nao usar stow, apenas altere as configs direto
## Estrutura do Repositório

```plaintext
dotfiles/
├── config/
│   ├── nvim/
│   │   └── init.vim
│   ├── wezterm/
│   │   └── wezterm.lua
│   ├── sketchybar/
│   │   ├── config.json
│   │   └── items/
│   ├── yabai/
│   │   └── yabairc
│   └── zsh/
│       └── zshrc
├── setup_symlinks.sh
├── README.md
└── LICENSE
```
