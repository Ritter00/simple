#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

#python manage.py flush --no-input
python manage.py migrate

if [ "$TEST_ADMIN" = "True" ]
then
    python manage.py createsuperuser \
            --noinput \
            --username $ADMIN_NAME \
            --email $ADMIN_EMAIL

fi

exec "$@"