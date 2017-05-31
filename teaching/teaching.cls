% -----------------------------------------------------------------------------------
% -------------------------------- CLASS DESCRIPTION --------------------------------
% -----------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{teaching}[2016/08/24 v1.2.0 Class to produce teaching material]

% -----------------------------------------------------------------------------------
% -------------------------------- LaTeX EXTENSIONS ---------------------------------
% -----------------------------------------------------------------------------------                                    

\RequirePackage{calc}        % Mathematical operations within LaTeX commands
\RequirePackage{etex}        % Extended TeX engine
\RequirePackage{etoolbox}    % Tools for class and package authors
\RequirePackage{expl3}       % LaTeX3 functions
\RequirePackage{iftex}       % Allows to check the TeX engine used
\RequirePackage{iflang}      % Allows to check the language selected                                                          
\RequirePackage{forloop}     % Allows to use for loops
\RequirePackage{xifthen}     % Allows conditionals in LaTeX format
                             % Extends ifthen package (requires etex)
\RequirePackage{xstring}     % Perform operations on strings

% Fix some known LaTeX issues for pre-2015 kernel versions
% http://tex.stackexchange.com/questions/287146/how-to-use-fixltx2e-only-when-necessary
% Allows subindexes in text mode (\textsubscript{})
\begingroup\expandafter\expandafter\expandafter\endgroup
\expandafter\ifx\csname IncludeInRelease\endcsname\relax
  \RequirePackage{fixltx2e}
\fi 

% -----------------------------------------------------------------------------------
% -------------------------------- CLASS PROPERTIES ---------------------------------
% -----------------------------------------------------------------------------------                                    

\newbool{isNotes}
\newbool{isExercises}
\newbool{isLab}
\newbool{isQuiz}
\newbool{isExam}
\newbool{isSolution}
\newbool{isReport}

% Class options
\DeclareOption{notes}{\booltrue{isNotes}}
\DeclareOption{exercises}{\booltrue{isExercises}}
\DeclareOption{lab}{\booltrue{isLab}}
\DeclareOption{quiz}{\booltrue{isQuiz}}
\DeclareOption{exam}{\booltrue{isExam}}
\DeclareOption{solution}{\booltrue{isSolution}}
\DeclareOption{report}{\booltrue{isReport}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}  % Pass unknown options
                                                               % to the base class
\ProcessOptions\relax  % Process given options
\LoadClass{article}    % Load base class          

% -----------------------------------------------------------------------------------
% -------------------------------------- FONTS --------------------------------------
% -----------------------------------------------------------------------------------

% Encoding
\RequirePackage[T1]{fontenc}     % Output: Works for most European languages
\RequirePackage[utf8]{inputenc}  % Input: Allows to type special characters using
                                 % regular keyboard commands. Options: latin1, utf8

\RequirePackage{microtype}  % Enhances presentation subtly (justification...), 
                            % especially in multicolumn environments. If it throws
                            % an error try [protrusion=true, expansion=true]
							                       
% Fonts
\RequirePackage{charter}                  % Serif: Bitstream Charter w/o math support
\RequirePackage[defaultsans]{opensans}    % Sans:  Open Sans
\RequirePackage[varqu,varl]{inconsolata}  % Monospaced: Inconsolata
\RequirePackage{amsfonts}                 % American Mathematical Society fonts
\RequirePackage{upgreek}                  % Upright greek letters

% Use Ubuntu font for titling if installed; otherwise use Open Sans
\IfFileExists{ubuntu.sty}{
  \RequirePackage[none]{ubuntu}
  \providecommand{\titlingfont}{\fontUbuntuMedium}
}{
  \providecommand{\titlingfont}{\fontseries{sb}\fosfamily} 
}

% Other serif fonts
%\RequirePackage{fourier}              % Utopia text with Fourier math
%\RequirePackage{kerkis}               % Extended Bookman
%\RequirePackage{libertine}            % Linux Libertine
%\RequirePackage{pslatex}              % Times New Roman w/ math support
%\RequirePackage{times}                % Times New Roman w/o math support
%\RequirePackage{tgtermes}             % Extended Nimbus Roman
%\RequirePackage[bitstream-charter]{mathdesign}  % Bitstream Charter w/ math support
  %\let\circledS\undefined                       % Prevent incompatibility with amssymb

