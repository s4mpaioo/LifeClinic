*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL_CADASTRO}      http://localhost:3000/cadastro.html
${BROWSER}           chrome
${INPUT_NOME}        id=nome
${INPUT_CPF}         id=cpf
${INPUT_NASC}        id=dataNascimento
${INPUT_TEL}         id=telefone
${INPUT_EMAIL}       id=emailCad
${INPUT_SENHA}       id=senha
${INPUT_TERMS}       id=terms
${BOTAO_CADASTRAR}   css=#formCadastro button[type="submit"]

*** Test Cases ***
CT01 - Deve bloquear cadastro com campos vazios
    [Documentation]    Partição P1: Submeter formulário vazio — deve permanecer na tela de cadastro
    Open Browser    ${URL_CADASTRO}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Click Button    ${BOTAO_CADASTRAR}
    Sleep    2s
    ${url_atual}=    Get Location
    Should Contain    ${url_atual}    cadastro
    [Teardown]    Close Browser

CT02 - Deve exibir erro com CPF inválido
    [Documentation]    Partição P2: CPF com formato inválido — deve permanecer na tela de cadastro
    Open Browser    ${URL_CADASTRO}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${INPUT_NOME}        Teste Usuario
    Input Text    ${INPUT_CPF}         111.111.111-11
    Input Text    ${INPUT_NASC}        2000-01-01
    Input Text    ${INPUT_TEL}         11999999999
    Input Text    ${INPUT_EMAIL}       teste.interface@email.com
    Input Text    ${INPUT_SENHA}       Teste123!
    Click Element    ${INPUT_TERMS}
    Click Button    ${BOTAO_CADASTRAR}
    Sleep    2s
    ${url_atual}=    Get Location
    Should Contain    ${url_atual}    cadastro
    [Teardown]    Close Browser

CT03 - Deve cadastrar com dados validos e redirecionar
    [Documentation]    Partição P3: Todos os campos válidos — redirecionamento para index.html
    Open Browser    ${URL_CADASTRO}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${INPUT_NOME}        Teste Usuario
    Input Text    ${INPUT_CPF}         529.982.247-25
    Input Text    ${INPUT_NASC}        2000-01-01
    Input Text    ${INPUT_TEL}         11999999999
    Input Text    ${INPUT_EMAIL}       teste.interface@email.com
    Input Text    ${INPUT_SENHA}       Teste123!
    Click Element    ${INPUT_TERMS}