import requests
import sys
import json
import os
import TestResultUpdate
# import GooglesheetGate

# Note: Link to generate json payload for slack
# https://app.slack.com/block-kit-builder/TKFLXPEQ3#%7B%22attachments%22:%5B%7B%22color%22:%22%3Cstatus_color%3E%22,%22blocks%22:%5B%7B%22type%22:%22section%22,%22text%22:%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Triger%20From:*%20%3Ctrigger_from%3E%22%7D%7D,%7B%22type%22:%22section%22,%22text%22:%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Test%20result:*%22%7D%7D,%7B%22type%22:%22context%22,%22elements%22:%5B%7B%22type%22:%22mrkdwn%22,%22text%22:%22:white_check_mark:%20Passed%20=%20%3Cpass_num%3E%22%7D,%7B%22type%22:%22plain_text%22,%22text%22:%22:x:%20Failed%20=%20%3Cfail_num%3E%22,%22emoji%22:true%7D,%7B%22type%22:%22plain_text%22,%22text%22:%22:warning:%20Skip%20=%20%3Cskip_num%3E%22,%22emoji%22:true%7D%5D%7D,%7B%22type%22:%22section%22,%22text%22:%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Branch:*%20%3Cbranch%3E%22%7D%7D,%7B%22type%22:%22section%22,%22text%22:%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Report:*%20%3C%3Creport_link%3E%7CClick%20here%20to%20see%20the%20report%3E%22%7D%7D,%7B%22type%22:%22section%22,%22text%22:%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Test%20duration:*%20%3Ctest_duration%3E%22%7D%7D,%7B%22type%22:%22section%22,%22fields%22:%5B%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Description:*%20%5Cn%3Cdeploy_description%3E%22%7D,%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Pipeline%20link:*%20%5Cn%3C%3Cdeploy_link%3E%7CClick%20here%20to%20see%20deployment%20result%3E%22%7D%5D%7D%5D%7D%5D%7D

acceptance_percent = int(os.getenv('ACCEPTANCE_RATIO')) if os.getenv('ACCEPTANCE_RATIO') is not None else 95
print("Acceptance ratio:" + str(acceptance_percent))
resource_path = 'public/output.xml'
pass_color = '#95FB81'
medium_color = '#FAA35B'
fail_color = '#FA5B5B'
slackNotiPath = 'PythonFunction/slackPayload.json'

def openFile(path):
    file = open(path, 'r')
    return  file

def findReportResult(file):
    result_line = 'Empty'
    isFound = False
    duration = {}

    for line in file.readlines():
        if 'All Tests' in line:
            result_line = line
            isFound = True
            print('isFound: '+str(isFound))
        if 'elapsedtime' in line:
            elapsed_time = line.split()[4].replace('"','').replace('elapsedtime=','').replace('/>','')
            millis = int(elapsed_time)
            seconds=(millis/1000)%60
            minutes=(millis/(1000*60))%60
            hours=(millis/(1000*60*60))%24
            # duration = [str(seconds), str(minutes), str(hours)]
            duration = {'seconds': str(int(seconds)), 'minutes': str(int(minutes)), 'hours': str(int(hours))}
            print('elapsed_time: '+str(elapsed_time))

    if isFound:
        r_pass = result_line.split()[1].replace('"','').replace('pass=','')
        r_fail = result_line.split()[2].replace('"','').replace('fail=','')
        r_skip = result_line.split()[3].replace('"','').replace('skip=','').replace('>All','')
        result = [r_pass, r_fail,r_skip]
    else:
        result = [False]
        
    result.append(duration)
    print('Test result and duration:')
    print(result)
    return result

