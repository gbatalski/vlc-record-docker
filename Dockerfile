FROM ubuntu:18.04
RUN apt-get update && \
    apt-get -y --no-install-recommends install libqt4-dev libx11-dev vlc-bin vlc-plugin-base libqt4-sql-sqlite libvlc-dev build-essential gawk gtk2-engines-pixbuf git ca-certificates 
RUN git clone https://github.com/Jo2003/vlc_record.git vlc-record && \ 
    cd vlc-record && qmake-qt4 vlc-record.pro && make -j release && \
    make -f install.mak


FROM ubuntu:18.04
COPY --from=0 vlc-record/packages .
RUN apt-get update && \
    apt-get -y --no-install-recommends install vlc  gtk2-engines-pixbuf libqt4-help libqt4-network libqt4-sql-sqlite libqt4-xml libqtcore4 libqtgui4 && \ 
    dpkg -i vlc-record_*.deb && rm -rf vlc_record* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD [ "vlc-record" ]
