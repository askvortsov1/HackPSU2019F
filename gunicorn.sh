#!/bin/bash

echo "Starting Server"
sleep 4
python3 manage.py runserver 0.0.0.0:80 &
python3 manage.py makemigrations
python3 manage.py migrate
echo "Server Successfully Started"
sleep infinity
