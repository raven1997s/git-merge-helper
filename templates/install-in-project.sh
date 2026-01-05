#!/bin/bash
# =================================================================
# Install Git Merge Helper into YOUR Project
# =================================================================
#
# Usage:
#   cd your-project-root
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/raven1997s/git-merge-helper/main/templates/install-in-project.sh)"
#
# What it does:
#   1. Downloads the skill to ./.claude/skills/git-merge-helper
#   2. Configures CLAUDE.md with /mh and /merge-helper commands
#   3. Ensures .claude is in .gitignore (optional interaction)
# =================================================================

set -e

REPO_URL="https://github.com/raven1997s/git-merge-helper"
SKILL_TARGET_DIR=".claude/skills/git-merge-helper"
CONFIG_FILE="CLAUDE.md"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 Installing Git Merge Helper into current project...${NC}"

# 1. 检查是否在 git 根目录
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Warning: Current directory does not verify like a git root.${NC}"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 2. 下载 Skill 代码
echo -e "${BLUE}📦 Downloading skill source...${NC}"
mkdir -p "$SKILL_TARGET_DIR"

# 使用临时目录克隆，只提取 skill 部分
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

git clone --depth 1 --quiet "$REPO_URL" "$TEMP_DIR/repo"

# 覆盖式安装
if [ -d "$SKILL_TARGET_DIR" ]; then
    rm -rf "$SKILL_TARGET_DIR"
fi
mv "$TEMP_DIR/repo/skill/git-merge-helper" "$SKILL_TARGET_DIR"

echo -e "${GREEN}✓ Skill files installed to $SKILL_TARGET_DIR${NC}"

# 3. 配置 CLAUDE.md
echo -e "${BLUE}⚙️  Configuring $CONFIG_FILE...${NC}"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "# Claude Code Configuration" > "$CONFIG_FILE"
fi

# 检查是否已经配置
if grep -q "python3 .claude/skills/git-merge-helper" "$CONFIG_FILE"; then
    echo -e "${YELLOW}✓ Commands already present in $CONFIG_FILE${NC}"
else
    # 确保文件末尾有换行
    if [ -s "$CONFIG_FILE" ] && [ "$(tail -c 1 "$CONFIG_FILE")" != "" ]; then
        echo "" >> "$CONFIG_FILE"
    fi
    
    # 如果没有 Commands 章节，添加它
    if ! grep -q "^## Commands" "$CONFIG_FILE"; then
        echo "" >> "$CONFIG_FILE"
        echo "## Commands" >> "$CONFIG_FILE"
        echo "" >> "$CONFIG_FILE"
    fi
    
    # 追加命令
    echo "- **mh**: \`python3 .claude/skills/git-merge-helper/scripts/merge_executor.py\` - Safely merges current branch to target (default: main)." >> "$CONFIG_FILE"
    echo "- **merge-helper**: \`python3 .claude/skills/git-merge-helper/scripts/merge_executor.py\` - Alias for mh." >> "$CONFIG_FILE"
    
    echo -e "${GREEN}✓ Added /mh and /merge-helper commands to $CONFIG_FILE${NC}"
fi

# 4. Gitignore 建议
if [ -f ".gitignore" ]; then
    if ! grep -q ".claude" ".gitignore"; then
        echo -e "${YELLOW}💡 Tip: You might want to add '.claude' (or just logs) to .gitignore.${NC}"
        # 这里不自动修改，避免误判
    fi
fi

echo ""
echo -e "${GREEN}🎉 Installation Complete!${NC}"
echo -e "You can now use: ${BLUE}/mh <branch>${NC} or ${BLUE}/merge-helper <branch>${NC} in Claude."
echo ""
