# 変更レポート（要件/設計見直し）

## 概要
- 発生日: 2026-05-06
- 対象機能/モジュール: テンプレート自己説明、AI入口ルール、テンプレート健全性チェック
- 影響範囲: `README.md`, `AGENTS.md`, `docs/template-checklist.md`, `docs/template-structure.md`, `scripts/check-template.sh`, `.github/workflows/template-check.yml`
- 関係者: リポジトリ利用者、AIコード生成ツール

## 1. 何が想定外で起きたのか
- テンプレート本体のREADMEが、生成後プロジェクトとして読める文面になっていた。
- AI入口である `AGENTS.md` のテスト規約が、詳細ルールより弱く読める状態だった。

## 2. 想定外が起きた原因
- テンプレート本体向けの説明と、生成後プロジェクト向けの説明が同じREADME内で混在していた。
- 詳細ルールの強制力を `AGENTS.md` の要約へ十分に反映できていなかった。

## 3. 対応方法
- READMEをテンプレート本体の説明に統一する。
- `AGENTS.md` のテスト規約を `AI_INSTRUCTIONS.md` と整合する強さにする。
- 必須ファイルとREADMEの危険な残存文言を確認する軽量チェックを追加する。
- GitHub Actionsでテンプレートチェックを実行する。

## 4. 要件定義や設計で修正した部分
- テンプレートは「GitHub Template本体」として自己説明する方針に統一した。
- 変更時のテスト追加は原則必須とし、例外時は理由と検証方法を明記する方針に統一した。
- テンプレート健全性を手動チェックだけでなくスクリプトでも確認する方針を追加した。

## 補足（任意）
- 再発防止策: `scripts/check-template.sh` と `.github/workflows/template-check.yml` による自動チェック
