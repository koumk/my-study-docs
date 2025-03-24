iconv を使用して、Windows（Shift-JIS）から Linux（EUC-JP）に文字コードを変換し、同時に改行コードを CRLF（Windows）から LF（Linux）に変換するには、以下のコマンドを使用します。

サンプルコマンド:
bash
コピーする
編集する

iconv -f SHIFT-JIS -t EUC-JP input.txt | sed 's/\r$//' > output.txt

説明:
iconv -f SHIFT-JIS -t EUC-JP input.txt

-f SHIFT-JIS（SJIS や CP932 でも可）：変換元の文字コード（Windows の Shift-JIS）

-t EUC-JP：変換先の文字コード（Linux の EUC-JP）

sed 's/\r$//'

Windows の改行コード CRLF (\r\n) を LF (\n) に変換（\r を削除）

> output.txt

変換後のデータを output.txt に保存

確認:
変換後の output.txt を file コマンドで確認できます。

bash
コピーする
編集する
file output.txt
または、エンコーディングをチェック：

bash
コピーする
編集する
iconv -f EUC-JP -t UTF-8 output.txt | less
バッチ処理（複数ファイル変換）
ディレクトリ内のすべての *.txt を変換する場合:

bash
コピーする
編集する
for file in *.txt; do
  iconv -f SHIFT-JIS -t EUC-JP "$file" | sed 's/\r$//' > "converted_$file"
done
これにより、converted_ファイル名.txt として変換されたファイルが作成されます。

以上です！





Bashスクリプトでパラメータ（オプション）に-Eが含まれているかを判断するサンプルコード


#!/bin/bash

# フラグ変数
has_E=false

# 引数をループでチェック
for arg in "$@"; do
  if [ "$arg" = "-E" ]; then
    has_E=true
    break
  fi
done

# -Eの有無に応じた処理
if $has_E; then
  echo "Parameter -E is present"
else
  echo "Parameter -E is not present"
fi

echo "All arguments: $@"



#!/bin/bash

has_E=false

while getopts "E" opt; do
  case $opt in
    E) has_E=true;;
    ?) echo "Usage: $0 [-E]"; exit 1;;
  esac
done

if $has_E; then
  echo "Batch stopping all jobs..."
  # ジョブの一括強制終了処理（仮）
  for job in $(ps -ef | grep "[j]ob" | awk '{print $2}'); do
    kill -9 "$job" && echo "Stopped job $job"
  done
else
  echo "No -E specified, listing job status instead..."
  # ジョブ状態確認処理（仮）
  ps -ef | grep "[j]ob"
fi


#!/bin/bash

# フラグ変数
has_E=false

# オプション解析
while getopts "a:b:Ec" opt; do
  case $opt in
    a) echo "Option -a with value: $OPTARG";;
    b) echo "Option -b with value: $OPTARG";;
    E) has_E=true;;
    c) echo "Option -c detected";;
    ?) echo "Unknown option"; exit 1;;
  esac
done

# -Eの有無に応じた処理
if $has_E; then
  echo "Parameter -E is present"
else
  echo "Parameter -E is not present"
fi

# 残りの引数（オプション以外）をシフト
shift $((OPTIND - 1))
echo "Remaining arguments: $@"


#!/bin/bash

# 引数チェック（2つあるか）
if [ "$#" -ne 2 ]; then
    echo "エラー: パラメータの数が正しくありません。"
    echo "使用例: $0 123 \"apple,banana,orange\""
    echo "       $0 1 apple"
    exit 1
fi

param1="$1"  # 数値
param2="$2"  # 文字列またはカンマ区切り文字列

# **パラメータ1（数値）のチェック**
if [[ ! "$param1" =~ ^[0-9]+$ ]]; then
    echo "エラー: パラメータ1は整数である必要があります。（入力: $param1）"
    exit 1
fi

# **パラメータ2のチェック**
if [[ "$param1" == "0" || "$param1" == "1" ]]; then
    # パラメータ1が 0 または 1 の場合、パラメータ2は単純な文字列でOK
    if [[ "$param2" =~ "," ]]; then
        echo "エラー: パラメータ1が 0 または 1 の場合、パラメータ2は単純な文字列にしてください。（入力: $param2）"
        exit 1
    fi
