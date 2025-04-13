#!/bin/bash

# Nom du script et du manuel
SCRIPT="pinit.sh"
SCRIPT_NAME="pinit"
MANUAL="pinit.1"

# Chemins de destination
BIN_PATH="/usr/local/bin"
MAN_PATH="/usr/local/share/man/man1"
ZSHRC="$HOME/.zshrc"
BASHRC="$HOME/.bashrc"

# Vérifie si le script est déjà dans /usr/local/bin
if [ -f "$BIN_PATH/$SCRIPT_NAME" ]; then
    echo "$SCRIPT_NAME est déjà présent dans $BIN_PATH."
else
    # Copie le script dans /usr/local/bin et le rend exécutable
    sudo cp "$SCRIPT" "$BIN_PATH/$SCRIPT_NAME"
    sudo chmod +x "$BIN_PATH/$SCRIPT_NAME"
    echo "$SCRIPT_NAME a été copié dans $BIN_PATH."
fi

# Vérifie si le manuel est déjà dans /usr/local/share/man/man1
if [ -f "$MAN_PATH/$MANUAL" ]; then
    echo "La page manuelle $MANUAL est déjà présente dans $MAN_PATH."
else
    # Copie le fichier de manuel
    sudo cp "$MANUAL" "$MAN_PATH"
    echo "La page manuelle $MANUAL a été copiée dans $MAN_PATH."
    
    # Met à jour la base de données des pages de manuel
    sudo mandb
    echo "La base de données des pages man a été mise à jour."
fi

# Ajouter la commande pinit dans ~/.zshrc si elle n'existe pas déjà
if [ -f "$ZSHRC" ]; then
    if ! grep -q "pinit" "$ZSHRC"; then
        echo "alias pinit='$BIN_PATH/$SCRIPT_NAME'" >> "$ZSHRC"
        echo "La commande pinit a été ajoutée à $ZSHRC."
    else
        echo "La commande pinit est déjà présente dans $ZSHRC."
    fi
else
    echo "$ZSHRC n'existe pas."
fi

# Ajouter la commande pinit dans ~/.bashrc si elle n'existe pas déjà
if [ -f "$BASHRC" ]; then
    if ! grep -q "pinit" "$BASHRC"; then
        echo "alias pinit='$BIN_PATH/$SCRIPT_NAME'" >> "$BASHRC"
        echo "La commande pinit a été ajoutée à $BASHRC."
    else
        echo "La commande pinit est déjà présente dans $BASHRC."
    fi
else
    echo "$BASHRC n'existe pas."
fi

echo "Installation de pinit terminée."
echo "Rappel : insérer \"alias pinit='$BIN_PATH/$SCRIPT_NAME' >> $BASHRC\" dans votre fichier de configuration de shell pour pouvoir utiliser la commande directement"
