# Claude Code 配置

本项目已配置 Claude Code 支持，提供智能 Git 分支合并功能。

## 快速开始

### 首次使用（安装插件）

```bash
# 运行安装脚本（只需执行一次）
./scripts/setup-claude-merge-helper.sh

# 重启 Claude Code
```

### 日常使用

在项目目录中启动 Claude Code：

```bash
claude
```

然后使用以下任意方式：

**Slash Command（快捷命令）：**
```bash
/mh test              # 合并到 test 分支
/merge-helper dev     # 合并到 dev 分支
/merge-helper master  # 合并到 master 分支
```

**自然语言：**
```
帮我合并到 test
合并当前分支到 dev
把这个分支合并到 master
```

## 功能特性

- ✅ 自动创建临时分支，冲突时自动回滚
- ✅ 智能检测差异，提前拦截无需合并的分支
- ✅ 批量合并到多个目标分支
- ✅ 详细日志记录（保存在 `.claude/logs/`）
- ✅ 受保护分支检测（pre, prod, production）
- ✅ 网络重试机制

## 前置条件

使用前请确保：
- 工作目录干净（无未提交更改）
- 有远程仓库推送权限

## 日志位置

合并日志保存在：`.claude/logs/merge_*.log`

## 参考

- [Git Merge Helper](https://github.com/raven1997s/git-merge-helper) - 插件源码和文档