else
    # それ以外の場合、パラメータ2はカンマ区切りでダブルクォーテーションで囲まれていることを要求
    if [[ ! "$param2" =~ ^\"[^\"]+\"$ ]]; then
        echo "エラー: パラメータ1が 0 または 1 以外の場合、パラメータ2はダブルクォーテーションで囲まれたカンマ区切り文字列である必要があります。（入力: $param2）"
        exit 1
    fi

    # ダブルクォーテーションを取り除き、中身がカンマ区切りになっているかチェック
    param2_content="${param2:1:-1}"  # 先頭と末尾のダブルクォーテーションを削除

    if [[ ! "$param2_content" =~ ^[^,]+(,[^,]+)*$ ]]; then
        echo "エラー: パラメータ2はカンマ区切りの形式である必要があります。（入力: $param2）"
        exit 1
    fi
fi

echo "✅ 正常: パラメータチェックを通過しました！"
echo "パラメータ1（数値）: $param1"
echo "パラメータ2（内容）: $param2"



date -d "19801 seconds ago" "+%Y-%m-%d %H:%M:%S"


date -d "@$(( $(date +%s) - 19801 ))" "+%Y-%m-%d %H:%M:%S"


#!/bin/bash

# 引数チェック（2つあるか）
if [ "$#" -ne 2 ]; then
    echo "エラー: パラメータの数が正しくありません。"
    echo "使用例: $0 123 \"apple,banana,orange\""
    exit 1
fi

param1="$1"  # 数値
param2="$2"  # ダブルクォーテーションで囲まれたカンマ区切り文字列

# **パラメータ1（数値）のチェック**
if [[ ! "$param1" =~ ^[0-9]+$ ]]; then
    echo "エラー: パラメータ1は整数である必要があります。（入力: $param1）"
    exit 1
fi

# **パラメータ2（カンマ区切り文字列）のチェック**
if [[ ! "$param2" =~ ^\"[^\"]+\"$ ]]; then
    echo "エラー: パラメータ2はダブルクォーテーションで囲まれたカンマ区切り文字列である必要があります。（入力: $param2）"
    exit 1
fi

# **ダブルクォーテーションを取り除き、中身がカンマ区切りになっているかチェック**
param2_content="${param2:1:-1}"  # 先頭と末尾のダブルクォーテーションを削除

if [[ ! "$param2_content" =~ ^[^,]+(,[^,]+)*$ ]]; then
    echo "エラー: パラメータ2はカンマ区切りの形式である必要があります。（入力: $param2）"
    exit 1
fi

echo "✅ 正常: パラメータチェックを通過しました！"
echo "パラメータ1（数値）: $param1"
echo "パラメータ2（カンマ区切り）: $param2_content"




#!/bin/bash

# コマンド実行（仮の例）
output=$(sjPEX_netinfo -d20100801 -FTSframe1 TSnet1)

# 2行目の取得
line2=$(echo "$output" | sed -n '2p')

# スペース区切りで2個目のデータを取得（awk を使用）
second_field=$(echo "$line2" | awk '{print $2}')

# "TSnet1" かどうかチェック
if [[ "$second_field" == "TSnet1" ]]; then
    echo "✅ 2行目の2個目のデータは 'TSnet1' です"
else
    echo "❌ 2行目の2個目のデータは 'TSnet1' ではありません（取得値: '$second_field'）"
fi






#!/bin/bash

input="apple,banana,grape,orange"  # チェックする文字列
expected_count=4                   # 期待する項目数

IFS=',' read -r -a array <<< "$input"  # カンマ区切りで配列に分割
actual_count=${#array[@]}              # 配列の要素数を取得

if [ "$actual_count" -eq "$expected_count" ]; then
    echo "項目数が一致しています。(${actual_count}項目)"
else
    echo "エラー: 項目数が異なります。(${actual_count}項目, 期待値: ${expected_count}項目)"
fi



#!/bin/bash

input="apple,banana,20240304,orange"  # チェックする文字列
expected_count=4                       # 期待する項目数

IFS=',' read -r -a array <<< "$input"  # カンマ区切りで配列化
actual_count=${#array[@]}              # 配列の要素数を取得

# 項目数チェック
if [ "$actual_count" -ne "$expected_count" ]; then
    echo "エラー: 項目数が異なります。(${actual_count}項目, 期待値: ${expected_count}項目)"
    exit 1
fi

# 3番目の要素を取得
third_element="${array[2]}"

# YYYYMMDD 形式チェック（8桁の数字）
if [[ ! "$third_element" =~ ^[0-9]{8}$ ]]; then
    echo "エラー: 3番目の項目が YYYYMMDD の形式ではありません。(${third_element})"
    exit 1
fi

# 日付の妥当性チェック（2024-02-30 などの不正日付を弾く）
year="${third_element:0:4}"
month="${third_element:4:2}"
day="${third_element:6:2}"

if ! date -d "$year-$month-$day" "+%Y%m%d" &>/dev/null; then
    echo "エラー: 3番目の項目が無効な日付です。(${third_element})"
    exit 1
fi

echo "正常: 項目数と日付フォーマットが正しいです。（${third_element}）"




#!/bin/bash

input="apple,banana20240304orange"  # チェックする文字列
expected_count=4                     # 期待する項目数

IFS=',' read -r -a array <<< "$input"  # カンマ区切りで配列化
actual_count=${#array[@]}              # 配列の要素数を取得

# 項目数チェック
if [ "$actual_count" -ne "$expected_count" ]; then
    echo "エラー: 項目数が異なります。(${actual_count}項目, 期待値: ${expected_count}項目)"
    exit 1
fi

# 3番目の要素を取得
third_element="${array[2]}"

# 3番目の要素が空かどうかチェック
if [ -z "$third_element" ]; then
    echo "エラー: 3番目の項目が存在しません。"
    exit 1
fi

# YYYYMMDD 形式チェック（8桁の数字）
if [[ ! "$third_element" =~ ^[0-9]{8}$ ]]; then
    echo "エラー: 3番目の項目が YYYYMMDD の形式ではありません。(${third_element})"
    exit 1
fi

# 日付の妥当性チェック
year="${third_element:0:4}"
month="${third_element:4:2}"
day="${third_element:6:2}"

if ! date -d "$year-$month-$day" "+%Y%m%d" &>/dev/null; then
    echo "エラー: 3番目の項目が無効な日付です。(${third_element})"
    exit 1
fi

echo "正常: 項目数と日付フォーマットが正しいです。（${third_element}）"


