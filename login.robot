*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}              http://localhost:3000/index.html
${BROWSER}          chrome

${INPUT_EMAIL}      id=email
${INPUT_SENHA}      id=password
${BOTAO_ENTRAR}     css=button[type="submit"]
${MENSAGEM_ERRO}    id=erroLogin

*** Test Cases ***
CT01 - Deve realizar login com credenciais válidas
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_EMAIL}    teste.login@email.com
    Input Password    ${INPUT_SENHA}    senha123
    Sleep    1s
    Click Button    ${BOTAO_ENTRAR}
    Sleep    2s
    Wait Until Location Contains    dashboard.html    timeout=5s
    Close Browser

CT02 - Deve bloquear envio com e-mail vazio
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Password    ${INPUT_SENHA}    senha123
    Sleep    1s
    Click Button    ${BOTAO_ENTRAR}
    Sleep    2s
    Element Should Be Visible    ${INPUT_EMAIL}
    Close Browser

CT03 - Deve exibir erro para e-mail não cadastrado
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_EMAIL}    naoexiste@email.com
    Input Password    ${INPUT_SENHA}    senha123
    Sleep    1s
    Click Button    ${BOTAO_ENTRAR}
    Sleep    2s
    Wait Until Element Is Visible    ${MENSAGEM_ERRO}    timeout=5s
    Element Text Should Be    ${MENSAGEM_ERRO}    E-mail ou senha incorretos.
    Close Browser

CT04 - Deve exibir erro para senha incorreta
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Input Text        ${INPUT_EMAIL}    pedro@gmail.com
    Input Password    ${INPUT_SENHA}    senhaerrada
    Sleep    1s
    Click Button    ${BOTAO_ENTRAR}
    Sleep    2s
    Wait Until Element Is Visible    ${MENSAGEM_ERRO}    timeout=5s
    Element Text Should Be    ${MENSAGEM_ERRO}    E-mail ou senha incorretos.
    Close Browser