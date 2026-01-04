# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.2.0] - 2026-01-04

### Added
- 配置文件支持（config.py + config.json）
- 并发保护机制（防止同时执行多个合并）
- 详细恢复指导（回滚失败时提供手动步骤）
- 大文件保护（超过限制提示手动处理）

### Fixed
- assume-unchanged 文件检测逻辑错误（之前错误跳过小写 h 标记）
- 受保护分支误杀问题（feature/pre-fix 等合法分支不再被误阻止）
- 项目根目录检测（不在 Git 仓库时抛出清晰错误）

### Changed
- 网络错误关键词扩展（添加 DNS、SSL、handshake 等识别）

## [2.1.0] - 2026-01-04

### Added
- 全面 Git 状态检查（Submodule、LFS、Assume-unchanged）
- 网络重试机制（3 次重试，递增延迟）
- 批量合并预检（全部成功或全部失败模式）
- merge_prechecker.py 脚本
- git_status_checker.py 脚本
- git_network_helper.py 脚本

### Changed
- branch_selector 支持非交互式模式

## [2.0.0] - 2026-01-04

### Added
- 冲突解决建议（根据文件类型提供针对性建议）
- 批量合并到多个分支
- 受保护分支检查（禁止 pre/prod）
- 自动日志清理（一周内最多 10 个，一个月内最多 5 个）
- conflict_resolver.py 脚本
- log_cleaner.py 脚本
- WORKFLOW.md 流程文档

### Changed
- 环境检查过滤 .DS_Store 和 .claude

## [1.1.0] - 2026-01-04

### Added
- 差异提前拦截
- 4 个 Python 辅助脚本

## [1.0.0] - 2026-01-04

### Added
- 初始版本
- 基本的分支合并功能
- 临时分支创建
- 冲突检测与回滚
- 日志记录
