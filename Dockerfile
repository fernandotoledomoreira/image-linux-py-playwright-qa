FROM mcr.microsoft.com/playwright/python:v1.29.0-focal

WORKDIR /image-linux-py-playwright-qa
COPY . /image-linux-py-playwright-qa

# Instala as dependências do sistema operacional
RUN apt-get update && apt-get install -y \
    vim \
    bash \
    git \
    default-jre \
    tzdata \
    zip \
    unzip \
    wget \
    software-properties-common

# Instala o Allure Framework
RUN wget -q https://github.com/allure-framework/allure2/releases/download/2.22.0/allure-2.22.0.tgz && \
    tar -zxvf allure-2.22.0.tgz -C /opt/ && \
    ln -s /opt/allure-2.22.0/bin/allure /usr/bin/allure && \
    rm -R allure-2.22.0.tgz

# Instala o Python 3.11
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && apt-get install -y python3.11

# Instala o pip e outras dependências Python
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.11 get-pip.py && \
    pip install --upgrade pip && \
    pip install awscli && \
    pip install -r requirements.txt

# Configura o timezone
ENV TZ America/Sao_Paulo

# Configura permissões adequadas
RUN chmod 777 -R /image-linux-py-playwright-qa
