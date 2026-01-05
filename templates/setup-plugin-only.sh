#!/bin/bash
# ============================================
# Claude Code Git Merge Helper - Plugin 安装脚本
# 用于内嵌 Skill 的项目，只需安装 Plugin
# 
# Skill 已内置在项目的 .claude/skills/ 目录中
# 此脚本只安装 Plugin 以启用 /mh 和 /merge-helper 命令
# ============================================

set -e

REPO_URL="https://github.com/raven1997s/git-merge-helper"

echo "🚀 正在安装 Claude Code Git Merge Helper Plugin..."
echo ""
echo "📝 注意: Skill 已内置在项目中，自然语言功能无需安装"
echo ""

# 检查 claude 命令是否存在
if ! command -v claude &> /dev/null; then
    echo "❌ 错误: 未找到 claude 命令"
    echo "请先安装 Claude Code: https://docs.anthropic.com/claude-code/getting-started"
    exit 1
fi

# ==========================================
# 安装 Plugin (支持 Slash Command)
# ==========================================
echo "📦 安装 Plugin (支持 /mh, /merge-helper)..."

# 添加 marketplace
claude plugin marketplace add "$REPO_URL" 2>/dev/null || true

# 安装插件
claude plugin install git-merge-helper@git-merge-helper 2>/dev/null || {
    echo "⚠️ 插件可能已安装，尝试更新..."
    claude plugin update git-merge-helper@git-merge-helper 2>/dev/null || true
}

echo ""
echo "============================================"
echo "🎉 安装完成！"
echo "============================================"
echo ""
echo "支持的触发方式："
echo ""
echo "  Slash Command (需要此脚本安装):"
echo "    /mh test              # 合并到 test 分支"
echo "    /merge-helper dev     # 合并到 dev 分支"
echo ""
echo "  自然语言 (已内置，无需安装):"
echo "    帮我合并到 test"
echo "    合并当前分支到 master"
echo ""
echo "💡 提示: 请重启 Claude Code 以使更改生效"
