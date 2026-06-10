*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                  http://localhost:3000/agendar.html
${BROWSER}              chrome

${SELECT_MEDICO}        id=medico
${INPUT_DATA}           id=data
${SELECT_HORARIO}       id=horario
${INPUT_MOTIVO}         id=motivo
${BOTAO_AGENDAR}        css=button[type="submit"]
${MENSAGEM}             id=mensagem

*** Test Cases ***
CT01 - Deve agendar consulta com dados válidos
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Select From List By Label    ${SELECT_MEDICO}    Dra. Ana Rodrigues
    Input Text    ${INPUT_DATA}    2027-03-20
    Sleep    1s
    Select From List By Label    ${SELECT_HORARIO}    10:00
    Input Text    ${INPUT_MOTIVO}    Retorno médico
    Sleep    1s
    Click Button    ${BOTAO_AGENDAR}
    Sleep    2s
    Wait Until Element Is Visible    ${MENSAGEM}    timeout=5s
    Element Text Should Be    ${MENSAGEM}    Consulta agendada com sucesso!
    Close Browser

CT02 - Deve bloquear envio sem médico selecionado
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${INPUT_DATA}    2027-03-20
    Input Text    ${INPUT_MOTIVO}    Retorno médico
    Sleep    1s
    Click Button    ${BOTAO_AGENDAR}
    Sleep    2s
    Element Should Be Visible    ${SELECT_MEDICO}
    Close Browser

CT03 - Deve rejeitar data anterior à data atual
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Select From List By Label    ${SELECT_MEDICO}    Dra. Ana Rodrigues
    Input Text    ${INPUT_DATA}    2018-01-01
    Sleep    1s
    Select From List By Label    ${SELECT_HORARIO}    10:00
    Input Text    ${INPUT_MOTIVO}    Retorno médico
    Sleep    1s
    Click Button    ${BOTAO_AGENDAR}
    Sleep    2s
    Wait Until Element Is Visible    ${MENSAGEM}    timeout=5s
    Element Text Should Be    ${MENSAGEM}    Não é possível agendar consultas em datas passadas.
    Close Browser
