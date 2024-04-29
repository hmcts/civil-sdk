#!/usr/bin/env bash

set -eu

dir=$(dirname ${0})

${dir}/utils/idam-add-role.sh "national-business-centre"
${dir}/utils/idam-add-role.sh "nbc-team-leader"
${dir}/utils/idam-add-role.sh "ctsc-team-leader"
${dir}/utils/idam-add-role.sh "ctsc"
${dir}/utils/idam-add-role.sh "task-supervisor"
${dir}/utils/idam-add-role.sh "cwd-user"
${dir}/utils/idam-add-role.sh "civil-national-business-centre"
${dir}/utils/idam-add-role.sh "judge"
${dir}/utils/idam-add-role.sh "hearing-centre-admin"
${dir}/utils/idam-add-role.sh "hearing-centre-team-leader"

${dir}/utils/idam-add-role.sh "ccd-import"
${dir}/utils/idam-add-role.sh "caseworker"
${dir}/utils/idam-add-role.sh "caseworker-civil"
${dir}/utils/idam-add-role.sh "caseworker-caa"
${dir}/utils/idam-add-role.sh "caseworker-approver"
${dir}/utils/idam-add-role.sh "defendant"

# User used during the CCD import and ccd-role creation
${dir}/utils/idam-create-caseworker.sh "ccd.docker.default@hmcts.net" "ccd-import"

${dir}/utils/ccd-add-role.sh "caseworker-civil"
${dir}/utils/ccd-add-role.sh "caseworker-caa"
${dir}/utils/ccd-add-role.sh "caseworker-approver"

${dir}/utils/idam-add-role.sh "prd-aac-system"
${dir}/utils/ccd-add-role.sh "prd-aac-system"

${dir}/utils/ccd-add-role.sh "citizen"

${dir}/utils/ccd-add-role.sh "caseworker-cmc-anonymouscitizen"
${dir}/utils/ccd-add-role.sh "caseworker-cmc"
${dir}/utils/ccd-add-role.sh "caseworker-cmc-legaladvisor"
${dir}/utils/ccd-add-role.sh "caseworker-cmc-judge"
${dir}/utils/ccd-add-role.sh "TTL-admin"

${dir}/utils/ccd-add-role.sh "next-hearing-date-admin"

roles=("solicitor" "systemupdate" "admin" "staff" "judge")
for role in "${roles[@]}"
do
  ${dir}/utils/idam-add-role.sh "caseworker-civil-${role}"
  ${dir}/utils/ccd-add-role.sh "caseworker-civil-${role}"
done

accessprofiles=("defendant" "judge-profile" "basic-access" "ga-basic-access" "legal-adviser" "GS_profile" "caseworker-ras-validation" "full-access" "admin-access" "APPLICANT-PROFILE" "APPLICANT-PROFILE-SPEC" "RESPONDENT-ONE-PROFILE-SPEC"
"civil-administrator-basic" "civil-administrator-standard" "caseworker-wa-task-configuration" "hearing-schedule-access" "APP-SOL-UNSPEC-PROFILE" "APP-SOL-SPEC-PROFILE" "RES-SOL-ONE-UNSPEC-PROFILE" "RESPONDENT-ONE-PROFILE"
"RES-SOL-ONE-SPEC-PROFILE" "RES-SOL-TWO-UNSPEC-PROFILE" "RES-SOL-TWO-SPEC-PROFILE" "payment-access" "caseflags-admin" "caseflags-viewer" "hearing-manager" "hearing-viewer" "caseworker-wa-task-configuration" "CITIZEN-CLAIMANT-PROFILE" "CITIZEN-DEFENDANT-PROFILE" "cui-admin-profile" "cui-nbc-profile" "citizen-profile" 
"caseworker-civil-citizen-ui-pcqextractor" "hearing-centre-team-leader" "national-business-centre" "hearing-centre-admin" "judge" "next-hearing-date-admin" "court-officer-order")

for accessprofile in "${accessprofiles[@]}"
do
  ${dir}/utils/ccd-add-role.sh "${accessprofile}"
done

roles=("caa" "case-manager" "finance-manager" "organisation-manager" "user-manager")
for role in "${roles[@]}"
do
  ${dir}/utils/idam-add-role.sh "pui-${role}"
done

${dir}/utils/idam-add-role.sh "caseworker-probate"
${dir}/utils/idam-add-role.sh "caseworker-probate-solicitor"

${dir}/utils/idam-add-role.sh "caseworker-ia"
${dir}/utils/idam-add-role.sh "caseworker-ia-legalrep-solicitor"

${dir}/utils/idam-add-role.sh "caseworker-publiclaw"
${dir}/utils/idam-add-role.sh "caseworker-publiclaw-solicitor"

${dir}/utils/idam-add-role.sh "xui-approver-userdata"

${dir}/utils/idam-add-role.sh "caseworker-cmc-anonymouscitizen"
${dir}/utils/idam-add-role.sh "caseworker-cmc"
${dir}/utils/idam-add-role.sh "caseworker-cmc-legaladvisor"
${dir}/utils/idam-add-role.sh "caseworker-cmc-judge"
${dir}/utils/idam-add-role.sh "TTL-admin"

prdRoles=('"caseworker"','"defendant"','"caseworker-caa"','"caseworker-divorce"','"caseworker-divorce-solicitor"','"caseworker-divorce-financialremedy"','"caseworker-divorce-financialremedy-solicitor"','"caseworker-probate"','"caseworker-ia"','"caseworker-probate-solicitor"','"caseworker-publiclaw"','"caseworker-ia-legalrep-solicitor"','"caseworker-publiclaw-solicitor"','"caseworker-civil"','"caseworker-civil-solicitor"','"xui-approver-userdata"','"pui-caa"','"prd-admin"','"pui-case-manager"','"pui-finance-manager"','"pui-organisation-manager"','"pui-user-manager"')
${dir}/utils/idam-add-role.sh "prd-admin" "${prdRoles[@]}"
${dir}/utils/idam-add-role.sh "payments"
${dir}/utils/ccd-add-role.sh "payments"

${dir}/utils/idam-add-role.sh "next-hearing-date-admin"
