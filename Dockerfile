#FROM debian:bullseye-slim
FROM rust:1.78.0-slim-bullseye
ARG DEBIAN_FRONTEND=noninteractive

# Install the necessary libraries to use python3.11
RUN apt-get update \
&&  apt-get -y upgrade \
&&  apt-get install -y apt-utils \
&&  apt-get install -y tzdata  \
&&  apt-get install -y wget curl build-essential task-japanese locales-all \
&&  ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/* \
&&  echo "END"

# Install noip
#  (https://tarufu.info/domain_acquisition_no-ip/)
RUN cd /tmp \
&&  export PATH=${PATH}:/opt/rust/bin \
&&  wget https://dmej8g5cpdyqd.cloudfront.net/downloads/noip-duc_3.0.0.tar.gz \
&&  tar xvfz noip-duc_3.0.0.tar.gz \
&&  cd noip-duc_3.0.0 \
&&  cargo build --release \
&&  cp target/release/noip-duc /usr/local/bin \
&&  rm -rf /tmp/* \
&&  echo "END"

#&&  wget http://www.noip.com/client/linux/noip-duc-linux.tar.gz \

# Copying the startup script
# COPY ./config/start.sh ./config/no-ip2.conf /tmp/

# Install startup scripts and do final cleanup
# RUN mv /tmp/start.sh / \
# &&  mv /tmp/no-ip2.conf /usr/local/etc \
# &&  apt-get clean \
# &&  rm -rf /var/lib/apt/lists/* \
# &&  rm -rf /tmp/* \
# &&  echo "END"

