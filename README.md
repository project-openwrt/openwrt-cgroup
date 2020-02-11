## Netfilter and iptables extension for cgroup target ported to OpenWrt.

Compile
---
```bash
# cd to OpenWrt source path
cd openwrt
# Clone this repo
git clone --branch master --depth 1 https://github.com/project-openwrt/openwrt-cgroup package/openwrt-cgroup
# Select Network -> Firewall -> iptables-mod-cgroup
make menuconfig
# Compile
make V=s
```

Example
---
```bash
iptables -A OUTPUT -p tcp --sport 80 -m cgroup ! --path service/http-server -j DROP
iptables -A OUTPUT -p tcp --sport 80 -m cgroup ! --cgroup 1 -j DROP
```
