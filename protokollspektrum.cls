% Minutes template for Spektrum rf
% 
% Copyright (c) 2020 Christoffer Fridlund
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy of
% this software and associated documentation files (the "Software"), to deal in
% the Software without restriction, including without limitation the rights to
% use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
% of the Software, and to permit persons to whom the Software is furnished to do
% so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

\NeedsTeXFormat{LaTeX2e} %[1994/06/01]
\ProvidesClass{protokollspektrum}[2016/12/10 Class Protokoll Spektrum]


% Base class of this class
\LoadClass[11pt,a4paper]{article}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Packages

%-----------------------------------------------------------------------------------
% The class uses UTF8 as input encoding. The files created should use this as well.
% It has language support for swedish by default, if an article in another language
% will be added, then list of langauges in the babel argument has to be updated.
%-----------------------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[swedish]{babel}


%-----------------------------------------------------------------------------------
% More control over the paragraphs.
%-----------------------------------------------------------------------------------
\RequirePackage{parskip}

\RequirePackage[margin=2.5cm]{geometry}
\RequirePackage[svgnames]{xcolor}

\RequirePackage{fancyhdr}

\RequirePackage{pgf}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{pgfkeys}

\RequirePackage{datetime}
\newdateformat{specialdate}{\twodigit{\THEDAY}.\twodigit{\THEMONTH}.\THEYEAR}

\RequirePackage{enumitem}



