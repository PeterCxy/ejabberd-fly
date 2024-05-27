#!/usr/bin/env bash

source /env.sh

echo "ERLANG_NODE_ARG=$ERLANG_NODE_ARG"

# HACK for local access
echo "127.0.0.1 $UNIQUE_HOSTNAME" >> /etc/hosts

chown -R ejabberd:ejabberd /home/ejabberd/database

export ERL_OPTIONS="-proto_dist inet6_tcp"

su -p ejabberd -c "/home/ejabberd/bin/ejabberdctl foreground" &
PID=$!

# This will prevent ejabberdctl from working for some reason
unset ERL_OPTIONS

sleep 120

if [ ! -z "$INTRODUCER_MACHINE_ID" ] && [ "$INTRODUCER_MACHINE_ID" != "$FLY_MACHINE_ID" ]; then
  JOIN_TARGET="ejabberd@$INTRODUCER_MACHINE_ID.vm.$FLY_APP_NAME.internal"
  echo "Joining cluster $JOIN_TARGET"
  /home/ejabberd/bin/ejabberdctl join_cluster "$JOIN_TARGET"
  /home/ejabberd/bin/ejabberdctl status
fi

wait $PID
