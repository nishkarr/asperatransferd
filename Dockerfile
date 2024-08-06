FROM debian:bullseye as builder
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl unzip
WORKDIR /temp
RUN curl -L https://ibm.biz/aspera_transfer_sdk -o aspera_transfer_sdk.zip
RUN unzip -qud . aspera_transfer_sdk.zip
COPY daemon.conf .
FROM debian:bullseye-slim
WORKDIR /usr/local/asperatransferd
COPY --from=builder /temp/linux-x86_64 /usr/local/asperatransferd/linux-x86_64
COPY --from=builder /temp/noarch       /usr/local/asperatransferd/etc
COPY --from=builder /temp/daemon.conf  /usr/local/asperatransferd/etc/daemon.conf
VOLUME [ "/var/log/asperatransferd/logs" ]
EXPOSE 5500
CMD ["/usr/local/asperatransferd/linux-x86_64/asperatransferd", "-c", "/usr/local/asperatransferd/etc/daemon.conf"]
