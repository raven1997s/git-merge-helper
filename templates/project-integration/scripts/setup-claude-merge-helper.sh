#!/bin/bash
# ============================================
# Claude Code Git Merge Helper 完整安装脚本
# 安装后支持：
#   - /mh test, /merge-helper test (Slash Command)
#   - "帮我合并到 test" (自然语言)
# ============================================

set -e

REPO_URL="https://github.com/raven1997s/git-merge-helper"
SKILL_DIR="$HOME/.claude/skills/git-merge-helper"

echo "🚀 正在安装 Claude Code Git Merge Helper..."
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
echo "📦 [1/2] 安装 Plugin (支持 /mh, /merge-helper)..."

# 添加 marketplace
claude plugin marketplace add "$REPO_URL" 2>/dev/null || true

# 安装插件
claude plugin install git-merge-helper@git-merge-helper 2>/dev/null || {
    echo "⚠️ 插件可能已安装，尝试更新..."
    claude plugin update git-merge-helper@git-merge-helper 2>/dev/null || true
}

echo "✅ Plugin 安装完成"
echo ""

# ==========================================
# 安装 Skill (支持自然语言)
# ==========================================
echo "📦 [2/2] 安装 Skill (支持自然语言触发)..."

# 创建临时目录
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# 克隆仓库
echo "   下载 Skill 源码..."
git clone --depth 1 --quiet "$REPO_URL" "$TEMP_DIR/git-merge-helper"

# 创建 skills 目录
mkdir -p "$HOME/.claude/skills"

# 复制 skill
if [ -d "$SKILL_DIR" ]; then
    echo "   更新现有 Skill..."
    rm -rf "$SKILL_DIR"
fi
cp -r "$TEMP_DIR/git-merge-helper/skill/git-merge-helper" "$SKILL_DIR"

echo "✅ Skill 安装完成"
echo ""

# ==========================================
# 完成
# ==========================================
echo "============================================"
echo "🎉 安装完成！"
echo "============================================"
echo ""
echo "支持的触发方式："
echo ""
echo "  Slash Command:"
echo "    /mh test              # 合并到 test 分支"
echo "    /merge-helper dev     # 合并到 dev 分支"
echo ""
echo "  自然语言:"
echo "    帮我合并到 test"
echo "    合并当前分支到 master"
echo ""
echo "💡 提示: 请重启 Claude Code 以使更改生效"
echo "   退出当前 claude 会话后重新运行 'claude' 命令"
