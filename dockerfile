FROM texlive/texlive:latest

RUN sed -i 's/main$/main contrib/' /etc/apt/sources.list &&\
    apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-liberation \
        #python3-pip \
        ttf-mscorefonts-installer &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

#RUN pip3 install --upgrade "latexminted>=0.7.0" --break-system-packages     &&\
#    ln -sf /usr/local/bin/latexminted /usr/local/texlive/2025/bin/x86_64-linux/latexminted

RUN fc-cache -f -v /usr/share/fonts 

WORKDIR /data

