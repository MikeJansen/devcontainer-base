FROM mcr.microsoft.com/devcontainers/base:jammy

COPY xdg-open /usr/local/bin

RUN <<EOF
apt-get update
apt-get -y install bash-completion
rm -rf /var/lib/apt/lists/*
EOF

# eksctl
RUN <<EOF
arch=$(uname -m)
if [ "$arch" = "aarch64" ]; then
    arch="arm64"
fi
platform="$(uname -s)_${arch}"
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${platform}.tar.gz"
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep "$platform" | sha256sum --check
tar -xzf eksctl_"$platform".tar.gz -C /tmp && rm eksctl_"$platform".tar.gz
mv /tmp/eksctl /usr/local/bin
EOF
