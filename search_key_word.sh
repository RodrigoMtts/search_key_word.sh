#!/bin/bash

# definir a função de pesquisa para arquivos .odt
function search_odt {
  # verificar se o usuário inseriu um caminho de diretório como argumento
  if [ -z "$1" ]; then
    echo "É necessário especificar o caminho do diretório a ser pesquisado."
    exit 1
  fi

  # verificar se o diretório especificado existe
  if [ ! -d "$1" ]; then
    echo "Diretório inválido: $1"
    exit 1
  fi

  # procurar por todos os arquivos .odt no diretório especificado e em seus subdiretórios, e pesquisar por "reservado" (case insensitive)
  echo "Procurando por 'reservado' em arquivos .odt ..."
  find "$1" -type f -name "*.odt" -exec sh -c 'if libreoffice --cat "$0" | grep -qi "reservado"; then echo "Encontrado em $0"; else echo "Não encontrado em $0"; fi' {} \;
}

# definir a função de pesquisa para arquivos .pdf
function search_pdf {
  # verificar se o usuário inseriu um caminho de diretório como argumento
  if [ -z "$1" ]; then
    echo "É necessário especificar o caminho do diretório a ser pesquisado."
    exit 1
  fi

  # verificar se o diretório especificado existe
  if [ ! -d "$1" ]; then
    echo "Diretório inválido: $1"
    exit 1
  fi

  # procurar por todos os arquivos .pdf no diretório especificado e em seus subdiretórios, e pesquisar por "reservado" (case insensitive)
  echo "Procurando por 'reservado' em arquivos .pdf ..."
  find "$1" -type f -name "*.pdf" -exec sh -c 'if pdftotext "$0" - | grep -qi "reservado"; then echo "Encontrado em $0"; else echo "Não encontrado em $0"; fi' {} \;
}

# exibir um menu para permitir que o usuário escolha em que tipo de arquivo pesquisar a palavra
echo "Qual tipo de arquivo você deseja pesquisar?"
echo "1. Arquivos .odt"
echo "2. Arquivos .pdf"

# ler a escolha do usuário
read -r choice

case "$choice" in
  1)
    # pedir ao usuário o caminho do diretório a ser pesquisado
    echo "Digite o caminho do diretório a ser pesquisado:"
    read -r directory

    # chamar a função de pesquisa para arquivos .odt
    search_odt "$directory"
    ;;
  2)
    # pedir ao usuário o caminho do diretório a ser pesquisado
    echo "Digite o caminho do diretório a ser pesquisado:"
    read -r directory

    # chamar a função de pesquisa para arquivos .pdf
    search_pdf "$directory"
    ;;
  *)
    echo "Opção inválida. Saindo."
    exit 1
    ;;
esac
