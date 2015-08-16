#!/bin/bash

#if [ ! -f /etc/haproxy/haproxy.cfg ]; then

  # Install haproxy
  /usr/bin/apt-get -y install haproxy keepalived

  # Configure haproxy
  cat > /etc/default/haproxy <<EOD
# Set ENABLED to 1 if you want the init script to start haproxy.
ENABLED=1
# Add extra flags here.
#EXTRAOPTS="-de -m 16"
EOD
  cat > /etc/haproxy/haproxy.cfg <<EOD
global
    log 127.0.0.1   local0
    log 127.0.0.1   local1 notice
    daemon
    maxconn 256

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    retries 3
    option redispatch
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend http-in
    bind *:80
    default_backend webservers

backend webservers
    balance roundrobin
    # Poor-man's sticky
    # balance source
    # JSP SessionID Sticky
    # appsession JSESSIONID len 52 timeout 3h
    option httpchk
    option forwardfor
    option http-server-close
    server web1 192.168.1.11:80 maxconn 32 check
    server web2 192.168.1.12:80 maxconn 32 check

listen admin
    bind *:8080
    stats enable
EOD

  cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.orig
  /usr/sbin/service haproxy restart
#fi

cat >> /etc/sysctl.conf <<EOD 
net.ipv4.ip_nonlocal_bind=1
EOD
sysctl -p


cat > /etc/keepalived/keepalived.conf <<EOD
vrrp_script chk_haproxy {           # Requires keepalived-1.1.13
        script "killall -0 haproxy"     # cheaper than pidof
        interval 2                      # check every 2 seconds
        weight 2                        # add 2 points of prio if OK
}

vrrp_instance VI_1 {
        interface eth1
        state MASTER
        virtual_router_id 51
        priority 101                    # 101 on master, 100 on backup
        virtual_ipaddress {
            192.168.1.2
        }
        track_script {
            chk_haproxy
        }
}
EOD

/etc/init.d/keepalived restart