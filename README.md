# LaTeX templates
This repository holds a collection of LaTeX templates intended to make it easier for everyone, whether you have previous experience with LaTeX or not, to type visually appealing documents.

Currently, the available templates are mostly of an academic nature (bachelor's, master's, and PhD theses, teaching material...) and specifically designed for the [ICAI School of Engineering](https://www.icai.comillas.edu/), which belongs to [Comillas Pontifical University](https://www.comillas.edu/). Nevertheless, users with basic knowledge of LaTeX should be able to modify them for other purposes without much effort.

## Contents
- [Template description](#template-description)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
- [Developers](#developers)
- [License](#license)

## Template description
- `teaching.cls` - Allows to write teaching material such as class notes, exercises, lab guides, quizzes, exams, and exam solutions.

## Getting started
### Installation
You can just drop the template you need in your project's folder and start using it straightaway. However, in order to keep everything tidy, you can also make templates accessible from your LaTeX distribution.

#### MiKTeX (Windows)
1. Create a `ROOT` path (e.g., `C:\Libraries\LaTeX`).

2. Place the templates you want to use in a subdirectory of `ROOT\tex\latex` (e.g., `C:\Libraries\LaTeX\tex\latex\teaching`).

3. Register the `ROOT` directory in MiKTeX. To do so, open the `Settings (Admin)` utility, select the `Roots` tab, and add your `ROOT` path (e.g., `C:\Libraries\LaTeX`). Note that the trailing `\tex\latex` must not be included!

4. Finally, switch to the `General` tab and press `Refresh FNDB` to update the file name database.

#### TeX Live (Windows, macOS, Linux)
1. Type the following command on the command prompt or terminal to determine the root path for local files.

  ```
  kpsewhich -var-value=TEXMFHOME
  ```

  In my case, the value of `TEXMFHOME` in macOS is:

  ```
  /Users/jboalml/Library/texmf
  ```

2. You should place the templates you want to use in a subdirectory of `TEXMFHOME/tex/latex/` (e.g., `/Users/jboalml/Library/texmf/tex/latex/teaching/`). You may need to create the folder path. This approach has the advantage that it is not necessary to update the package database as TeX searches your personal `texmf` tree directly.

3. Optionally, you can verify that your distribution is able to find the template using the following command:

  ```
  kpsewhich filename
  ```

  where `filename` stands for the template name (e.g., `teaching.cls`).

#### Troubleshooting
If none of the above options work for you (probably because you are using a different combination of OS and LaTeX distribution), check the following links for alternatives:
- [Where do I place my own .sty or .cls files, to make them available to all my .tex files?](http://tex.stackexchange.com/questions/1137/where-do-i-place-my-own-sty-or-cls-files-to-make-them-available-to-all-my-te)
- [How do I add a .sty file to my MacTeX/TeXShop installation?](http://tex.stackexchange.com/questions/10252/how-do-i-add-a-sty-file-to-my-mactex-texshop-installation)
- [Install custom .cls using TeX Live in local directory.](http://tex.stackexchange.com/questions/96976/install-custom-cls-using-tex-live-in-local-directory)
- [How to make LaTeX see local texmf tree.](http://tex.stackexchange.com/questions/30494/how-to-make-latex-see-local-texmf-tree)
- [How to register my own packages or classes in a separate drive to TeX Live installation?](http://tex.stackexchange.com/questions/20160/how-to-register-my-own-packages-or-classes-in-a-separate-drive-to-tex-live-insta)
- [Create a local texmf tree in MiKTeX.](http://tex.stackexchange.com/questions/69483/create-a-local-texmf-tree-in-miktex)
- [Error: Sorry, but "MiKTeX Configuration Utility" did not succeed.](https://tex.stackexchange.com/questions/265674/miktex-two-things-did-not-succeed)

#### Ubuntu font family
Some templates use the [Ubuntu font family](http://font.ubuntu.com/) for titling. You will find the fonts and installation instructions for TeX Live on macOS and Linux [here](https://github.com/tzwenn/ubuntu-latex-fonts). Note that you will have to reinstall them whenever you update your TeX Live distribution.

Unfortunately, the author does not support installing these fonts in Windows and doing it manually can be quite tricky. For this reason, if Ubuntu fonts cannot be found in your system, the templates that use them will automatically switch to Open Sans, which is a similar alternative.

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

- Default values are highlighted in bold. The single- or double-sided option's default value depends on the template. Therefore, I would suggest that you always explicitly define it.
- As the main font chosen in most templates is rather large, a **font size** of `11pt` is generally recommended over `12pt`.
- **The language option is mandatory**; otherwise the document will not compile. If you need to use more than one language write them one after the other. Bear in mind that the last language you type will be the one selected at the beginning of the document.
- Some templates have additional options:
  ##### `teaching.cls`
  - You can define the purpose of the document (i.e., `notes`, `exercises`, `lab`, `quiz`, `exam`, `solution`, or `report`). Layout and appearance will be automatically set accordingly.
  - If the document is an `exam`, you may use the `nograde` option to remove the grade box from the frontcover.
  - You can override the default logo used (either `comillas-color-h` or `comillas-bw-h`, depending on the document purpose) with `logo=` followed by one of these options (e.g., `logo=icai-color-h`):
  
  | Logo                                         | Color | Layout     | Parameter value    |
  |----------------------------------------------|-------| -----------| -------------------|
  | Universidad Pontificia Comillas              | Color | Vertical   | comillas-color     |
  | Universidad Pontificia Comillas              | Color | Horizontal | comillas-color-h   |
  | Universidad Pontificia Comillas              | B/W   | Vertical   | comillas-bw        |
  | Universidad Pontificia Comillas              | B/W   | Horizontal | comillas-bw-h      |
  | Universidad Pontificia Comillas (old logo)   | Color | Horizontal | comillas-color-old |
  | Universidad Pontificia Comillas (old logo)   | B/W   | Horizontal | comillas-bw-old    |
  | Comillas ICAI                                | Color | Vertical   | icai-color         |
  | Comillas ICAI                                | Color | Horizontal | icai-color-h       |
  | Comillas ICAI                                | B/W   | Vertical   | icai-bw            |
  | Comillas ICAI                                | B/W   | Horizontal | icai-bw-h          |
  | Instituto de Investigación Tecnológica (IIT) | Color | Horizontal | iit-color          |
  | Instituto de Investigación Tecnológica (IIT) | B/W   | Horizontal | iit-bw             |
  | Cátedra de Industria Conectada               | Color | Horizontal | cic-color          |
  | Cátedra de Industria Conectada               | B/W   | Horizontal | cic-bw             |

#### Example
In order to use `teaching.cls` to write some class notes in Spanish you would type:

```
\documentclass[11pt,a4paper,twoside,spanish,notes]{teaching}
```

and to change the default logo:

```
\documentclass[11pt,a4paper,twoside,spanish,notes,logo=icai-color-h]{teaching}
```

#### Sample documents
In each template directory you will find a `samples` folder with skeleton documents to get you started.

#### Troubleshooting
Check the [issues](https://github.com/jboalml/latex/issues) section for common problems and solutions. Let me know the issues you face and your solutions (if you have them) so I can incorporate them to the repository!

## Developers
This repository is developed and maintained by [Jaime Boal](https://github.com/jboalml).

### Acknowledgments
I would like to thank [Romano Giannetti](https://github.com/Rmano) for detecting quite a few bugs and providing feedback on how to improve the `teaching.cls` template.

## License
This repository is licensed under the [GNU General Public License v2.0](LICENSE.txt).

Logos are property of [Comillas Pontifical University](https://www.comillas.edu/). All rights reserved.
