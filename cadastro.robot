*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                   http://localhost:3000/cadastro.html
${BROWSER}               chrome

${INPUT_NOME}            id=nome
${INPUT_CPF}             id=cpf
${INPUT_DATA}            id=dataNascimento
${INPUT_TELEFONE}        id=telefone
${INPUT_EMAIL}           id=emailCad
${INPUT_ENDERECO}        id=endereco
${INPUT_SENHA}           id=senha
${CHECKBOX_TERMOS}       id=terms
${BOTAO_CADASTRAR}       css=button[type="submit"]
${MENSAGEM_ERRO}         id=erroCadastro

*** Test Cases ***
CT01 - Deve realizar cadastro com dados válidos
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_NOME}       João Silva
    Input Text        ${INPUT_CPF}        529.982.247-25
    Input Text        ${INPUT_DATA}       2000-05-10
    Input Text        ${INPUT_TELEFONE}   11999999999
    Input Text        ${INPUT_EMAIL}      joao.ct01@email.com
    Input Text        ${INPUT_ENDERECO}   Rua das Flores, 123
    Input Password    ${INPUT_SENHA}      senha123
    Select Checkbox   ${CHECKBOX_TERMOS}
    Sleep    1s
    Click Button    ${BOTAO_CADASTRAR}
    Sleep    2s
    Wait Until Location Contains    dashboard.html    timeout=5s
    Close Browser

CT02 - Deve validar nome obrigatório
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_CPF}        529.982.247-25
    Input Text        ${INPUT_DATA}       2000-05-10
    Input Text        ${INPUT_TELEFONE}   11999999999
    Input Text        ${INPUT_EMAIL}      joao.ct02@email.com
    Input Text        ${INPUT_ENDERECO}   Rua das Flores, 123
    Input Password    ${INPUT_SENHA}      senha123
    Select Checkbox   ${CHECKBOX_TERMOS}
    Sleep    1s
    Click Button    ${BOTAO_CADASTRAR}
    Sleep    2s
    ${valid}=    Execute Javascript    return document.getElementById('nome').validity.valueMissing
    Should Be True    ${valid}
    Close Browser

CT03 - Deve validar CPF inválido
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_NOME}       João Silva
    Input Text        ${INPUT_CPF}        111.111.111-11
    Input Text        ${INPUT_DATA}       2000-05-10
    Input Text        ${INPUT_TELEFONE}   11999999999
    Input Text        ${INPUT_EMAIL}      joao.ct03@email.com
    Input Text        ${INPUT_ENDERECO}   Rua das Flores, 123
    Input Password    ${INPUT_SENHA}      senha123
    Select Checkbox   ${CHECKBOX_TERMOS}
    Sleep    1s
    Click Button    ${BOTAO_CADASTRAR}
    Sleep    2s
    Wait Until Element Is Visible    ${MENSAGEM_ERRO}    timeout=5s
    Element Text Should Be    ${MENSAGEM_ERRO}    CPF inválido. Verifique os números digitados.
    Close Browser

CT04 - Deve validar senha com menos de 8 caracteres
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_NOME}       João Silva
    Input Text        ${INPUT_CPF}        529.982.247-25
    Input Text        ${INPUT_DATA}       2000-05-10
    Input Text        ${INPUT_TELEFONE}   11999999999
    Input Text        ${INPUT_EMAIL}      joao.ct04@email.com
    Input Text        ${INPUT_ENDERECO}   Rua das Flores, 123
    Input Password    ${INPUT_SENHA}      123
    Select Checkbox   ${CHECKBOX_TERMOS}
    Sleep    1s
    Click Button    ${BOTAO_CADASTRAR}
    Sleep    2s
    Wait Until Element Is Visible    ${MENSAGEM_ERRO}    timeout=5s
    Element Text Should Be    ${MENSAGEM_ERRO}    A senha deve ter no mínimo 8 caracteres.
    Close Browser

CT05 - Deve validar termos não aceitos
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_NOME}       João Silva
    Input Text        ${INPUT_CPF}        529.982.247-25
    Input Text        ${INPUT_DATA}       2000-05-10
    Input Text        ${INPUT_TELEFONE}   11999999999
    Input Text        ${INPUT_EMAIL}      joao.ct05@email.com
    Input Text        ${INPUT_ENDERECO}   Rua das Flores, 123
    Input Password    ${INPUT_SENHA}      senha123
    Sleep    1s
    Click Button    ${BOTAO_CADASTRAR}
    Sleep    2s
    Wait Until Element Is Visible    ${MENSAGEM_ERRO}    timeout=5s
    Element Text Should Be    ${MENSAGEM_ERRO}    Você precisa aceitar os Termos de Uso e a Política de Privacidade para continuar.
    Close Browser