def getSlackNotiPayload(r_pass, r_fail, r_skip, trigger_from, status_color, 
                        branch, test_duration, report_link, deploy_link, deploy_description,
                        environment):
    try:
        slack_payload = openFile(slackNotiPath)
        str_json = str(json.load(slack_payload))
        seconds = test_duration.get('seconds')
        minutes = test_duration.get('minutes')
        hours = test_duration.get('hours')
        deploy_description = deploy_description.replace('"','<dp-quote>')
        deploy_description = deploy_description.replace("'","<sg-quote>")
        return str_json\
        .replace('<pass_num>',str(r_pass))\
        .replace('<fail_num>',str(r_fail))\
        .replace('<skip_num>',str(r_skip))\
        .replace('<trigger_from>',str(trigger_from))\
        .replace('<branch>',str(branch))\
        .replace('<report_link>',str(report_link))\
        .replace('<status_color>',str(status_color))\
        .replace('<deploy_link>',deploy_link)\
        .replace('<deploy_description>',deploy_description)\
        .replace('<environment>',environment)\
        .replace('<test_duration>', hours + ' hours '
                 + minutes + ' minutes ' 
                 + seconds + ' seconds')\
        .replace("'",'"').replace('True','true')  #This one is important. It's for avoid the invalid error due to python build in.
    except KeyError:
        slack_payload = openFile(slackNotiPath)
        str_json = str(json.load(slack_payload))
        return str_json\
        .replace('<pass_num>',str(r_pass))\
        .replace('<fail_num>',str(r_fail))\
        .replace('<skip_num>',str(r_skip))\
        .replace('<trigger_from>',str(trigger_from))\
        .replace('<branch>',str(branch))\
        .replace('<report_link>',str(report_link))\
        .replace('<status_color>',str(status_color))\
        .replace('<deploy_link>',deploy_link)\
        .replace('<deploy_description>',deploy_description)\
        .replace('<environment>',environment)\
        .replace('<test_duration>',"00"+" hours " 
                + "00" + " minutes" 
                + "00" + " seconds")\
        .replace("'",'"').replace('True','true')  #This one is important. It's for avoid the invalid error due to python build in.
    except FileNotFoundError:
        return '{"text":"*TEST_RESULT*: Can not find SlackJson payload ' +\
                  '\n*TRIGGER_FROM*: ' + trigger_from +\
                  '\n*JOB_ID*: ' + 'JOB_ID' + \
                  '\n*BRANCH*: ' + 'COMMIT_BRANCH' +\
                  '\n*URL_ALL_REPORT*: ' + report_link + '"}'
                #   '\n*START_TIME*: ' + 'JOB_STARTED_AT' +\
        
def getStatusColor(r_pass, r_fail, r_skip):
    should_pass_num = (int(r_pass)+int(r_fail)+int(r_skip))*acceptance_percent/100
    current_pass = int(r_pass)+int(r_skip)
    if current_pass == (int(r_pass)+int(r_fail)+int(r_skip)):
        return pass_color
    elif current_pass >= should_pass_num:
        return medium_color
    else:
        return fail_color

def getSlackMsgPayloadOld(result, info):
    if result[0] != False:
        result_pass, result_fail, result_skip, duration = result[0], result[1], result[2], result[3]
        status_color = getStatusColor(result_pass, result_fail, result_skip)
        return getSlackNotiPayload(result_pass, result_fail, result_skip,
                                  info.get('trigger_from'), status_color,
                                  COMMIT_BRANCH, duration, URL,
                                  info.get('pipeline_link'), info.get('description'),
                                  ENVIRONMENT)
    else:
        return '{"text":"*TEST_RESULT*: Can not find Test Result' +\
                  '\n*TRIGGER_FROM*: ' + TRIGGER_FROM +\
                  '\n*JOB_ID*: ' + JOB_ID + \
                  '\n*BRANCH*: ' + COMMIT_BRANCH +\
                  '\n*URL_ALL_REPORT*: ' + URL + '"}'
                #   '\n*START_TIME*: ' + JOB_STARTED_AT +\
                    
def getSlackMsgPayload(result, duration, info):
    result_pass, result_fail, result_skip = result["pass"], result["fail"], result["skip"]
    status_color = getStatusColor(result_pass, result_fail, result_skip)
    return getSlackNotiPayload(result_pass, result_fail, result_skip,
                            info.get('trigger_from'), status_color,
                            COMMIT_BRANCH, duration, URL,
                            info.get('pipeline_link'), info.get('description'),
                            ENVIRONMENT)

    
def sendSlackMessage(body, url):
    headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    print('header = ' + str(headers))
    print('payload = ' + str(body))
    response = requests.request("POST",
                     url, 
                     headers=headers, 
                     data=body)
    
    print('response = ' + str(response.content))
    

def getInfoFromSource(source):
    schedule_des = str(ENVIRONMENT) + ' daily automation testing'
    manual_des = os.getenv('MANUAL_DES') if os.getenv('MANUAL_DES') is not None else '<set value to os var MANUAL_DES>'
    DEFAULT_BRANCH = os.getenv('CI_DEFAULT_BRANCH')
    merge_des = 'Merge branch ' + str(DEFAULT_BRANCH) + ' into ' + str(COMMIT_BRANCH)
    push_des = 'Push branch ' + str(DEFAULT_BRANCH) + ' into ' + str(COMMIT_BRANCH)
    
    if source.lower()=='push':
        return{"trigger_from": "Push to " + str(COMMIT_BRANCH), "pipeline_link": QA_LINK, "description": push_des, "destination": QA_SLACK}
    elif source.lower()=='schedule':
        return{"trigger_from": "Schedule", "pipeline_link": QA_LINK, "description": schedule_des, "destination": QA_SLACK}
    elif source.lower()=='merge_request_event':
        return{"trigger_from": "Merge to main", "pipeline_link": QA_LINK, "description": merge_des, "destination": QA_SLACK}
    elif source.lower()=='parent_pipeline':
        return{"trigger_from": "Deployment to " + str(ENVIRONMENT), "pipeline_link": DEPLOY_LINK, "description": DEPLOY_DESCP, "destination": MAIN_SLACK}
    elif source.lower()=='pipeline':
        return{"trigger_from": "Deployment to " + str(ENVIRONMENT), "pipeline_link": DEPLOY_LINK, "description": DEPLOY_DESCP, "destination": MAIN_SLACK}
    elif source.lower()=='web':
        return{"trigger_from": "Manual trigger from web", "pipeline_link": QA_LINK, "description": manual_des, "destination": QA_SLACK}
    else:
        return{"trigger_from": str(TRIGGER_FROM) + " default", "pipeline_link": DEPLOY_LINK, "description": DEPLOY_DESCP, "destination": QA_SLACK}


