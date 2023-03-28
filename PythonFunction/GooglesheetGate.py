# importing the required libraries
import gspread
import re
import os
from datetime import date
from oauth2client.service_account import ServiceAccountCredentials

# define the scope
scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']
# add credentials to the account
# authorize the clientsheet 
IS_LOCAL = 'local'
if IS_LOCAL.lower() == 'local':
    creds = ServiceAccountCredentials.from_json_keyfile_name('google.json', scope)
    client = gspread.authorize(creds)
else:
    token = os.getenv('GOOGLE_KEY')
    creds = ServiceAccountCredentials.from_json(token)  ### Need to test with CI
    # creds = ServiceAccountCredentials.from_json_keyfile_dict(token)
    client = gspread.authorize(creds)

def openGoogleSheet(sheet_url, sheet_name):
    spreadsheet = client.open_by_url(sheet_url)
    worksheet = spreadsheet.worksheet(sheet_name)
    return worksheet

def getResultColumn(worksheet):
    result_regex = re.compile("(?i)(status)")
    result_location = worksheet.find(result_regex)
    # result_location = worksheet.find("Result")
    return result_location.col

def getTestCaseRow(testcase_id, worksheet):
    testcase_location = worksheet.find(str(testcase_id))
    return testcase_location.row

def getColumnLocation(keyword, worksheet):
    # result_regex = re.compile("(?i)"+"("+keyword+")")
    # result_location = worksheet.find(result_regex)
    result_location = worksheet.find(keyword)
    print(result_location)
    return result_location.col

def getRowLocation(keyword, worksheet):
    # result_regex = re.compile("(?i)"+"("+keyword+")")
    # result_location = worksheet.find(result_regex)
    result_location = worksheet.find(keyword)
    print(result_location)
    return result_location.row
    
def getLatestRow(worksheet):
    list_of_dicts = worksheet.get_all_records()
    return len(list_of_dicts)

#####################################################################################################################################################################
def updateTestResult(testcase_id, test_result, sheet_url, sheet_name):
    #[Document]        
    # testcase_id  the testcase id for the case want to update status
    # test_result  it's result
    # sheet_url is the google sheet url ***Must give editer permission to the serveice account****
    # sheet_name is the name of the target sheet
    try:
        worksheet = openGoogleSheet(sheet_url, sheet_name)
        result_col = getResultColumn(worksheet)
        testcase_row = getTestCaseRow(testcase_id, worksheet)
        worksheet.update_cell(testcase_row, result_col, str(test_result.capitalize()))
    except Exception as error:
        print(error)
        
def updateLatestResultReport(result_dict, sheet_url, sheet_name):
    #[Document]        
    # result_dict expected:  result_pass(int), result_fail(int), result_skip(int), total_case(int)
    # sheet_url is the google sheet url ***Must give editer permission to the serveice account****
    # sheet_name is the name of the target sheet
    
    try:
        worksheet = openGoogleSheet(sheet_url, sheet_name)
        latest_row = getLatestRow(worksheet)
        current_row = latest_row+2
        total_case_location = getColumnLocation("Total Test Case", worksheet)
        date_location = getColumnLocation("date", worksheet)
        pass_location = getColumnLocation("Pass", worksheet)
        fail_location = getColumnLocation("Fail", worksheet)
        skip_location = getColumnLocation("Skip", worksheet)
        
        today = date.today()
        result_pass = result_dict.get("pass")
        result_fail = result_dict.get("fail")
        result_skip = result_dict.get("skip")
        total_case = int(result_pass) + int(result_fail) + int(result_skip)
        worksheet.update_cell(current_row, date_location, str(today.strftime("%d/%m/%Y")))
        worksheet.update_cell(current_row, total_case_location, str(total_case))
        worksheet.update_cell(current_row, pass_location, str(result_pass))
        worksheet.update_cell(current_row, fail_location, str(result_fail))
        worksheet.update_cell(current_row, skip_location, str(result_skip))
        
    except Exception as error:
        print(error)
        
# Utils
#####################################################################################################################################################################
def updateBetId(quest_uid, parent, bet, game, usercode):
    sheet_url = 'https://docs.google.com/spreadsheets/d/1nqmxtpLAQQWPOpfy_poJqSDzpCIFQub8xcweg1ij8HQ/edit'
    sheet_name = 'Matching'
    worksheet = openGoogleSheet(sheet_url, sheet_name)
    traget_row = getRowLocation(quest_uid, worksheet)
    worksheet.update_cell(traget_row, '5', str(parent))
    worksheet.update_cell(traget_row, '6', str(bet))
    worksheet.update_cell(traget_row, '7', str(game))
    worksheet.update_cell(traget_row, '8', str(usercode))
    