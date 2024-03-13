#!/bin/bash

if [ -z "${WORKSPACE}" ]; then
    WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    export WORKSPACE
fi

if [ -z "${WORKSPACE_CONF}" ]; then
    WORKSPACE_CONF="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/conf.d/env.sh"
    export WORKSPACE_CONF
fi

# Init env.local.sh if it does not exist; source it regardless
export DEVC_CONF="${WORKSPACE}/conf.d"
export DEVC_CONF_LOCAL="${DEVC_CONF}/env.local.sh"
export DEVC_CONF_DEFAULT="${DEVC_CONF}/env.default"
if [ ! -f "${DEVC_CONF_LOCAL}" ]; then
    cp "${DEVC_CONF_DEFAULT}" "${DEVC_CONF_LOCAL}"

    DEVC_ID="$(openssl rand -base64 10 | tr -d '+=/' | cut -c1-5 | tr '[:upper:]' '[:lower:]')"
    "${WORKSPACE}/bin/set-local-env.sh" "DEVC_ID" "${DEVC_ID}"
    DEVC_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    "${WORKSPACE}/bin/set-local-env.sh" "DEVC_ACCOUNT_ID" "${DEVC_ACCOUNT_ID}"

    chmod +x "${DEVC_CONF_LOCAL}"
fi
source "${DEVC_CONF_LOCAL}"
