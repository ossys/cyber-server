FROM continuumio/miniconda

WORKDIR '/app'

RUN apt-get -y install gcc libc6-dev

COPY environment.yml .

RUN conda env create -f environment.yml

COPY . .

RUN conda activate Cyber
