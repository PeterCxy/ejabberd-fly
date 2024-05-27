#!/usr/bin/env bash

# Set this to a known machine ID; this is not the "main" node, but we just need a way to
# know which machine is already configured.
INTRODUCER_MACHINE_ID=7811eedf959778

export ERLANG_COOKIE=change_me
export ERL_OPTIONS="-proto_dist inet6_tcp"
export INET_DIST_INTERFACE='::'

# Machine-unique internal hostnames: https://fly.io/docs/networking/private-networking/
UNIQUE_HOSTNAME=$FLY_MACHINE_ID.vm.$FLY_APP_NAME.internal
export ERLANG_NODE_ARG=ejabberd@$FLY_MACHINE_ID.vm.$FLY_APP_NAME.internal
