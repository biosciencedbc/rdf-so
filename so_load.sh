#!/bin/bash

#
# soのRDFファイルをロードする
#


# プロパティ
WORK_DIR=/work
DATA_DIR=/data
FORCE_CONVERT=0
VERSION_FILE="so_version.txt"

# オプション解析
while getopts fP: OPT
  do
   case $OPT in
     f)  FORCE_CONVERT=1
   ;;
   esac
  done
shift  $(($OPTIND - 1))


cd ${WORK_DIR}
# versionの確認
version=`curl -s -L "http://www.ebi.ac.uk/ols/api/ontologies/so" | jq '.config | .version'`
file_url=`curl -s -L "http://www.ebi.ac.uk/ols/api/ontologies/so" | jq '.config | .id' | sed "s/\"//g"` 


# 前回ファイルのバージョンが記載されたファイルが存在する場合
if [ -e ${VERSION_FILE} ] && [ $FORCE_CONVERT -eq 0 ] ; then 
  before_version=`cat "${VERSION_FILE}"`
  # versionの更新がなければ、その旨を出力し正常終了する
  if [ "${before_version}" = "${version}" ]; then 
    echo "RDF is already up to date"
    exit 0
  # versionに更新があればダウンロードする
  else
    cd ${DATA_DIR}
    wget ${file_url} 2> /dev/stdout
    chmod 777 $(ls) 
    echo "${version}" > ${WORK_DIR}/${VERSION_FILE}
    chmod 777 ${WORK_DIR}/${VERSION_FILE}
  fi
# 前回ファイルがない場合(初回実行の場合)
else 
  
  # ファイルをダウンロードする
  cd ${DATA_DIR}
  wget ${file_url} 2> /dev/stdout
  chmod 777 $(ls)
  echo "${version}" > ${WORK_DIR}/${VERSION_FILE}
  chmod 777 ${WORK_DIR}/${VERSION_FILE}
fi




