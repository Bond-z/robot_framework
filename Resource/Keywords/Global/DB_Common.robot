*** Settings ***
Library           DatabaseLibrary
Variables         ../../Config/Environment.yaml

*** Keywords ***
DB Connect To SQL Database
    [Arguments]    ${db_name}    ${db_username}    ${db_password}    ${db_host}    ${db_port}
    DatabaseLibrary.Connect To Database    dbapiModuleName=pymysql    dbName=${db_name}    dbUsername=${db_username}    dbPassword=${db_password}    dbHost=${db_host}    dbPort=${db_port}

DB Connect To Postgres Database
    [Arguments]    ${db_name}    ${db_username}    ${db_password}    ${db_host}    ${db_port}=5432
    DatabaseLibrary.Connect To Database    dbapiModuleName=psycopg2    dbName=${db_name}    dbUsername=${db_username}    dbPassword=${db_password}    dbHost=${db_host}    dbPort=${db_port}

DB Connect To Database Pigspin Loyalty
    DB Connect To Postgres Database    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.LOYALTY.DB_NAME}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.LOYALTY.USER}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.LOYALTY.PASSWORD}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.LOYALTY.IP}

DB Connect To Database Pigspin User
    DB Connect To Postgres Database    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.USER.DB_NAME}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.USER.USER}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.USER.PASSWORD}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.USER.IP}

DB Connect To Database Pigspin Php
    DB Connect To SQL Database    ${ENVIRONMENT.DATABASE.MYSQL.${ar_ENVIRONMENT}.SERVICES.PHP.DB_NAME}    ${ENVIRONMENT.DATABASE.MYSQL.${ar_ENVIRONMENT}.SERVICES.PHP.USER}    ${ENVIRONMENT.DATABASE.MYSQL.${ar_ENVIRONMENT}.SERVICES.PHP.PASSWORD}    ${ENVIRONMENT.DATABASE.MYSQL.${ar_ENVIRONMENT}.SERVICES.PHP.IP}    ${ENVIRONMENT.DATABASE.MYSQL.${ar_ENVIRONMENT}.SERVICES.PHP.PORT}

DB Connect To Database Pigspin Game
    DB Connect To Postgres Database    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.GAME.DB_NAME}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.GAME.USER}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.GAME.PASSWORD}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.GAME.IP}

DB Connect To Database Pigspin Wallet
    DB Connect To Postgres Database    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.WALLET.DB_NAME}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.WALLET.USER}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.WALLET.PASSWORD}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.WALLET.IP}


DB Connect To Database Pigspin Back Office
    DB Connect To Postgres Database    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.BACKOFFICE.DB_NAME}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.BACKOFFICE.USER}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.BACKOFFICE.PASSWORD}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.BACKOFFICE.IP}

DB Connect To Database Pigspin Affiliate
    DB Connect To Postgres Database    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.AFFILIATE.DB_NAME}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.AFFILIATE.USER}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.AFFILIATE.PASSWORD}    ${ENVIRONMENT.DATABASE.POSTGRESQL.ENV.${ar_ENVIRONMENT}.SERVICES.AFFILIATE.IP}

QUERY Daily Game Quest Information By On Date
    [Arguments]    ${on_date}
    [Documentation]    on_date format -> '2022-01-28'
    ...
    ...    การเอา result_dict ไปใช้ ให้ Get From Dictionary ด้วยคีย์ Transaction Uid
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT quest_name, game_name, quest_level, reward, uid as quest_uid FROM quest_list WHERE uid IN (SELECT quest_uid FROM quest_random WHERE on_date = '${on_date}')
    ${result_dict}    Create Dictionary
    ${length}    Get Length    ${result}
    FOR    ${index}    IN RANGE    ${length}
        ${info}    Get From List    ${result}    ${index}
        ${dict}    Create Dictionary
        Set To Dictionary    ${dict}    quest_name    ${info}[0]
        Set To Dictionary    ${dict}    game_name    ${info}[1]
        Set To Dictionary    ${dict}    quest_level    ${info}[2]
        Set To Dictionary    ${dict}    reward    ${info}[3]
        Set To Dictionary    ${dict}    quest_uid    ${info}[4]
        Set To Dictionary    ${result_dict}    ${info}[4]    ${dict}
    END
    [Return]    ${result_dict}

