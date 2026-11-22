#!/usr/bin/env bash
set -euo pipefail

# 构建在 CI 内完成：克隆上游源码（打包仓库不保留上游代码），构建静态站点，产出内容目录。
UPSTREAM="https://github.com/xikhar/papertrails.git"
SRC=".upstream"

rm -rf "$SRC"
git clone --depth 1 "$UPSTREAM" "$SRC"

cd "$SRC"

npm ci
npm run build

# 复制构建产物到 content 目录（供 contentdir 打包）
cd ..
rm -rf content
mkdir -p content
cp -R "$SRC/dist/." content/
rm -rf "$SRC"

echo "build done: content files = $(find content -type f | wc -l)"
