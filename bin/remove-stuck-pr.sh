#!/bin/bash

repository=${1}
prNumber=${2}

if [[ ${repository} != "service" && ${repository} != "citizen-ui" && ${repository} != "general-apps-ccd-definition" && ${repository} != "general-applications" && ${repository} != "ccd" && ${repository} != "camunda" ]]; then
  echo "Supported repositories: general-apps-ccd-definition,citizen-ui,ccd, camunda,service,general applications"
  exit 1
fi

if [ -z "$prNumber" ]; then
  echo "You need to provide pr number"
  exit 1
fi

podsPrefix="civil-${repository}-pr-${prNumber}"
echo "Clearing resources for PR: " ${podsPrefix}

helm list -n civil | grep ${podsPrefix} | awk '{print $1}' | xargs helm uninstall -n civil
kubectl get deploy -n civil | grep ${podsPrefix} | awk '{print $1}' | xargs kubectl delete deploy -n civil
kubectl get job -n civil | grep ${podsPrefix} | awk '{print $1}' | xargs kubectl delete job -n civil
kubectl get statefulset -n civil| grep ${podsPrefix} | awk '{print $1}' | xargs kubectl delete statefulset -n civil
kubectl get svc -n civil | grep ${podsPrefix} | awk '{print $1}' | xargs kubectl delete svc -n civil
kubectl get po -n civil | grep ${podsPrefix} | awk '{print $1}' | xargs kubectl delete po -n civil
kubectl get secret -n civil | grep ${podsPrefix} | awk '{print $1}' | xargs kubectl delete secret -n civil
kubectl get PodDisruptionBudget -n civil | grep ${podsPrefix} | awk '{print $1}' | xargs kubectl delete PodDisruptionBudget -n civil
kubectl get ing -n civil | grep ${podsPrefix} | awk '{print $1}' | xargs kubectl delete ing -n civil
kubectl get configmaps -n civil | grep ${podsPrefix} | awk '{print $1}' | xargs kubectl delete configmaps -n civil