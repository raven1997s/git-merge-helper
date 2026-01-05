---
description: 快速执行分支合并
argument-hint: <target-branch>
allowed-tools: [Read, Bash(python3:.claude/skills/*/scripts/*), Bash(git:*)]
---

# Git Merge 命令

快速执行分支合并到目标分支。

## 参数

使用 `$ARGUMENTS` 访问用户传入的目标分支。

## 示例

- `/merge-helper test` - 合并到 test 分支
- `/merge-helper master` - 合并到 master 分支
- `/merge-helper dev env` - 批量合并到多个分支

## 执行流程

1. 检查环境（工作目录必须干净）
2. 检查差异（提前拦截）
3. 执行合并（创建临时分支）
4. 处理结果（成功推送或冲突回滚）

详细流程见 SKILL.md 和 WORKFLOW.md。
