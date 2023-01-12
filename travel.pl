% Knowledge Base
flight(ac01, airCanada, toronto, vancouver).
flight(ac02, airCanada, toronto, montreal).
flight(ac03, airCanada, montreal, losAngeles).
flight(ac04, airCanada, edmonton, toronto).
flight(ac05, airCanada, vancouver, shanghai).
flight(ac06, airCanada, toronto, edmonton).
flight(ac07, airCanada, toronto, london).
flight(ac08, airCanada, toronto, losAngeles).
flight(ac09, airCanada, vancouver, shanghai).
flight(ua01, unitedAirlines, chicago, toronto).
flight(ua02, unitedAirlines, losAngeles, manchester).
flight(ua03, unitedAirlines, edmonton, newYork).
flight(ua04, unitedAirlines, losAngeles, miami).
flight(d01, delta, toronto, losAngeles).
flight(d02, delta, toronto, london).
flight(wj01, westJet, toronto, beijing).
flight(wj02, westJet, toronto, hongKong).
flight(wj03, westJet, edmonton, montreal).

dtime(ac01, toronto, 830).
dtime(ac02, toronto, 1100).
dtime(ac03, montreal, 700).
dtime(ac04, edmonton, 700).
dtime(ac05, vancouver, 1030).
dtime(ac06, toronto, 700).
dtime(ac07, toronto, 1000).
dtime(ac08, toronto, 1215).
dtime(ac09, vancouver, 1230).
dtime(ua01, chicago, 1845).
dtime(ua02, losAngeles, 500).
dtime(ua03, edmonton, 815).
dtime(ua04, losAngeles, 1100).
dtime(d01, toronto, 1400).
dtime(d02, toronto, 1400).
dtime(wj01, toronto, 615).
dtime(wj02, toronto, 500).
dtime(wj03, edmonton, 1100).

atime(ac01, vancouver, 1230).
atime(ac02, montreal, 1215).
atime(ac03, losAngeles, 1430).
atime(ac04, toronto, 930).
atime(ac05, shanghai, 2400).
atime(ac06, edmonton, 800).
atime(ac07, london, 1900).
atime(ac08, losAngeles, 1500).
atime(ac09, shanghai, 2300).
atime(ua01, toronto, 2100).
atime(ua02, manchester, 2330).
atime(ua03, newYork, 1015).
atime(ua04, newYork, 1400).
atime(d01, losAngeles, 2100).
atime(d02, london, 2030).
atime(wj01, beijing, 1745).
atime(wj02, hongKong, 2000).
atime(wj03, montreal, 1200).

location(toronto, canada).
location(montreal, canada).
location(vancouver, canada).
location(edmonton, canada).
location(losAngeles, usa).
location(chicago, usa).
location(newYork, usa).
location(miami, usa).
location(manchester, uk).
location(london, uk).
location(shanghai, china).
location(beijing, china).
location(hongKong, china).


% Lexicon
article(a). article(an). article(any).

common_noun(flight, X) :- flight(X, _, _, _).
common_noun(city, X) :- location(X, _).
common_noun(country, X) :- location(_, X).
common_noun(time, X) :- dtime(_, _, X), X >= 0, X =< 2400.
common_noun(time, X) :- atime(_, _, X), X >= 0, X =< 2400.

preposition(to, X, Y) :- flight(X, _, _, Y).
preposition(to, X, Y) :- flight(X, _, _, Z), location(Z, Y).
preposition(from, X, Y) :- flight(X, _, Y, _).
preposition(from, X, Y) :- flight(X, _, Z, _), location(Z, Y).
preposition(in, X, Y) :- location(X, Y).
preposition(with, X, Y) :- dtime(X, _, Y).
preposition(with, X, Y) :- atime(X, _, Y).
preposition(of, X, Y) :- dtime(Y, _, X).
preposition(of, X, Y) :- atime(Y, _, X).
preposition(between, X, Y) :- flight(X, _, Y, _).
preposition(between, X, Y) :- flight(X, _, Z, _), location(Z, Y).
preposition(and, X, Y) :- flight(X, _, _, Y).
preposition(and, X, Y) :- flight(X, _, _, Z), location(Z, Y).

