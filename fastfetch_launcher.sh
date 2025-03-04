#!/bin/bash

# Obtém o tema de ícones atual
ICON_THEME=$(grep "gtk-theme-name=" ~/.config/gtk-3.0/settings.ini | cut -d'=' -f2)

# Define a pasta de ícones baseada no tema
# ${XDG_CONFIG_HOME} eh a variavel de ambiente XDG_CONFIG_HOME, que define onde ficam os arquivos de config
# do usuario (atraves da especificacao do XDG)
# ':-' significa se a variavel estiver vazia ou nao definida, usa o valor a direita
# $HOME/.config eh o padrao caso XDG_CONFIG_HOME nao esteja definiido
if [[ "$ICON_THEME" == "Graphite-Mono" ]]; then
    PNG_FOLDER="${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/pngs/dark"
elif [[ "$ICON_THEME" == "Catppuccin-Mocha" ]]; then
    PNG_FOLDER="${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/pngs/Drakula-Blue"
elif [[ "$ICON_THEME" == "Decay-Green" ]]; then
    PNG_FOLDER="${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/pngs/dark-green"
elif [[ "$ICON_THEME" == "Material-Sakura" ]]; then
    PNG_FOLDER="${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/pngs/verde"
elif [[ "$ICON_THEME" == "Synth-Wave" ]]; then
    PNG_FOLDER="${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/pngs/rosa"
else
    PNG_FOLDER="${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/pngs/default"
fi

# Seleciona um PNG aleatório da pasta correspondente
PNG_FILE=$(find "$PNG_FOLDER" -name "*.png" | shuf -n 1)

# Substitui dinamicamente o valor do logo no JSON de configuração

#Sem paddgin top:
# jq --arg pngfile "$PNG_FILE" '.logo.source = $pngfile' ~/.config/fastfetch/config.jsonc > ~/.config/fastfetch/config_temp.jsonc

# Com padding top:
jq --arg pngfile "$PNG_FILE" '.logo = (.logo + {source: $pngfile})' ~/.config/fastfetch/config.jsonc > ~/.config/fastfetch/config_temp.jsonc


# Executa o Fastfetch com a configuração modificada
fastfetch --config ~/.config/fastfetch/config_temp.jsonc
