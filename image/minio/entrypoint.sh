#!/usr/bin/env bash

ACCESS_KEY_FILE=/run/secrets/${MINIO_ACCESS_KEY_NAME}
SECRET_KEY_FILE=/run/secrets/${MINIO_SECRET_KEY_NAME}

if [ -f "$ACCESS_KEY_FILE" ] && [ -f "$SECRET_KEY_FILE" ]; then
    if [ -f "$ACCESS_KEY_FILE" ]; then
        MINIO_ACCESS_KEY=$(cat $ACCESS_KEY_FILE)
        export MINIO_ACCESS_KEY
    fi
    if [ -f "$SECRET_KEY_FILE" ]; then
        MINIO_SECRET_KEY=$(cat $SECRET_KEY_FILE)
        export MINIO_SECRET_KEY
    fi
fi
