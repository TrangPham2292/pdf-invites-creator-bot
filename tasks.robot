*** Settings ***
Documentation       Create PDF invitations based on Excel data.


Library    RPA.FileSystem
Library    RPA.Excel.Files
Library    RPA.PDF
Library    RPA.Archive

*** Variables ***
${EXCEL_FILE_PATH}=    ${CURDIR}${/}devdata${/}Data.xlsx
${PDF_TEMP_OUTPUT_DIR}=    ${CURDIR}${/}temp
${PDF_TEMPLATE_PATH}=    ${CURDIR}${/}devdata${/}invite.template


*** Tasks ***
Create PDF invitations
    Set up directories
    ${inviations}=    Collect invitations from Excel file
    FOR    ${invitationData}    IN    @{inviations}
        Run Keyword And Continue On Failure
        ...    Create PDF file for invitation    ${invitationData}
    END
    Create ZIP package for PDF files
    [Teardown]    Cleanup PDF temporary directory

*** Keywords ***
Set up directories
    Create Directory    ${PDF_TEMP_OUTPUT_DIR}
    Create Directory    ${OUTPUT_DIR}
Collect invitations from Excel file
    Open Workbook    ${EXCEL_FILE_PATH}
    ${invitations}    Read Worksheet As Table    header=${True}
    Close Workbook
    RETURN    ${invitations}
Create PDF file for invitation
    [Arguments]    ${invitationData}
    Template Html To Pdf
    ...    ${PDF_TEMPLATE_PATH}
    ...    ${PDF_TEMP_OUTPUT_DIR}${/}${invitationData}[first_name]_${invitationData}[last_name].pdf
    ...    ${invitationData}
Create ZIP package for PDF files
    ${zip_file_name}=    Set Variable    ${OUTPUT_DIR}${/}PDFs.zip
    Archive Folder With Zip
    ...    ${PDF_TEMP_OUTPUT_DIR}
    ...    ${zip_file_name}
Cleanup PDF temporary directory
    Remove Directory    ${PDF_TEMP_OUTPUT_DIR}    ${True}