# Personnalisation

## YAML

### Qu'est ce que YAML

> YAML est un format de sérialisation de données lisible par l'humain, souvent utilisé pour les fichiers de configuration et les métadonnées (par ex. front matter dans Markdown/Pandoc) ([source](https://www.ibm.com/fr-fr/think/topics/yaml)) 


### Utilisation du YAML avec markdown

> Ici nous allons vous présenter ce qu'il faut savoir sur YAML avec markdown et quelques exemple de son utilisations.
>
> YAML est à mettre tout au début de son fichier, en voici un exemple :

```
title: "Rapport SAE"
author: 
  - "Aernout Robin"  
  - "Chekalil Youssef"
  - "Verez Tom"
date: \today

css: style.css

linkcolor: blue
urlcolor: red
colorlinks: true
 
fenced_divs: true 
admonition: true 

toc: true          
toc-depth: 2       
numbersections: true
```

#### YAML Markdown via Pandoc

> Le bloc ci-dessus correspond aux **métadonnées YAML** utilisées par Pandoc. Il doit toujours commencer et se terminer par `---`. Ce bloc permet de **configurer le document** avant sa conversion (en PDF, HTML, etc.). Il contient les informations principales ainsi que des options qui influencent directement le rendu final.



#### Les bases de yaml

> Ici, nous allons ous présenter les bases de YAML afin de personnaliser votre PDF ainsi que votre HTM. Dans l'exemple que nous avons mis ci-dessus, il y contient les bases.  
> Nous allons donc vous présenter les différentes lignes ainsi que leur fonctionnement et leur subtilité.
>
> Les premières lignes définissent les informations de base du document :  
> - `title` : correspond au titre du document, affiché en haut du fichier généré.
> - `author` : permet de renseigner un ou plusieurs auteurs.
> - `date` : ici `\today` permet d’afficher automatiquement la date du jour lors de la génération.
> 
> Ces éléments sont souvent utilisés pour créer une **page de couverture automatique**.


#### Gestion du style

> La ligne `css: style.css` sert uniquement pour la génération en **HTML**. Elle permet d’appliquer un fichier CSS externe afin de personnaliser l’apparence (couleurs, polices, marges, etc.).
> 
> Ce qui faut retenir ici, c'est que chaque instruction YAML pour le PDF est un raccourci pour un paramètre d’un package LaTeX. Donc ici ce sont que de simples raccourci et cahce derrière les vraies commandes. 
>
> Cependant elle reste valble, il faut juste en etre conscient.
>
> Concernant `linkcolor: blue`, cela permet de définir la **couleur des liens** dans le document PDF. Pour un rendu HTML, il est généralement préférable de gérer cela directement dans le fichier CSS.
>
> Concernant `urlcolor: red`, cela permet de définir la **couleur des liens externes** (comme les sites web) dans le document PDF. Pour un rendu HTML, on gère généralement cela directement via CSS.
>
> Concernant `colorlinks: true`, cette option indique à LaTeX d’**appliquer les couleurs aux liens eux-mêmes** plutôt que de les entourer d’un encadré coloré.  
>
> Sans cette option, LaTeX crée par défaut des cadres colorés autour des liens, ce qui peut rendre les liens moins esthétiques ou surlignés en PDF. Pour faire bref, les liens ne changeront pas de couleur.


#### Extensions Markdown

> Les options suivantes activent des fonctionnalités supplémentaires de Pandoc pour le html :
> - `fenced_divs: true` : permet d’utiliser des blocs délimités par `:::` pour créer des conteneurs personnalisés suivie de `{.(nomDeVotreClass)}.`
> - `admonition: true` : fonctionne de la même manière mais avec des blocs prédéfini, c'est à dire en mettant apèrs `:::` soit `warning/tips/note`.
>
> Les options restantes permettent principalement de structurer automatiquement le document. Par exemple, `toc: true` active la génération d’une table des matières, ce qui permet d’avoir une vue d’ensemble des différentes sections. L’option `numbersections: true` ajoute une numérotation automatique aux titres (1, 1.1, 1.2, etc.), ce qui améliore la lisibilité et l’organisation du document. Enfin, `toc-depth: 2` limite la table des matières aux titres de niveau 1 et 2, évitant ainsi qu’elle devienne trop longue ou difficile à lire.

::: warning
Attention: ces options retantes ne fonctionne que pour le pdf, et non pour le html !
:::

> Il existe également de nombreuses autres options YAML plus avancées. Par exemple, `mathjax: true` permet d’afficher des formules mathématiques dans un document HTML, tandis que l’ajout de packages LaTeX permet de gérer des équations complexes lors de la génération en PDF. Ces fonctionnalités offrent davantage de possibilités, mais elles nécessitent une meilleure compréhension de Pandoc et de YAML pour être utilisées efficacement. 


## CSS

### Qu'est ce que le css

