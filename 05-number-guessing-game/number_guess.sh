#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME';")

if [[ -z $USER_ID ]]
then
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME');")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME';")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID;")
  BEST_GAME=$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE user_id=$USER_ID;")

  if [[ -z $BEST_GAME ]]
  then
    BEST_GAME=0
  fi

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

echo "Guess the secret number between 1 and 1000:"

while true
do
  read GUESS

  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    continue
  fi

  ((NUMBER_OF_GUESSES++))

  if [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    break
  elif [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  else
    echo "It's higher than that, guess again:"
  fi
done

INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(user_id, number_of_guesses) VALUES($USER_ID, $NUMBER_OF_GUESSES);")

echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"