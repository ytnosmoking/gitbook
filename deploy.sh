#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
gitbook build ./ ./books

# 进入生成的文件夹
cd ./books

git init
git add -A
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io/<REPO>
git branch -M main
git push -f https://github.com/ytnosmoking/gitbook.git main:gh-pages