> CSS, ou Cascading Style Sheets, est un langage de feuilles de style utilisé pour définir l’apparence et la présentation des documents HTML ou XML. Il permet de séparer le contenu du document de sa mise en forme, ce qui facilite la maintenance et assure une cohérence du design sur plusieurs pages ([source](https://developer.mozilla.org/fr/docs/Web/CSS))

### Utilisation du CSS

#### Son fonctionnement

> Le CSS fonctionne avec des **sélecteurs** (comme `h1`, `a`, `.note`) qui permettent de cibler des éléments HTML, puis d’appliquer des **propriétés** (couleur, taille, marges, etc.).

---

#### Structure d’une règle CSS

> Une règle CSS se compose de trois éléments :

```css
sélecteur {
  propriété: valeur;
}
```

> - Le **sélecteur** désigne l’élément à modifier  
> - La **propriété** correspond à ce que l’on veut changer  
> - La **valeur** définit comment on le change  

---

#### Exemple de classes personnalisées

> Voici des classes CSS permettant de styliser des blocs d’information :

```css
.note {
  border-left: 4px solid #2196F3;
  background-color: #dcf1ff;
  padding: 10px;
  margin: 10px 0px;
}

.warning {
  border-left: 4px solid #f44336;
  background-color: #ffe1e6;
  padding: 10px;
  margin: 10px 0px;
}

.tip {
  border-left: 4px solid #00ff1e;
  background-color: #b8ffc2;
  padding: 10px;
  margin: 10px 0px;
}
```

> Ces classes permettent de créer des blocs visuels :  
> - `.note` → information  
> - `.warning` → avertissement  
> - `.tip` → conseil  
>
> Vous pouvez donc les personnaliser comme bon vous semble.
>
> Nous allons vous présenter les plus basiques :
>
> `boder-left` permet de gérer la bordure gauche, ici nous avons décider de mettre sa taille à 4px, solid pour dire que c'est un trait continue plein en vert
>
> `background-color` pour définir la couleur de l'arrière plan
>
> En CSS, **margin** et **padding** servent à créer de l’espace autour des éléments, mais ils agissent à des endroits différents. Le **padding** correspond à l’espace **à l’intérieur** d’un élément, entre le contenu (texte, image…) et sa bordure. Autrement dit, il "repousse" le contenu vers l’intérieur, créant un espace interne. Par exemple, `padding: 20px;` ajoutera 20 pixels entre le texte et la bordure de l’élément.
> 
> À l’inverse, le **margin** correspond à l’espace **à l’extérieur** d’un élément, entre la bordure de l’élément et les autres éléments autour. Il "repousse" l’élément lui-même, créant un espace externe. Par exemple, `margin: 20px;` ajoutera 20 pixels entre l’élément et ses voisins.
> 
> Nous vous invitions à aller voir [cette page](https://fr.siteground.com/kb/margin-vs-padding/) pour y comprendre un peu mieux son principe. 

> 


#### Mise en forme des titres

```css
h1 {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    text-transform: uppercase;
}

h2 {
    font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
    text-transform: uppercase;
}
```

> - `font-family` permet de changer la police
> - `text-transform: uppercase` met le texte en majuscules  
>
> Cependant il y en a une multitudes pour le text, vous pouvez tous les retrouver [ici](https://developer.mozilla.org/fr/docs/Learn_web_development/Core/Text_styling/Fundamentals)

---

#### Stylisation des liens

```css
a {
    color: #0800ff;         
    text-decoration: none;          
    transition: all 0.3s;
    display: inline-block;    
}

a:hover {
    color: #a600ff;           
    text-decoration: underline; 
    transform: scale(1.05);
}
```

> Le sélecteur `a` cible tous les liens du document et permet de définir leur style par défaut. Ici, color définit la couleur du lien et `text-decoration: none` supprime le soulignement classique. La propriété `display: inline-block` transforme le lien en bloc en ligne, ce qui permet d’appliquer des transformations comme l’agrandissement.
>
> `transition: all 0.3s` crée une animation fluide sur toutes les propriétés lorsqu’elles changent, par exemple la couleur ou la taille.
>
> Le sélecteur `a:hover` s’applique lorsque l’utilisateur passe la souris sur le lien. `color` change la couleur du lien au survol, `text-decoration: underline` ajoute le soulignement, et `transform: scale(1.05)` agrandit légèrement le lien pour un effet interactif et visuel.

---

#### Style du code

```css
code {
  background-color: #ebebeb;      
  color: #0b2540;                  
  padding: 2px 6px;                 
  border-radius: 4px;             
  font-family: 'Courier New', Courier, monospace;
  font-size: 0.95em;    
}
```

> Le sélecteur `code` cible tous les blocs de code ou les inline code dans ton document.  
> 
> `background-color: #ebebeb;` crée un fond gris clair pour améliorer la lisibilité.  
> `color: #0b2540;` définit la couleur du texte pour qu’il ressorte sur le fond.  
> `padding: 2px 6px;` ajoute un espace à l’intérieur du bloc, pour que le texte ne touche pas les bords.  
> `border-radius: 4px;` arrondit légèrement les coins du bloc.  
> `font-family: 'Courier New', Courier, monospace;` applique une police à chasse fixe adaptée au code.  
> `font-size: 0.95em;` ajuste légèrement la taille du texte pour qu’il s’intègre mieux dans le document.

---


## Documentations

> Ici nous allons mettre la documetnation utile, que nous avons utilisé et que vous pouvez utilisé.
>
> Voici une [doc YAML](https://stackoverflow.com/questions/75548339/mixing-yaml-and-markdown) que vous pouvez utilisé pour mieux comprendre et apprendre pour de choses, et en voici une pour le [CSS](https://developer.mozilla.org/fr/docs/Web/CSS)
