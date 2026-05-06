# 変更レポート（要件/設計見直し）

## 概要
- 発生日: 2026-05-06
- 対象機能/モジュール: テンプレート健全性チェック、GitHub Actions、チェックリスト
- 影響範囲: `.github/workflows/template-check.yml`, `scripts/check-template.sh`, `docs/template-checklist.md`
- 関係者: テンプレート利用者、生成後プロジェクトの保守者

## 1. 何が想定外で起きたのか
- 生成後プロジェクトでも workflow がデフォルトの `template` モードで実行されるため、README のテンプレート文言残りを CI で検出できない可能性があった。
- `AI_INSTRUCTIONS.md` が参照する `docs/project-intent.md` が必須ファイルチェックとチェックリストに含まれていなかった。

## 2. 想定外が起きた原因
- `generated` モードはスクリプトに追加されていたが、GitHub Actions から実行される経路に接続されていなかった。
- `docs/project-intent.md` の重要度が上がった後、必須ファイル定義への反映が漏れていた。

## 3. 対応方法
- workflow で `GITHUB_REPOSITORY` を見て、テンプレート本体では `template`、それ以外では `generated` モードを実行するようにした。
- `scripts/check-template.sh` の `required_files` に `docs/project-intent.md` を追加した。
- `docs/template-checklist.md` に `docs/project-intent.md` と CI の自動モード切替確認項目を追加した。

## 4. 要件定義や設計で修正した部分
- テンプレート本体と生成後プロジェクトでは、CI で実行すべきチェックモードが異なることを明示した。
- `docs/project-intent.md` を AI 向け必須導線の一部として扱う方針に揃えた。
