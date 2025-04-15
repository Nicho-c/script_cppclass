#!/bin/bash

# Fonction pour afficher l'aide
usage() {
    echo "Usage: newclass <nom_classe>"
    echo ""
    echo "Options :"
    echo "  <nom_classe> : Nom de la classe CPP a crée."
    exit 1
}

if [ $# -lt 1 ]; then
	echo "Nombre d'arguments invalide"
    usage
fi

CLASS_NAME="$1"
CLASS_NAME_U=$(echo "$CLASS_NAME" | tr '[:lower:]' '[:upper:]')
if [ -z "$2" ]; then
	CLASS_DEFAULT_KEY="key"
else
	CLASS_DEFAULT_KEY="$2";
fi

# Cloner le projet par défaut
git clone "git@github.com:Nicho-c/template_cpp_class.git" "temp_template_cppclass" || { echo "Erreur lors du téléchargement des templates."; exit 1; }

CPP_FILE=$(<temp_template_cppclass/class.cpp.txt)
HPP_FILE=$(<temp_template_cppclass/class.hpp.txt)

CPP_FILE="${CPP_FILE//\{\{CLASS_NAME\}\}/$CLASS_NAME}"
CPP_FILE="${CPP_FILE//\{\{CLASS_NAME_U\}\}/$CLASS_NAME_U}"
CPP_FILE="${CPP_FILE//\{\{CLASS_DEFAULT_KEY\}\}/$CLASS_DEFAULT_KEY}"
HPP_FILE="${HPP_FILE//\{\{CLASS_NAME\}\}/$CLASS_NAME}"
HPP_FILE="${HPP_FILE//\{\{CLASS_NAME_U\}\}/$CLASS_NAME_U}"
HPP_FILE="${HPP_FILE//\{\{CLASS_DEFAULT_KEY\}\}/$CLASS_DEFAULT_KEY}"

echo "$CPP_FILE" > $CLASS_NAME".cpp"
echo "$HPP_FILE" > $CLASS_NAME".hpp"

rm -rf temp_template_cppclass

echo "La class $CLASS_NAME a été créé avec succès."
