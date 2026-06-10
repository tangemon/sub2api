#!/usr/bin/env bash
# 本地构建镜像的快速脚本，避免在命令行反复输入构建参数。

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

NPM_REGISTRY="${NPM_REGISTRY:-https://registry.npmmirror.com}"
NODE_IMAGE="${NODE_IMAGE:-docker-0.unsee.tech/node:24-alpine}"
GOLANG_IMAGE="${GOLANG_IMAGE:-docker-0.unsee.tech/golang:1.26.4-alpine}"
ALPINE_IMAGE="${ALPINE_IMAGE:-docker-0.unsee.tech/alpine:3.21}"
POSTGRES_IMAGE="${POSTGRES_IMAGE:-docker-0.unsee.tech/postgres:18-alpine}"

docker build -t sub2api:latest \
    --build-arg NODE_IMAGE="${NODE_IMAGE}" \
    --build-arg GOLANG_IMAGE="${GOLANG_IMAGE}" \
    --build-arg ALPINE_IMAGE="${ALPINE_IMAGE}" \
    --build-arg POSTGRES_IMAGE="${POSTGRES_IMAGE}" \
    --build-arg NPM_REGISTRY="${NPM_REGISTRY}" \
    --build-arg GOPROXY=https://goproxy.cn,direct \
    --build-arg GOSUMDB=sum.golang.google.cn \
    -f "${REPO_ROOT}/Dockerfile" \
    "${REPO_ROOT}"
