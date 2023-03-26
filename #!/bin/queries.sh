#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals) + sum( opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"


echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT round(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(x.goals)*2 FROM (SELECT winner_goals as goals FROM games UNION ALL SELECT opponent_goals as goals from games)x")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"


echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(winner_id) FROM games WHERE winner_goals >2")"


echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name from games inner join teams on games.winner_id = teams.team_id where year = 2018 AND round ='Final'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "Select name from (SELECT name from games full join teams on games.winner_id = teams.team_id where year = 2014 AND round ='Eighth-Final' UNION SELECT name from games full join teams on games.opponent_id = teams.team_id where year = 2014 and round ='Eighth-Final') AS name_list ORDER BY name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(name) AS unique_name from games inner join teams on games.winner_id = teams.team_id ORDER BY unique_name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name from games inner join teams on games.winner_id = teams.team_id WHERE round = 'Final' ORDER BY year")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name from teams where name LIKE 'Co%'")"
