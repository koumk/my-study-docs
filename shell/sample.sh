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


