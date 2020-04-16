# README

## MIT License

    Minutes template for Spektrum rf
    
    Copyright (c) 2020 Christoffer Fridlund
    
    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
    of the Software, and to permit persons to whom the Software is furnished to do
    so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

As Spektrum rf is the organization for Swedish-speaking students at the Faculty of Science at the University Helsinki, the rest of this README will be in Swedish.

## Filer

    protokollspektrum.cls
LaTeX-klassen som gör allt jobb i bakgrunden.

    template_mini.tex
En minimalistisk testfil, färdig att använda.

    template.tex
En kopia av protokollet från September 2016, med kommentarer för de olika kommandona och parametrarna

## Användning

För att kunna använda den här protokollbottnen måste `protokollspektrum.cls` filen finnas i samma mapp som ".tex" filen som editeras eller i någon av mapparna som LaTeX använder för att hitta alla andra installerade paket.

Protokollet består av "punkter", punkterna kan sättas in med två olika kommandon:

    \punkt{<titel>}{<innehåll>}

Enklaste sättet att sätta in en punkt är att använda det här kommandot. Men om man vill sätta in några extra radbyten eller av någon anledning behöver använda mera LaTeX-kod för att fylla i innehållet, så kan man använda det andra sättet:

    \begin{punkten}{<titel>}
        <innehåll>
    \end{punkten}

Programmet sköter numreringen av punkterna själv, så det enda användaren måste göra är att sätta dem i rätt ordning.

LaTeX bryr sig inte om de flesta tabbar/radbyten, utan man måste själv specifikt säga åt systemet att använda ett blankt utrymme.

Man kan sätta hur många tommar rader som helst mellan punkterna, men innuti `\punkt`-kommandot är ett av undantagen för tomma rader.

När man skapar PDF:en brukar LaTeX oftast villa göra de temporära hjälpfilerna flera gånger, för att alla referenser ska fungera. I det här fallet gäller det främst sidnumrerningen.

Filen `template.tex` har grundstrukturen för ett protokoll.

Alla kommandon är valbara, med det undantaget att man måste sätta med åtminstone en punkt i protokollet, annars klagar LaTeX kompilatorn.

## Kommandon

### `\documentclass`

För att välja mellan måmö och stymö protokollen ska man välja mellan de här två kommandona:

    \documentclass[styrelse]{protokollspektrum}

och

    \documentclass{protokollspektrum}

### Före `\\begin{document}`

När hölls mötet?
    
    \datum{<dag>}{<månad}{<år>}

Var hölls mötet?
    
    \plats{<var hölls mötet>}

Närvarande från styrelsen
    
    \styrelse{<namn1>, <namn2>, etc}

Närvarande medlemmar
    
    \medlemmar{<bilaga>}

Bilagor inkluderade med dokumentet, kan finnas hur många som helst. Listan kommer i samma ordning som de är listade.
    
    \bilaga{<vilken bilaga>}

Underteckningslinjer i slutet av dokumentet. Kan finnas hur många som helst.

    \signatur{<vem ska skriva under dokumentet>}

### Mellan `\begin{document}` och `\end{document}`

En punkt i protokollet

    \punkt{<titel>}{<innehåll>}

En mera avancerad punkt i protokollet, klarar av radbyten för att göra olika paragrafer.

    \begin{punkten}{<titel>}
        \<innehåll>
    \end{punkten}
    
Kommentar som inte hör till någon punkt. Använd det här ifall kommentarern kommer före första punkten.

    \anteckningstart{<innehåll>}

Kommentar som inte hör till någon punkt. Använd det här ifall kommentaren kommer mellan punkter.

    \anteckning{<innehåll>}

Kommentar som inte hör till någon punkt. Använd det här ifall kommentaren kommer efter sista punkten.

    \anteckningslut{<innehåll>}

## Verktyg

För att kunna använda filerna i det här paketet, så måste man ha någon form av LaTeX installation på datorn.

* `texlive`  (Linux + Windows)
* `miktex`  (Windows)
* etc.

Utöver det här rekommenderas en editor (`Visual Studio Code`, `TexMaker`, etc).
