#!/bin/bash

# Função pra calcular uso de RAM (em %)
get_ram_usage() {
  pages_free=$(vm_stat | grep "Pages free" | awk '{print $3}' | tr -d '.')
  pages_active=$(vm_stat | grep "Pages active" | awk '{print $3}' | tr -d '.')
  pages_speculative=$(vm_stat | grep "Pages speculative" | awk '{print $3}' | tr -d '.')
  pages_inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | tr -d '.')
  pages_wired=$(vm_stat | grep "Pages wired down" | awk '{print $4}' | tr -d '.')

  page_size=$(vm_stat | grep "page size of" | awk '{print $8}' | tr -d '.')
  total_pages=$(($pages_free + $pages_active + $pages_speculative + $pages_inactive + $pages_wired))
  used_pages=$(($pages_active + $pages_speculative + $pages_wired))
  used_percent=$((100 * $used_pages / $total_pages))
  echo $used_percent
}

# RAM
ram=$(get_ram_usage)

# VOLUME
volume=$(osascript -e "output volume of (get volume settings)")

# BATERIA
bateria=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

# USO DE CPU
cpu=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | cut -d% -f1)
cpu=${cpu%.*}

# JSON de saída
echo "{\"ram\": $ram, \"volume\": $volume, \"bateria\": $bateria, \"cpu\": $cpu}"
