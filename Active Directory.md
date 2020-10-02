## Group policies
- _De updates op de GPO op de DC worden onmiddelijk gepushed naar de DC die de PDC emulator rol vervult._
- Filter -> de GPO is van toepassing op deze group. Hoe kan je dan rechten weigeren? -> ga bij de GPO naar delegation en neem het recht "apply group policy" weg
- GPO pas je toe op domain, site of OU. Dit is een eerste filter. Vervolgens kan je op deze gegeven subset verder filteren op groups (of met WMI)
### Group policies results van toepassing op client
```
gpresult /R
```
Run je best als admin om ook user policies te zien
Je kan ook vanop uw DC de uiteindelijke policies van uw client opvragen maar daarvoor moet je via WMI kunnen verbinden en dit moet je toelaten in de firewall. Gelukkig kun je dit
ook via GPO's. Zie `starter gpo's`.Resultaten staan in de map `Group policy results`
Je kan er ook de events zien of de updates geslaagd waren en wanneer.

### Group policies modelling
Analoog aan de vorige maar is meer een "whatif". Dit is zonder client informatie. Dus firewall kan gesloten blijven maar zaken zoals wmi filtering 
zal niet altijd werken. Bv. als je filtert op current disk space available. Windows zal jou dus wel paar vragen stellen om de scenario te simuleren. Handig als je bv wilt zien wat er gebeurd als je een gebruiker van OU of groep wijzigt.

### GPO's onmiddelijk uitvoeren.
- `gpupdate`
- rechter muisknop op de OU > update gpo
  - opgelet: dit werkt ook enkel als de firewall het toestaat
  - ook hiervoor hebben we een starter GPO klaar staan (uiteraard moetje wel gpupdate doen om deze te laten uitvoeren of half (?) uur wachten of herinloggen)
