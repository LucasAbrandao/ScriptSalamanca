# Script de Organização de Arquivos

Este é um script em Bash para organizar arquivos de áudio em pastas locais, renomeandoe  formatando os asquivos compactados do google drive no formatado utilizado na base de dados firestone do projeto salamanca

## Requisitos

- baixar o conteudo compactado da pasta do google drive, descompactar e renomear para "drive" a pasta com os audios
- deixar em uma pasta raiz somente o script e a pasta "drive" ja descompactada

## Lista de Palavras

O script inclui listas de palavras em latim e inglês. Você pode personalizar essas listas editando o script e alterando os valores das variáveis `latin_words` e `english_words`.

## Uso

- com o ambiente preparado executar os comandos:

1. sendo 'script.sh o nome dado ao script
 
    ``` shell 
    chmod +x script.sh 
    ```
2. executar o script com

    ``` shell 
    ./script.sh
    ```