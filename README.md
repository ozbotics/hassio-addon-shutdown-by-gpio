# Shutdown by GPIO

[![Release][release-shield]][release] ![Project Stage][project-stage-shield] ![Project Maintenance][maintenance-shield]


Shutdown by GPIO by Ozbotics.

## About

This addon provides support for gracefull shutdown (or reboot) when a GPIO pin is pulsed.
This allows attached UPS modules or simple momentary switches to initiate safe shutdowns.

This add-on was originally written to support the Raspberry Pi X720 UPS HAT.
The default options match the X720's requirements

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. [Add our Hass.io add-ons repository][repository] to your Hass.io instance.
1. Install the "Shutdown by GPIO" add-on
1. Configure the "Shutdown by GPIO" add-on
1. Start the "Shutdown by GPIO" add-on

## Configuration

This addon provides configuration options to specify:

- Shutdown GPIO Pin (the pin your button or device is connected to)
- Trigger Level (the state HI | LOW of the pin, that triggers the shutdown)
- The minimum length of pulse to trigger reboot (short press)
- The minimum length of pulse to trigger shutdown (long press)
- The amount of time to pause before actually performing shutdown/reboot (handy when debugging)
- Status LED GPIO Pin (the pin your Status LED is connected to)

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```json
{
  "log_level": "info",
  "shutdown_button_pin": 4,
  "shutdown_trigger_level": 1,
  "boot_led_pin": 17,
  "reboot_pulse_min_ms": 200,
  "shutdown_pulse_min_ms": 600,
  "pause_before_reboot_secs": 60,
  "pause_before_shutdown_secs": 60
}
```

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`:  Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

### Option: `shutdown_button_pin`

Sets the GPIO pin your device uses to connect to the Raspberry Pi. 
The value must be between `1` and `27`. This value is set to `4` by default.

### Option: `shutdown_trigger_level`

Sets the pin level your device uses to trigger a shutdown
`0` for LOW or `1` for HIGH. This value is set to `1` by default.

### Option: `boot_led_pin`

Sets the GPIO pin your device uses as a status LED. 
The value must be between `1` and `27`. This value is set to `17` by default.

### Option: `reboot_pulse_min_ms`

Sets the minimum amount of time (in milliseconds) that the signal must be held to trigger a reboot (short press)
The value must be between `10` and `1000`. This value is set to `200` by default.

### Option: `shutdown_pulse_min_ms`

Sets the minimum amount of time (in milliseconds) that the signal must be held to trigger a shutdown (long press)
The value must be between `100` and `10000`. This value is set to `600` by default.

### Option: `pause_before_reboot_secs`

Sets the amount of time (in seconds) that the system pauses before initiating reboot
The value must be between `0` and `1000`. This value is set to `60` by default.

### Option: `pause_before_shutdown_secs`

Sets the amount of time (in seconds) that the system pauses before initiating shutdown
The value must be between `0` and `1000`. This value is set to `60` by default.


## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases]
functionality. The format of the log is based on
[Keep a Changelog][keepchangelog].

Releases are based on [Semantic Versioning][semver], and use the format
of ``MAJOR.MINOR.PATCH``. In a nutshell, the version will be incremented
based on the following:

- ``MAJOR``: Incompatible or major changes.
- ``MINOR``: Backwards-compatible new features and enhancements.
- ``PATCH``: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You have several options to get them answered:

- The [Community Hass.io Add-ons Discord chat server][discord] for add-on
  support and feature requests.
- The [Home Assistant Discord chat server][discord-ha] for general Home
  Assistant discussions and questions.
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

You could also [open an issue here][issue] GitHub.

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

## Authors & contributors

The original setup of this repository is by [Jon van Noort][ozbotics].

## License

MIT License

Copyright (c) 2019 Ozbotics

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[commits-shield]: https://img.shields.io/github/commit-activity/y/ozbotics/hassio-addon-shutdown-by-gpio.svg
[commits]: https://github.com/ozbotics/hassio-addon-shutdown-by-gpio/commits/master
[contributors]: https://github.com/ozbotics/hassio-addon-shutdown-by-gpio/graphs/contributors
[dockerhub]: https://hub.docker.com/r/ozbotics/example
[issue]: https://github.com/ozbotics/hassio-addon-shutdown-by-gpio/issues
[license-shield]: https://img.shields.io/github/license/ozbotics/hassio-addon-shutdown-by-gpio.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2019.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg
[reddit]: https://reddit.com/r/homeassistant
[releases-shield]: https://img.shields.io/github/release/ozbotics/hassio-addon-shutdown-by-gpio.svg
[releases]: https://github.com/ozbotics/hassio-addon-shutdown-by-gpio/releases
[version-shield]: https://images.microbadger.com/badges/version/hassioaddons/example.svg
