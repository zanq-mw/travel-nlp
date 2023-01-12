# Travel-nlp

Travel-nlp is a natural language processing program, written in prolog, that uses a knowledge base of flight information, a lexicon, and a word parser, to understand the inputted questions, and output the correct answer to the questions.

## Understanding the Knowledge base
It is essential to understand what the knowledge base is in order to know what questions to ask the application. The knowledge base is a collection of facts regarding the flights. These are used to answer the inputted questions.

The knowledge base can be found at the top of Travel-nlp/travel.pl file. There are 4 types of facts in the knowledge base
1. A **Flight fact** tells the airline, city of departure, city of arrival, and name of a flight. It follows the format flight(F, C, X, Y ) where F is a name of a flight, C is a carrier, and X and Y are the from and to cities, e.g.:
```
flight(aa300,americanAirlines,ny,austin).
flight(ua95,unitedAirlines,chicago,toronto).
flight(ac987,airCanada,edmonton,montreal).
flight(ac087,airCanada,vancouver,shanghai).
```
2. A **Departure fact** tells the name, city of departure, and departure time of a flight. It follows the format dtime(Flight, City, Time): The departure time of Flight from City is Time, e.g.
```
dtime(ac987,edmonton,1130). dtime(aa300,ny,1200). /* ny stands for New York*/
dtime(ua95,chicago,1215). dtime(ac087,vancouver,1300).
```
3. An **Arrival fact** tells the name, city of arrival, and arrival time of a flight. It follows the format atime(Flight, City, Time): The arrival time of Flight to City is Time, e.g.
```
atime(ac987,montreal,1645). atime(ua95,toronto,1330).
atime(aa300,austin,1600). atime(ac087,shanghai,2300).
```
4. A **Location** fact tells the country that a city is located in. It follows the format location(X, C), where X is a city, and C is a country. For example:
```
location(toronto,canada). location(shanghai,china).
```

#### Note: Time is represented by an integer and is in 24 hour format. 2359 corresponds to 23:59 or 11:59 pm.

## How to run
Ensure you have downloaded and installed [SWI Prolog](https://www.swi-prolog.org/download/stable). Open SWI Prolog on your computer. Click on File > Consult, and select the travel-nlp/travel.pl file.

Alternatively, you can use an [online prolog compiler](https://swish.swi-prolog.org/). Just create a program and copy & paste the code from travel-nlp/travel.pl file into the left pane. The right pane can be used for querying.

In order to ask it questions, the query needs to follow the format what({Words}, Answer), where Words is a list of each word in the question (all lowercase). For example, to ask what is "the shortest flight from toronto to vancouver, you would input
```
what([the, shortest, flight, from, toronto, to, vancouver], Answer)
```
and the output would be
```
Answer = ac01
```

See travel-nlp/travel_queries.txt for more examples of queries you can run.

