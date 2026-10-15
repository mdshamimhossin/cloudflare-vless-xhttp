
FROM alpine:3.21

RUN apk add --no-cache ca-certificates curl unzip

RUN curl -fL --retry 3 \
    https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    -o /tmp/xray.zip \
    && mkdir -p /usr/local/share/xray \
    && unzip -o /tmp/xray.zip -d /usr/local/share/xray \
    && install -m 755 /usr/local/share/xray/xray /usr/local/bin/xray \
    && rm -f /tmp/xray.zip

COPY config.json /etc/xray/config.json

EXPOSE 8080

CMD ["xray", "run", "-config", "/etc/xray/config.json"]
