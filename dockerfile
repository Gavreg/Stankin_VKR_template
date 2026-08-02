FROM texlive/texlive:TL2025-historic
RUN sed -i 's/main$/main contrib/' /etc/apt/sources.list && apt update && apt install -y fonts-liberation python3.14 ttf-mscorefonts-installer
RUN pip install Pygments
RUN fc-cache -f -v /usr/share/fonts
WORKDIR /data

