#! /bin/bash

rsync -a --checksum --exclude '.*' ~  /tmp/backup
