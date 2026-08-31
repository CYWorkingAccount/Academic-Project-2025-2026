# Installation de services réseaux

**Réalisé par Robin AERNOUT, Tom VEREZ et Youssef CHEKALIL**

## Préparer l'environnement

Avant de commencer, il faut installer Pandoc sur la machine (nous avons utilisé une VM Debian) :

```
sudo apt update
sudo apt install pandoc -y
```

On peut vérifier que tout est bon avec `pandoc --version`.

## Nos commandes de conversion

Voici les commandes qu'on utilise concrètement pour compiler nos fichiers de la semaine 1 à 5 en un seul document propre.

### Sortie HTML
Pour avoir un rendu web avec une table des matières et les titres numérotés, on lance :

```
# Version standard
pandoc Semaine1.md Semaine2.md Semaine3.md Semaine4.md Semaine5.md -o rapport.html -s --toc --toc-depth=2 -N --css style.css
```

**À savoir sur nos options :**
* On liste tous nos fichiers `.md` à la suite pour qu'ils fusionnent.
* `-s` permet d'avoir un fichier HTML complet (pas juste uns fragment).
* `--toc` génère automatiquement le sommaire au début.
* `-N` numérote nos sections (1, 1.1, etc.).

### Sortie PDF

C'est la même logique, mais on change l'extension de sortie. 

```
pandoc Semaine1.md Semaine2.md Semaine3.md Semaine4.md Semaine5.md -o rapport.pdf --toc --toc-depth=2 -N
```

*Note : Pas besoin du `-s` ici, Pandoc le gère tout seul pour le format PDF. Ni du css car c'est que pour le HTML*

Si on utilise un en-tête **YAML** (pour le style CSS ou les emojis), on peut simplifier la commande car Pandoc récupère les réglages directement dans le fichier contrairement au HTML où on est obligé de spécifier toute la commande:

```
pandoc Semaine1.md Semaine2.md Semaine3.md Semaine4.md Semaine5.md -o rapport.pdf
```


Nous avons décidé de laisser le format PDF par défaut de LaTeX, afin de garantir une compatibilité optimale avec Pandoc et d’éviter les erreurs liées à l’utilisation de moteurs alternatifs comme XeLaTeX ou LuaLaTeX, tout en conservant un rendu propre et stable du document.

Nous avons aussi utilisé des extention YAML, tout y est expliqué dans la semaine 5.

---

## Contenu du projet

Le rapport complet est découpé par étapes pour plus de clarté :

* **Semaine 1** : Mise en place de notre VM Debian.
* **Semaine 2** : Prise en main de Markdown et Pandoc.
* **Semaine 3** : Travail collaboratif avec Git.
* **Semaine 4** : Montage de notre propre forge avec Forgejo.
* **Semaine 5** : Peaufinage du style (YAML et CSS).

Pour consulter le travail final, il suffit d'ouvrir `rapport.html` ou `rapport.pdf`. Toutes nos captures d'écran sont rangées dans le dossier `img/`.