\DeclareDocumentCommand{\motestyp}{ m }{\def\cls@motestyp{#1}}


\AtBeginDocument{%
	{\Large\textbf{\cls@monthname{} \cls@motestyp{}, \cls@datum{}\\}}
	Plats: \cls@plats{}
	\vskip0.2cm
	\begin{minipage}[t]{0.2\linewidth}
		Närvarande:
	\end{minipage}
	\hfill
	\begin{minipage}[t]{0.79\linewidth}
		\cls@styrelse{}
	\end{minipage}
	
	
	\ifx\cls@medlemmar\@undefined
	\else
		\begin{minipage}[t]{0.2\linewidth}
			Övriga närvarande:
		\end{minipage}
		\hfill
		\begin{minipage}[t]{0.79\linewidth}
			\cls@medlemmar{}
		\end{minipage}
	\fi
	
	\vskip1.0cm
	
	\begin{description}[style=nextline]%
}

\AtEndDocument{%
	\end{description}%

%	\clearpage
%	\pagebreak
%
%%%	%\vfill
	\begin{minipage}[t]{0.99\linewidth}
	\ifx\cls@bilagor\@undefined
	\else
		\vskip1.0cm
		\textbf{Bilagor:}
		\begin{description}[noitemsep]
		\dolistloop{\cls@bilagor}
		\end{description}
	\fi
	\end{minipage}
	
	\begin{minipage}[t]{0.99\linewidth}
	\ifx\cls@signaturer\@undefined
	\else
	\begin{center}
		\dolistloop{\cls@signaturer}
	\end{center}
	\fi
	\end{minipage}
}

\AfterEndDocument{%
}

\RequirePackage{lastpage}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options

% Om styrelse är med som option i documentclass kommandot byter texten i rubriken till följande.
\DeclareOption{styrelse}{\motestyp{styrelsemöte}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ExecuteOptions{}
\ProcessOptions\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configuration

\renewcommand{\familydefault}{\sfdefault}
\setlength{\parskip}{0.5\baselineskip}


%-----------------------------------------------------------------------------------
% Calculates if the page count is dividable with four when compiling. It shows a 
% message with how many pages there currently is if an error occurs.
%
% This helps with the booklet layout. Normally a book or booklet has even number
% of pages, to be able to glue or tie them together.
%-----------------------------------------------------------------------------------


% Lista för att hantera bilagor
\newcounter{BilagaCounter}
\NewDocumentCommand{\bilaga}{ m }{%
	\listgadd{\cls@bilagor}{%
		\stepcounter{BilagaCounter}%
		\item[Bilaga \theBilagaCounter] #1
	}
}


\newcounter{SignaturCounter}
\NewDocumentCommand{\signatur}{ m }{%
	\listgadd{\cls@signaturer}{%
		\stepcounter{SignaturCounter}%
		\pgfmathparse{mod(\theSignaturCounter,2)==1}
		\begin{minipage}[t]{0.45\linewidth}%
			\vskip1.5cm
			\centering
			\hrulefill \\
			#1
		\end{minipage}%
	    \ifnum \pgfmathresult=1
	    		\hfill %\hspace{0.5cm}
	   	\else
	   		\newline
	    \fi
	}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Header and Footer

\pagestyle{fancy}
\fancyhf{}

\setlength{\headheight}{14pt}
\renewcommand{\headrulewidth}{0.8pt}
\renewcommand{\headrule}{\color{LightGray}\hrule}
\fancyhead[L]{ \textcolor{gray}{\slshape Spektrum rf} }
\fancyhead[C]{ \textcolor{gray}{\slshape Mötesprotokoll} }
\fancyhead[R]{ \textcolor{gray}{\slshape \cls@datum{}} }

\renewcommand{\footrulewidth}{0.8pt}
\renewcommand{\footrule}{\color{LightGray}\hrule}
\fancyfoot[C]{ \textcolor{gray}{\slshape \thepage{} av \pageref{LastPage}} }

\DeclareDocumentCommand{\datum}{ m m m }{\def\cls@datum{\specialdate{\formatdate{#1}{#2}{#3}}}\def\cls@month{#2}}
\DeclareDocumentCommand{\extradatum}{ m m m }{\def\cls@extradatum{\specialdate{\formtadate{#1}{#2}{#3}}}\def\cls@extramonth{#2}}
\DeclareDocumentCommand{\plats}{ m }{\def\cls@plats{#1}}
\DeclareDocumentCommand{\styrelse}{ m }{\def\cls@styrelse{#1}}
\DeclareDocumentCommand{\medlemmar}{ m }{\def\cls@medlemmar{#1}}


% I slutet av preamblen så definieras de kommandon som ännu inte blivit definierade med default-värden.
\AtEndPreamble{%
	\ifx\cls@datum\@undefined
		\datum{\day}{\month}{\year}
	\fi
	
	\ifx\cls@motestyp\@undefined
		\motestyp{månadsmöte}
	\fi
	
	\ifx\cls@plats\@undefined
		\plats{Klubben}
	\fi
	
	\ifx\cls@styrelse\@undefined
		\styrelse{~}
	\fi
	
%	\ifx\cls@medlemmar\@undefined
%		\medlemmar{Se bilaga}
%	\fi
}


% Används för att konvertera månaden i sifferformat till bokstäver, för att skriva titeln på dokumentet.
\newcommand{\cls@monthname}{%
	\ifx\cls@extramonth\@undefined
		\ifcase\cls@month
		\or Januari% 1
		\or Februari% 2
		\or Mars% 3
		\or April% 4
		\or Maj% 5
		\or Juni% 6
		\or Juli% 7
		\or Augusti% 8
		\or September% 9
		\or Oktober% 10
		\or November% 11
		\or December% 12
		\fi
	\else	% Använd extradatum för att specificera titeln annorlunda än när själva mötet hölls.
		\ifcase\cls@extramonth
		\or Januari% 1
		\or Februari% 2
		\or Mars% 3
		\or April% 4
		\or Maj% 5
		\or Juni% 6
		\or Juli% 7
		\or Augusti% 8
		\or September% 9
		\or Oktober% 10
		\or November% 11
		\or December% 12
		\fi
	\fi
}



\newcounter{PunktCounter}

\DeclareDocumentCommand{\punkt}{ m m }{%
	\stepcounter{PunktCounter} %
	\item[\thePunktCounter.~#1] #2
	\vskip0.2cm
}

\DeclareDocumentEnvironment{punkten}{ m }
{
	\stepcounter{PunktCounter}%
	\item[\thePunktCounter.~#1]
}
{
	\vskip0.2cm
}

\NewDocumentCommand{\anteckning}{ m }{%
	\end{description}%
	#1
	\begin{description}[style=nextline]%
}

\NewDocumentCommand{\anteckningstart}{ m }{%
	\item[]%
	\vspace{-\baselineskip}
	\vspace{-\topsep}
	\vspace{-\itemsep}
	\vspace{-\itemsep}
	\anteckning{#1}%
}

\NewDocumentCommand{\anteckningslut}{ m }{%
	\anteckning{#1}%
	\item[]%
	\vspace{-\baselineskip}%
	\vspace{-\topsep}%
	\vspace{-\itemsep}%
	\vspace{-\itemsep}%
}


\endinput

