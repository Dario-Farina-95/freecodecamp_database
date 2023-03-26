#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do

#esclusione del winner
if [[ $winner != "winner" ]]
then
#prendi winner id
winner_id=$($PSQL "select team_id from teams where name = '$winner'")

#se non trovato(ovvero se non è già presente tra i team)
  if [[ -z $winner_id ]]
  then
  #inseriscilo tra i team
  insert_winner=$($PSQL "INSERT INTO teams(name) VALUES('$winner')")

  #if [[ $insert_winner == "INSERT 0 1" ]]
   # then
   # echo inserted into teams taken from winner, $winner
  #fi
  fi
fi

#inserimento dei team da opponent con la stessa logica

#esclusione del opponent
if [[ $opponent != "opponent" ]]
then
#prendi opponent id
opponent_id=$($PSQL "select team_id from teams where name = '$opponent'")
#se non trovato(ovvero se non è già presente tra i team)
  if [[ -z $opponent_id ]]
  then
  #inseriscilo tra i team
  insert_opponent=$($PSQL "INSERT INTO teams(name) VALUES('$opponent')")

  #if [[ $insert_opponent == "INSERT 0 1" ]]
   # then
    #echo inserted into teams taken from opponent, $opponent
  #fi
  fi
fi

#insert data into games
if [[ $year != 'year' ]]
then
#take winner_id
team_winner_id=$($PSQL "select team_id from teams where name ='$winner'")
#echo $team_winner_id
#take opponent_id
team_opponent_id=$($PSQL "select team_id from teams where name ='$opponent'")
#echo $team_opponent_id

insert_data_games=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id,winner_goals,opponent_goals) VALUES($year , '$round', $team_winner_id, $team_opponent_id, $winner_goals, $opponent_goals)")
#echo $insert_data_games
fi

done
