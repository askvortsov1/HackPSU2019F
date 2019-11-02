FROM python:3.6
ENV PYTHONUNBUFFERED 1

RUN apt-get update
RUN apt-get --assume-yes install xmlsec1

COPY ./requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

COPY ./gunicorn.sh /gunicorn.sh
COPY ./entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh
RUN sed -i 's/\r//' /gunicorn.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /gunicorn.sh

COPY ./src /code
WORKDIR /code

ENTRYPOINT ["/entrypoint.sh"]
