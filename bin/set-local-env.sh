#!/bin/bash

env_name="$1"
env_value="$2"
if grep -q "^export ${env_name}=" "${DEVC_CONF_LOCAL}"; then
    sed -i -E "s@^export ${env_name}=.*\$@export ${env_name}=\"${env_value}\"@" "${DEVC_CONF_LOCAL}"
else
    echo "export ${env_name}=\"${env_value}\"" >> "${DEVC_CONF_LOCAL}"
fi
