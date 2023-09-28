#!/bin/bash


latin_words=("acer" "aesculus" "alnus" "amaranthaceae" "apiaceae" "artemisia" "asteraceae" "betula" "brassicaceae" "cannabis" "castanea" "casuarina" "cedrus" "corylus" "cupressaceae" "cyperaceae" "echium" "ericaceae" "fabaceae" "fraxinus" "helianthus" "juncaceae" "liguliflora" "ligustrum" "mercurialis" "morus" "myrtaceae" "olea" "oleaeceae" "palmae" "pinus" "plantago" "platanus" "poaceae" "populus" "quercus" "rosaceae" "rumex" "salix" "sambucus" "ulmus" "urticaceae" "urtica-memb")
english_words=("hour" "set" "amount" "minus" "read")


#defirnir diretorio atual
root_dir="$(pwd)"

# cri as pastas
mkdir -p "$root_dir/verified_recordings/latin_words"
mkdir -p "$root_dir/verified_recordings/english_words"
mkdir -p "$root_dir/erros"

# funcao pra conversao minusculos
to_lower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

# Loop pelos diretórios em "drive"
for dir in "$root_dir/drive"/*; do
    if [ -d "$dir" ]; then
        full_name=$(basename "$dir")
        #echo "Processando diretório: $full_name"

        # Loop pelos arquivos no diretório "seu_nome_completo"
        for file in "$dir"/*; do
            if [ -f "$file" ]; then
                filename=$(basename "$file")
                extension="${filename##*.}"
                filename_without_extension="${filename%.*}"

                # Converte o nome do arquivo para minúsculas
                filename_lowercase=$(to_lower "$filename_without_extension")

                # Verifica se o nome do arquivo está na lista de palavras latinas (ignorando maiúsculas/minúsculas)
                if [[ " ${latin_words[@]} " =~ " ${filename_lowercase} " ]]; then
                    target_dir="$root_dir/verified_recordings/latin_words/$filename_lowercase"
                # Verifica se o nome do arquivo está na lista de palavras em inglês (ignorando maiúsculas/minúsculas)
                elif [[ " ${english_words[@]} " =~ " ${filename_lowercase} " ]]; then
                    target_dir="$root_dir/verified_recordings/english_words/$filename_lowercase"
                else
                    echo "Erro: Nome de arquivo não encontrado nas listas - $full_name/$filename"
                    # Gera um nome de arquivo variável para a pasta de erros
                    new_error_filename="${filename_lowercase}_$full_name.$extension"
                    cp "$file" "$root_dir/erros/$new_error_filename"
                    continue
                fi

                # Cria o diretório de destino, se não existir
                mkdir -p "$target_dir"

                # Gera um nome de arquivo variável com base no nome completo e na extensão
                new_filename="${filename_lowercase}_$full_name.$extension"

                # Copia o arquivo para o diretório de destino com o novo nome, mantendo o nome original dentro do diretório "drive"
                cp "$file" "$target_dir/$new_filename"
            fi
        done
    fi
done

echo "Processo concluído"
