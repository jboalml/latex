% -----------------------------------------------------------------------------------
% -------------------------------- CLASS DESCRIPTION --------------------------------
% -----------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{teaching}[2019/09/01 v1.5.0 Class to produce teaching material]

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

\RequirePackage{kvoptions}   % Key-value class and package options
  %\SetupKeyvalOptions{      % Modify family name and prefix
  %  family = teaching,      % Defaults to class or package name if not set
  %  prefix = teaching@
  %}

% Class options
\DeclareBoolOption{exam}
\DeclareBoolOption{exercises}
\DeclareBoolOption{lab}
\DeclareBoolOption{notes}
\DeclareBoolOption{quiz}
\DeclareBoolOption{report}
\DeclareBoolOption{solution}

\DeclareBoolOption[false]{nograde}  % Remove grade box in exams

\DeclareBoolOption{circuitikz}  % Enable circuitikz customizations

\DeclareStringOption[]{logo}[]  % Set to \empty if option not provided (first [])
                                % or given without value (second [])

% Pass unknown options to the base class
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessKeyvalOptions*  % Process given options
\LoadClass{article}     % Load base class    

% Select default value for logo
\ifx\teaching@logo\empty
  \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam} or bool {teaching@solution} or bool {teaching@report}}{
    \setkeys{teaching}{logo=comillas-bw-h}
  }{
    \setkeys{teaching}{logo=comillas-color-h}
  }      
\fi

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
\RequirePackage{XCharter}                 % Serif: Bitstream Charter w/o math support (includes oldstyle and superior figures, and small caps)
\RequirePackage[defaultsans]{opensans}    % Sans: Open Sans
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
%\RequirePackage{charter}              % Bitstream Charter w/o math support
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
  \let\Cross\relax            % Prevent clash with marvosym due to redefinition of \Cross
