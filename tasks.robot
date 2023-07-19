*** Settings ***
Documentation       Create PDF invitations based on Excel data.



*** Variables ***
${EXCEL_FILE_PATH}=    ${CURDIR}${/}devdata${/}Data.xlsx
${PDF_TEMP_OUTPUT_DIR}=    ${CURDIR}${/}temp
${PDF_TEMPLATE_PATH}=    ${CURDIR}${/}devdata${/}invites.template


*** Tasks ***
Minimal task
    Create PDF invitations
    Log    Done.

*** Keywords ***
Create PDF invitations
    Log    Start creation

Download data from Excel files
    Log    1
Reformat Excel data
    Log    2
Create PDF invitation
    Log    3
Create ZIP for all invitations
    Log    4
Write logs
    Log    5
Clean up
    Log    6