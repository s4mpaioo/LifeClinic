*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL_LOGIN}         http://localhost:3000/index.html
${BROWSER}           chrome
${INPUT_EMAIL}       id=email
${INPUT_SENHA}       id=password
${BOTAO_LOGIN}       css=button[type="submit"]

*** Test Cases ***
CT01 - Deve bloquear login com campos vazios
    [Documentation]    Regra R1: Submeter formulário vazio — deve permanecer na tela de login
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Click Button    ${BOTAO_LOGIN}
    Sleep    2s
    ${url_atual}=    Get Location
    Should Contain    ${url_atual}    index.html
    [Teardown]    Close Browser

CT02 - Deve bloquear login com senha vazia
    [Documentation]    Regra R2: E-mail preenchido mas senha vazia — deve permanecer na tela de login
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${INPUT_EMAIL}    teste.api@email.com
    Click Button    ${BOTAO_LOGIN}
    Sleep    2s
    ${url_atual}=    Get Location
    Should Contain    ${url_atual}    index.html
    [Teardown]    Close Browser

CT03 - Deve realizar login com credenciais validas
    [Documentation]    Regra R3: Credenciais corretas — redirecionamento para dashboard
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_EMAIL}    teste.api@email.com
    Input Password    ${INPUT_SENHA}    Teste123!
    Click Button      ${BOTAO_LOGIN}
    Sleep    3s
    Wait Until Location Contains    dashboard    timeout=10s
    [Teardown]    Close Browser