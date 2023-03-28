import xml.etree.ElementTree as ET
from googleapiclient.discovery import build
from google.oauth2 import service_account
import time
import pandas
import os
import json
from dotenv import load_dotenv

## Google services ##
# SERVICE_ACCOUNT_FILE = 'keys.json'

load_dotenv()
SERVICE_ACCOUNT_FILE = os.getenv("GG_SHEET")

SCOPES = ['https://www.googleapis.com/auth/spreadsheets']

creds = None
creds = service_account.Credentials.from_service_account_file(
        SERVICE_ACCOUNT_FILE, scopes=SCOPES)

# The ID and range of a sample spreadsheet.
SAMPLE_SPREADSHEET_ID = '1DAcqs2HRS8CyP-OP2HP6KYP68Tpl9JrbQNG9VY4Sk_I'


service = build('sheets', 'v4', credentials=creds)

# Call the Sheets API to get all test cases ID
sheet = service.spreadsheets()

################################################### End Google service path #######################################################

# resource_path = '../test_result/output.xml'
resource_path = 'public/output.xml'

#Test result value to gg sheet
test_passed = [["PASSED"]]
test_failed = [["FAILED"]]


def read_xml():

    tree = ET.parse(resource_path)

    root = tree.getroot()

    testcase = []
    testresult = []

    for item in root.findall('./statistics/tag/stat'):

        testcase_id = item.text
        spass = item.attrib["pass"]
        sfail = item.attrib["fail"]
        sskip = item.attrib["skip"]

        try:
            if spass == "1":
                testcase.append(testcase_id)
                testresult.append("pass")
                # print(testcase_id, "pass")
            elif sfail == "1":
                testcase.append(testcase_id)
                testresult.append("fail")
                # print(testcase_id, "fail")
            elif sskip == "1":
                testcase.append(testcase_id)
                testresult.append("skip")
                # print(testcase_id, "skip")
        except Exception as e:
            print('Error: ', str(e))

    df = pandas.DataFrame(testcase, columns=['id'])
    test_result = df.assign(Result = testresult)

    return test_result

def clear_sheet_value():
    sheets = ["Authentication","Lobby","AllGamePage","Wallet","Profile","Affiliate","Promotion_page","Profile"]
    for i in range(0, len(sheets)):
        time.sleep(1)
        sheet_range = sheets[i]
        sheet_range = sheet_range + "!O3:Q150"

        request = sheet.values().clear(spreadsheetId=SAMPLE_SPREADSHEET_ID,
                range=sheet_range).execute()
    
    
def send_test_result(test_result):
    
    for i in range(0, len(test_result['id'])):  
        time.sleep(1)
        if "MCLB" in test_result['id'].iloc[i]:
            prefix = test_result['id'].iloc[i]
            sheet_no = get_sheet_column_no(prefix)

            if test_result['Result'].iloc[i] == "pass":
                request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
                        range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

            if test_result['Result'].iloc[i] == "fail":
                request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
                        range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        elif "MCLGN" in test_result['id'].iloc[i]:
            prefix = test_result['id'].iloc[i]
            sheet_no = get_sheet_column_no(prefix)

            if test_result['Result'].iloc[i] == "pass":
                request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
                        range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

            if test_result['Result'].iloc[i] == "fail":
                request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
                        range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "BOE2E" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "DDEP" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "MDEP" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "TDEP" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "DDQP" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "MDQP" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "TDQP" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                
        
        # elif "DLBP" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "MLBP" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "TLBP" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
                

        # elif "DLYS" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute() 
                 
        # elif "DLGN" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()
        
        # elif "MLGN" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()

        # elif "TLGN" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()

        # elif "MLYS" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()  
                

        # elif "TLYS" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute() 
                

        # elif "MPRO" in test_result['id'].iloc[i]:
        #     prefix = test_result['id'].iloc[i]
        #     sheet_no = get_sheet_column_no(prefix)

        #     if test_result['Result'].iloc[i] == "pass":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_passed}).execute()
                

        #     if test_result['Result'].iloc[i] == "fail":
        #         request = sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
        #                 range=sheet_no, valueInputOption="USER_ENTERED", body={"values":test_failed}).execute()   
                
              

def get_sheet_column_no(prefix):

    if "MCLB" in prefix:
        get_num = prefix.partition("-")[2]
        result_col = int(get_num) + 2
        myposition = str(result_col)
        ggsheet = "Authentication!P"
        column_row = ggsheet + myposition

    elif "MCLGN" in prefix:
        get_num = prefix.partition("-")[2]
        result_col = int(get_num) + 2
        myposition = str(result_col)
        ggsheet = "Lobby!P"
        column_row = ggsheet + myposition

    # elif "DAGP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "AllGamePage!O"
    #     column_row = ggsheet + myposition

    # elif "DLBP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Lobby!O"
    #     column_row = ggsheet + myposition

    # elif "MLBP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Lobby!P"
    #     column_row = ggsheet + myposition

    # elif "TLBP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Lobby!Q"
    #     column_row = ggsheet + myposition

    # elif "DDEP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Deposit_FE!O"
    #     column_row = ggsheet + myposition

    # elif "MDEP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Deposit_FE!P"
    #     column_row = ggsheet + myposition

    # elif "TDEP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Deposit_FE!Q"
    #     column_row = ggsheet + myposition

    # elif "DDQP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Quest!O"
    #     column_row = ggsheet + myposition

    # elif "MDQP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Quest!P"
    #     column_row = ggsheet + myposition

    # elif "TDQP" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Quest!Q"
    #     column_row = ggsheet + myposition

    # elif "DLYS" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "PigShop!O"
    #     column_row = ggsheet + myposition

    # elif "MLYS" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "PigShop!P"
    #     column_row = ggsheet + myposition

    # elif "TLYS" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "PigShop!Q"
    #     column_row = ggsheet + myposition

    # elif "MPRO" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Profile!P"
    #     column_row = ggsheet + myposition

    # elif "DLGN" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Login!O"
    #     column_row = ggsheet + myposition

    # elif "MLGN" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Login!P"
    #     column_row = ggsheet + myposition

    # elif "TLGN" in prefix:
    #     get_num = prefix.partition("-")[2]
    #     result_col = int(get_num) + 2
    #     myposition = str(result_col)
    #     ggsheet = "Login!Q"
    #     column_row = ggsheet + myposition

    return column_row

    
if __name__ == '__main__':
    
    clear_sheet_value()
    result = read_xml()
    send_test_result(result)