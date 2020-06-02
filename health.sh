#!/bin/sh

if [ -z ${CHECK_URL+x} ]; then CHECK_URL="https://status.aws.amazon.com/"; fi

curl -f -sS -x http://localhost:3128/ -I $CHECK_URL || exit 1

exit 0