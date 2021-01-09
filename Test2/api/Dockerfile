FROM python:2
WORKDIR /usr/src/app

RUN git clone https://github.com/akashsahu-gh/technical-tests-master.git

COPY . .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /usr/src/app/technical-tests-master

CMD [ "python", "/usr/src/app/technical-tests-master/Test2/api/main.py" ]
EXPOSE 8000