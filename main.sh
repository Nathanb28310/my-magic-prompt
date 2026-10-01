#!/bin/bash
source ./quit.sh
source ./joke.sh
source ./calc.sh
source ./.env

verification() {
  echo "Quel est votre identifiant ?"
  read id
  echo "Quel est votre mot de passe ?"
  read mdp
  if [ "$id" != "$LOGIN" ] && [ "$mdp" != "$MDP" ]; then
    exit
  else
    echo "accès autorisé"
  fi
} 

cmd() {
  cmd=$1
  #argv=$*

  case "${cmd}" in
    quit | exit ) quit;;

    help ) echo "Commandes : help, ls, rm, rmd, rmdir, about, version, age, quit, profil, passw, cd, pwd, hour, httpget, smtp, open, joke"  ;;

    joke ) joke ;;

    calc ) calc;; 

    ls ) ls -lah;;

    pwd ) pwd ;;

    rm) 
      echo "Quel fichier veux-tu suprimer ?"
      read fichier 
      [ -n "$fichier" ] && rm "$fichier" || echo "Le fichier n'existe pas";;

    rmd | rmdir) 
      echo "Quel dossier veux-tu suprimer ?"
      read dossier
      [ -n "$dossier" ] && rmdir "$dossier" || echo "Le fichier n'existe pas";;

    cd ) 
      echo "Dans quel dossier veux-tu aller ?"
      read dossier
      cd "$dossier" || cd;;

    hour ) date +%H:%M:%S ;; 

    age ) 
      echo "Quel est ton âge ?"
      read ton_age
      if [ $ton_age -lt 18 ]; then 
        echo "Mineure"
      else
        echo "Majeur"
      fi;;

    version | --v | vers ) echo "Version : 1.0.0";;

    profil ) 
      echo "Quel est ton prénom ?"
      read ton_prenom
      echo "Quel est ton nom ?"
      read ton_nom
      echo "Quel est ton âge ?"
      read ton_age
      echo "Quel est ton email ?"
      read ton_email
      echo "Tu t'appelles $ton_prenom $ton_nom, tu as $ton_age ans et voici ton email : $ton_email";;

    httpget ) 
      echo "Comment veux tu appeler ton fichier"
      read fichier
      echo "URL ?"
      read url
      curl -o $fichier.html $url;;

    passw ) 
      echo "MDP ?"
      read mdp1
      echo "Remettre MDP ?"
      read mdp2
      verification
      if [ "$mdp1" -eq "$mdp2" ]; then
        MDP="$mdp1"
        echo "modification du mdp"
      else
        echo "echec modification"
      fi;;

    about) echo "if saving you means losing you then so be it.";;

    smtp) 
      echo "Quel est le destinataire ?"
      read destinataire
      echo "Quel est l'objet ?"
      read objet
      echo "Quel est le message"
      read message
      echo "Le destinataire : $destinataire" 
      echo "L'objet : $objet"
      echo "Le message : $message";;
      #echo -e "Subject:$objet\n\n$message" | msmtp "$destinataire" 2>/dev/null || echo "E-mail envoyé à $destinataire";;

    open) 
      echo "Quel fichier veux tu ouvrir"
      read fichier
      vim $fichier;;

    * ) echo "Commande inconnue, utilise help";;

  esac

}

main() {
  lineCount=1

  while [ 1 ]; do
    date=$(date +%H:%M)
    echo -ne "${date} - [\033[31m${lineCount}\033[m] - \033[33mXzen\033[m ~ ☠️ ~ "
    read string

    cmd $string
    lineCount=$(($lineCount+1))
  done
}

verification
main