QUERY Daily Game Quest Title By On Date
    [Arguments]    ${on_date}
    [Documentation]    on_date format -> '2022-01-28'
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT quest_name FROM quest_list WHERE uid IN (SELECT quest_uid FROM quest_random WHERE on_date = '${on_date}')
    ${result_list}    Create_list
    FOR    ${index}    IN    @{result}
        ${info}    Get From List    ${index}    0
        Append To List    ${result_list}    ${info}
    END
    [Return]    ${result_list}

QUERY Daily Game Quest Subtitle By On Date
    [Arguments]    ${on_date}
    [Documentation]    on_date format -> '2022-01-28'
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT game_name FROM quest_list WHERE uid IN (SELECT quest_uid FROM quest_random WHERE on_date = '${on_date}' and quest_type != 'LOGIN');
    ${result_list}    Create_list
    FOR    ${index}    IN    @{result}
        ${info}    Get From List    ${index}    0
        Append To List    ${result_list}    ${info}
    END
    [Return]    ${result_list}

QUERY Daily Quest Quest Id and Game ID By On Date
    [Arguments]    ${on_date}
    [Documentation]    on_date format -> '2022-01-28'
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT game_id , uid as quest_id FROM public.quest_list WHERE uid IN (SELECT quest_uid FROM public.quest_random WHERE on_date = '${on_date}') and quest_type != 'LOGIN';
    ${result_list}    Create_list
    FOR    ${index}    IN    @{result}
        ${dict}    Create Dictionary
        ${game_id}    Get From List    ${index}    0
        ${quest_id}    Get From List    ${index}    1
        Set To Dictionary    ${dict}    game_id=${game_id}    quest_id=${quest_id}
        Append To List    ${result_list}    ${dict}
    END
    [Return]    ${result_list}

QUERY Daily Quest Quest Id and Game ID By On Date Include Login Quest
    [Arguments]    ${on_date}
    [Documentation]    on_date format -> '2022-01-28'
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT game_id , uid as quest_id FROM public.quest_list WHERE uid IN (SELECT quest_uid FROM public.quest_random WHERE on_date = '${on_date}');
    ${result_list}    Create_list
    FOR    ${index}    IN    @{result}
        ${dict}    Create Dictionary
        ${game_id}    Get From List    ${index}    0
        ${quest_id}    Get From List    ${index}    1
        Set To Dictionary    ${dict}    game_id=${game_id}    quest_id=${quest_id}
        Append To List    ${result_list}    ${dict}
    END
    [Return]    ${result_list}

INSERT Quest Transaction And Set Up All Status
    [Arguments]    ${on_date}    ${user_code}=${TEST_USER.username}    ${status}=0    ${receive}=False
    [Documentation]    on_date format -> '2022-01-28'
    DB Connect To Database Pigspin Loyalty
    Execute Sql String    DELETE FROM public.quest_transaction WHERE on_date = '${on_date}' and customer_code = '${user_code}'
    ${current_time}    WEB Get DateTime
    ${quest_info_list}    QUERY Daily Quest Quest Id and Game ID By On Date    ${on_date}
    FOR    ${index}    IN    @{quest_info_list}
        ${uuid}    Evaluate    uuid.uuid4()    modules=uuid
        Execute Sql String    INSERT INTO public.quest_transaction VALUES('${current_time}', '${current_time}', '${uuid}', '${index}[game_id]', '${index}[quest_id]', 'automation_mockup','automation_mockup', '0', '${on_date}', '${receive}', null, '${status}', '${user_code}')
    END

INSERT Quest Transaction And Set Up All Status Include Login Quest
    [Arguments]    ${on_date}    ${user_code}=${TEST_USER.username}    ${status}=0    ${receive}=False
    [Documentation]    on_date format -> '2022-01-28'
    DB Connect To Database Pigspin Loyalty
    Execute Sql String    DELETE FROM public.quest_transaction WHERE on_date = '${on_date}' and customer_code = '${user_code}'
    ${current_time}    WEB Get DateTime
    ${quest_info_list}    QUERY Daily Quest Quest Id and Game ID By On Date Include Login Quest    ${on_date}
    FOR    ${index}    IN    @{quest_info_list}
        ${uuid}    Evaluate    uuid.uuid4()    modules=uuid
        Execute Sql String    INSERT INTO public.quest_transaction VALUES('${current_time}', '${current_time}', '${uuid}', '${index}[game_id]', '${index}[quest_id]', 'automation_mockup','automation_mockup', '0', '${on_date}', '${receive}', null, '${status}', '${user_code}')
    END

