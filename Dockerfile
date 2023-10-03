FROM python:3.9.18-alpine3.18

WORKDIR /usr/src/prj

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade pip
RUN apk update \
    && apk add gcc musl-dev postgresql-dev python3-dev

COPY ./requirements.txt .
RUN pip install -r requirements.txt

COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' /usr/src/prj/entrypoint.sh
RUN chmod +x /usr/src/prj/entrypoint.sh

COPY . .

ENTRYPOINT ["/usr/src/prj/entrypoint.sh"]