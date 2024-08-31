{
  self,
  config,
  ...
}: {
  xdg.configFile = {
    "sketchybar/cpu/item.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar

        sketchybar                                        \
          --add item cpu right                            \
          --set cpu update_freq=10                        \
                    icon=                                \
                    script="$CONFIG_ROOT/cpu/script.sh"
      '';
    };

    "sketchybar/cpu/script.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source $CONFIG_ROOT/vars.sh

        CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
        CPU_INFO=$(ps -eo pcpu,user)
        CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
        CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

        CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

        sketchybar --set $NAME label="$CPU_PERCENT%" icon.color="$COLOR_INFORMATION"

        if [ "CPU_PERCENT" -gt "60" ]; then
          sketchybar --set $NAME icon.color="$COLOR_WARNING"
        else if [ "$CPU_PERCENT" -gt "80" ]; then
          sketchybar --set $NAME icon.color="$COLOR_ERROR"
        fi
      '';
    };
  };
}