QUERY Quest Information From Transaction Uid
    [Arguments]    ${transaction_uid}
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT quest_name, game_name, quest_level, reward, uid as quest_uid FROM quest_list WHERE uid IN (SELECT quest_uid FROM quest_transaction WHERE uid = '${transaction_uid}')
    ${result_dict}    Create Dictionary
    ${length}    Get Length    ${result}
    FOR    ${index}    IN RANGE    ${length}
        ${info}    Get From List    ${result}    ${index}
        Set To Dictionary    ${result_dict}    quest_name    ${info}[0]
        Set To Dictionary    ${result_dict}    game_name    ${info}[1]
        Set To Dictionary    ${result_dict}    quest_level    ${info}[2]
        Set To Dictionary    ${result_dict}    reward    ${info}[3]
        Set To Dictionary    ${result_dict}    quest_uid    ${info}[4]
    END
    [Return]    ${result_dict}

QUERY List Of Quest Information By on_date
    [Arguments]     ${on_date}
    DB Connect To Database Pigspin Loyalty
    ${result}     Query    SELECT quest_name, game_name, quest_level, reward, uid as quest_uid FROM quest_list WHERE uid IN (SELECT quest_uid FROM quest_transaction WHERE on_date = '${on_date}')
    ${result_list}    Create List
    ${length}    Get Length    ${result}
    FOR    ${index}    IN RANGE    ${length}
        ${info_dict}    Create Dictionary
        ${info}    Get From List    ${result}    ${index}
        Set To Dictionary    ${info_dict}    quest_name    ${info}[0]
        Set To Dictionary    ${info_dict}    game_name    ${info}[1]
        Set To Dictionary    ${info_dict}    quest_level    ${info}[2]
        Set To Dictionary    ${info_dict}    reward    ${info}[3]
        Set To Dictionary    ${info_dict}    quest_uid    ${info}[4]
        Append to list    ${result_list}    ${info_dict}
    END
    [Return]    ${result_list}

DELETE Quest Complete Receive
    [Arguments]    ${on_date}    ${user_code}=${TEST_USER.username}
    [Documentation]    on_date format -> '2022-01-28'
    DB Connect To Database Pigspin Loyalty
    Execute Sql String    DELETE FROM public.quest_complete_log WHERE on_date = '${on_date}' and customer_code = '${user_code}'

DELETE User Login Log
    DatabaseLibrary.Execute Sql String    DELETE FROM tbl_customer_login_log WHERE customer_phone='${TEST_USER.phone.uncensor}';

QUERY Game Ids From Recent Game
    [Arguments]    ${user_name}    ${order_by}    ${limit}
    ${game_ids}=    Query    SELECT game_id FROM public.recent_game_activity WHERE player_username ='${username}' order by updated_at ${order_by} \ limit ${limit}
    Set Test Variable    ${game_ids}

QUERY Any Login Quest From on_date
    [Arguments]    ${on_date}
    [Documentation]    on_date format -> '2022-01-28'
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT game_id , uid as quest_id FROM public.quest_list WHERE uid IN (SELECT quest_uid FROM public.quest_random WHERE on_date = '${on_date}') and quest_type = 'LOGIN';
    ${is_login}     Run Keyword And Return Status    Should Not Be Empty     ${result}
    [Return]    ${is_login}

QUERY Mainquest Ticket Amount
    DB Connect To Database Pigspin Loyalty
    ${result}    QUERY    SELECT config_value FROM configuration WHERE config_name = 'QUEST_SPECIAL_REWARD';
    ${result}    Get From List    ${result}    0
    [return]    ${result}[0]

DELETE All Bigwin Transaction
    [Arguments]    ${user_code}
    DB Connect To Database Pigspin Loyalty
    Execute Sql String    DELETE FROM public.big_win_transaction WHERE customer_code = '${user_code}'

