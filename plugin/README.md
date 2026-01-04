# Git Merge Helper Plugin

这是 [Git Merge Helper](https://github.com/your-username/git-merge-helper) 的 Claude Code 插件版本。

## 安装

```bash
plugin install https://github.com/your-username/git-merge-helper
```

## 使用

### Slash Command

```bash
/merge test      # 合并到 test 分支
/merge master    # 合并到 master 分支
```

### Skill 技能

插件会自动注册技能，可通过自然语言触发：

```
"帮我合并到 test"
"merge helper"
"合并分支"
```

## 包含内容

- **Skill**: `skills/git-merge-helper/` - 完整的合并助手技能
- **Command**: `commands/merge.md` - 快速合并命令

详细文档见主仓库 [README.md](../README.md)