% Other sans fonts
%\RequirePackage[scaled]{helvet}          % Helvetica scaled (0.95) to match Times New Roman
%\RequirePackage[defaultsans]{cantarell}  % Cantarell
%\RequirePackage[defaultsans]{droidsans}  % Droid Sans

% Monospaced fonts
%\RequirePackage{courier}                 % Courier
%\renewcommand*\ttdefault{lmtt}           % Latin Modern Typewriter

% Fonts accessible via \fontfamily 
% (e.g. \renewcommand\rmdefault{bch} or \fontfamily{bch}\selectfont)
% pag                    Avant Garde
% fve                    Bera Serif
% fvs                    Bitstream Vera Sans
% pbk                    Bookman
% bch                    Charter
% ccr                    Computer Concrete
% cmr                    Computer Modern
% cmtt                   Computer Modern Typewriter
% pcr                    Courier
% mdugm                  Garamond
% phv                    Helvetica
% fi4                    Inconsolata
% jkp                    Kp-font Roman
% jkpss                  Kp-font Sans
% lmr                    Latin Modern
% lmss                   Latin Modern Sans
% lmtt                   Latin Modern Typewriter
% lmvtt                  Latin Modern Typrewriter Proportional
% LinuxBiolinumT-OsF     Linux Biolinum (formerly 'fxb')
% LinuxLibertineT-OsF    Linux Libertine (formerly 'fxl')
% pnc                    New Century Schoolbook
% ppl                    Palatino
% pplx                   Palatino w/ math support (Mathpazo)
% ptm                    Times
% uncl                   Uncial
% futs                   Utopia (also 'put')
% pzc                    Zapf Chancery

% Symbols
\RequirePackage{bbding}
  \let\Cross\relax         % Prevent clash with marvosym due to redefinition of \Cross
\RequirePackage{dictsym}
\RequirePackage{marvosym} 
\RequirePackage{eurosym}   % Must be loaded after marvosym
\RequirePackage{pifont}

% -----------------------------------------------------------------------------------
% ------------------------------------ LANGUAGE -------------------------------------
% -----------------------------------------------------------------------------------

\RequirePackage{csquotes}                 % Smart quotes. Required by babel. 
                                          % Must go after inputenc
\RequirePackage{babel}                    % Language must be passed as a class option
%\RequirePackage[spanish,english]{babel}  % The last language listed is the default
  %\decimalpoint                          % Use decimal point in those languages in
                                          % which it is not the default symbol
  \hyphenation{mi-cro-con-tro-la-do-res}  % Correct hyphenation for selected words
  
  % English names
  \addto\captionsenglish{%
    \def\exercisesname{Exercises}%
    \def\gradename{Grade}%
    \def\groupname{Group}%
    \def\instructionsname{Instructions}%
    \def\labname{Laboratory}%
    \def\notesname{Notes}%
    \def\ofname{of}%
    \def\studentname{Name}%
    \ifbool{isExercises}{%
      \def\sectionname{Exercise}}{%
      \ifboolexpr{bool {isQuiz} or bool {isExam} or bool {isSolution}}{%
        \def\sectionname{Problem}}{%
        \def\sectionname{}%
      }
    }
  }  
  
  % Spanish names
  \addto\captionsspanish{%
    \def\tablename{Tabla}%
    \def\exercisesname{Ejercicios}%
    \def\gradename{Calificación}%
    \def\groupname{Grupo}%
    \def\instructionsname{Instrucciones}%
    \def\labname{Laboratorio}%
    \def\notesname{Apuntes}%
    \def\ofname{de}
    \def\studentname{Nombre}%
    \ifbool{isExercises}{%
      \def\sectionname{Ejercicio}}{%
      \ifboolexpr{bool {isQuiz} or bool {isExam} or bool {isSolution}}{%
        \def\sectionname{Problema}}{%
        \def\sectionname{}%
      }
    }
  }

