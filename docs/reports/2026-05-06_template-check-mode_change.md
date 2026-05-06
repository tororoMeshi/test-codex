# 変更レポート（要件/設計見直し）

## 概要
- 発生日: 2026-05-06
- 対象機能/モジュール: テンプレート健全性チェック、生成後プロジェクト検証、テンプレート構成定義
- 影響範囲: `README.md`, `scripts/check-template.sh`, `docs/template-checklist.md`, `docs/template-structure.md`
- 関係者: テンプレート利用者、派生プロジェクト利用者、AIコード生成ツール

## 1. 何が想定外で起きたのか
- テンプレート本体の構成チェックと、生成後プロジェクトの置換漏れチェックが同じ扱いになっていた。
- ドキュメントでは `docs/reports/` を必須としている一方で、スクリプトは `docs/reports/.gitkeep` を必須にしていた。
- ドキュメントでは `README.md` が推奨追加だったが、スクリプトは `README.md` を前提に検査していた。

## 2. 想定外が起きた原因
- テンプレート本体で正しいREADME文言と、生成後プロジェクトでは残ってはいけないREADME文言の区別が明示されていなかった。
- 空ディレクトリ保持のための `.gitkeep` と、仕様として必須の `docs/reports/` ディレクトリが混同されていた。
- READMEの位置づけが、文書上の構成定義とスクリプトの実行前提で揃っていなかった。

## 3. 対応方法
- `scripts/check-template.sh` に `template` / `generated` mode を追加し、テンプレート本体チェックと生成後チェックを分離する。
- 必須ファイルとして `README.md` を明示する。
- `docs/reports/.gitkeep` ではなく `docs/reports/` ディレクトリの存在を確認する。
- テンプレート構成とチェックリストで `README.md` を必須に揃える。

## 4. 要件定義や設計で修正した部分
- テンプレート本体では `scripts/check-template.sh template`、生成後プロジェクトでは `scripts/check-template.sh generated` を使う方針に変更した。
- READMEはテンプレートの利用方針を伝える入口として必須扱いに変更した。
- 変更レポート保存先の要件は、実装都合の `.gitkeep` ではなく `docs/reports/` ディレクトリの存在で判断する方針に変更した。

## 補足（任意）
- 再発防止策: スクリプトの mode 分離と、ドキュメント上の必須構成の明確化
