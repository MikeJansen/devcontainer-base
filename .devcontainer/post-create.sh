#!/bin/bash

sed -i '/^#--DEVC-BEGIN/,/^#--DEVC-END/ d' ~vscode/.bashrc
cat << 'EOF' >> ~vscode/.bashrc
#--DEVC-BEGIN
source <(kubectl completion bash)
source <(eksctl completion bash)
source <(helm completion bash)
alias k=kubectl
complete -F __start_kubectl k
complete -C "$(which aws_completer)" aws
source "${WORKSPACE_CONF}"
#--DEVC-END
EOF
