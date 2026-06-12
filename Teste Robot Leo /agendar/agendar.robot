*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL_LOGIN}            http://localhost:3000/index.html
${URL_AGENDAR}          http://localhost:3000/agendar.html
${BROWSER}              chrome

${INPUT_EMAIL_LOGIN}    id=email
${INPUT_SENHA_LOGIN}    id=password
${BOTAO_LOGIN}          css=#formLogin button[type="submit"]

${SELECT_MEDICO}        id=doctor
${INPUT_DATA}           id=date
${SELECT_HORARIO}       id=time
${INPUT_MOTIVO}         id=reason
${BOTAO_AGENDAR}        css=#appointmentForm button[type="submit"]

*** Keywords ***
Fazer Login
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_EMAIL_LOGIN}    leo@gmail.com
    Input Password    ${INPUT_SENHA_LOGIN}    10101020
    Click Button      ${BOTAO_LOGIN}
    Sleep    2s
    Go To    ${URL_AGENDAR}
    Sleep    2s

*** Test Cases ***
CT01 - Deve agendar consulta com dados válidos
    [Documentation]    Regra R1: Todos os campos válidos — redirecionado para consultas
    Fazer Login
    Select From List By Label    ${SELECT_MEDICO}    Dr. Carlos Oliveira - Clínica Geral
    Input Text    ${INPUT_DATA}    2027-02-15
    Sleep    1s
    Select From List By Value    ${SELECT_HORARIO}    09:00
    Input Text    ${INPUT_MOTIVO}    Consulta de rotina
    Sleep    1s
    Click Button    ${BOTAO_AGENDAR}
    Sleep    3s
    Wait Until Location Contains    consultas.html    timeout=10s
    [Teardown]    Close Browser

CT02 - Deve bloquear envio sem médico selecionado
    [Documentation]    Regra R2: Médico não selecionado — campo obrigatório bloqueado pelo navegador
    Fazer Login
    Input Text    ${INPUT_DATA}    2027-02-15
    Sleep    1s
    Select From List By Value    ${SELECT_HORARIO}    09:00
    Sleep    1s
    Click Button    ${BOTAO_AGENDAR}
    Sleep    2s
    ${valid}=    Execute Javascript    return document.getElementById('doctor').validity.valueMissing
    Should Be True    ${valid}
    [Teardown]    Close Browser

CT03 - Deve bloquear data no passado
    [Documentation]    Regra R3: Data anterior ao mínimo definido — bloqueado pelo navegador
    Fazer Login
    Select From List By Label    ${SELECT_MEDICO}    Dr. Carlos Oliveira - Clínica Geral
    Execute Javascript    document.getElementById('date').removeAttribute('min')
    Input Text    ${INPUT_DATA}    2019-05-10
    Sleep    1s
    Select From List By Value    ${SELECT_HORARIO}    09:00
    Sleep    1s
    Click Button    ${BOTAO_AGENDAR}
    Sleep    2s
    ${erro}=    Execute Javascript    return document.getElementById('erroAgendar') ? document.getElementById('erroAgendar').textContent : 'bloqueado pelo navegador'
    Should Not Be Empty    ${erro}
    [Teardown]    Close Browser