\RequirePackage{dictsym}
\RequirePackage{fontawesome}
\RequirePackage{marvosym} 
\RequirePackage{eurosym}      % Must be loaded after marvosym
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
    \def\authorname{Author}%
    \def\authorsname{Authors}%
    \def\bibname{References}%
    \def\exercisesname{Exercises}%
    \def\gradename{Grade}%
    \def\groupname{Group}%
    \def\instructionsname{Instructions}%
    \def\labname{Laboratory}%
    \def\notesname{Notes}%
    \def\ofname{of}%
    \def\studentname{Name}%
    \ifbool{teaching@exercises}{%
      \def\sectionname{Exercise}}{%
      \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam} or bool {teaching@solution}}{%
        \def\sectionname{Problem}}{%
        \def\sectionname{}%
      }
    }
  }  
  
  % Spanish names
  \addto\captionsspanish{%
    \def\tablename{Tabla}%
    \def\authorname{Autor}%
    \def\authorsname{Autores}%
    \def\bibname{Referencias}%
    \def\exercisesname{Ejercicios}%
    \def\gradename{Calificación}%
    \def\groupname{Grupo}%
    \def\instructionsname{Instrucciones}%
    \def\labname{Laboratorio}%
    \def\notesname{Apuntes}%
    \def\ofname{de}
    \def\studentname{Nombre}%
    \ifbool{teaching@exercises}{%
      \def\sectionname{Ejercicio}}{%
      \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam} or bool {teaching@solution}}{%
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
  \providecolor{yellowComillas}{RGB}{225,184,28}
  \providecolor{grayComillas}{RGB}{83,86,90}
  \providecolor{blueComillasIcai}{RGB}{0,53,148}
  \providecolor{redComillasIcade}{RGB}{164,18,63}
  \providecolor{blueComillasCihs}{RGB}{123,164,219}
  \providecolor{darkblue}{RGB}{0,67,134}  
  \providecolor{darkgreen}{RGB}{0,145,92}
  \providecolor{darkred}{rgb}{.647,.129,.149}
  \providecolor{subtlegray}{gray}{0.9}
  \providecolor{greenC++}{rgb}{0,0.5,0}
  \providecolor{redC++}{rgb}{0.64,0.08,0.08}
  \providecolor{grayPython}{gray}{0.4}
  \providecolor{greenPython}{rgb}{0,0.5,0}
  \providecolor{orangePython}{HTML}{CC7832}
  \providecolor{violetPython}{rgb}{0.75,0.12,0.95}
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
  
\RequirePackage{etaremune}       % Reverse-counting enumerate
                                                       
% Equations
\interdisplaylinepenalty = 2500  % Allow page breaks for multiline equations 
                                 % (-10000 encourage, 10000 forbid)                                                 

% Rotate floats            
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
% -------------------------------------- PLOTS --------------------------------------
% -----------------------------------------------------------------------------------

% Vector graphics
\RequirePackage{tikz}  
  \usetikzlibrary{arrows.meta}       % Arrow tips              
  \usetikzlibrary{babel}             % Solves a clash between babel and PGF/TikZ 3.0.0 (http://tex.stackexchange.com/questions/166772/problem-with-babel-and-tikz-using-draw)
  \usetikzlibrary{calc}              % Make complex coordinate calculations
  \usetikzlibrary{positioning}       % Relative node positioning
  \usetikzlibrary{shapes.arrows}     % Arrow shape nodes
  \usetikzlibrary{shapes.geometric}  % Geometric shape nodes
  
% Plots
\RequirePackage{pgfplots}
  \pgfplotsset{compat=1.16}
  
% -----------------------------------------------------------------------------------
% ------------------------------------ CIRCUITS -------------------------------------
% -----------------------------------------------------------------------------------

\ifbool{teaching@circuitikz}{
  \RequirePackage[RPvoltages,american,cuteinductors,siunitx]{circuitikz}

    % Line thickness
    \ctikzset{monopoles/ground/thickness=1}
    \ctikzset{bipoles/thickness=1}
    \ctikzset{tripoles/thickness=1}
    \ctikzset{quadpoles/thickness=1}
    \ctikzset{multipoles/thickness=1}
    \tikzstyle{every path}=[line width=0.75pt, line join=rect, line cap=butt]
  
    % Font dimension
    \tikzstyle{every node}=[font=\small]
    
    % Base component size
    \ctikzset{bipoles/length=1.25cm}
    
    % Pasive components
    \ctikzset{capacitors/scale=0.7}
    \ctikzset{resistors/scale=0.8}
    
    % Diodes
    \ctikzset{bipoles/diode/height=0.225}
	  \ctikzset{bipoles/diode/width=0.225}
	  \ctikzset{bipoles/bidirectionaldiode/height=0.8}
	  \ctikzset{bipoles/bidirectionaldiode/width=0.8}
	  \ctikzset{bipoles/bidirectionaldiode/diode width left=0.225}
		\ctikzset{bipoles/bidirectionaldiode/diode width right=0.225}
    
    % Power supply arrows  
    \ctikzset{monopoles/vcc/width=0.25}
    \ctikzset{monopoles/vcc/arrow={Latex}}
    \ctikzset{monopoles/vee/arrow={Latex}}
  
    % Operational amplifiers
    \ctikzset{tripoles/op amp/font=\fontsize{6}{0}\selectfont\boldmath}  % + and - font size
    \ctikzset{tripoles/op amp/height=1.25}             % Total height
    \ctikzset{tripoles/op amp/width=2.0}               % Total width (including ports)
    \ctikzset{tripoles/op amp/input height=0.6}        % Input port separation
    \ctikzset{tripoles/op amp/port width=0.6}          % Port length (1 = None, 0 = All) 
    \ctikzset{tripoles/op amp/up pos=0.5}              % Top and bottom anchor position
    
    % Fully differential operational amplifiers
    \ctikzset{tripoles/fd op amp/font=\fontsize{6}{0}\selectfont\boldmath}  % + and - font size
    \ctikzset{tripoles/fd op amp/height=1.25}          % Total height
    \ctikzset{tripoles/fd op amp/width=2.0}            % Total width (including ports)
    \ctikzset{tripoles/fd op amp/input height=0.6}     % Input port separation
    \ctikzset{tripoles/fd op amp/output height=0.4}    % Output port separation
    \ctikzset{tripoles/fd op amp/port width=0.6}       % Port length (1 = None, 0 = All) 
    \ctikzset{tripoles/fd op amp/up pos=0.5}           % Top and bottom anchor position
    
    % Transconductance amplifiers
    \ctikzset{tripoles/gm amp/font=\fontsize{6}{0}\selectfont\boldmath}  % + and - font size
    \ctikzset{tripoles/gm amp/height=1.25}             % Left height
    \ctikzset{tripoles/gm amp/height 2=0.5}            % Right height
    \ctikzset{tripoles/gm amp/width=1.625}             % Total width (including ports)
    \ctikzset{tripoles/gm amp/input height=0.6}        % Input port separation
    \ctikzset{tripoles/gm amp/port width=0.55}         % Port length (1 = None, 0 = All) 
    \ctikzset{tripoles/gm amp/up pos=0.5}              % Top and bottom anchor position
    
    % Instrumentation amplifiers
    \ctikzset{tripoles/inst amp/font=\fontsize{6}{0}\selectfont\boldmath}  % + and - font size
    \ctikzset{tripoles/inst amp/height=1.25}           % Left height
    \ctikzset{tripoles/inst amp/height 2=0.6}          % Right height
    \ctikzset{tripoles/inst amp/width=1.625}           % Total width (including ports)
    \ctikzset{tripoles/inst amp/input height=0.6}      % Input port separation
    \ctikzset{tripoles/inst amp/port width=0.6}        % Port length (1 = None, 0 = All) 
    \ctikzset{tripoles/inst amp/up pos=0.5}            % Top and bottom anchor position
    \ctikzset{tripoles/inst amp/refv pos=0.8}          % Top and bottom reference position
    
    % Fully differential instrumentation amplifiers
    \ctikzset{tripoles/fd inst amp/font=\fontsize{6}{0}\selectfont\boldmath}  % + and - font size
    \ctikzset{tripoles/fd inst amp/height=1.25}        % Left height
    \ctikzset{tripoles/fd inst amp/height 2=0.6}       % Right height
    \ctikzset{tripoles/fd inst amp/width=1.625}        % Total width (including ports)
    \ctikzset{tripoles/fd inst amp/input height=0.6}   % Input port separation
    \ctikzset{tripoles/fd inst amp/output height=0.4}  % Output port separation
    \ctikzset{tripoles/fd inst amp/port width=0.6}     % Port length (1 = None, 0 = All) 
    \ctikzset{tripoles/fd inst amp/up pos=0.5}         % Top and bottom anchor position
    \ctikzset{tripoles/fd inst amp/refv pos=0.8}       % Top and bottom reference position
    
    % Instrumentation amplifiers with gain resistor terminals
    \ctikzset{tripoles/inst amp ra/font=\fontsize{6}{0}\selectfont\boldmath}  % + and - font size
    \ctikzset{tripoles/inst amp ra/height=2}           % Left height
    \ctikzset{tripoles/inst amp ra/height 2=0.6}       % Right height
    \ctikzset{tripoles/inst amp ra/width=2.2}          % Total width (including ports)
    \ctikzset{tripoles/inst amp ra/input height=0.75}  % Input port separation
    \ctikzset{tripoles/inst amp ra/port width=0.6}     % Port length (1 = None, 0 = All) 
    \ctikzset{tripoles/inst amp ra/up pos=0.5}         % Top and bottom anchor position
    \ctikzset{tripoles/inst amp ra/refv pos=0.8}       % Top and bottom reference position
    \ctikzset{tripoles/inst amp ra/ra pos=0.5}         % Gain resistor terminals
    
    % Plain amplifiers
    \ctikzset{tripoles/plain amp/height=1.25}          % Total height
    \ctikzset{tripoles/plain amp/width=2}              % Total width (including ports)
    \ctikzset{tripoles/plain amp/input height=0.6}     % Input port separation
    \ctikzset{tripoles/plain amp/port width=0.6}       % Port length (1 = None, 0 = All) 
    \ctikzset{tripoles/plain amp/up pos=0.5}           % Top and bottom anchor position
}{}

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
      {°}{{\textdegree}}1 {º}{{\textordmasculine}}1 {ª}{{\textordfeminine}}1
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
  
  % Python
  \providecommand{\Python}{
    \lstset{
      language          = Python,                 % Language
      basicstyle        = \ttfamily\small,        % Default format 
      keywordstyle      = \color{orangePython},   % Keyword format						
      commentstyle      = \color{greenPython},    % Comment format
      stringstyle       = \color{violetPython},   % String format
      breaklines        = true,                   % Automatic line breaks
      breakatwhitespace = true,                   % Line breaks only at white spaces
      tabsize           = 4,                      % Number of spaces equal to a tab
      showspaces        = false,                  % Show spaces in the code
      showtabs          = false,                  % Show tabs in the code
      showstringspaces  = false,                  % Show spaces among strings
      %backgroundcolor  = \color{white},          % Background color
      %numbers          = left,                   % Line number positioning
      %numberstyle      = \footnotesize,          % Line number format
      %numbersep        = 10pt,                   % Line number and code separation
      %firstnumber      = auto,                   % Display number in the first row
      %stepnumber       = 10,                     % Gap between two numbered lines
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
    
    \fancyhead[RE,LO]{\includegraphics[height = 1.15cm]{images/\teaching@logo.pdf}}
    
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
    \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam} or bool {teaching@solution}}{
      \RequirePackage{lastpage}
      \fancyfoot[RO,LE]{\thepage~\ofname~\pageref*{LastPage}} % With \pageref* LastPage
                                                              % will not be a link
    }{
      \fancyfoot[RO,LE]{\thepage}
    }

  \fancypagestyle{plain}{
    \fancyhead{}            % Clear the header
  }
  
% Add frontmatter, mainmatter and backmatter commands (adapted from the book class)
\makeatletter
  \providecommand\frontmatter{%
    \cleardoublepage
    \pagenumbering{roman}
  }

  \providecommand\mainmatter{
    \cleardoublepage
    \pagenumbering{arabic}
  }

  \providecommand\backmatter{%
    \if@openright
      \cleardoublepage
    \else
      \clearpage
    \fi
  }
\makeatother
									 
\RequirePackage{emptypage}	% Blank pages should not have neither header nor footer

% Place text anywhere on the page
\RequirePackage[absolute]{textpos}
  \setlength{\TPHorizModule}{\paperwidth}
	\setlength{\TPVertModule}{\paperheight - \voffset}
  
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
\providecommand{\cspace}{\hspace{1pt}}                         % Space betweeen variables
\providecommand{\Partial}[2]{\frac{\partial #1}{\partial #2}}  % Partial derivative

% -----------------------------------------------------------------------------------
% -------------------------------------- UNITS --------------------------------------
% -----------------------------------------------------------------------------------

% Text units
\renewcommand{\textohm}{\ensuremath{\Omega}}

\RequirePackage{siunitx}             % Advanced units
  \sisetup{
    detect-all,                      % Use the current font and weight
    retain-explicit-plus,            % Display leading plus sign if present
    per-mode         = symbol,       % Use a slash to indicate units in the denominator
    range-phrase     = --,           % Use an en-dash for ranges
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

% -----------------------------------------------------------------------------------
% ---------------------------------- BIBLIOGRAPHY -----------------------------------
% ----------------------------------------------------------------------------------- 

\RequirePackage[backend=biber,
            %bibstyle=ieee, %ieee-alphabetic
            bibencoding=utf8,
            bibstyle=ieee, % ieee-alphabetic
            %citestyle=alphabetic,
            %citestyle=numeric-comp,
            natbib=true,
            hyperref=true,
            url=true,
            doi=false,
            isbn=false,
            backref=false,
            block=none, %space
            maxcitenames=2,
            mincitenames=1
            %maxnames=2,
            %maxbibnames=10,
            %minbibnames=10
            ]{biblatex} 
            
\RequirePackage{xpatch}
  \xpatchbibdriver{online}{
    \printtext[parens]{\usebibmacro{date}}
  }{
    \iffieldundef{year}{}{
      \printtext[parens]{\usebibmacro{date}}
    }
  }{}{
    \typeout{There was an error patching biblatex-ieee (specifically, ieee.bbx's @online driver)}
  }

\renewcommand{\bibfont}{\normalfont\small}

% -----------------------------------------------------------------------------------
% ----------------------------------- MISCELLANY ------------------------------------
% ----------------------------------------------------------------------------------- 

% Keyboard like keys
\RequirePackage[os=win]{menukeys}    
  \renewmenumacro{\directory}[/]{pathswithfolder}

\RequirePackage{comment}             % Comment text out
\RequirePackage{pdfpages}            % Attach .pdf files
\RequirePackage{qrcode}              % Generate QR codes
\RequirePackage[normalem]{ulem}      % Underlining


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
  \ifbool{teaching@exercises}{%
    \def\sectionautorefname{Exercise}}{%
    \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam} or bool {teaching@solution}}{%
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
  \ifbool{teaching@exercises}{%
    \def\sectionautorefname{Ejercicio}}{%
    \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam} or bool {teaching@solution}}{%
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
      \ifbool{teaching@report}{%
      	\Large #1\\%
      }{%
        \Large (#1)\\%
      }%
    }%
    \vspace{0.5cm}
  }%
  
  % Subheader
  \ifbool{teaching@notes}{\subheader{\notesname}}{
    \ifbool{teaching@exercises}{\subheader{\exercisesname}}{
      \ifbool{teaching@lab}{\subheader{\labname}}{
        \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam} or bool {teaching@solution} or bool {teaching@report}}{\subheader{\theDegree}}{
        }
      }
    }
  }
  
  % Footer and PDF information
  \renewcommand{\theTitle}{#2}
  \footer{\theTitle}
  
  % Student data
  \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam}}{
    \vspace{0.5cm}
    \noindent
    \begin{tabularx}{\linewidth}{@{}Xr@{}}
      \textbf{\studentname:}~\line(1,0){325} & \textbf{\groupname:}~\line(1,0){45}
    \end{tabularx}{\parfillskip=0pt\par}
    \vspace{0.25cm plus 0.25cm minus 0.25cm}
  }{}
    
  % Instructions 
  \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam}}{
    \ifdefempty{\theInstructions}{}{
      \ifbool{teaching@exam}{\vspace{1cm}}{}
      \ifbool{teaching@quiz}{\vspace{0.75cm}}{}
    
      {\noindent\centering\titlingfont\LARGE \MakeUppercase{\instructionsname}\\}
    
      \vspace{0.75cm}
    
      \begin{itemize}[leftmargin=*]
        \theInstructions
      \end{itemize} 
    }
  }{}
  
  % Spacing
  \ifbool{teaching@exam}{\vfill}{}
  \ifbool{teaching@quiz}{\vspace{0.5cm}}{}
      
  % Grade
  \ifbool{teaching@exam}{   
    \ifbool{teaching@nograde}{}{  
      \begin{flushright}
        \Large\textbf{\gradename:} \hspace{0.25cm} 
        \fbox{
          \begin{minipage}{2.5cm}
            \hfill \vspace{1.25cm}
          \end{minipage}
        }
      \end{flushright}
    
      \vspace{0.75cm}
    }
    
    \cleardoublepage
  }{}
}

