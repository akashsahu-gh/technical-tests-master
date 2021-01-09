FROM python:2
WORKDIR /usr/src/app

RUN git clone https://github.com/akashsahu-gh/technical-tests-master.git

WORKDIR /usr/src/app/technical-tests-master

RUN pip install --no-cache-dir -r ./Test2/api/requirements.txt

CMD [ "python", "/usr/src/app/technical-tests-master/Test2/api/main.py" ]
EXPOSE 8080