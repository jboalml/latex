# LaTeX templates
This repository holds a collection of LaTeX templates intended to make it easier for everyone, whether you have previous experience with LaTeX or not, to type visually appealing documents.

Currently, the available templates are mostly of an academic nature (bachelor's, master's, and PhD theses, teaching material...) and specifically designed for the [ICAI School of Engineering](http://icai.comillas.edu/), which belongs to [Comillas Pontifical University](http://comillas.edu/). Nevertheless, users with basic knowledge of LaTeX should be able to modify them for other purposes without much effort.

## Contents
- [Template description](#template-description)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
- [Documentation](#documentation)
- [Developers](#developers)
- [License](#license)

## Template description
- `teaching.cls` - Allows to write teaching material such as class notes, exercises, lab guides, quizzes, exams, and exam solutions.

## Getting started
### Installation
You can just drop the template you need in your project's folder and start using it straightaway. However, in order to keep everything tidy, you can also make templates accessible from your LaTeX distribution.

First, type the following command on the command prompt or terminal to determine where to copy the templates.

```
kpsewhich -var-value=TEXMFHOME
```

In my case, using MacTeX on Mac OS X, the value of `TEXMFHOME` is:

```
/Users/jboal/Library/texmf
```

You should place the templates you want to use in a subdirectory of `TEXMFHOME/tex/latex/` (e.g., `/Users/jboal/Library/texmf/tex/latex/teaching/`). You may need to create the folder path. This approach has the advantage that it is not necessary to update the package database as TeX searches your personal `texmf` tree directly.

You can verify that your distribution is able to find the template using the following command:

```
kpsewhich filename
```

where `filename` stands for the template name (e.g., `teaching.cls`).

If this procedure does not work for you (probably because you are using a different OS or a different LaTeX distribution), check the following links for alternatives:
- [Where do I place my own .sty or .cls files, to make them available to all my .tex files?](http://tex.stackexchange.com/questions/1137/where-do-i-place-my-own-sty-or-cls-files-to-make-them-available-to-all-my-te)
- [How do I add a .sty file to my MacTeX/TeXShop installation?](http://tex.stackexchange.com/questions/10252/how-do-i-add-a-sty-file-to-my-mactex-texshop-installation)
- [Install custom .cls using TeX Live in local directory.](http://tex.stackexchange.com/questions/96976/install-custom-cls-using-tex-live-in-local-directory)
- [How to make LaTeX see local texmf tree.](http://tex.stackexchange.com/questions/30494/how-to-make-latex-see-local-texmf-tree)
- [How to register my own packages or classes in a separate drive to TeX Live installation?](http://tex.stackexchange.com/questions/20160/how-to-register-my-own-packages-or-classes-in-a-separate-drive-to-tex-live-insta)

#### Ubuntu font family
Some templates use the [Ubuntu font family](http://font.ubuntu.com/) for titling. You will find the fonts and installation instructions [here](https://github.com/tzwenn/ubuntu-latex-fonts).

### Usage
After setting everything up, create a new `.tex` file and type the `\documentclass` command at the beginning. Its structure should be:

```
\documentclass[option1,option2,option3]{classname}
```
where `classname` is the template name.

#### Options

| Option                  | Possible values          |
|-------------------------|--------------------------|
| Font size               | **10pt**, 11pt, 12pt     |
| Paper size              | **a4paper**, letterpaper |
| Single- or double-sided | oneside, twoside         |
| Language                | english, spanish         |

- Default values are highlighted in bold.
- As the main font chosen in most templates is rather large, a **font size** of `11pt` is recommended over `12pt`.
- **The language option is mandatory**; otherwise the document will not compile. If you need to use more than one language write them one after the other. Bear in mind that the last language you type will be the one selected at the beginning of the document.
- **Some templates have additional options**. Check the [wiki](https://github.com/jboalml/latex/wiki) to learn how to further customize the different templates. For instance, in the case of `teaching.cls` you can define the purpose of the document (i.e., `notes`, `exercises`, `lab`, `quiz`, `exam`, or `solution`). Layout and appearance will be automatically set accordingly.

#### Example
In order to use `teaching.cls` to write some class notes in Spanish you would type:

```
\documentclass[11pt,a4paper,twoside,spanish,notes]{teaching}
```

#### Sample documents
In each template directory you will find a `samples` folder with skeleton documents to get you started.

## Developers
This repository is developed and maintained by [Jaime Boal](https://github.com/jboalml).

### Acknowledgments
I would like to thank Romano Giannetti for detecting quite a few bugs and providing feedback on how to improve the `teaching.cls` template.

## License
This repository is licensed under the [GNU General Public License v2.0](LICENSE.md).

The Comillas logo is property of [Comillas Pontifical University](http://comillas.edu/). All rights reserved.
