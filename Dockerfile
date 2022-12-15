FROM python:3

WORKDIR /image-linux-py-playwright-qa
COPY . /image-linux-py-playwright-qa

RUN wget -q https://github.com/allure-framework/allure2/releases/download/2.19.0/allure-2.19.0.tgz
RUN tar -zxvf allure-2.19.0.tgz -C /opt/
RUN ln -s /opt/allure-2.19.0/bin/allure /usr/bin/allure

RUN apt update
RUN apt install -y vim
RUN apt install -y python3-pip
RUN apt install -y bash
RUN apt install -y awscli
RUN apt install -y git
RUN apt install -y default-jre

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
RUN pip install --upgrade pip

RUN mkdir /root/.ssh/
ADD keygit /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts && chmod 600 /root/.ssh/id_rsa
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN pip install -r requirements.txt
RUN chmod 777 -R /image-linux-py-playwright-qa