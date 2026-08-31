

# Rapport d'installation du service Forgejo

## Préliminaire : Redirection de port

### Comment avons-nous configuré la redirection dans VirtualBox ?

> Pour accéder à l'interface web de Forgejo (port 3000) depuis la machine physique, nous avons dû créer une règle de redirection, car la VM est isolée derrière un NAT.
>
> Nous sommes allés dans les **Paramètres** de la machine, onglet **Réseau**, puis dans la section **Avancé**. En ouvrant le menu **Redirection de ports**, nous avons ajouté une règle TCP : le port **3000** de l'hôte (notre PC) communique désormais avec le port **3000** de l'invité (la VM). [source](https://www.google.com/search?q=https://www.virtualbox.org/manual/ch06.html%23natforward)
>
>


## Comprendre l’écosystème Forgejo

### Qu’est-ce que Forgejo ?

> Forgejo est ce qu'on appelle une forge logicielle. C'est un outil complet qui permet d'héberger des dépôts Git, de gérer des tickets d'incidents et de collaborer sur du code source. Il est léger, écrit en langage Go, et propose une interface web très réactive. [source](https://www.google.com/search?q=https://forgejo.org/static/forgejo.pdf)
>

### Qu’est-ce qu’un fork (dans le domaine du développement logiciel) ?

> Un **fork** se produit lorsque des développeurs reprennent le code source d'un projet existant pour lancer une nouvelle branche indépendante. Cela permet de faire évoluer le logiciel selon une vision différente, souvent suite à des désaccords communautaires.[source](https://fr.wikipedia.org/wiki/Fork_\(d%C3%A9veloppement_logiciel\))
>

### De quel logiciel Forgejo est-il issu ?

> Forgejo est né d'un fork de **Gitea**, qui était lui-même à l'époque une version dérivée de Gogs. On reste donc sur une base technique très similaire entre ces trois outils. [source](https://forgejo.org/2022-12-15-hello-forgejo/)
>

### Pourquoi ce fork a-t-il eu lieu ?

> Le changement a été motivé par une modification de la gouvernance de Gitea vers une structure commerciale à but lucratif. Une partie de la communauté a préféré créer Forgejo pour garantir que le projet reste "100% libre" et géré de manière désintéressée. [source](https://forgejo.org/faq/)
>

### Les logiciels d’origine existent-ils encore ?

> Oui, Gitea est toujours maintenu et bénéficie de mises à jour régulières. Les deux logiciels coexistent désormais, chacun suivant sa propre feuille de route technique. [source](https://github.com/go-gitea/gitea)

### Qu’est-ce qui différencie la gouvernance de Forgejo de celle de Gitea ?

> Forgejo privilégie une gestion communautaire sous l'égide de l'organisation *Codeberg e.V.*, tandis que Gitea fonctionne désormais sous un modèle de société privée (Gitea Ltd). [source](https://www.google.com/search?q=https://forgejo.org/governance/)



## Installation de Forgejo sur Debian

> Comme Forgejo n'est pas encore présent dans les dépôts `apt` officiels, nous avons utilisé l'installation par binaire.

### Comment avons-nous installé le binaire Forgejo ?

> On a récupéré le fichier binaire sur le site officiel, on lui a donné les droits d'exécution, puis on l'a déplacé dans un répertoire système (`/usr/local/bin`) pour pouvoir l'appeler facilement en ligne de commande. [source](https://forgejo.org/docs/latest/admin/installation/binary/)


`wget https://codeberg.org/forgejo/forgejo/releases/download/v14`  
`.0.3/forgejo-14.0.3-linux-amd64`  
`chmod +x forgejo-14.0.3-linux-amd64`  
`mv forgejo-14.0.3-linux-amd64 /usr/local/bin/forgejo`



### Quelles sont les dépendances et l'utilisateur requis ?

> On a installé Git, car c'est le moteur de la forge. Côté sécurité, on a créé un utilisateur système `forgejo` dédié : il n'a pas de mot de passe et ne peut pas se connecter directement, ce qui protège le reste du système. [source](https://www.google.com/search?q=https://forgejo.org/docs/latest/admin/installation/binary/%23create-a-user-to-run-forgejo)


`apt install git git-lfs`
`adduser --system --shell /bin/bash --group --disabled-password --home /home/forgejo forgejo` 

## Architecture et réseau

### Pourquoi Forgejo écoute-t-il sur le port 3000 plutôt que sur le port 80 ?

> Sous Linux, seul l'utilisateur "root" peut lancer un service sur le port 80. Comme nous faisons tourner Forgejo avec un utilisateur restreint pour plus de sécurité, nous utilisons le port 3000. Cela évite de donner trop de privilèges au logiciel. [source](https://en.wikipedia.org/wiki/Registered_port)

## Base de données

### Pourquoi SQLite est-il préféré à PostgreSQL ou MySQL pour ce projet ?

> On a choisi SQLite pour sa simplicité. Contrairement aux autres, il n'y a pas de serveur à installer ou à configurer : la base de données est un simple fichier. C'est idéal pour une petite instance ou un environnement de test. [source](https://www.sqlite.org/whentouse.html)

### Où se trouve le fichier de base de données SQLite et qui en est le propriétaire ?

> Le fichier se trouve dans `/var/lib/forgejo/data/forgejo.db`. Il appartient à l'utilisateur `forgejo` que nous avons créé précédemment. [source](https://www.google.com/search?q=https://forgejo.org/docs/latest/admin/installation/binary/%23installation-structure)



## Gestion du service systemd

### Qu’est-ce qu’un service systemd et à quoi sert-il ?

> C'est un gestionnaire qui pilote les logiciels en arrière-plan. Il permet de lancer Forgejo automatiquement au démarrage de la machine et de le relancer s'il s'arrête brutalement. [source](https://wiki.debian.org/fr/systemd)

### Où est situé le fichier de service forgejo et que contient-il ?

> Il est dans `/etc/systemd/system/forgejo.service`. Il indique au système l'utilisateur à utiliser, le dossier de travail et la commande exacte pour démarrer le serveur web. [source](https://codeberg.org/forgejo/forgejo/src/branch/forgejo/contrib/systemd/forgejo.service)

### Quelle est la différence entre systemctl start, enable et restart ?

> `start` lance le service tout de suite ; `enable` programme son lancement au démarrage de la machine ; `restart` l'arrête puis le relance (très utile après avoir modifié la configuration). [source](https://man7.org/linux/man-pages/man1/systemctl.1.html)

### Comment visualiser les logs avec journalctl ?

> On utilise `journalctl -u forgejo`. On peut aussi filtrer les logs les plus récents ou les suivre en direct pour débugger l'installation. [source](https://man7.org/linux/man-pages/man1/journalctl.1.html)



## Sécurité

### Quelles sont les permissions des fichiers /etc/forgejo et app.ini ?

> Le dossier appartient à `root` et au groupe `forgejo`, avec des droits stricts (770). C'est crucial car le fichier `app.ini` contient des informations sensibles qui ne doivent pas être visibles par n'importe qui sur la machine. [source](https://www.google.com/search?q=https://forgejo.org/docs/latest/admin/installation/binary/%23installation-structure)

### Sur quel port écoute le serveur SSH de Forgejo ?

> Il utilise le port **22**. C'est le port officiel du protocole SSH, indispensable pour que les utilisateurs puissent "pousser" ou récupérer du code de manière sécurisée. [source](https://en.wikipedia.org/wiki/Secure_Shell)

### Quelles mesures de sécurité prendre si le serveur était ouvert sur Internet ?

> On passerait obligatoirement par un certificat SSL (HTTPS) via un "Reverse Proxy" comme Nginx. On renforcerait aussi le SSH en désactivant les mots de passe au profit de clés privées uniquement. [source](https://forgejo.org/docs/latest/admin/reverse-proxy/)







