*** Variables ***
${BO_search_customer_txt}    xpath=//input[@class="ant-input ant-input-lg"]
${BO_edit_btn}     xpath=//*[@class="ant-table-tbody"]/tr[2]//*[contains(text(), 'PS381660885')]/../../../../td[14]
${BO_accountname_th_txt}    xpath=//input[@id="accountName"]
${BO_accountname_en_txt}    xpath=//input[@id="accountNameEN"]
${BO_enable_account}       xpath=(//*[@id="status"]//*[@class="ant-space-item"])[1]
${BO_disable_account}       xpath=(//*[@id="status"]//*[@class="ant-space-item"])[2]
${BO_confirm_edit_btn}    xpath=//*[@class="ant-modal-footer"]/button[2]
${BO_final_confirm_ok_btn}   xpath=//*[@class="AlertModal question-button"]/button[2]
${BO_user_status}          xpath=//*[@class="ant-table-tbody"]/tr[2]//*[contains(text(), 'PS381660885')]/../../../../td[13]
