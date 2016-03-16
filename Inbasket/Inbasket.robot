*** Settings ***
Resource          ../../dev/RobotScripts/IPA.txt
Library           Selenium2Library
Library           OperatingSystem
Library           String

*** Variables ***
${InbasketURL}    http://usspnkxiong01.infor.com:8383/lpa1/Lpa/home?csk.PfiInbasketLandingPage=Infor    # Inbasket Login landing page for IRVINE PARK RC
${Username}       lawson    # Username to login
${Password}       lawson    # password for Username
${ValidationURLs}    file:///C:/Infor/Landmark11/lpa1_ValidationURLs.htm    # Brings up lpa1 Validation URLs in a browser

*** Test Cases ***
ValidationURLs_IPAInbasketLink
    [Documentation]    This script checks if ValidationURLs page displays and will navigate to the IPA Inbasket login page by clicking the Inbasket link.
    [Tags]    Regression
    Set Selenium Speed    1.5
    Open Browser    ${ValidationURLs}
    Maximize Browser Window
    Wait Until Element Is Visible    link=IPA Inbasket
    Click Link    link=IPA Inbasket
    Close All Browsers

UserLogin_LoginWithValidCredentials
    [Documentation]    This script does the following:
    ...
    ...    *1.* Open new browser.
    ...    *2.* Navigate to Inbasket login page.
    ...    *3.* Enter VALID credentials.
    ...    *4.* Login.
    ...    *5.* Verify "My Tasks" link exists on page.
    ...    *6.* Logout.
    ...    *7.* Verify User Name field displays on page.
    ...    *8.* Close all browser.
    [Tags]    Regression
    Set Selenium Speed    .50
    Open Browser    ${InbasketURL}
    Maximize Browser Window
    Input Text    id=userId    ${Username}
    Input Password    id=password    ${Password}
    Click Button    ${InhasketLoginButton}
    Page Should Contain Element    xpath=.//*[@id='firstLayer']/div[1]/a[contains(@href,"/lpa1/Lpa/menu/ProcessFlowMenu.MyTasks?csk.PfiInbasketLandingPage=Infor")]
    Click Element    xpath=.//*[@id='secondLayer']/div[3]/a[contains(@href,"/lpa1/Lpa/menu/ProcessFlowMenu.Options?csk.PfiInbasketLandingPage=Infor")]
    Click Element    xpath=//html/body/div[1]/header/div[2]/ul/li[3]/span[2]/span[@class='inforBannerText']
    Click Element    xpath=.//*[@id='LogoutLink']
    Element Should Be Visible    id=userId
    Close All Browsers

UserLogin_LoginWithInvalidCredentials
    [Documentation]    This script does the following:
    ...
    ...    *1.* Open new browser.
    ...    *2.* Navigate to Inbasket login page.
    ...    *3.* Enter INVALID credentials.
    ...    *4.* Login.
    ...    *5.* Verify Error occured on page.
    [Tags]    Regression
    Set Selenium Speed    .5
    Open Browser    ${InbasketURL}
    Maximize Browser Window
    Input Text    id=userId    tester
    Input Password    id=password    password
    Click Button    ${InhasketLoginButton}
    Page Should Contain Element    xpath=//html/body/div/form/div[2]/div[@class='errorText']
    Close All Browsers
