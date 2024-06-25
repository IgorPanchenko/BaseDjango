# pull official base image
FROM python:3.11.4-slim-buster

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt update && apt install -y nginx

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .

CMD ["python3", "manage.py", "migrate"]
CMD ["python3", "manage.py", "collectstatic"]
CMD ["gunicorn", "core.wsgi:application", "-b", "0.0.0.0:8000"]