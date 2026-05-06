# 変更レポート: 生成後モードスモークテスト追加

## 1. 何が想定外で起きたのか
- `generated` モードの検査ロジックが、テンプレート本体CIで継続的に実行されない構成になっていた。
- `.github/workflows/template-check.yml` と `scripts/check-template.sh` がテンプレート本体専用の必須ファイル扱いになっており、生成後プロジェクト側の品質ゲートとして残す方針とずれていた。

## 2. 想定外が起きた原因
- テンプレート本体専用ファイルと、生成後プロジェクトにも必要な品質ゲートの分類が混在していた。
- GitHub Actions の自動判定では通常どちらか一方のモードだけを実行するため、テンプレート本体では `generated` 分岐の退行を検出しにくかった。

## 3. 対応方法
- `.github/workflows/template-check.yml` と `scripts/check-template.sh` を共通必須ファイルへ戻した。
- `docs/template-checklist.md`, `docs/template-structure.md`, `scripts/smoke-test-generated.sh` をテンプレート本体専用ファイルとして扱うよう整理した。
- テンプレート本体CIで生成後プロジェクト相当の一時コピーを作り、テンプレート由来文書を除いたうえで `scripts/check-template.sh generated` を実行する `scripts/smoke-test-generated.sh` を追加した。

## 4. 要件定義や設計で修正した部分
- 生成後プロジェクトにも workflow と検査スクリプトを残す方針を `docs/template-checklist.md` に明記した。
- テンプレート本体専用ファイルと生成後にも残す品質ゲートの分類を `docs/template-structure.md` に明記した。

## 検証方法
- `bash -n scripts/check-template.sh`
- `bash -n scripts/smoke-test-generated.sh`
- `bash scripts/check-template.sh template`
- `bash scripts/smoke-test-generated.sh`
