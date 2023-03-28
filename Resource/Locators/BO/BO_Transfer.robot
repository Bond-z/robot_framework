*** Variables ***

#Transfer Page
${BO_affi_radio_tab}     xpath=//*[@class='ant-radio-button-wrapper']
${BO_add_withdraw_item_btn}    xpath=//*[@class='ant-page-header-heading-extra']/button
${BO_search_user_withdraw_txt}    xpath=//input[@class='ant-input ant-input-lg']
${BO_modal_search_btn}    xpath=//*[@class='ant-input-group-addon']/button
${BO_total_affi_balance}    xpath=(//*[@class='search-result-column'])[2]//*[@class='value']
${BO_modal_cancel_btn}    xpath=//*[@class='ant-modal-footer']/button[1]
${BO_modal_withdraw_amt_txt}    xpath=//input[@id="withdrawamount"]
${BO_modal_confirm_btn}     xpath=//*[@class="ant-modal-footer"]/button[2]
${BO_final_comfirm_modal}    xpath=(//*[@class="ant-modal-content"])[2]
${BO_modal_final_confirm_transfer_btn}     xpath=//*[@class="AlertModal question-button"]/button[2]

#Tab รายการที่ต้องทำ
${BO_total_request_transfer}    xpath=(//*[@class="ant-table-row ant-table-row-level-0"])
${BO_transfer_btn}      xpath=//*[@class="ant-table-row ant-table-row-level-0"]//*[contains(text(),"{row_index}")]/../../td[10]
# ${BO_dropdown_bank_transfer}     xpath=(//*[@class="ant-dropdown ant-dropdown-placement-topRight "])[1]/ul/li[3]
${BO_modal_select_bank_txt}     xpath=//*[@class=" css-ackcql"]
${BO_transfer_select_bank_dp}    xpath=(//*[@class="ant-dropdown ant-dropdown-placement-bottomRight "])[1]/ul/li[3]

${BO_modal_select_bank_component}     xpath=//*[@class=" css-1ar3v5n-menu"]
${BO_madal_select_bank}    xpath=//*[@class="back-office-account-name" and contains(text(),"จำลอง สังข์ทอง")]

${BO_modal_reject_transfer_btn}     xpath=//*[@class="ant-modal-footer"]/button[2]
${BO_modal_confirm_transfer_via_bank}     xpath=//*[@class="ant-modal-footer"]/button[3]
${BO_modal_confirm_transfer}     xpath=//*[@class="ant-modal-content"]
${BO_alert_modal_final_confirm_btn}     xpath=//*[@class="AlertModal question-button"]/button[2]
#Sub Tab รอถอนเงิน รอคืนเงิน
${BO_todo_wait_list_withdraw}    xpath=//*[@class="ant-radio-group ant-radio-group-outline backoffice-radio-button"]/label[1]
${BO_todo_wait_list_transfer}    xpath=//*[@class="ant-radio-group ant-radio-group-outline backoffice-radio-button"]/label[2]

${BO_modal_select_bank_txt}     xpath=//*[@class=" css-14el2xx-placeholder"]
${BO_modal_dropdown_bll_bank}    

#Tab ประวัติทำรายการ
${BO_transfer_history_tab}    xpath=//*[@class="ant-tabs-nav-list"]/div[3]
${BO_verify_transfer_to_username}    xpath=//*[@class="ant-table-tbody"]/tr[2]//*[contains(text(), '{username}')]
${BO_verify_transfer_amount}    xpath=//*[@class="ant-table-tbody"]/tr[2]//*[contains(text(), '{amount}')]
${BO_verify_transfer_status}    xpath=//*[@class="ant-table-tbody"]/tr[2]//*[contains(text(), '{status}')]

# ${BO_verify_transfer_amount}    xpath=(//*[@class="ant-table-tbody"]//*[contains(text(),'PS621003847')])[1]/../../td[6]
# ${BO_verify_transfer_amount}    xpath=(//*[@class="ant-table-tbody"]//*[contains(text(),'PS621003847')])[1]/../../td[7]
