#!/usr/bin/env bash

set -eu

dir=$(dirname ${0})

${dir}/utils/idam-create-service.sh "ccd_gateway" "ccd_gateway" "ccd_gateway_secret" "http://localhost:3451/oauth2redirect"

${dir}/utils/idam-create-service.sh "civil" "civil" "OOOOOOOOOOOOOOOO" "https://localhost:9000/oauth2/callback"

${dir}/utils/idam-create-service.sh "xui_webapp" "xui_webapp" "OOOOOOOOOOOOOOOO" "http://localhost:3333/oauth2/callback" "false" "profile openid roles manage-user create-user search-user"

${dir}/utils/idam-create-service.sh "xui_mo_webapp" "xui_mo_webapp" "OOOOOOOOOOOOOOOO" "http://localhost:3000/oauth2/callback" "false" "profile openid roles manage-user create-user manage-roles search-user"

${dir}/utils/idam-create-service.sh "xuiaowebapp" "xuiaowebapp" "OOOOOOOOOOOOOOOO" "http://localhost:3000/oauth2/callback" "false" "profile openid roles manage-user create-user search-user"

${dir}/utils/idam-create-service.sh "aac_manage_case_assignment" "aac_manage_case_assignment" "OOOOOOOOOOOOOOOO" "https://manage-case-assignment/oauth2redirect" "false" "openid profile roles manage-user"

${dir}/utils/idam-create-service.sh "rd_professional_api" "rd_professional_api" "OOOOOOOOOOOOOOOO" "https://rd_professional_api/oauth2redirect" "false" "openid profile roles create-user manage-user search-user"

${dir}/utils/idam-create-service.sh "rd_user_profile_api" "rd_user_profile_api" "OOOOOOOOOOOOOOOO" "https://rd_user_profile_api/oauth2redirect" "false" "openid profile roles create-user manage-user search-user"

${dir}/utils/idam-create-service.sh "am_role_assignment" "am_role_assignment" "am_role_assignment_secret" "http://localhost:4096/oauth2redirect" "false" "profile openid roles search-user"

${dir}/utils/idam-create-service.sh "ccd_data_store_api" "ccd_data_store_api" "idam_data_store_client_secret" "http://ccd-data-store-api/oauth2redirect" "false" "profile openid roles manage-user"

${dir}/utils/idam-create-service.sh "civil_citizen_ui" "civil_citizen_ui" "citizen-ui-secret" "http://localhost:3001/oauth2/callback" "false" "profile openid roles manage-user create-user search-user openid profile roles"

${dir}/utils/idam-create-service.sh "civil_service" "civil_service" "OOOOOOOOOOOOOOOO" "http://localhost:4000/oauth2/callback" "false" "profile openid roles manage-user create-user search-user openid profile roles"