% Frontcover[Logo]{Title}{Subtitle}{Pretitle}
\providecommand{\Frontcover}[4][comillas-color]{
  {%
    \thispagestyle{empty}{
      \newgeometry{left=2.5cm, right=2.5cm, top=2cm, bottom=2cm}
	
      \centering
      \includegraphics[width = 6.25cm]{#1.pdf}\\
      \vspace{0.5cm}

      \titlingfont
      \LARGE\MakeUppercase{\ifblank{#4}{\theDegree}{#4}}\\
      \vspace{\fill}
 	
      \huge\MakeUppercase{\theSubject}\\
      \vspace{0.75cm}
      
      % Title
      \fontsize{27}{27}\titlingfont\selectfont \MakeUppercase{#2}\\
        
      % Subtitle
      \ifblank{#2}{}{
        \vspace{0.675cm} 
        \LARGE\titlingfont\selectfont #3\\
      }
      
      % Authors
      \vspace{\fill}
      \fontsize{14}{14}\sffamily\fontseries{sb}\selectfont
        
      \StrCount{\theAuthor}{,}[\numCommas]
      \ifthenelse{\equal{\numCommas}{0}}{         
        \authorname:\\ 
        \vspace{0.25cm} 
        \theAuthor\\ 
      }{
        \authorsname:\\ 
        \vspace{0.25cm} 
        \foreach \author in \theAuthor {
          \vspace{0.15cm} \author\\
        }
      }
    
      % Place and date
      \vspace{\fill}
      \vspace{-2cm}
		  \fontsize{14}{14}\selectfont Madrid\\
		  \vspace{0.25cm} 
      \fontsize{12}{12}\selectfont \theDate
	
      % Footer
      \vspace{1cm}
	    \begin{textblock}{1}[0,1](0,1)
	      \tikzstyle{pie} = [
	        rectangle, draw = none, 
	        fill = yellowComillas, 
	        minimum width = \paperwidth, 
	        minimum height=2cm, 
	        text centered
	      ]					
	      \begin{tikzpicture}
		      \node[pie]{\parbox{0.95\textwidth}
          {\centering \fontsize{10}{12}\fontfamily{phv}\bfseries\selectfont\color{white}
			    Alberto Aguilera, 25 -- 28015 Madrid (Spain) -- Tel. (+34) 91.542.28.00\\ www.icai.comillas.edu}};
	      \end{tikzpicture}
	    \end{textblock}
      
      \restoregeometry
    }
    
    \cleardoublepage
  }
  
  % Subheader
  \ifbool{teaching@notes}{\subheader{\notesname}}{
    \ifbool{teaching@exercises}{\subheader{\exercisesname}}{
      \ifbool{teaching@lab}{\subheader{\labname}}{
        \ifboolexpr{bool {teaching@quiz} or bool {teaching@exam} or bool {teaching@solution} or bool {teaching@report}}{\subheader{\theDegree}}{
        }
      }
    }
  }
  
  % Footer and PDF information
  \renewcommand{\theTitle}{#2}
  \footer{\theTitle}
}
