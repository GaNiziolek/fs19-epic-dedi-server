FROM ubuntu:focal

ARG MONO_VER="6.4.0"
ARG GECKO_VER="2.47"
ARG DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 \
&& apt-get update \
&& apt-get install -y --no-install-recommends cabextract curl ca-certificates gnupg wget python3 python3-pip \
&& curl -fsSL https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
&& echo 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' > /etc/apt/sources.list.d/wine.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends supervisor winbind winehq-stable winetricks xvfb haproxy \
&& mkdir -p /usr/share/wine/mono /usr/share/wine/gecko \
&& wget https://dl.winehq.org/wine/wine-mono/${MONO_VER}/wine-mono-${MONO_VER}-x86.msi -O /usr/share/wine/mono/wine-mono-${MONO_VER}.msi \
&& wget https://dl.winehq.org/wine/wine-gecko/${GECKO_VER}/wine_gecko-${GECKO_VER}-x86.msi -O /usr/share/wine/gecko/wine_gecko-${GECKO_VER}-x86.msi \
&& wget https://dl.winehq.org/wine/wine-gecko/${GECKO_VER}/wine_gecko-${GECKO_VER}-x86_64.msi -O /usr/share/wine/gecko/wine_gecko-${GECKO_VER}-x86_64.msi \
&& rm -rf /var/lib/apt/lists/* \
&& apt-get autoremove -y \
&& apt-get autoclean -y

RUN mkdir /app

ENV WINEPREFIX=/app

RUN winecfg && \
    winetricks --unattended settings win10 && \
    winetricks dxvk

RUN pip install legendary-gl

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY haproxy.cfg /etc/haproxy/haproxy.cfg

COPY start.sh /app

RUN chmod +x /app/start.sh

CMD "/app/start.sh"
