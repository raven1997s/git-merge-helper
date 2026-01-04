# Contributing to Git Merge Helper

感谢你有兴趣贡献！本文档将指导你如何参与贡献。

## 如何贡献

### 报告 Bug

1. 在 Issues 中搜索是否已有相同问题
2. 如果没有，创建新的 Issue，包含：
   - 清晰的标题
   - 详细的问题描述
   - 复现步骤
   - 预期行为
   - 实际行为
   - 环境信息（OS、Git 版本、Claude Code 版本）

### 提交功能建议

1. 在 Issues 中搜索是否已有相同建议
2. 如果没有，创建新的 Issue，包含：
   - 清晰的标题
   - 功能描述
   - 使用场景
   - 可能的实现方案

### 提交代码

1. Fork 本仓库
2. 创建功能分支：`git checkout -b feature/amazing-feature`
3. 提交更改：`git commit -m 'Add amazing feature'`
4. 推送到分支：`git push origin feature/amazing-feature`
5. 创建 Pull Request

### 代码规范

#### Python 脚本

- 遵循 PEP 8 规范
- 添加类型注解
- 编写文档字符串
- 保持函数简洁（< 50 行）

#### Markdown 文档

- 使用清晰的标题结构
- 添加代码示例
- 保持语言简洁

#### Commit 消息

使用 Conventional Commits 格式：

```
feat: add batch merge support
fix: resolve assume-unchanged detection bug
docs: update README installation guide
refactor: simplify merge executor logic
test: add unit tests for conflict checker
```

## 开发环境设置

```bash
# 克隆仓库
git clone https://github.com/your-username/git-merge-helper.git
cd git-merge-helper

# 复制技能到本地
cp -r skill/git-merge-helper ~/.claude/skills/

# 测试技能
# 在 Claude Code 中说："帮我合并到 test"
```

## 项目结构

```
git-merge-helper/
├── skill/                    # 核心技能
│   └── git-merge-helper/
│       ├── SKILL.md          # 技能定义
│       ├── README.md         # 详细说明
│       ├── WORKFLOW.md       # 流程图
│       └── scripts/          # Python 脚本
├── plugin/                   # 插件版本
│   ├── .claude-plugin/
│   │   └── plugin.json
│   └── commands/
│       └── merge.md
├── LICENSE
├── README.md
├── CHANGELOG.md
└── CONTRIBUTING.md
```

## 测试

在提交 PR 前，请确保：

1. 测试所有 Python 脚本功能
2. 在 Claude Code 中测试技能触发
3. 验证文档清晰完整
4. 检查代码风格

## Pull Request 检查清单

- [ ] 代码通过测试
- [ ] 文档已更新
- [ ] Commit 消息符合规范
- [ ] CHANGELOG.md 已更新（如果是新功能）
- [ ] 没有合并冲突

## 获取帮助

如果你有任何问题，欢迎：

- 创建 Issue
- 在 Discussions 中讨论
- 查看 README.md 和 WORKFLOW.md

## 行为准则

请尊重所有贡献者，保持友好和专业的交流方式。

## 许可证

贡献的代码将使用 MIT 许可证发布。

---

再次感谢你的贡献！
