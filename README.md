# Git Merge Helper

> 智能 Git 分支合并助手 - 安全、自动化地完成分支合并操作

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Skill-blue)](https://code.claude.com/docs/en/skills)
[![Version](https://img.shields.io/badge/version-2.2.0-green)](https://github.com/raven1997s/git-merge-helper/releases)
[![Stars](https://img.shields.io/github/stars/raven1997s/git-merge-helper?style=social)](https://github.com/raven1997s/git-merge-helper/stargazers)

## 特性

- **安全第一** - 自动创建临时分支，冲突时自动回滚
- **智能检测** - 提前拦截无需合并的分支，全面 Git 状态检查
- **批量操作** - 一次合并到多个目标分支
- **网络重试** - 自动重试机制，应对网络不稳定
- **详细日志** - 所有操作都有完整的日志记录
- **冲突建议** - 检测到冲突时提供解决建议
- **并发保护** - 防止同时执行多个合并导致冲突
- **配置灵活** - 支持自定义配置文件

## 安装

### 方式一：从 GitHub 安装 Plugin（推荐 - 支持 Slash Command）

```bash
# 1. 添加 GitHub 仓库作为 marketplace
claude plugin marketplace add https://github.com/raven1997s/git-merge-helper

# 2. 安装插件
claude plugin install git-merge-helper@git-merge-helper
```

安装后可使用：
```bash
/merge-helper test    # 合并到 test 分支
/mh test              # 合并到 test 分支（简写）
/merge-helper master  # 合并到 master 分支
```

### 方式二：安装 Skill（支持自然语言触发）

```bash
# 克隆仓库
git clone https://github.com/raven1997s/git-merge-helper.git

# 复制 Skill 到全局目录（所有项目可用）
cp -r git-merge-helper/skill/git-merge-helper ~/.claude/skills/

# 或复制到当前项目（仅当前项目可用）
mkdir -p .claude/skills
cp -r git-merge-helper/skill/git-merge-helper .claude/skills/
```

安装后可使用自然语言：
```
帮我合并到 test
合并当前分支到 master
merge helper dev
```

### 方式三：完整安装（推荐 - 支持所有触发方式）

同时安装 Plugin 和 Skill，获得完整体验：

```bash
# 1. 克隆仓库
git clone https://github.com/raven1997s/git-merge-helper.git
cd git-merge-helper

# 2. 安装 Plugin（Slash Command）
claude plugin marketplace add ./
claude plugin install git-merge-helper@git-merge-helper

# 3. 安装 Skill（自然语言）
cp -r skill/git-merge-helper ~/.claude/skills/

# 4. 重启 Claude Code 生效
```

### 触发方式对比

| 触发方式 | 示例 | 需要安装 |
|---------|------|---------|
| Slash Command | `/merge-helper test`、`/mh test` | Plugin |
| 自然语言 | "帮我合并到 test" | Skill |

### 方式四：团队项目集成

如果你想让团队成员拉取项目后也能使用快捷命令，可以在项目中添加安装脚本：

```bash
# 1. 在项目中创建脚本目录
mkdir -p scripts

# 2. 下载安装脚本
curl -o scripts/setup-claude-merge-helper.sh \
  https://raw.githubusercontent.com/raven1997s/git-merge-helper/main/templates/setup-claude-merge-helper.sh
chmod +x scripts/setup-claude-merge-helper.sh

# 3. 添加 CLAUDE.md（可选，用于说明）
curl -o CLAUDE.md \
  https://raw.githubusercontent.com/raven1997s/git-merge-helper/main/templates/CLAUDE.md

# 4. 提交到项目
git add scripts/setup-claude-merge-helper.sh CLAUDE.md
git commit -m "feat: 添加 Claude Code 分支合并插件支持"
```

团队成员使用：
```bash
# 拉取项目后，运行一次安装脚本
./scripts/setup-claude-merge-helper.sh

# 之后就可以使用
/mh test
/merge-helper dev
```

## 快速开始

### 前置条件

- Git 仓库已初始化
- 工作目录干净（无未提交更改）
- 有推送权限

### 基本使用

```
用户: 帮我合并到 test

AI: ✓ 检测到 1 个新提交需要合并
    ✓ 无冲突
    ✅ 成功合并到 test 分支
    📝 日志已保存到 .claude/logs/merge_20260104_143000.log
```

### 批量合并

```
用户: 帮我合并到 test 和 dev

AI: 🔍 预检 2 个分支...
    [1/2] 合并到 test... ✅ SUCCESS
    [2/2] 合并到 dev...  ✅ SUCCESS
    成功: 2/2
```

## 配置

配置文件位置：`.claude/skills/git-merge-helper/scripts/config.json`

```json
{
  "max_retries": 3,
  "retry_delay": 2,
  "network_timeout": 30,
  "max_week_logs": 10,
  "max_month_logs": 5,
  "protected_branches": ["pre", "prod", "production"],
  "max_conflict_file_size": 10485760
}
```

| 配置项 | 默认值 | 说明 |
|--------|--------|------|
| `max_retries` | 3 | 网络操作最大重试次数 |
| `retry_delay` | 2 | 基础重试延迟（秒） |
| `max_week_logs` | 10 | 一周内最多保留的日志数 |
| `max_month_logs` | 5 | 一个月内最多保留的日志数 |
| `protected_branches` | [...] | 受保护分支列表 |
| `max_conflict_file_size` | 10485760 | 冲突文件最大大小（10MB） |

## 工作流程

```
1. 检查环境 → 2. 检查差异 → 3. 选择分支
   ↓
4. 创建临时分支 → 5. 拉取最新代码 → 6. 执行合并
   ↓
7. 检测冲突
   ├─ 无冲突 → 推送、清理、返回 ✅
   └─ 有冲突 → 自动回滚、记录日志 ❌
```

详细流程图见 [WORKFLOW.md](skill/git-merge-helper/WORKFLOW.md)

## Python 脚本

```bash
# 执行完整合并流程
python3 .claude/skills/git-merge-helper/scripts/merge_executor.py test

# 各组件脚本
branch_selector.py     # 分支选择器
conflict_checker.py    # 冲突检测器
conflict_resolver.py   # 冲突解决建议器
merge_prechecker.py    # 合并预检器
git_status_checker.py  # Git 状态检查器
git_network_helper.py  # 网络操作辅助类
logger.py              # 日志记录器
log_cleaner.py         # 日志清理器
config.py              # 配置管理器
```

## 错误处理

| 场景 | 处理方式 |
|------|---------|
| 工作目录不干净 | 提示提交或 stash |
| 检测到冲突 | 自动回滚，记录冲突文件 |
| 远程分支不存在 | 提示可用分支列表 |
| 网络问题 | 自动重试 3 次，递增延迟 |

## 日志位置

所有日志保存在：`.claude/logs/merge_*.log`

## 受保护分支

以下分支默认受保护，禁止操作：
- `pre`
- `prod`
- `production`
- `master-prod`
- `pre-prod`

可在配置文件中自定义。

## 常见问题

### Q: 如何跳过合并检查？

A: 技能会自动检测差异，如果没有新提交会提前拦截，无需手动跳过。

### Q: 冲突后如何恢复？

A: 技能会自动回滚到合并前状态，查看日志文件了解冲突详情，然后手动处理。

### Q: 支持哪些 Git 服务器？

A: 支持 GitLab、GitHub、Gitee 等所有标准 Git 服务器。

## 开发

本项目同时支持 Skill 和 Plugin 两种安装方式。为避免重复维护：

```bash
# 开发时只需编辑 skill/git-merge-helper/ 目录

# 发布前同步到 plugin 目录
./sync.sh
```

脚本会自动将 `skill/` 目录同步到 `plugin/skills/`，确保两种安装方式保持一致。

## 贡献

欢迎贡献！请阅读 [CONTRIBUTING.md](CONTRIBUTING.md)

## 版本历史

详见 [CHANGELOG.md](CHANGELOG.md)

## 许可证

[MIT License](LICENSE)

## 致谢

- [Claude Code](https://code.claude.com/) - 强大的 AI 编程助手
- [Git](https://git-scm.com/) - 版本控制系统

---

Made with ❤️ for developers who love automation
