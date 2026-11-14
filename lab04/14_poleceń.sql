-- Zad.1 
SELECT z.id, z.data_zamowienia, z.status, k.imie, k.nazwisko
FROM zamowienia z
JOIN klienci k ON z.klient_id = k.id;

--Zad.2
SELECT k.nazwa, AVG(p.cena)
FROM produkty p
JOIN kategorie k ON k.id = p.kategoria_id
GROUP BY k.nazwa;

--Zad.3
SELECT k.imie, k.nazwisko, SUM(pz.ilosc * pz.cena_jednostkowa) AS wydatki 
FROM pozycje_zamowien pz
JOIN zamowienia z ON z.id = pz.zamowienie_id
JOIN klienci k ON k.id = z.klient_id
GROUP BY k.id, k.imie, k.nazwisko
ORDER BY wydatki DESC
LIMIT 5;

--Zad.4
SELECT k.nazwa, COUNT(p.id)
FROM kategorie k
JOIN produkty p ON p.kategoria_id = k.id
GROUP BY k.id, k.nazwa
HAVING COUNT(p.id)>5

--Zad.5
SELECT p.nazwa
FROM produkty p
LEFT JOIN pozycje_zamowien pz ON pz.produkt_id = p.id
WHERE pz.produkt_id IS NULL;

--Zad.6
SELECT status, COUNT(id) AS liczba_zamowien
FROM zamowienia
GROUP BY status;

--Zad.7
SELECT p.imie, p.nazwisko, COUNT(z.pracownik_id) AS ilosc_obsluzonych_zamowien
FROM pracownicy p
JOIN zamowienia z ON z.pracownik_id = p.id
GROUP BY p.id, p.imie, p.nazwisko
ORDER BY ilosc_obsluzonych_zamowien DESC
LIMIT 1;

--Zad.8
SELECT k.id, k.imie, k.nazwisko, COUNT(z.id) AS liczba_zamowien
FROM klienci k
LEFT JOIN zamowienia z ON z.klient_id = k.id
GROUP BY k.id, k.imie, k.nazwisko;

--Zad.9
SELECT k.nazwa, SUM(pz.ilosc * pz.cena_jednostkowa) AS wartosc_sprzedazy
FROM kategorie k
JOIN produkty p ON p.kategoria_id = k.id
JOIN pozycje_zamowien pz ON pz.produkt_id = p.id
GROUP BY k.id, k.nazwa
ORDER BY wartosc_sprzedazy DESC
LIMIT 5;

--Zad.10
SELECT p.nazwa, p.cena, p.kategoria_id
FROM produkty p
WHERE p.cena > (
	SELECT AVG(p2.cena)
	FROM produkty p2
	WHERE p2.kategoria_id = p.kategoria_id
);

--Zad.11
SELECT k.imie, k.nazwisko
FROM klienci k
LEFT JOIN zamowienia z ON z.klient_id = k.id
WHERE z.id IS NULL;

--Zad.12
SELECT k.nazwa, SUM(pz.ilosc) AS liczba_sprzedanych_sztuk
FROM kategorie k
LEFT JOIN produkty p ON p.kategoria_id = k.id
LEFT JOIN pozycje_zamowien pz ON p.id = pz.produkt_id
GROUP BY k.id, k.nazwa;

--Zad.13
SELECT p.imie, p.nazwisko, COUNT(z.id) AS liczba_zamowien
FROM pracownicy p
LEFT JOIN zamowienia z ON p.id = z.pracownik_id
GROUP BY p.id, p.imie, p.nazwisko
HAVING COUNT(z.id) < (
    SELECT AVG(liczba_z)
    FROM (
        SELECT COUNT(z2.id) AS liczba_z
        FROM pracownicy p2
        LEFT JOIN zamowienia z2 ON p2.id = z2.pracownik_id
        GROUP BY p2.id
    )subquery
);

--Zad.14
SELECT p.nazwa, COUNT(pz.id) AS liczba_wystapien
FROM produkty p
JOIN pozycje_zamowien pz ON p.id = pz.produkt_id
GROUP BY p.id, p.nazwa
ORDER BY liczba_wystapien DESC
LIMIT 3;