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


