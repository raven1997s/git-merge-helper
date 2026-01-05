#!/bin/bash
# ============================================
# Claude Code 插件安装脚本
# 运行此脚本以启用 /mh 和 /merge-helper 快捷命令
# ============================================

set -e

echo "🚀 正在安装 Claude Code Git Merge Helper 插件..."

# 检查 claude 命令是否存在
if ! command -v claude &> /dev/null; then
    echo "❌ 错误: 未找到 claude 命令"
    echo "请先安装 Claude Code: https://docs.anthropic.com/claude-code/getting-started"
    exit 1
fi

# 添加 marketplace
echo "📦 添加插件市场..."
claude plugin marketplace add https://github.com/raven1997s/git-merge-helper 2>/dev/null || true

# 安装插件
echo "⬇️ 安装插件..."
claude plugin install git-merge-helper@git-merge-helper 2>/dev/null || {
    echo "⚠️ 插件可能已安装，尝试更新..."
    claude plugin update git-merge-helper@git-merge-helper 2>/dev/null || true
}

echo ""
echo "✅ 安装完成！"
echo ""
echo "使用方法："
echo "  /merge-helper test    # 合并到 test 分支"
echo "  /mh test              # 合并到 test 分支（简写）"
echo "  /merge-helper master  # 合并到 master 分支"
echo ""
echo "💡 提示: 请重启 Claude Code 以使更改生效"
