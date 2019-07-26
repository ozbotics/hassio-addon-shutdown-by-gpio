#!/usr/bin/with-contenv bashio
# ==============================================================================
#
# Ozbotics Add-ons: Shutdown by GPIO
#
# Initiate shutdown / reboot when GPIO pin is triggered
#
# ==============================================================================

shutdownButtonPin=$(bashio::config 'shutdown_button_pin')
shutdownTriggerLevel=$(bashio::config 'shutdown_trigger_level')
bootLedPin=$(bashio::config 'boot_led_pin')
rebootPulseMinMs=$(bashio::config 'reboot_pulse_min_ms')
shutdownPulseMinMs=$(bashio::config 'shutdown_pulse_min_ms')
pauseBeforeRebootSecs=$(bashio::config 'pause_before_reboot_secs')
pauseBeforeShutdownSecs=$(bashio::config 'pause_before_shutdown_secs')


configureGPIO() {
  if [ ! -e /sys/class/gpio/gpio$shutdownButtonPin ]; then
    echo -n $shutdownButtonPin > /sys/class/gpio/export
  fi  
  echo -n "in" > /sys/class/gpio/gpio$shutdownButtonPin/direction

  if [ ! -e /sys/class/gpio/gpio$bootLedPin ]; then
    echo -n $bootLedPin > /sys/class/gpio/export
  fi  
  echo -n "out" > /sys/class/gpio/gpio$bootLedPin/direction
  echo -n 1 > /sys/class/gpio/gpio$bootLedPin/value
}

shutdown() {
  bashio::log.info  "Shutting down in ${pauseBeforeShutdownSecs} seconds"
  echo -n 0 > /sys/class/gpio/gpio$bootLedPin/value
  sleep $pauseBeforeShutdownSecs
  echo `curl -s -X POST -H "X-HASSIO-KEY: $HASSIO_TOKEN" "http://hassio/host/shutdown"`
}

reboot() {
  bashio::log.info  "Rebooting in ${pauseBeforeRebootSecs} seconds"
  echo -n 0 > /sys/class/gpio/gpio$bootLedPin/value
  sleep $pauseBeforeRebootSecs
  echo `curl -s -X POST -H "X-HASSIO-KEY: $HASSIO_TOKEN" "http://hassio/host/reboot"`
}

monitorGPIO() {
  while true; do
    shutdownSignal=$(cat /sys/class/gpio/gpio$shutdownButtonPin/value)
    if [ $shutdownSignal != $shutdownTriggerLevel ]; then
      sleep 0.2
    else  
      pulseStart=$(date +%s%N | cut -b1-13)
      while [ $shutdownSignal = $shutdownTriggerLevel ]; do
        sleep 0.02
        if [ $(($(date +%s%N | cut -b1-13)-$pulseStart)) -gt $shutdownPulseMinMs ]; then
          shutdown
          exit
        fi
        shutdownSignal=$(cat /sys/class/gpio/gpio$shutdownButtonPin/value)
      done
      if [ $(($(date +%s%N | cut -b1-13)-$pulseStart)) -gt $rebootPulseMinMs ]; then 
        reboot
        exit
      fi
    fi
  done
}

main() {
  bashio::log.trace "${FUNCNAME[0]}"

  #bashio::log.info  "shutdown_button_pin: ${shutdownButtonPin}"
  #bashio::log.info  "shutdown_trigger_level: ${shutdownTriggerLevel}"
  #bashio::log.info  "boot_led_pin: ${bootLedPin}"
  #bashio::log.info  "reboot_pulse_min_ms: ${rebootPulseMinMs}"
  #bashio::log.info  "shutdown_pulse_min_ms: ${shutdownPulseMinMs}"
  #bashio::log.info  "pause_before_reboot_secs: ${pauseBeforeRebootSecs}"
  #bashio::log.info  "pause_before_shutdown_secs: ${pauseBeforeShutdownSecs}"

  configureGPIO
  bashio::log.info "Waiting for GPIO${shutdownButtonPin} to be held to ${shutdownTriggerLevel} for ${rebootPulseMinMs}ms to Reboot or ${shutdownPulseMinMs}ms to Shutdown"
  monitorGPIO

  while true; do
    sleep 0.2
  done
  
}
main "$@"
