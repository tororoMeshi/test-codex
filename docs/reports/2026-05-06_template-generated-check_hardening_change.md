# 変更レポート（要件/設計見直し）

## 概要
- 発生日: 2026-05-06
- 対象機能/モジュール: テンプレート健全性チェック、GitHub Actions、生成後プロジェクト検証
- 影響範囲: `.github/workflows/template-check.yml`, `scripts/check-template.sh`, `docs/template-checklist.md`, `docs/template-structure.md`
- 関係者: テンプレート利用者、生成後プロジェクトの保守者

## 1. 何が想定外で起きたのか
- GitHub Actions のチェックモード判定が固定リポジトリ名に依存していた。
- 生成後プロジェクトのテンプレート文言チェックが `README.md` のみに限定されていた。
- GitHub Actions とチェック用スクリプトの位置づけが、必須構成と推奨構成の間で揃っていなかった。

## 2. 想定外が起きた原因
- テンプレート本体と生成後プロジェクトを判定する根拠として、リポジトリの属性ではなくリポジトリ名を使っていた。
- 生成後も残すファイルと、テンプレート本体専用ファイルの扱いが明示されていなかった。
- 自動チェックを標準運用にする方針が、構成ドキュメントへ十分に反映されていなかった。

## 3. 対応方法
- GitHub Actions で GitHub API の `is_template` を参照し、`template` / `generated` モードを自動判定する。
- `generated` モードでは Markdown 全体からテンプレート本体向け文言を検出する。
- `docs/template-checklist.md` と `docs/template-structure.md` をテンプレート本体専用ファイルとして扱い、生成後プロジェクトでは残存を検出する。
- `.github/workflows/template-check.yml` と `scripts/check-template.sh` を必須構成に寄せる。

## 4. 要件定義や設計で修正した部分
- テンプレート本体判定は固定リポジトリ名ではなく、GitHub API の `is_template` を使う方針に変更した。
- 生成後プロジェクトでは、README だけでなく Markdown 全体のテンプレート文言残りを検査する方針に変更した。
- CI とチェックスクリプトをテンプレート標準構成として扱う方針に変更した。
