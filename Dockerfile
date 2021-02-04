FROM ubuntu

MAINTAINER Emilien BINET <78504841+EmilienBINET@users.noreply.github.com>

RUN  apt-get update \
  && apt-get install -y wget python3 \
  && rm -rf /var/lib/apt/lists/*

ADD resetbox.sh /bin/resetbox.sh
ADD tplink_smartplug.py /bin/tplink_smartplug.py

ENTRYPOINT [ "/bin/resetbox.sh" ]