INSERT Bigwin Transaction
    [Arguments]    ${user_code}    ${phone_number}    ${is_upload}    ${is_cliam}
    ...    ${game_ref_type}=PG_GAME    ${game_id}=89    ${bet_amount}=1    ${earn_amount}=250
    DB Connect To Database Pigspin Loyalty
    ${current_time}    WEB Get DateTime    plus_hour=+0
    ${uuid}    Evaluate    uuid.uuid4()    modules=uuid
    ${image_link}    Set Variable if    ${is_upload}==${True}    
    ...    'https://s3.ap-southeast-1.amazonaws.com/assets.pigspin.xyz/pigspin-assets/loyalty/bigwin/e57fe492-f7d0-4735-94eb-14a36beaa33b.png'    null
    ${received_at}    Set Variable if    ${is_cliam}==${True}    
    ...    '${current_time}'   null
    Execute Sql String   INSERT INTO public.big_win_transaction VALUES('${current_time}', '${current_time}', '${uuid}'::uuid, '${user_code}', '${phone_number}', '${game_id}', 'Automation_mock_test_parent_bet', 'Automation_mock_test_bet', 0.0, ${bet_amount}, ${earn_amount}, 'NORMAL'::featuretype::featuretype, ${is_upload},${image_link}, ${is_cliam}, ${received_at}, 1, '${game_ref_type}'::gamereftype::gamereftype);
    [Return]    ${uuid}

QUERY Bigwin Ticket Amount
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT config_value From public.configuration where config_name='BIGWIN_TICKETS'
    ${result}    Get From List    ${result}    0
    [Return]    ${result}[0]

DELETE All Weeklky Transaction
    [Arguments]    ${user_code}
    DB Connect To Database Pigspin Loyalty
    Execute Sql String    DELETE FROM public.weekly_quest_transaction WHERE customer_code = '${user_code}'

INSERT Weekly quest Transaction
    [Arguments]    ${user_code}    ${phone_number}    ${is_cliam}
    ...    ${game_ref_type}=PG_GAME    ${game_id}=89    ${bet_amount}=1.00    ${earn_amount}=890.00
    DB Connect To Database Pigspin Loyalty
    ${weekly_random}    QUERY Weekly quest random    is_latest=${true}
    ${current_time}    WEB Get DateTime    plus_hour=+0
    ${uuid}    Evaluate    uuid.uuid4()    modules=uuid
    ${received_at}    Set Variable if    ${is_cliam}==${True}    
    ...    '${current_time}'   null
    Execute Sql String   INSERT INTO public.weekly_quest_transaction VALUES('${current_time}', '${current_time}', '${uuid}'::uuid, '${user_code}', '${phone_number}', '${game_id}', 'Automation MOCK', 'Automation MOCK', ${bet_amount}, ${earn_amount}, ${is_cliam}, ${received_at}, 1, '${weekly_random}[1]'::uuid, '${weekly_random}[0]'::uuid, null);
    [Return]    ${uuid}
    
QUERY Weekly quest random
    [Arguments]    ${is_latest}=${true}    ${on_date}=2000-01-02
    DB Connect To Database Pigspin Loyalty
    IF    ${is_latest}==${true}
        ${result}    Query    SELECT uid, quest_uid, on_date from public.weekly_quest_random where on_date =(select max(on_date) from weekly_quest_random);
    ELSE
        ${result}    Query    SELECT uid, quest_uid, on_date from weekly_quest_random where on_date ='${on_date}';
    END
    [Return]    ${result}[0]

QUERY weekly quest ticket Amount
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT config_value, config_name from public.configuration where config_name ='WEEKLY_QUEST_TICKET';
    [Return]  ${result}[0]

QUERY Weeklyquest Quest Information
    [Arguments]    ${quest_uid}
    DB Connect To Database Pigspin Loyalty
    ${result}    Query    SELECT quest_name, game_name from public.weekly_quest_list where uid ='${quest_uid}';
    ${weekly_info}    Create Dictionary    quest_name=${result}[0][0]    game_name=${result}[0][1]
    [Return]    ${weekly_info}

INSERT or UPDATE user Ticket
    [Arguments]    ${customer_code}    ${ticket_amount}
    DB Connect To Database Pigspin Loyalty
    ${current_time}    WEB Get DateTime    plus_hour=+0
    ${result}    Query    Select * from public.user_tickets where customer_code='${customer_code}';
    ${exist}    Run Keyword And Return Status    Should Not Be Empty    ${result}
    IF    ${exist}
        Execute Sql String    UPDATE public.user_tickets SET tickets=${ticket_amount}, updated_at='${current_time}' WHERE customer_code='${customer_code}';
    ELSE
        ${uuid}    Evaluate    uuid.uuid4()    modules=uuid
        Execute Sql String    INSERT INTO public.user_tickets VALUES('${current_time}', '${current_time}', '${uuid}'::uuid, ${ticket_amount}, '${customer_code}');
    END

