#!/bin/bash

sudo cat <<EOF | sudo tee /etc/yum.repos.d/grafana.repo
[grafana]
name=grafana
baseurl=https://rpm.grafana.com
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://rpm.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
EOF

sudo rpm --import https://rpm.grafana.com/gpg.key

sudo dnf update -y
sudo dnf install grafana -y


sudo systemctl daemon-reload


sudo systemctl start grafana-server
sudo systemctl enable grafana-server