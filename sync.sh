#!/bin/bash
# 同步 skill 目录到 plugin 目录

set -e

echo "🔄 正在同步 skill -> plugin/skills..."

# 删除 plugin 下的旧目录
rm -rf plugin/skills/git-merge-helper

# 复制 skill 目录到 plugin
cp -r skill/git-merge-helper plugin/skills/

echo "✅ 同步完成！"
echo ""
echo "修改内容仅需编辑 skill/git-merge-helper/，发布前运行此脚本同步即可"
