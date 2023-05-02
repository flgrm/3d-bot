ARG BASE_IMG=python:3
FROM ${BASE_IMG} as dev
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ARG USER=bot
WORKDIR /app
COPY . /app/
RUN useradd $USER && \
    pip3 install --upgrade pip && \
    pip3 install -r requirements.txt && \
    pip3 install debugpy
USER $USER
CMD ["python3", "-m", "debugpy", "--listen", "0.0.0.0:3001", "3d-bot.py"]

FROM python:3 as prod
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ARG USER=bot
WORKDIR /app
COPY . /app/
RUN useradd $USER && \
    chown $USER:$USER /app && \
    pip install --upgrade pip && \
    pip install -r requirements.txt
USER $USER
CMD ["python3", "3d-bot.py"]