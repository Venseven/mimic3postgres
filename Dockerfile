FROM postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB postgres
COPY main.sql /docker-entrypoint-initdb.d/
RUN apt-get update 
RUN apt-get install wget -y
RUN apt-get install unzip -y
# RUN wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1kp9bkvAnLrQ9j-ifdF8T6eL19CcftIfC' -O MIMIC.zip
RUN wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1kp9bkvAnLrQ9j-ifdF8T6eL19CcftIfC' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1kp9bkvAnLrQ9j-ifdF8T6eL19CcftIfC" -O MIMIC.zip && rm -rf /tmp/cookies.txt
RUN unzip MIMIC.zip 
RUN rm MIMIC.zip