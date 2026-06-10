*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                  http://localhost:3000/medicamentos.html
${BROWSER}              chrome

${INPUT_NOME}           id=nome
${INPUT_HORARIO}        id=horario
${CHECKBOX_QUA}         id=qua
${BOTAO_ADICIONAR}      css=button[type="submit"]
${MENSAGEM}             id=mensagem

*** Test Cases ***
CT01 - Deve cadastrar medicamento com dados completos
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${INPUT_NOME}       Omeprazol
    Input Text    ${INPUT_HORARIO}    07:00
    Select Checkbox    ${CHECKBOX_QUA}
    Sleep    1s
    Click Button    ${BOTAO_ADICIONAR}
    Sleep    2s
    Wait Until Element Is Visible    ${MENSAGEM}    timeout=5s
    Element Text Should Be    ${MENSAGEM}    Medicamento cadastrado!
    Close Browser

CT02 - Deve bloquear cadastro com nome em branco
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${INPUT_HORARIO}    07:00
    Select Checkbox    ${CHECKBOX_QUA}
    Sleep    1s
    Click Button    ${BOTAO_ADICIONAR}
    Sleep    2s
    Element Should Be Visible    ${INPUT_NOME}
    Close Browser

CT03 - Deve exibir erro quando nenhum dia for selecionado
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${INPUT_NOME}       Omeprazol
    Input Text    ${INPUT_HORARIO}    07:00
    Sleep    1s
    Click Button    ${BOTAO_ADICIONAR}
    Sleep    2s
    Wait Until Element Is Visible    ${MENSAGEM}    timeout=5s
    Element Text Should Be    ${MENSAGEM}    Nome, horário e pelo menos um dia são obrigatórios.
    Close Browser
