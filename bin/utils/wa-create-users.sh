#!/usr/bin/env bash

# Setup Users
echo ""
echo "Setting up required Users..."
./create-user.sh "ccd-import@fake.hmcts.net" "CCD" "Import" "London01" "ccd-import" "[{\"code\":\"ccd-import\"}]"
./create-user.sh "${IDAM_CASEWORKER_SYSTEM_USERNAME}" "System" "user" "${IDAM_CASEWORKER_SYSTEM_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-system\"}]"

echo "Setting up WA test accounts"
./create-user.sh "${TEST_WA_CASEOFFICER_A_USERNAME}" "CaseOfficer" "TestPurposes A" "${TEST_WA_CASEOFFICER_A_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-caseofficer\"}]"
./create-user.sh "${TEST_WA_CASEOFFICER_B_USERNAME}" "CaseOfficer" "TestPurposes B" "${TEST_WA_CASEOFFICER_B_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-caseofficer\"}]"
./create-user.sh "${TEST_WA_LAW_FIRM_USERNAME}" "LegalRep" "TestPurposes" "${TEST_WA_LAW_FIRM_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-system\"}, { \"code\": \"caseworker-civil-legalrep-solicitor\"}, { \"code\": \"payments\"}]"
./organisational-role-assignment.sh "${TEST_WA_LAW_FIRM_USERNAME}" "${TEST_WA_LAW_FIRM_PASSWORD}" "PUBLIC" "case-allocator" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_LAW_FIRM_USERNAME}" "${TEST_WA_LAW_FIRM_PASSWORD}" "PUBLIC" "task-supervisor" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_LAW_FIRM_USERNAME}" "${TEST_WA_LAW_FIRM_PASSWORD}" "PUBLIC" "tribunal-caseworker" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'

./create-user.sh "${TEST_WA_DLQ_PROCESS_USERNAME}" "WAUser" "WaDlqProcess" "${TEST_WA_DLQ_PROCESS_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-system\"}, { \"code\": \"caseworker-wa\"}, { \"code\": \"caseworker-wa-task-configuration\"}, { \"code\": \"caseworker-civil-legalrep-solicitor\"}, { \"code\": \"payments\"}]"
./organisational-role-assignment.sh "${TEST_WA_DLQ_PROCESS_USERNAME}" "${TEST_WA_DLQ_PROCESS_PASSWORD}" "PUBLIC" "case-allocator" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_DLQ_PROCESS_USERNAME}" "${TEST_WA_DLQ_PROCESS_PASSWORD}" "PUBLIC" "task-supervisor" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_DLQ_PROCESS_USERNAME}" "${TEST_WA_DLQ_PROCESS_PASSWORD}" "PUBLIC" "tribunal-caseworker" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'

echo "Setting up WA Users and role assignments..."
./create-user.sh "${WA_SYSTEM_USERNAME}" "WASystem" "WaUser" "${WA_SYSTEM_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-system\"}, { \"code\": \"caseworker-wa\"}, { \"code\": \"caseworker-wa-task-configuration\"}]"

./create-user.sh "${TEST_WA_CASEOFFICER_PUBLIC_A_USERNAME}" "CaseOfficer" "A-Public" "${TEST_WA_CASEOFFICER_PUBLIC_A_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-caseofficer\"}]"
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_A_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_A_PASSWORD}" "PUBLIC" "case-allocator" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_A_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_A_PASSWORD}" "PUBLIC" "task-supervisor" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_A_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_A_PASSWORD}" "PUBLIC" "tribunal-caseworker" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'

./create-user.sh "${TEST_WA_CASEOFFICER_PUBLIC_B_USERNAME}" "CaseOfficer" "B-Public" "${TEST_WA_CASEOFFICER_PUBLIC_B_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-caseofficer\"}]"
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_B_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_B_PASSWORD}" "PUBLIC" "case-allocator" '{"jurisdiction":"CIVIL","region":"east-england","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_B_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_B_PASSWORD}" "PUBLIC" "task-supervisor" '{"jurisdiction":"CIVIL","region":"east-england","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_B_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_B_PASSWORD}" "PUBLIC" "tribunal-caseworker" '{"jurisdiction":"CIVIL","region":"east-england","primaryLocation":"765324"}'

./create-user.sh "${TEST_WA_CASEOFFICER_PUBLIC_C_USERNAME}" "CaseOfficer" "C-Public" "${TEST_WA_CASEOFFICER_PUBLIC_C_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-caseofficer\"}]"
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_C_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_C_PASSWORD}" "PUBLIC" "case-allocator" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_C_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_C_PASSWORD}" "PUBLIC" "task-supervisor" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_C_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_C_PASSWORD}" "PUBLIC" "tribunal-caseworker" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'

./create-user.sh "${TEST_WA_CASEOFFICER_PUBLIC_D_USERNAME}" "CaseOfficer" "D-Public" "${TEST_WA_CASEOFFICER_PUBLIC_D_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-caseofficer\"}]"
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_D_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_D_PASSWORD}" "PUBLIC" "case-allocator" '{"jurisdiction":"CIVIL","region":"east-england","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_D_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_D_PASSWORD}" "PUBLIC" "task-supervisor" '{"jurisdiction":"CIVIL","region":"east-england","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_WA_CASEOFFICER_PUBLIC_D_USERNAME}" "${TEST_WA_CASEOFFICER_PUBLIC_D_PASSWORD}" "PUBLIC" "tribunal-caseworker" '{"jurisdiction":"CIVIL","region":"east-england","primaryLocation":"765324"}'

