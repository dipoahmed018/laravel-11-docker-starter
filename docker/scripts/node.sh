#!/bin/sh

UID=$(stat -c "%u" ".env.example")

deluser --remove-home node
adduser -u "$UID" --disabled-password  node

if [ ! -d node_modules ]; then
    su node -c "npm install"
fi

su node -c "npm run dev"
