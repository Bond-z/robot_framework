# import xml.etree.ElementTree as ET
from lxml import etree
# import sys
resource_path = "public/output.xml"
expect_suite = ["HP888", "SCR"]

### Xpath
test_id_xpath = ".//tag[starts-with(.,'DQP')]"
id_prefix_xpath = ".//tag[starts-with(.,'<prefix>')]"
suite_and_test_id_xpath = "//suite[@name = '<suite_name>']//tag[contains(.,'<test_id>')]"
start_time_xpath = "/..//status/@starttime"
test_result_xpath = "/..//status[contains(@starttime,'<status_time>')]/@status"
all_test_xpath = ".//stat[contains(.,'All Tests')]"
duration_xpath = ".//status/@elapsedtime"



def getAllTestIdFromPrefix(xml_url, prefix):
    report_file = open(xml_url, 'r')
    tree = etree.parse(report_file)
    formated_xpath = id_prefix_xpath.replace("<prefix>", prefix)
    id_list = tree.xpath(formated_xpath)
    return id_list

def getAllTestResult(xml_url):
    report_file = open(xml_url, 'r')
    tree = etree.parse(report_file)
    all_test_result = tree.xpath(all_test_xpath)
    result_dict = all_test_result[0].attrib
    return  result_dict

def getTestDuration(xml_url):
    report_file = open(xml_url, 'r')
    tree = etree.parse(report_file)
    elapsed_time = tree.xpath(duration_xpath)
    millis = int(elapsed_time[0])
    seconds=(millis/1000)%60
    minutes=(millis/(1000*60))%60
    hours=(millis/(1000*60*60))%24
    return {'seconds': str(int(seconds)), 'minutes': str(int(minutes)), 'hours': str(int(hours))}
    
def getAllTestResultFromId(xml_url, suite, id_list):
    
    report_file = open(xml_url, 'r')
    tree = etree.parse(report_file)
    
    suite_result = {}
    for suite in suite:
        # print(suite)
        id_result = {}
        for test_id in id_list:
            
            time_xpath = suite_and_test_id_xpath+start_time_xpath
            expected_xpath = time_xpath.replace("<suite_name>",suite)
            expected_xpath = expected_xpath.replace("<test_id>",test_id.text)
            # print(expected_xpath)
            list_test_case = tree.xpath(expected_xpath)
            # print(list_test_case)
            
            if  len(list_test_case):
                test_result_xpath = suite_and_test_id_xpath+test_result_xpath
                result_xpath = test_result_xpath.replace("<suite_name>",suite)
                result_xpath = result_xpath.replace("<test_id>",test_id.text)
                result_xpath = result_xpath.replace("<status_time>",list_test_case[-1])   ### last one
                # print(result_xpath)
                test_result = tree.xpath(result_xpath)
                # print(test_result)
                print(str(test_id.text)+ " " + str(test_result[0]))
                # print(list_test_case[0].text)
                id_result[test_id.text]=str(test_result[0])
        suite_result[suite]=id_result
    return suite_result

# id_list = getAllTestIdFromPrefix(resource_path, "DQP")
# test_status = getAllTestResultFromId(resource_path, expect_suite, id_list)
# key_list = list(test_status) ## วิธีการดึง list ของ dictionary key
# print(test_status)
# print(key_list)

# print(getAllTestResult(resource_path))
# print(getTestDuration(resource_path))