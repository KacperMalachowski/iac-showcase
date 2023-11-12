# Z Pulumi na księżyc? Znaczy do chmury ;)

Instalacja pulumi na windowsie jest banalnie prosta i sprowadza się do jednej komendy:\
`curl -fsSL https://get.pulumi.com | sh`

W przypadku systemu windows skorzystać należy ze strony https://www.pulumi.com/docs/install/,   
gdzie pobrać należy instalator zgodny z wersją systemu.

Zaczniemy od ustawienia lokalnego systemu plików jako backendu pulumi.\
Tak jak kazde narzędzie IaC tak i pulumi posiada swój stan, ale o nim później.\
W tym celu uzywamy komendy: 
`pulumi login --local`

Gdy pulumi już wie, że ma używać lokalnego systemu plików możemy przejsc do prawdziwej zabawy.
Cel na dziś to postawienie prostej strony internetowej korzystajac z bucket'a na google cloud.

Zacznimy zatem nowy projekt w pustym katalogu, można skorzystać z poniższej komendy: `mkdir -p pulumi && pulumi new`\
NAstępnie pulumi