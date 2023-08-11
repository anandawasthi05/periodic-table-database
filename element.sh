#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  #if an argument is provided
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number=$1;")"
    if [[ -z $ELEMENT_NAME ]]
    then
      echo "I could not find that element in the database."
    else
      ELEMENT_SYMBOL="$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1;")"
      ELEMENT_TYPE="$($PSQL "SELECT type FROM properties, types WHERE atomic_number=$1 AND properties.type_id=types.type_id;")"
      ELEMENT_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1;")"
      ELEMENT_BOILING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1;")"
      ELEMENT_MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")"
      echo "The element with atomic number $1 is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
    fi
  elif [[ $1 =~ ^(([A-Z][a-z])|([A-Z])){1,2}$ ]]
  then
    ELEMENT_NAME="$($PSQL "SELECT name FROM elements WHERE symbol='$1';")"
    if [[ -z $ELEMENT_NAME ]]
    then
      echo "I could not find that element in the database."
    else
      ELEMENT_ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")"
      ELEMENT_TYPE="$($PSQL "SELECT type FROM properties, types WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER AND properties.type_id=types.type_id;")"
      ELEMENT_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER;")"
      ELEMENT_BOILING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER;")"
      ELEMENT_MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")"
      echo "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($1). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
    fi
  elif [[ $1 =~ ^[A-Z][a-z]+$ ]]
  then
    ELEMENT_ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")"
    if [[ -z $ELEMENT_ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
    else
      ELEMENT_SYMBOL="$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER;")"
      ELEMENT_TYPE="$($PSQL "SELECT type FROM properties, types WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER AND properties.type_id=types.type_id;")"
      ELEMENT_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER;")"
      ELEMENT_BOILING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER;")"
      ELEMENT_MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER;")"
      echo "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $1 ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $1 has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
    fi
  else
    echo "I could not find that element in the database."
  fi
fi