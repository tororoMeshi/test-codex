# 変更レポート（要件/設計見直し）

## 概要
- 発生日: 2026-05-06
- 対象機能/モジュール: テンプレート生成後チェック、GitHub Actions のチェックモード判定
- 影響範囲: `.github/workflows/template-check.yml`, `docs/template-checklist.md`
- 関係者: テンプレート利用者、生成後プロジェクトの保守者

## 1. 何が想定外で起きたのか
- `docs/template-checklist.md` と `docs/template-structure.md` の扱いについて、ドキュメントでは置き換えを許す表現だったが、スクリプトでは存在した時点で失敗する仕様になっていた。
- GitHub Actions の `is_template` 判定で、API取得失敗や想定外レスポンスが `generated` 判定に落ちる可能性があった。

## 2. 想定外が起きた原因
- テンプレート本体専用ファイルと生成後プロジェクト用ファイルの命名・残存方針が明示されていなかった。
- CIのモード判定で、取得失敗と `false` 判定を明確に分離していなかった。

## 3. 対応方法
- `docs/template-checklist.md` と `docs/template-structure.md` は生成後プロジェクトでは削除する方針に統一した。
- 実プロジェクト用に同種の文書が必要な場合は、`project-checklist.md` や `project-structure.md` など別名で作成する方針を明記した。
- `is_template` 判定は `true` / `false` / 取得失敗または想定外レスポンスを明示的に分け、取得失敗時はCIを失敗させるようにした。

## 4. 要件定義や設計で修正した部分
- テンプレート本体専用ファイルは、生成後プロジェクトに同名で残さない設計に変更した。
- CIのチェックモード判定は fail closed とし、不明な状態を生成後プロジェクト扱いしない設計に変更した。
