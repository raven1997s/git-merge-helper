# Claude Code 配置

本项目已内置 Git Merge Helper 技能，提供智能分支合并功能。

## 使用方式

### 方式一：自然语言（拉取即用 ✅）

直接在 Claude Code 中使用自然语言：

```
帮我合并到 test
合并当前分支到 dev
把这个分支合并到 master
```

**无需任何安装！** Skill 已内置在项目中。

### 方式二：Slash Command（需运行一次安装脚本）

如果你想使用快捷命令 `/mh` 和 `/merge-helper`：

```bash
# 只需运行一次
./scripts/setup-claude-merge-helper.sh
```

然后就可以使用：
```
/mh test              # 合并到 test 分支
/merge-helper dev     # 合并到 dev 分支
```

## 功能特性

- ✅ 自动创建临时分支，冲突时自动回滚
- ✅ 智能检测差异，提前拦截无需合并的分支
- ✅ 批量合并到多个目标分支
- ✅ 详细日志记录（`.claude/logs/merge_*.log`）
- ✅ 受保护分支检测（pre, prod, production）

## 前置条件

- 工作目录干净（无未提交更改）
- 有远程仓库推送权限

## 参考

- [Git Merge Helper](https://github.com/raven1997s/git-merge-helper)