QUERY Game_name ordered top 10 jackpot game
    DB Connect To Database Pigspin Game
    ${result}    Query    SELECT game_name, actual_rtp FROM game WHERE status='ACTIVE' and ref_type ='PG_GAME' and actual_rtp is not null and actual_rtp > '0' order by actual_rtp desc limit 10;
    [Return]    ${result}

QUERY Game_name ordered lowest 10 jackpot game
    DB Connect To Database Pigspin Game
    ${result}    Query    SELECT game_name, actual_rtp FROM game WHERE status='ACTIVE' and ref_type ='PG_GAME' and actual_rtp is not null and actual_rtp > '0' order by actual_rtp limit 10;
    [Return]    ${result}

UPDATE Game Actual RTP by Game name
    [Arguments]    ${game_name}    ${actual_rtp}
    DB Connect To Database Pigspin Game
    Execute Sql String    UPDATE public.game SET actual_rtp=${actual_rtp} WHERE game_name='${game_name}';


QUERY QR Transfer Information From User Code
    [Arguments]    ${customer_code}    ${qr_transfer_amount}    ${created_at}
    DB Connect To Database Pigspin Back Office
    ${result}    QUERY    SELECT request_amount, bank_name FROM public.qr_transaction_request WHERE customer_code='${customer_code}' and generate_amount='${qr_transfer_amount}' and created_at >= '${created_at}';
    ${result}    Get From List    ${result}    0
    ${result_dict}    Create Dictionary    request_amount=${result}[0]    bank_name=${result}[1]
    [Return]    ${result_dict}


Query User Withdraw Request
    [Arguments]    ${customer_code}    ${request_time}    ${withdraw_amount}
    DB Connect To Database Pigspin Back Office
    ${result}    Query    SELECT to_bank_account_number FROM "transaction" JOIN transaction_withdraw ON transaction.uid=transaction_withdraw.uid WHERE customer_code ='${customer_code}' and created_at >='${request_time}' and amount ='${withdraw_amount}';
    ${result}    Get From List    ${result}    0
    [Return]    ${result}[0]

INSERT Affiliate Transaction
    [Arguments]    ${upline_uid}    ${downline_uid}    ${amount}
    DB Connect To Database Pigspin Affiliate
    ${current_time}    WEB Get DateTime    plus_hour=+0
    ${uuid}    Evaluate    uuid.uuid4()    modules=uuid
    Execute Sql String   INSERT INTO public.affiliate_transaction VALUES('${current_time}', '${current_time}', '${uuid}'::uuid, NULL, '${upline_uid}', '${downline_uid}', 'DEBIT', 'NONE', ${amount},0,0,${amount},${amount}, 'SUCCESS', 'เพิ่มมือจากการยืนยันตัวตนผ่าน db');
    [Return]    ${uuid}

INSERT Affiliate Income To Upline
    [Arguments]    ${upline_uid}    ${amount}
    DB Connect To Database Pigspin Affiliate
    Execute Sql String    UPDATE public.affiliate_user_balance set balance = balance + ${amount}, total_kyc_verified = total_kyc_verified + ${0} where user_uid = '${upline_uid}';

INSERT Transaction Log
    [Arguments]    ${transaction_uid}     ${action_by_uid}=cdc573a4-145a-4380-971e-7c20c0500d2a
    DB Connect To Database Pigspin Affiliate
    ${current_time}    WEB Get DateTime    plus_hour=+0
    ${uuid}    Evaluate    uuid.uuid4()    modules=uuid
    Execute Sql String   INSERT INTO public.transaction_log VALUES('${current_time}', '${current_time}', '${uuid}'::uuid, NULL, '${transaction_uid}', '${action_by_uid}',NULL);

Update User Status To Active
    [Arguments]    ${phone_number}    ${status}='ACTIVE'
    DB Connect To Database Pigspin User
    Execute Sql String    UPDATE public.pig_user SET status=${status} WHERE phone_number='${phone_number}';
