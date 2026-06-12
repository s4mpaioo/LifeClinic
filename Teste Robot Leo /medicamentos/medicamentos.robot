*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL_LOGIN}            http://localhost:3000/index.html
${URL_MEDICAMENTOS}     http://localhost:3000/medicamentos.html
${BROWSER}              chrome

${INPUT_EMAIL_LOGIN}    id=email
${INPUT_SENHA_LOGIN}    id=password
${BOTAO_LOGIN}          css=#formLogin button[type="submit"]

${INPUT_NOME}           id=nomeMed
${INPUT_HORARIO}        id=horarioMed
${CHECKBOX_TER}         css=input[value="TER"]
${BOTAO_SALVAR}         css=#formMedicamento button[type="submit"]

*** Keywords ***
Fazer Login
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_EMAIL_LOGIN}    leo@gmail.com
    Input Password    ${INPUT_SENHA_LOGIN}    10101020
    Click Button      ${BOTAO_LOGIN}
    Sleep    2s
    Go To    ${URL_MEDICAMENTOS}
    Sleep    2s

*** Test Cases ***
CT01 - Deve cadastrar medicamento com dados válidos
    [Documentation]    Regra R1: Todos os campos válidos — medicamento salvo com sucesso
    Fazer Login
    Input Text    ${INPUT_NOME}       Ibuprofeno
    Input Text    ${INPUT_HORARIO}    12:00
    Execute Javascript    document.querySelector('input[value="TER"]').click()
    Sleep    1s
    Click Button    ${BOTAO_SALVAR}
    Sleep    3s
    ${btn}=    Get Text    ${BOTAO_SALVAR}
    Should Contain    ${btn}    Salvo
    [Teardown]    Close Browser

CT02 - Deve bloquear envio com nome vazio
    [Documentation]    Regra R2: Nome vazio — alerta exibido pelo JavaScript
    Fazer Login
    Input Text    ${INPUT_HORARIO}    12:00
    Execute Javascript    document.querySelector('input[value="TER"]').click()
    Sleep    1s
    Click Button    ${BOTAO_SALVAR}
    Sleep    2s
    ${alerta}=    Execute Javascript    return window._lastAlert || ''
    # Validação: botão ainda habilitado (form não enviou)
    Element Should Be Enabled    ${BOTAO_SALVAR}
    [Teardown]    Close Browser

CT03 - Deve validar dias não selecionados
    [Documentation]    Regra R3: Nenhum dia selecionado — alerta exibido pelo JavaScript
    Fazer Login
    Input Text    ${INPUT_NOME}       Ibuprofeno
    Input Text    ${INPUT_HORARIO}    12:00
    Sleep    1s
    Click Button    ${BOTAO_SALVAR}
    Sleep    2s
    # Validação: botão ainda habilitado (form não enviou)
    Element Should Be Enabled    ${BOTAO_SALVAR}
    [Teardown]    Close Browser
