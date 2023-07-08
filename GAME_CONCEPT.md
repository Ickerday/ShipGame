# Game concept
- Jesteś kapitanem wielkiego zeppelina, twoim zadaniem jest przelecenie z punktu A do punktu B na mapie, przejście do kolejnej mapy i tak pięć razy
- IMMERSYWNE UI, okrętem kieruje się klikając na różne komponenty okrętu (jak w grach point and click)
- Silent hunter III baza, Highfleet też baza. Baza.
- Gracz nie ma wszystkich informacji i musi dużo szacować/kombinować/domyślać się
- Grafika a la pizza tower
- Gra nie porusza żadnych ważnych tematów w sferze narracyjnej, bo po co
- Price tag: 5-8 USD + niekończące się promocje na steamie

### Mapy składają się z:
- okrętu gracza 
- prize ships do obrabowania 
- okrętów patrolowych przeciwnika
- Tras patrolowych i handlowych po których poruszają się okręty przeciwnika i prize ships
- chmur w których można się schować
- outpostów przeciwnika
- punktów w których można kupić nowe komponenty/ulepszenia do okrętu/sprzedać syf z ładowni
- Punktów udostępniających różne informacje

## Gracz na pokonanie mapy ma X czasu (w minutach) - jeśli tego nie zrobi, to z końca mapy zaczną wylatywać zeppeliny przeciwnika które go gonią

### Okręt gracza składa się z:
- HP 
- Pancerza
- Napędu
- Drącego się typa który robi za sonar/radar
- Torpedowni (można wyjebać torpedę)
- armat (automatycznie nakurwiają w najbliższy cel)
- Pojemności (w tonach) / ładowni
- Persykopu (możliwy overscope!)

### Gracz musi balansować następującymi zasobami
- czasem
- ładownią

- Okręty przeciwnika składają się z
- HP
- Pancerza
- Armat
- Sensorów

### AI okrętów przeciwnika zachowuje się w następujący sposób
- Jeśli wie gdzie jest gracz, to go goń i podpłyń na tyle blisko, żeby w niego nakurwiać
- Jeśli widział gracza, ale teraz już nie, to patroluj najbliższą pozycję
-- Jeśli istnieje jakiś event, to wyślij najbliższy okręt żeby go zrealizował
-- Jeśli nie istnieje to znajdź najbliższą wolną patrolową trasę i sobie po niej patroluj
-- Jeśli nie istnieje najbliższa wolna patrolowa trasa i nie ma żadnego eventu, to leć do najbliższego outpostu i sobie tam idluj na luzie

### Do ładowni wchodzi następujące cargo:
- Torpedy
- Amunicja (do armat)
- Loot

- Jeśli okręty przeciwnika zostaną sprowadzone do 0 HP, to zmieniają się w powoli opadające na dno (?) wraki
- Wraki można splądrować żeby zdobyć cargo/loot

## Gameplay loop
> Bądź graczem
> otwórz mapę
> zobacz gdzie są najbliższe punkty które chciałbyś odwiedzić
> wiesz że między outpostami przeciwnika latają prize ship i dobrze je rozpierdolić żeby zdobyć hajs
> wiesz że między outpostami przeciwnika latają okręty patrolowe i w sumie chujowo być rozpierdolonym
> w sumie to okręty patrolowe da się rozpierdolić, ale trochę chujowo marnować zasoby na to
> ./high-risk-high-retard.sh
> zauważ że trochę dalej jest punkt obserwacyjny który może ci powiedzieć co i jak
> pomiędzy outpostami masz chmurę
> gdzieś po drodze jeszcze punkt do opylenia szajsu
> HMMMMMMM
> przypomnij sobie nieuchronny-upływ-czasu.png
> zaplanuj trasę
> leć do punktu obserwacyjnego
> co jakiś czas walnij młotkiem drącego się typa żeby nasłuchiwać co i jak
> zauważ po drodze patrol i prize ship 
> chyba cię słyszeli
> nie-ma-paniki
> szybciutko spierdalasz na bok w chmurę, wylatujesz z drugiej strony, silnik na 50% wydajności, stealth 100%, szafa gra
> walisz torpedą w chwilowo osamotniony prize ship, podpływasz, szybko plądrujesz i spierdalasz zanim ktokolwiek się skapnie co się dzieje
> profit
> okazuje się że z góry mapy płyną ci wpierdolić jakieś patrole 
> stealth jest opcjonalny w tej misji
> Mr. Tyresse, give these niggas a volley!
> leć spieniężyć loot, naprawić okręt, kupić jakiś nowy syf i nakurwiać dalej