% -----------------------------------------------------------------------------------
% ----------------------------- USER DEFINED PARAMETERS -----------------------------
% -----------------------------------------------------------------------------------                                    

\providecommand{\theAuthor}{}
\providecommand{\theDate}{}
\providecommand{\theDegree}{}
\providecommand{\theInstructions}{}
\providecommand{\theKeywords}{}
\providecommand{\theSubject}{}
\providecommand{\theTitle}{}

\providecommand{\Author}[1]{\renewcommand{\theAuthor}{#1}}
\providecommand{\Date}[1]{\renewcommand{\theDate}{#1}}
\providecommand{\Degree}[1]{\renewcommand{\theDegree}{#1}}
\providecommand{\Instructions}[1]{\renewcommand{\theInstructions}{#1}}
\providecommand{\Keywords}[1]{\renewcommand{\theKeywords}{#1}}
\providecommand{\Subject}[1]{\renewcommand{\theSubject}{#1}}

% -----------------------------------------------------------------------------------
% ----------------------------------- PAGE LAYOUT -----------------------------------
% -----------------------------------------------------------------------------------

% Margins
% Use option showframe to display the margins
\RequirePackage[left=2cm, right=2cm, top=1.75cm, bottom=2.25cm]{geometry}
\RequirePackage{changepage}  % Allows different margins in selected pages

% Line spacing
\RequirePackage{setspace}    % Keeps single spacing in footnotes, captions...
  \setstretch{1.10}          % Other options: \singlespacing, \onehalfspacing,
                             % and \doublespacing
                             
% Paragraphs    
\RequirePackage[parfill]{parskip}  % Space between paragraphs. Requires to manually
                                   % correct all extra space introduced in headings
\setlength{\parindent}{15pt}       % Indentation. Must go after parskip

% Columns and rows (both in tables and text)
\RequirePackage{multicol}
  \setlength{\columnsep}{1cm}      % Column separation
  \setlength{\columnseprule}{1pt}  % Draw a vertical line to separate columns
\RequirePackage{multirow}
\RequirePackage{vwcol}             % Variable width columns
		
% Avoid hyphenation when possible (-10000 encourage, 10000 forbid)
\hyphenpenalty       =  7500
\tolerance           =  1000
  
% Avoid widow and club lines when possible (-10000 encourage, 10000 forbid)
\widowpenalty        = 10000
\displaywidowpenalty = 10000
\clubpenalty         = 10000
	  
% Ignore layout errors below these thresholds
%\hbadness 1414  % Horizontal badness
%\hfuzz 0.3pt    % Horizontal overfull boxes
%\vfuzz 0.3pt    % Vertical overfull boxes

% ----------------------------------------------------------------------------------- 
% ------------------------------------- COLORS --------------------------------------
% ----------------------------------------------------------------------------------- 

% Use cmyk option for printing could be advisable
\RequirePackage[dvipsnames,hyperref,table]{xcolor}

  % User defined colors
  % \definecolor can be used instead but it overwrites previous color names
  \providecolor{comillas}{RGB}{234,171,0}
  \providecolor{darkblue}{RGB}{0,67,134}  
  \providecolor{darkgreen}{RGB}{0,145,92}
  \providecolor{darkred}{rgb}{.647,.129,.149}
  \providecolor{subtlegray}{gray}{0.9}
  \providecolor{greenC++}{rgb}{0,0.5,0}
  \providecolor{redC++}{rgb}{0.64,0.08,0.08}
  \providecolor{greenMatlab}{rgb}{0.13,0.54,0.13}
  \providecolor{violetMatlab}{rgb}{0.75,0.12,0.95}
  \providecolor{white}{rgb}{1,1,1}

% ----------------------------------------------------------------------------------- 
% ------------------------------------ HEADINGS -------------------------------------
% ----------------------------------------------------------------------------------- 

% Section numbering
\setcounter{secnumdepth}{5}  % Last level numbered (max. 5): subparagraph
				
% Format
\RequirePackage{titlesec}
  %\titleformat{\chapter}[block]{\centering\LARGE\titlingfont\thispagestyle{fancy}}
  %                             {\chaptertitlename~\thechapter . }{0pt}{}
                             
  %\titlespacing*{\chapter}{0pt}{-20pt plus 5pt minus 5pt}{10pt plus 5pt minus 5pt}	
																			
  \titleformat{\section}{\LARGE\titlingfont}
                        {\ifdefempty{\sectionname}{}{\sectionname~}\thesection .}{0.35em}{}
  \titlespacing*{\section}{0pt}{1.75ex plus .5ex minus .5ex}{-0.25ex plus .5ex minus 1ex}
				
  \titleformat{\subsection}{\Large\titlingfont}{\thesubsection .}{0.35em}{}
  \titlespacing*{\subsection}{0pt}{1.25ex plus .5ex minus .5ex}{-0.25ex plus .5ex minus 1ex}

  \titleformat{\subsubsection}{\large\titlingfont}{\thesubsubsection .}{0.35em}{}
  \titlespacing*{\subsubsection}{0pt}{1ex plus .5ex minus .5ex}{0ex plus .25ex minus .25ex}
				
  \titleformat{\paragraph}{\normalsize\titlingfont}{\theparagraph .}{0.35em}{}
  \titlespacing*{\paragraph}{0pt}{.75ex plus .25ex minus .25ex}{0ex plus .25ex minus .25ex}
																
  \titleformat{\subparagraph}{\normalsize\titlingfont}{\thesubparagraph .}{0.35em}{}
  \titlespacing*{\subparagraph}{0pt}{.5ex plus .25ex minus .25ex}{0ex plus .25ex minus .25ex}

% -----------------------------------------------------------------------------------
% ------------------------------ FLOATING ENVIRONMENTS ------------------------------
% -----------------------------------------------------------------------------------

\RequirePackage{float}  % Format options for floats
	
% Images
\RequirePackage[encoding,filenameencoding=latin1]{grffile}  % Path
  \graphicspath{{./images/}}

\RequirePackage{graphicx}
\RequirePackage[export]{adjustbox}  % Allows to put a frame around an image

\ifPDFTeX
  \RequirePackage{epstopdf}  % Convert .eps images to .pdf automatically
    \epstopdfsetup{
      update,    % Only regenerate .pdf files if the .eps file is newer
      prepend,   % Put the .eps extension at the beginning of the graphics list
      suffix =   % Give the resulting .pdf file the same name
    }
\else
  \RequirePackage{epsfig}    % Insert .eps figures
\fi

\RequirePackage[labelformat=simple]{subfig}               % Subfigures
  \renewcommand\thesubfigure{(\alph{subfigure})}          % Autoreference format
  \newcommand{\subfigureautorefname}{\figureautorefname}  % (e.g. Figure 1(b))
  
\RequirePackage{wrapfig}     % Wrap text around figures

\RequirePackage{caption}     % Captions
  \captionsetup{
    font          = small, 
    labelfont     = bf, 
    labelsep      = period, 
    justification = justified, 
    textfont      = small
  }
 	
% Penalize isolated floats	
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}
			
% Tables	
\RequirePackage{array}	            % Column size and alignment options

  % Define left, center and right aligned columns with fixed width
  \newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
  \newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
  \newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
  
\RequirePackage{booktabs}           % Table format
%\RequirePackage{hhline}            % Additional line formats
%  \doublerulesepcolor[rgb]{1,1,1}  % Correct color in tables with double lines
                                    % Requires xcolor
\RequirePackage{tabularx}           % Specify the table width. Requires array
\RequirePackage{xtab}               % Allows tables spanning over multiple pages

% Lists
\RequirePackage{enumitem}
  \setitemize{  % Use \setenumerate, \setdescription, or \setlist for other lists
    itemsep   = 0pt, 
    topsep    = 0pt, 
    partopsep = 0pt
  }  
                                                      
  %\renewcommand{\labelitemi}{\tiny$\blacksquare$}  % Change default bullet points
                                                       
% Equations
\interdisplaylinepenalty = 2500  % Allow page breaks for multiline equations 
                                 % (-10000 encourage, 10000 forbid)                                                 

% Rotate flots            
\RequirePackage{rotating}  % Must be loaded after graphicx

% -----------------------------------------------------------------------------------
% ------------------------------------ FOOTNOTES ------------------------------------
% -----------------------------------------------------------------------------------
	
% Format
\RequirePackage[bottom]{footmisc}  % Must be loaded before fancyhdr
  \renewcommand{\footnoterule}{\noindent\rule{2in}{0.4pt}\vspace{5pt}}
  
\RequirePackage{tablefootnote}     % Easily add footnotes in tables.
                                   % Must be loaded after rotating
	
% Prevent footnote splitting (-10000 encourage, 10000 forbid)
\interfootnotelinepenalty = 10000

% -----------------------------------------------------------------------------------
% -------------------------------------- CODE ---------------------------------------
% -----------------------------------------------------------------------------------  

\RequirePackage{verbatim}

\RequirePackage{listings}
  \lstset{
    inputencoding = utf8,  % Input encoding
    extendedchars = true,  % Extended ASCII
    texcl         = true,  % Activate LaTeX commands in comments
    mathescape    = true   % Mathematical expressions between $
    captionpos    = b,     % Caption position
    literate      =        % Support additional characters
      {á}{{\'a}}1  {é}{{\'e}}1  {í}{{\'i}}1 {ó}{{\'o}}1  {ú}{{\'u}}1
      {Á}{{\'A}}1  {É}{{\'E}}1  {Í}{{\'I}}1 {Ó}{{\'O}}1  {Ú}{{\'U}}1
      {à}{{\`a}}1  {è}{{\`e}}1  {ì}{{\`i}}1 {ò}{{\`o}}1  {ù}{{\`u}}1
      {À}{{\`A}}1  {È}{{\'E}}1  {Ì}{{\`I}}1 {Ò}{{\`O}}1  {Ù}{{\`U}}1
      {ä}{{\"a}}1  {ë}{{\"e}}1  {ï}{{\"i}}1 {ö}{{\"o}}1  {ü}{{\"u}}1
      {Ä}{{\"A}}1  {Ë}{{\"E}}1  {Ï}{{\"I}}1 {Ö}{{\"O}}1  {Ü}{{\"U}}1
      {â}{{\^a}}1  {ê}{{\^e}}1  {î}{{\^i}}1 {ô}{{\^o}}1  {û}{{\^u}}1
      {Â}{{\^A}}1  {Ê}{{\^E}}1  {Î}{{\^I}}1 {Ô}{{\^O}}1  {Û}{{\^U}}1
      {œ}{{\oe}}1  {Œ}{{\OE}}1  {æ}{{\ae}}1 {Æ}{{\AE}}1  {ß}{{\ss}}1
      {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1  {å}{{\r a}}1 {Å}{{\r A}}1
      {ñ}{{\~n}}1  {Ñ}{{\~N}}1  {¿}{{?`}}1  {¡}{{!`}}1
      % ¿ and ¡ are not correctly displayed if inconsolata font is used
      % together with the lstlisting environment. Consider typing code in
      % external files and using \lstinputlisting to display them instead.      
  }
			
  % Visual C++
  \providecommand{\VisualCpp}{
    \lstset{
      language          = [Visual]C++,           % Language
      basicstyle        = \ttfamily\small,       % Default format          
      keywordstyle      = \color{blue},          % Keyword format							
      commentstyle      = \color{greenC++},      % Comment format
      stringstyle       = \color{redC++},        % String format
      breaklines        = true,                  % Automatic line breaks
      breakatwhitespace = true,	                 % Line breaks only at white spaces
      tabsize           = 3,                     % Number of spaces equal to a tab
      showspaces        = false,                 % Show spaces in the code
      showtabs          = false,                 % Show tabs in the code
      showstringspaces  = false,                 % Show spaces among strings
      %backgroundcolor  = \color{white},         % Background color
      %numbers          = left,                  % Line number positioning
      %numberstyle      = \footnotesize,         % Line number format
      %numbersep        = 10pt,                  % Line number and code separation
      %firstnumber      = auto,                  % Display number in the first row
      %stepnumber       = 10,                    % Gap between two numbered lines
    }
  }
			
  % Matlab
  \providecommand{\Matlab}{
    \lstset{
      language          = Matlab,                % Language
      basicstyle        = \ttfamily\small,       % Default format 
      keywordstyle      = \color{black},         % Keyword format						
      commentstyle      = \color{greenMatlab},   % Comment format
      stringstyle       = \color{violetMatlab},  % String format
      breaklines        = true,                  % Automatic line breaks
      breakatwhitespace = true,                  % Line breaks only at white spaces
      tabsize           = 4,                     % Number of spaces equal to a tab
      showspaces        = false,                 % Show spaces in the code
      showtabs          = false,                 % Show tabs in the code
      showstringspaces  = false,                 % Show spaces among strings
      %backgroundcolor  = \color{white},         % Background color
      %numbers          = left,                  % Line number positioning
      %numberstyle      = \footnotesize,         % Line number format
      %numbersep        = 10pt,                  % Line number and code separation
      %firstnumber      = auto,                  % Display number in the first row
      %stepnumber       = 10,                    % Gap between two numbered lines
    }
  }

% Define a floating environment for code
\newfloat{code}{htbp}{loc}
  \addto\captionsenglish{\floatname{code}{Code}}
  \addto\captionsspanish{\floatname{code}{Código}}

% -----------------------------------------------------------------------------------
% ------------------------------- HEADERS AND FOOTERS -------------------------------
% -----------------------------------------------------------------------------------

% Margins
\setlength{\voffset}{5pt}         % Space from the top of the page (1in + \voffset)
\setlength{\headheight}{46pt}     % Header height
\setlength{\headsep}{20pt}        % Separation between the header and the body
\addtolength{\textheight}{-30pt}  % Footer height (space removed from the body)
\setlength{\footskip}{25pt}       % Footer height + Distance to the body.
                                  % The difference with the previous parameter should
                                  % be kept more or less constant (55pt) to preserve
                                  % the appearance

% Format
\RequirePackage{fancyhdr}

  % Separating rules
  \renewcommand{\headrulewidth}{0.8pt} 
  \renewcommand{\footrulewidth}{0.4pt}

  % Regular header and footer
  \pagestyle{fancy}
    \fancyhf{}  % Clear current header and footer
    
    \ifboolexpr{bool {isQuiz} or bool {isExam} or bool {isSolution} or bool {isReport}}{
      \fancyhead[RE,LO]{\includegraphics[width = 3cm]{images/logo-bw.pdf}}
    }{
      \fancyhead[RE,LO]{\includegraphics[width = 3cm]{images/logo-color.pdf}}
    }
	  
    \newcommand{\thesubheader}{}
    \newcommand{\subheader}[1]{\renewcommand{\thesubheader}{#1}}	  
	  
    \fancyhead[RO]{
      \raggedleft\titlingfont
      \Large\color{darkblue} \MakeUppercase{\theSubject}\linebreak
      \large\color[gray]{0.6} \MakeUppercase{\thesubheader}%
    }

    \fancyhead[LE]{
      \raggedright\titlingfont
      \Large\color{darkblue} \MakeUppercase{\theSubject}\linebreak
      \large\color[gray]{0.6} \MakeUppercase{\thesubheader}%
    } 
	  
    \providecommand{\thefooter}{}
    \providecommand{\footer}[1]{\renewcommand{\thefooter}{#1}}  
	  
    \fancyfoot[LO,RE]{\small \textbf{\thefooter}\linebreak \theDate}
    \ifboolexpr{bool {isQuiz} or bool {isExam} or bool {isSolution}}{
      \RequirePackage{lastpage}
      \fancyfoot[RO,LE]{\thepage~\ofname~\pageref*{LastPage}} % With \pageref* LastPage
                                                              % will not be a link
    }{
      \fancyfoot[RO,LE]{\thepage}
    }

  \fancypagestyle{plain}{
    \fancyhead{}            % Clear the header
  }
									 
\RequirePackage{emptypage}	% Blank pages should not have neither header nor footer
  
% -----------------------------------------------------------------------------------
% ----------------------------------- MATHEMATICS -----------------------------------
% -----------------------------------------------------------------------------------  

% American Mathematical Society macros
\RequirePackage[cmex10]{amsmath}  % cmex10 ensures only type 1 fonts will be used
\RequirePackage{amssymb}          % Symbols
\RequirePackage{amsthm}           % For theorems

\RequirePackage{cancel}           % Cancel equation terms
\RequirePackage{mathtools}        % Starred versions of matrix environments
\RequirePackage{xfrac}            % Fraction formats  
				
% Additional mathematical operators	
\DeclareMathOperator{\sen}{sen}
\DeclareMathOperator{\ctg}{ctg}
\DeclareMathOperator{\arcctg}{arcctg}
\DeclareMathOperator{\atan}{atan}

% Additional mathematical macros
\providecommand{\Partial}[2]{\frac{\partial\, #1}{\partial\, #2}}

% -----------------------------------------------------------------------------------
% -------------------------------------- UNITS --------------------------------------
% -----------------------------------------------------------------------------------

% Text units
\renewcommand{\textohm}{\ensuremath{\Omega}}

\RequirePackage[tight,nice]{units}   % Simple units
\RequirePackage{siunitx}             % Advanced units
  \sisetup{
    detect-all,                      % Use the current font and weight
    retain-explicit-plus,            % Display leading plus sign if present
    per-mode         = symbol,       % Use a slash to indicate units in the denominator
    range-phrase     = --,           % Use an en-dash for ranges
    output-product   = \cdot,        % Use a centered dot for products
    exponent-product = \cdot         % Use a centered dot for scientific notation
  }
  
  % Spanish language specific options
  \IfStrEq*{\languagename}{spanish}{
    \sisetup{output-decimal-marker = {,}}  % Use decimal comma
  }{}
  
  % Additional units   
  \DeclareSIUnit{\fahrenheit}{\SIUnitSymbolDegree F}
  \DeclareSIUnit{\degreeFahrenheit}{\fahrenheit}
  \DeclareSIUnit{\ntu}{NTU}          % Nephelometric Turbidity Unit
  \DeclareSIUnit{\ohm}{\ensuremath{\Omega}}
  \renewcommand{\SIUnitSymbolMicro}{\ensuremath{\upmu}}

% -----------------------------------------------------------------------------------
% ----------------------------------- MISCELLANY ------------------------------------
% ----------------------------------------------------------------------------------- 

\RequirePackage{comment}             % Comment text out
\RequirePackage{pdfpages}            % Attach .pdf files
\RequirePackage{tikz}                % Vector graphics
  \usetikzlibrary{babel}             % Solves a clash between babel and PGF/TikZ 3.0.0 (http://tex.stackexchange.com/questions/166772/problem-with-babel-and-tikz-using-draw)
\RequirePackage[normalem]{ulem}      % Underlining
\RequirePackage[os=win]{menukeys}    % Keyboard like keys
  \renewmenumacro{\directory}[/]{pathswithfolder}

% -----------------------------------------------------------------------------------
% -------------------------------- CROSS-REFERENCES ---------------------------------
% -----------------------------------------------------------------------------------

\ifPDFTeX
  \RequirePackage[pdftex]{hyperref}  % Must be loaded at the end
\else
  \RequirePackage{hyperref}
\fi
  \hypersetup{
    pdffitwindow       = true,
    pdftitle           = \theTitle,
    pdfauthor          = \theAuthor,
    pdfsubject         = \theSubject,
    pdfkeywords        = \theKeywords,
    pdfnewwindow       = true,
    colorlinks         = true,
    citecolor          = black,
    filecolor          = black,
    linkcolor          = black,
    urlcolor           = blue,
    breaklinks         = true,
    linktocpage        = false,
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    bookmarksopenlevel = 1
  }
  
\RequirePackage[all]{hypcap}  % Correct hyperlink anchors position in floats.
                              % Must be loaded after hyperref

% Modify automatic reference names
\addto\extrasenglish{%
  \def\partautorefname{Part}%
  \def\chapterautorefname{Chapter}%
  \ifbool{isExercises}{%
    \def\sectionautorefname{Exercise}}{%
    \ifboolexpr{bool {isQuiz} or bool {isExam} or bool {isSolution}}{%
      \def\sectionautorefname{Problem}}{%
      \def\sectionautorefname{Section}%
    }
  }
  \def\subsectionautorefname{Section}%
  \def\subsubsectionautorefname{Section}%
  \def\figureautorefname{Figure}%
  \def\tableautorefname{Table}%
  \def\equationautorefname{Equation}%
  \def\codeautorefname{Code}%
} 

\addto\extrasspanish{%
  \def\partautorefname{Parte}%
  \def\chapterautorefname{Capítulo}%
  \ifbool{isExercises}{%
    \def\sectionautorefname{Ejercicio}}{%
    \ifboolexpr{bool {isQuiz} or bool {isExam} or bool {isSolution}}{%
      \def\sectionautorefname{Problema}}{%
      \def\sectionautorefname{Sección}%
    }
  }
  \def\subsectionautorefname{Sección}%
  \def\subsubsectionautorefname{Sección}%
  \def\figureautorefname{Figura}%
  \def\tableautorefname{Tabla}%
  \def\equationautorefname{Ecuación}%
  \def\codeautorefname{Código}%
}

% -----------------------------------------------------------------------------------
% ------------------------------- USER DEFINED MACROS -------------------------------
% -----------------------------------------------------------------------------------                                    

\RequirePackage{macros}

% Title[Optional additional information]{Title}
\providecommand{\Title}[2][]{
  {%
    \noindent\titlingfont\huge\centering #2\\%
    \ifblank{#1}{}{%
      \vspace{2pt}%
      \Large (#1)\\%
    }%
    \vspace{0.5cm}
  }%
  
  % Subheader
  \ifbool{isNotes}{\subheader{\notesname}}{
    \ifbool{isExercises}{\subheader{\exercisesname}}{
      \ifbool{isLab}{\subheader{\labname}}{
        \ifboolexpr{bool {isQuiz} or bool {isExam} or bool {isSolution} or bool {isReport}}{\subheader{\theDegree}}{
        }
      }
    }
  }
  
  % Footer and PDF information
  \renewcommand{\theTitle}{#2}
  \footer{\theTitle}
  
  % Student data
  \ifboolexpr{bool {isQuiz} or bool {isExam}}{
    \vspace{0.5cm}
    \noindent
    \begin{tabularx}{\linewidth}{@{}Xr@{}}
      \textbf{\studentname:}~\line(1,0){325} & \textbf{\groupname:}~\line(1,0){45}
    \end{tabularx}{\parfillskip=0pt\par}
    \vspace{0.25cm plus 0.25cm minus 0.25cm}
  }{}
    
  % Instructions 
  \ifboolexpr{bool {isQuiz} or bool {isExam}}{
    \ifdefempty{\theInstructions}{}{
      \ifbool{isExam}{\vspace{1cm}}{}
      \ifbool{isQuiz}{\vspace{0.75cm}}{}
    
      {\noindent\centering\titlingfont\LARGE \MakeUppercase{\instructionsname}\\}
    
      \vspace{0.75cm}
    
      \begin{itemize}[leftmargin=*]
        \theInstructions
      \end{itemize} 
    }
  }{}
  
  % Spacing
  \ifbool{isExam}{\vfill}{}
  \ifbool{isQuiz}{\vspace{0.5cm}}{}
      
  % Grade
  \ifbool{isExam}{     
    \begin{flushright}
      \Large\textbf{\gradename:} \hspace{0.25cm} 
      \fbox{
        \begin{minipage}{2.5cm}
          \hfill \vspace{1.25cm}
        \end{minipage}
      }
    \end{flushright}
    
    \vspace{0.75cm}
    
    \cleardoublepage
  }{}
}
