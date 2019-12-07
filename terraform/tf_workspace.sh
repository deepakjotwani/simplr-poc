#! /bin/bash

if [ "$1" == "" ]
then
  workspace=devops
else
  workspace=$1
fi

search_result=`terraform workspace list | grep $workspace`
if [ "$search_result" != "" ]
then
  terraform workspace select $workspace
else
  terraform workspace new $workspace
fi
