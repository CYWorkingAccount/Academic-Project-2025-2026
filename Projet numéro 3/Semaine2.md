# Les outils d'éditions 

Dans cette 2eme partie, nous allons tout d'abord vous présenter **Markdown** et **Pandoc** puis vous présenter les bases de ses outils et leurs fonctionnalités.

## Présentation des outils

### Qu'est ce que le "Markdown"

> Le **Markdown** est un langage de balisage léger qui permet de **mettre en forme du texte** de manière simple et lisible, sans avoir besoin de logiciels compliqués. Il permet par exemple de créer des titres, listes, liens, images, ou du texte en gras/italique simplement avec des caractères spéciaux ([source](https://daringfireball.net/projects/markdown/)). Markdown est très populaire car il est **facile à apprendre**, rapide à écrire, et peut être **converti** en HTML ou PDF très facilement. A titre informatif, notre projet est écrit en Markdown.

### Qu'est ce que pandoc ?

> Vous devez probablement vous demander comment on peut convertir un fichier `.md` (Markdown) en HTML ou PDF. C’est là tout l’intérêt de Pandoc : il s’agit d’un **outil de conversion** de documents universel, capable de **transformer** des fichiers entre de nombreux formats différents, comme Markdown, HTML, PDF DOCX, et bien d’autres encore. Pandoc peut également **gérer** des références bibliographiques, des tableaux, des images et même des présentations, ce qui en fait un **outil extrêmement puissant** pour automatiser et standardiser la production de documents.

## Tout savoir sur pandoc et markdown

### Utilisation du markdown

> Son utilisation est **extremement simple**, dans cette partie, nous allons vous donnez le minimum requis afin de pouvoir utilisé markdown et vous fournir la **documentation** si vous voulez en savoir plus, car bien évidemment, il y a trop de choses pour que nous vous expliquons tout, et nous meme ne connaissons pas tous. Dans ce que je vais vous présenter, je vais vous expliquer à quoi cela sert et un exemple de ce que cela donne en vous montrant ce que j'ai mis pour avoir ce rendu.  
>

#### Les titres `#`

> Il y a différent **niveau** de titres, de 1 à 6:

---

### Titre de niveau 3 
#### Titre de niveau 4 
##### Titre de niveau 5 

---

```
### Titre de niveau 3
#### Titre de niveau 4
##### Titre de niveau 5
```

> Les titres sont les éléments les plus importants pour organiser la structure d'un document. Pour créer un titre, ajoutez un dièse (#) avant un mot ou une phrase. Le nombre de dièses indique le niveau du titre, les titres pouvant aller jusqu'à 6. 
>
> Ici nous en avons fait l'exemples avec les titres de niveaux 3, 4 et 5. Les numéros a coté sont dues à une option de pandoc. 

::: note
Cependant, il est important de respecter un ordre logique : il faut toujours commencer par un titre de niveau 1, puis de niveau 2. Il n’est pas possible de passer directement à un titre de niveau 3 sans respecter cette hiérarchie.
:::

#### Mettre du text en gras et/ou italique `*`

> Vous pouvez mettre du text en gras, en italique ou les 2 en utilisant des asthérisques (*), il vous en suffit de un de chaque côté de la phrase que vous voulez mettre en italique, de deux pour le mettre en gras et de 3 pour le mettre en gras et en italique.

*Text en italique*  
**Text en gras**  
***Text en gras et en italique***

```

*Text en italique*
**Text en gras**
***Text en grras et en italique***

```

#### Mettre des ciations `>`

> Les **citaions** servent à **mettre en avant** un **texte particulier** en le distinguant du reste du contenu.  
>
> Vous les distinguerai avec les barre sur la gauche. 
>
> Dans notre rapport nous mettons trés régulièrement des ciations, nous trouvons que cela rend un meilleur visuelle.
>
>Nous avons aussi remarqué que même si sur la preview cela marche, si vous ne mettez pas d'espace entre `>`et votre texte, lorsque vous allez modifier le format avec pandoc, les `>`s'afficheront et le texte ne sera pas mis en avant.

> Ceci est une citations

```
> Ceci est une citations
```

#### Insérer une image et une source

> Pour mettre une source, il vous suffit de mettre entre [] le texte qui sera cliquable puis mettre l'URL entre ()

[Ceci est une source vers google](https://www.google.com/?hl=fr)

```
[Ceci est une source vers google](https://www.google.com/?hl=fr)
```

> Pour insérer une image, il vous suffit de faire la même chose mais en ajoutant un point d'explamation devant (!) ce qui sera entre [] sera le texte altérnatif et ce qui sera entre () sera la où mène votre image.
>
> Donc si vous etes dans un dossier A, que votre fichier .md ou vous écrivez s'y trouve et que vos image sont dans un sous dossiers B. Alors ce que vous devez mettre entre () est `B/(nom de votre image)`  
>
> Ceci est important car sinon, votre image ne s'affichera pas. N'oubliez pas aussi que si vous envoyez votre fichier .md à une personne sans aussi envoyez les images avec la bonne hiérarche de fichier, il ne verra pas vos image. 

#### Passer à la ligne/une ligne

> Pour passer à la ligne, il vous suffit de mettre 2 espaces à la fin de la ligne d'avant.
>
> Pour passer une ligne il n'y a pas d'autre chose à faire que de sauter une ligne, cepandant vous ne pouvez pas passer plus d'une ligne. **Markdown** considère plusieurs sauts de ligne comme une seule

#### Les listes/sous-listes

> Ils existent 2 type de listes, les listes numérotés et les listes avec des • 
>
> Pour les listes numérotés, ils vous suffit de faire 1., cependant vous n'etes pas obliger de suivre l'ordre, vous pouvez à chaque fois mettre 1., cela vous numérotera automatiquement.

1. 
1. 
1. 

```
    1.
    1.
    1.
```

> Cependant faites attention à l'indentation, si vous mettez entre vos listes des citations, vous devez décaler le texte vers la droite (tabulation), sinon la liste ne marchera pas et ce ne sera pas une liste.
>
> Il existe aussi des liste avec des •  
>
> Pour ce faire, il y a 3 façon de faire, soit avec des `+`, soit avec des `-` ou avec des `*`. Cependant il est bon de savoir que entre chacun des différent moyens de faire, il y aura un plus grands espaces.

+
+
*
*
-
-

```
    +
    +
    *
    *
    -
    -

```
> Pour les sous-listes, ils vous suffit juste de décaler votre sous-liste. Voici un exempple

-  Titre 1
    1.  Sous titre 1
    1.  Sous titre 2
    1.  Sous titre 3
-  Titre 2
    1.  Sous titre 1
    1.  Sous titre 2
    1.  Sous titre 3

```
    - Titre 1
        1.  Sous titre 1
        1.  Sous titre 2
        1.  Sous titre 3
    - Titre 2
        1.  Sous titre 1
        1.  Sous titre 2
        1.  Sous titre 3
```

#### Les blocs de code

> Vous pouvez aussi ajouter des blocs de 2 manières différentes
> 
> Soit avec ` qui permet de mettre du code sur une ligne, en voici un exemple ;

```
    `Voici du code`
```

> Soit avec ``` qui permet de mettre du code sur plusieurs ligne. Vous pouvez aussi mettre après vos 3 premier backtick le nom du language que vous utlisez. Cela va mettre le code en couleur selon le language que vous utilisez.

```
    ```markdown
    Code
    Sur
    Plurieurs
    Ligne
    ```
```





#### Les métadonnées

> Il est possible d’ajouter des métadonnées 
en utilisant des accolades {} juste après cet élément. 
>
> Par exemple, après une image, un titre ou un bloc de code, on peut spécifier des attributs comme la taille, l’identifiant, la classe CSS ou un style particulier. 
>
> Pour une image, on peut ainsi écrire `![Texte alternatif](image.png){ width=50% }`pour indiquer que l’image doit occuper 50 % de la largeur du document. 
>
> On peut également donner un id pour référencer l’élément dans la table des matières ou dans un lien `{#mon-id}`, ou une classe CSS pour appliquer un style `{.ma-classe}`.
>
> Ces métadonnées permettent de contrôler le rendu précis de chaque élément.

### Utilisation de pandoc 

> Avant toute chose, n'oubliez pas d'installer pandoc, pour cela, vous pouvez aller voir dans le readme.

#### Transformer un fichier .md en .html

> Pour transformer un fichier .md en en un autre fichier, il vous suffit d'ouvrir un **terminal Linux** et de faire la commande `pandoc (nom du fichier) -o (nom du fichier qui va etre créer)`
>
> Le `-o` ou `--output` permet de transformer un fichier en un autre.
>
> Avec la commande `--list-input-formats` vous pouvez voir les formats d'entrer que pandoc accepte et avec `--list-output-formats` ceux de sorti.
>
> Ceci est la base de pandoc, cependant il existe de nombreuses options qui font la particularité de pandoc, nous allons vous en présenter quelques unes, mais vous pouvez aussi consulter la documentaion pandoc sur des sites ou sur le manuelle en fessant la commande `man pandoc`depuis un teminal

#### Les options

> Comme dit precédemment, nous allons vous présenter les options les plus basiques. 
>
> Tout ce qu'on va vous dire ici est spécifiié dans le **manuelle de pandoc** et pour plus d'information, vous pouvez aller y faire un tour.
> 
> L'option `--toc` ou  permet de faire une table des matières selon vos titres. D'autres options permettent d'avoir un meilleur visuelle pour votre table des matières comme `-N` qui vous permet d'avoir des numéros a côté de vos tites et de votre liste des matières ou de mieux gérer vos titres comme avec `--toc-depth=NUMBER`  qui vous permet de faire la table des matières selon le niveau de titre (`NUMBER`) que vous voulez.  
>
> L'option `-s` ou `--standalone` permet de générer un document complet. Sans cette option, pandoc va juste vous générer unn **fragement** et donc non un vrai fichier de votre format. Cette option est cependant mise sur certain fichier automatiquement comme avec PDF et d'autres enocre. 


## Documentations

> Ici nous allons vous donner quelques liens afin de pourvoir mieux vous renseigner et/ou approfondir vos connaissance. A savoir qu'il existe de nombreuses documentations, alors ici nous allons mettre, selon nous, les plus utiles. 
> 
> [Ici](https://www.markdownlang.com/fr/basic/headings.html) se trouve le site qui vous montre comment fonctionne **Mardown**, il comporte une documentation complète de markdown, facile d'utilisation.  
> 
> Vous poouvez utilisez [cette documentation](https://e-publish.uliege.be/md/chapter/outils/#outils) pour pandoc ou [celle-ci](https://pandoc.org/MANUAL.html#pandocs-markdown)
>
> Vous pouvez aussi apprendre Markdown grace a des tutoriels interactifs comme celuis de [CommonMark](https://commonmark.org/help/) ou (https://www.markdowntutorial.com/fr/)[https://www.markdowntutorial.com/fr/]







