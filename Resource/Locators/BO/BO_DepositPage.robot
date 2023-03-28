*** Variables ***
${BO_todo_list_tab}        xpath=//*[@class='ant-tabs-tab ant-tabs-tab-active']
${BO_history_tab}        xpath=(//*[@class="ant-tabs-nav-list"])/div[2]
${BO_deposit_btn}          xpath=//button[@class="ant-btn ant-btn-primary ant-btn-lg"]
${BO_deposit_modal}         xpath=//*[@class='ant-modal-content']
${BO_select_bank_account}     xpath=(//*[@class="ant-select-dropdown ant-select-dropdown-placement-bottomLeft "]//*[@class="ant-select-item-option-content"])[1]
${BO_select_bank_dropdown}    xpath=//input[@id='transactions_0_fromBankCode']
${BO_kbank}     xpath=//*[@class='ant-select-item ant-select-item-option ant-select-item-option-active']
${BO_dropdown_bbl}    xpath=(//*[@class='rc-virtual-list-holder-inner'])[2]/div[6]
${BO_dropdown_scb}    xpath=(//*[@class='rc-virtual-list-holder-inner'])[2]/div[2]
${BO_user_bank_account}     xpath=//input[@id='transactions_0_fromBankAccountNumber']
${BO_deposit_amount}     xpath=//input[@id='transactions_0_amount']
${BO_comfirm_deposit_btn}     xpath=//*[@class='ant-modal-footer']//button[2]
${BO_modal_comfirm_btn}     xpath=//*[@class='AlertModal question-button']/button[2]
${BO_todo_edit_btn}          xpath=//*[@class="ant-table-row ant-table-row-level-0"]//*[contains(text(),'Automated Account')]/../../../../td[11]//*[@class="ant-space-item"][1]/button
${BO_todo_edit_dropdown}    xpath=//*[@class="ant-dropdown ant-dropdown-show-arrow ant-dropdown-placement-bottomRight "]
${BO_todo_edit_dropdown_btn}          xpath=(//*[@class="ant-dropdown-menu-item"])[1]
${BO_todo_delete_dropdown_btn}          xpath=(//*[@class="ant-dropdown-menu-item"])[2]
${BO_todo_deposit_amt_table}     xpath=//*[@class="ant-table-row ant-table-row-level-0"]//*[contains(text(),'Automated Account')]/../../../../td[4]
${BO_todo_deposit_status_table}     xpath=//*[@class="ant-table-row ant-table-row-level-0"]//*[contains(text(),'Automated Account')]/../../../../td[7]
${BO_modal_content}          xpath=//*[@class="ant-modal-content"]
${BO_cancel_edit_modal}          xpath=//*[@class="ant-modal-footer"]//button[1]
${BO_confirm_edit_modal}          xpath=//*[@class="ant-modal-footer"]//button[2]
${BO_todo_deposit_btn}          xpath=//*[@class="ant-table-row ant-table-row-level-0"]//*[contains(text(),'Automated Account')]/../../../../td[11]//*[@class="ant-space-item"][2]/button
${BO_modal_deposit}          xpath=//*[@class='ant-modal-content']
${BO_modal_input_phone_txt}     xpath=//*[@class='ant-input ant-input-lg']
${BO_modal_username_txt}        xpath=(//*[@class='search-result-column']//*[@class='value'])[1]
${BO_modal_reject_deposit_btn}    xpath=//*[@class="ant-modal-footer"]/button[1]
${BO_modal_confirm_deposit_btn}    xpath=//*[@class='ant-btn ant-btn-success ant-btn-lg backoffice-button']
${BO_modal_final_confirm_btn}      xpath=//button[@class='ant-btn ant-btn-primary ant-btn-lg backoffice-button']
${BO_modal_after_confirm_btn}      xpath=//*[@class='AlertModal confirm-button']/button
${BO_alert_modal}          xpath=//*[@class="AlertModal question-button"]
${BO_madal_select_bank_dropdown}     xpath=//*[@class="ant-select-selection-item"]
${BO_select_reject_bank}          xpath=//*[@class="rc-virtual-list-holder-inner"]/div[5]
${BO_alert_modal_warning}          xpath=//*[@class="AlertModal--warning"]

#Sub Tab รอคืนเงิน รอแจ้งคืนเงิน
${BO_todo_wait_transfer_back_tab}    xpath=//*[@class="ant-radio-group ant-radio-group-outline backoffice-radio-button"]/label[2]
${BO_todo_goto_page}     xpath=//*[@class="ant-pagination-options-quick-jumper"]/input
${BO_todo_transfer_btn}    xpath=//*[@class="ant-table-row ant-table-row-level-0"]//*[contains(text(),'PS621003847')]/../../td[11]
${BO_transfer}     xpath=(//*[@class="ant-dropdown ant-dropdown-placement-topRight "]//*[@class="ant-typography"])[1]
${BO_modal_account_name_txt}    xpath=(//*[@class="ant-form-item-control-input-content"])[3]/input
${BO_confirm_transfer_modal}          xpath=//*[@class="footer"]/button[2]

#History table tab
${Deposit_history_status}    xpath=(//*[@class="ant-table-row ant-table-row-level-0"]//*[contains(text(),'PS621003847')])[1]/../../td[9]
  