if __name__ == '__main__':
    #Note: This part is for os variable investigation
    import pprint
    pprint.pprint(dict(os.environ), width = 1)
    
    ##Get Value From environment and parameter
    TRIGGER_FROM = sys.argv[1] if len(sys.argv[1]) > 1 and sys.argv[1] is not None else 'default_TRIGGER_FROM'
    URL = sys.argv[2] if len(sys.argv) > 2 and sys.argv[2] is not None else 'default_CI_URL'  ##Report link
    JOB_ID = os.getenv('CI_JOB_ID') if os.getenv('CI_JOB_ID') is not None else 'default_CI_JOB_ID'
    COMMIT_BRANCH = os.getenv('CI_COMMIT_BRANCH') if os.getenv('CI_COMMIT_BRANCH') is not None else 'default_CI_COMMIT_BRANCH'
    SOURCE = os.getenv('CI_PIPELINE_SOURCE') if os.getenv('CI_PIPELINE_SOURCE') is not None else 'default_source'  #push,schedule,merge_request_event,parent_pipeline
    DEPLOY_LINK = os.getenv('DEPLOY_LINK') if os.getenv('DEPLOY_LINK') is not None else 'default_deploy_link'
    DEPLOY_DESCP = os.getenv('DEPLOY_DESCP') if os.getenv('DEPLOY_DESCP') is not None else 'default_deploy_description'
    ENVIRONMENT = os.getenv('ENVIRONMENT') if os.getenv('ENVIRONMENT') is not None else 'default_environment'
    # ENVIRONMENT = os.getenv('DEFAULT_ENVIRONMENT') if os.getenv('DEFAULT_ENVIRONMENT') is not None else 'default_environment'
    QA_DES = os.getenv('CI_COMMIT_MESSAGE') if os.getenv('CI_COMMIT_MESSAGE') is not None else 'unknown_qa_des'
    QA_LINK = os.getenv('CI_PIPELINE_URL') if os.getenv('CI_PIPELINE_URL') is not None else 'unknown_qa_link'
    QA_SLACK = os.getenv('QA_SLACK_LINK')
    MAIN_SLACK = os.getenv('MAIN_SLACK_LINK')
    DAILY_SHEET_LINK = os.getenv('DASHBOARD_GOOGLE_SHEET_LINK') if os.getenv('DASHBOARD_GOOGLE_SHEET_LINK') is not None else 'https://docs.google.com/spreadsheets/d/1XmqtPh_nDKbO4wmnkTpyxGw01yoCuM0ka7Dl8by-Enc/edit'
    DAILY_SHEET_NAME = os.getenv('DASHBOARD_SHEET_NAME') if os.getenv('DASHBOARD_SHEET_NAME') is not None else 'Automation Daily Summary'
    
    # report_file = openFile(resource_path)
    # result = findReportResult(report_file)
    # info = getInfoFromSource(SOURCE)
    # print('info = ' + str(info))
    # payload = getSlackMsgPayload(result, info)
    # sendSlackMessage(payload, info.get('destination'))
    result = TestResultUpdate.getAllTestResult(resource_path)
    duration = TestResultUpdate.getTestDuration(resource_path)
    info = getInfoFromSource(SOURCE)
    payload = getSlackMsgPayload(result, duration, info)
    sendSlackMessage(payload, info.get('destination'))
    
    
    if SOURCE.lower()=='schedule':
        result = TestResultUpdate.getAllTestResult(resource_path)
        duration = TestResultUpdate.getTestDuration(resource_path)
        info = getInfoFromSource(SOURCE)
        payload = getSlackMsgPayload(result, duration, info)
        sendSlackMessage(payload, info.get('destination'))
        # GooglesheetGate.updateLatestResultReport(result, DAILY_SHEET_LINK, DAILY_SHEET_NAME)
    elif SOURCE.lower()=='web':
        result_dict = TestResultUpdate.getAllTestResultDict(resource_path)
        ### testcase_id_list = result_dict.Get all test case id #####
        ### testcase_position = GooglesheetGate.get all testcase id position (testcase_id_list)
        ### GooglesheetGate.update test result by id (result_dict, testcase_position)
        sendSlackMessage(payload, info.get('destination'))