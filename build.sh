#!/bin/bash

docker buildx build -t nishkarr/asperatransferd .

version=$(docker run --rm -it nishkarr/asperatransferd /usr/local/asperatransferd/linux-x86_64/asperatransferd version \
  | sed -Ee 's|^(.*) version (.*)\..*$$|\2|' \
  | sed 's/[[:blank:]]//g')

docker image tag nishkarr/asperatransferd nishkarr/asperatransferd:$version

echo "Tagged nishkarr/asperatransferd:$version"