ARG BUILD_FROM=hassioaddons/base:4.0.2

# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Copy root filesystem
COPY rootfs /

# Setup base
RUN apk add --no-cache \
    coreutils=8.31-r0

# Scrip to run after startup
CMD ["/usr/bin/run.sh"]

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="shutdown-by-gpio" \
    io.hass.description="Initiate shutdown when GPIO pin is triggered by Ozbotics" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Jon van Noort<jon@ozbotics>" \
    org.label-schema.description="Initiate shutdown when GPIO pin is triggered by Ozbotics" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="shutdown-by-gpio" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://github.com/ozbotics/hassio-addon-shutdown-by-gpio" \
    org.label-schema.usage="https://github.com/ozbotics/hassio-addon-shutdown-by-gpio/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/ozbotics/hassio-addon-shutdown-by-gpio" \
    org.label-schema.vendor="Ozbotics"