proper_noun(X) :- location(X, _).
proper_noun(X) :- location(_, X).

adjective(domestic, X) :- flight(X, _, City1, City2), location(City1, Country), location(City2, Country). 
adjective(international, X) :- flight(X, _, City1, City2), location(City1, Country1), location(City2, Country2), not(Country1=Country2).
adjective(airCanada, X) :- flight(X, airCanada, _, _).
adjective(unitedAirlines, X) :- flight(X, unitedAirlines, _, _).
adjective(westJet, X) :- flight(X, westJet, _, _).
adjective(delta, X) :- flight(X, delta, _, _).
adjective(long, X) :- dtime(X, City1, D1), atime(X, City2, A1), flight(Y, _, City1, City2), not(X=Y), dtime(Y, _, D2), atime(Y, _, A2), A1-D1 > A2-D2.
adjective(shortest, X) :- flight(X, _, City1, City2), dtime(X, City1, D), atime(X, City2, A), \+ (flight(Y, _, City1, City2), dtime(Y, City1, D2), atime(Y, City2, A2), Time1 is (A//100*60 + A mod 100)-(D//100*60 + D mod 100), Time2 is (A2//100*60 + A2 mod 100)-(D2//100*60 + D2 mod 100), Time2<Time1).
adjective(arrival, X) :- atime(_, _, X).
adjective(departure, X) :- dtime(_, _, X).
adjective(morning, X) :- dtime(X, _, D), D>= 500, D < 900.
adjective(morning, X) :- dtime(_, _, X), X >= 500, X < 900.
adjective(morning, X) :- atime(_, _, X), X >= 500, X < 900.
adjective(day, X) :- dtime(X, _, D), D>= 900, D < 1200.
adjective(day, X) :- dtime(_, _, X), X >= 900, X < 1200.
adjective(day, X) :- atime(_, _, X), X >= 900, X < 1200.
adjective(afternoon, X) :- dtime(X, _, D), D>=1200, D < 1700.
adjective(afternoon, X) :- dtime(_, _, X), X >= 1200, X < 1700.
adjective(afternoon, X) :- atime(_, _, X), X >= 1200, X < 1700.
adjective(evening, X) :- dtime(X, _, D), D>= 1700, D=<2200.
adjective(evening, X) :- dtime(_, _, X), X >= 1700, X =< 2200.
adjective(evening, X) :- atime(_, _, X), X >= 1700, X =< 2200.
adjective(canadian, X) :- location(X, canada).
adjective(american, X) :- location(X, usa).
adjective(chinese, X) :- location(X, china).


% Parser
what(Words, Ref) :- np(Words, Ref).

np([Place], Place) :- proper_noun(Place).
np([the | Rest], What) :- np2(Rest, What), \+ (np2(Rest, What2), not(What=What2)).
np([the | [shortest|Rest]], What) :- np2([shortest|Rest], What), dtime(What, _, D), atime(What, _, A), \+ (np2([shortest|Rest], What2), dtime(What2, _, D2), atime(What2, _, A2), Time1 is (A//100*60 + A mod 100)-(D//100*60 + D mod 100), Time2 is (A2//100*60 + A2 mod 100)-(D2//100*60 + D2 mod 100), Time2<Time1).
np([Art | Rest], What) :- not(Art=the), article(Art), np2(Rest, What).

np2([Adj | Rest], What) :- adjective(Adj, What), np2(Rest, What).
np2([Noun | Rest], What) :- common_noun(Noun, What), mods(Rest, What).

mods([], _).
mods(Words, What) :- append1(Start, End, Words), pp(Start, What), mods(End, What).

pp([Prep | Rest], What) :- preposition(Prep, What, What2), np(Rest, What2).

append1([], X, X).
append1([H|T], X, [H|Y]) :- append1(T, X, Y).
