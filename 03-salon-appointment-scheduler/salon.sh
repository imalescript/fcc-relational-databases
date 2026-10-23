#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only --no-align -c"

echo -e "\n~~~~~ MY SALON ~~~~~"

MAIN_MENU() {
  if [[ $1 ]]; then
    echo -e "\n$1"
  else
    echo -e "Welcome to My Salon, how can I help you?\n"
  fi

  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done

  read SERVICE_ID_SELECTED

  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
    return
  fi

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  if [[ -z $SERVICE_NAME ]]; then
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    # Escape single quotes to prevent SQL injection
    ESCAPED_PHONE=$(echo "$CUSTOMER_PHONE" | sed "s/'/''/g")
    
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$ESCAPED_PHONE'")

    if [[ -z $CUSTOMER_NAME ]]; then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      
      # Escape single quotes in name
      ESCAPED_NAME=$(echo "$CUSTOMER_NAME" | sed "s/'/''/g")
      
      # Insert new customer and get customer_id in one query using RETURNING
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$ESCAPED_PHONE', '$ESCAPED_NAME') RETURNING customer_id")
      CUSTOMER_ID=$INSERT_CUSTOMER_RESULT
    else
      # Customer exists, get customer_id
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$ESCAPED_PHONE'")
    fi

    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME

    # Escape single quotes in time
    ESCAPED_TIME=$(echo "$SERVICE_TIME" | sed "s/'/''/g")
    
    # Create appointment
    $PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$ESCAPED_TIME')"

    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN_MENU