./create-user.sh "${WA_CASEOFFICER_USERNAME}" "WaCaseOfficer" "case worker" "${WA_CASEOFFICER_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-wa\"}, {\"code\": \"caseworker-wa-task-officer\"}]"
./organisational-role-assignment.sh "${WA_CASEOFFICER_USERNAME}" "${WA_CASEOFFICER_USERNAME}" "PUBLIC" "case-allocator" '{"jurisdiction":"WA","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${WA_CASEOFFICER_USERNAME}" "${WA_CASEOFFICER_USERNAME}" "PUBLIC" "task-supervisor" '{"jurisdiction":"WA","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${WA_CASEOFFICER_USERNAME}" "${WA_CASEOFFICER_USERNAME}" "PUBLIC" "tribunal-caseworker" '{"jurisdiction":"WA","primaryLocation":"765324"}'


echo "Setting up CIVIL Users..."
./create-user.sh "${TEST_CASEOFFICER_USERNAME}" "Case" "Officer" "${TEST_CASEOFFICER_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-caseofficer\"}, { \"code\": \"payments\"}]"
./organisational-role-assignment.sh "${TEST_CASEOFFICER_USERNAME}" "${TEST_CASEOFFICER_PASSWORD}" "PUBLIC" "case-allocator" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_CASEOFFICER_USERNAME}" "${TEST_CASEOFFICER_PASSWORD}" "PUBLIC" "task-supervisor" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'
./organisational-role-assignment.sh "${TEST_CASEOFFICER_USERNAME}" "${TEST_CASEOFFICER_PASSWORD}" "PUBLIC" "tribunal-caseworker" '{"jurisdiction":"CIVIL","primaryLocation":"765324"}'

./create-user.sh "${TEST_JUDICIARY_USERNAME}" "Tribunal" "Judge" "${TEST_JUDICIARY_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-judiciary\"}]"
./create-user.sh "${TEST_LAW_FIRM_A_USERNAME}" "A" "Legal Rep" "${TEST_LAW_FIRM_A_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-system\"}, { \"code\": \"caseworker-civil-legalrep-solicitor\"}, { \"code\": \"payments\"}]"
./create-user.sh "${TEST_LAW_FIRM_B_USERNAME}" "B" "Legal Rep" "${TEST_LAW_FIRM_B_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, {\"code\": \"caseworker-civil-legalrep-solicitor\"},{ \"code\": \"payments\"}]"
./create-user.sh "${TEST_ADMINOFFICER_USERNAME}" "Admin" "Officer" "${TEST_ADMINOFFICER_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-admofficer\"}, { \"code\": \"payments\"}]"
./create-user.sh "${TEST_HOMEOFFICE_APC_USERNAME}" "Home Office" "APC" "${TEST_HOMEOFFICE_APC_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-homeofficeapc\"}]"
./create-user.sh "${TEST_HOMEOFFICE_LART_USERNAME}" "Home Office" "LART" "${TEST_HOMEOFFICE_LART_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-homeofficelart\"}]"
./create-user.sh "${TEST_HOMEOFFICE_POU_USERNAME}" "Home Office" "POU" "${TEST_HOMEOFFICE_POU_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-homeofficepou\"}]"
./create-user.sh "${TEST_HOMEOFFICE_GENERIC_USERNAME}" "Home Office" "Generic" "${TEST_HOMEOFFICE_GENERIC_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-respondentofficer\"}]"
./create-user.sh "${TEST_CITIZEN_USERNAME}" "Citizen" "User" "${TEST_CITIZEN_PASSWORD}" "citizens" "[{\"code\": \"citizen\"}]"

./create-user.sh "${TEST_LAW_FIRM_SHARE_CASE_ORG_USERNAME}" "Org Creator" "Legal Rep" "${TEST_LAW_FIRM_SHARE_CASE_ORG_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-legalrep-solicitor\"}, { \"code\": \"pui-case-manager\"}, { \"code\": \"pui-user-manager\"}, { \"code\": \"pui-finance-manager\"}, { \"code\": \"pui-organisation-manager\"}, { \"code\": \"caseworker-divorce\"}, { \"code\": \"caseworker-divorce-financialremedy\"}, { \"code\": \"caseworker-divorce-financialremedy-solicitor\"}, { \"code\": \"caseworker-divorce-solicitor\"}, { \"code\": \"caseworker-publiclaw-solicitor\"}, { \"code\": \"caseworker-publiclaw\"}, { \"code\": \"caseworker-probate-solicitor\"}, { \"code\": \"caseworker-probate\"}, { \"code\": \"caseworker-sscs\"}, { \"code\": \"caseworker-sscs-dwpresponsewriter\"}, { \"code\": \"payments\"}]"
./create-user.sh "${TEST_LAW_FIRM_SHARE_CASE_A_USERNAME}" "Share A" "Legal Rep" "${TEST_LAW_FIRM_SHARE_CASE_A_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-legalrep-solicitor\"}, { \"code\": \"pui-case-manager\"}, { \"code\": \"payments\"}]"
./create-user.sh "${TEST_LAW_FIRM_SHARE_CASE_B_USERNAME}" "Share B" "Legal Rep" "${TEST_LAW_FIRM_SHARE_CASE_B_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-legalrep-solicitor\"}, { \"code\": \"pui-case-manager\"}, { \"code\": \"payments\"}]"

./create-user.sh "${TEST_JUDGE_X_USERNAME}" "Judge" "X" "${TEST_JUDGE_X_PASSWORD}" "caseworker" "[{ \"code\": \"caseworker\"}, { \"code\": \"caseworker-civil\"}, { \"code\": \"caseworker-civil-judge\"}]"