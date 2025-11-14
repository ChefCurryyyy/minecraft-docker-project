FROM registry.terreactive.ch/dockerhub/library/busybox:latest

WORKDIR /mc

ADD https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.13+11/OpenJDK17U-jre_x64_linux_hotspot_17.0.13_11.tar.gz /tmp/jre.tar.gz

RUN mkdir -p /opt && \
    tar -xzf /tmp/jre.tar.gz -C /opt && \
    mv /opt/$(ls /opt) /opt/jre && \
    rm /tmp/jre.tar.gz

ADD https://piston-data.mojang.com/v1/objects/95495a7f485eedd84ce928cef5e223b757d2f764/server.jar /mc/minecraft_server.1.21.10.jar

RUN echo "eula=true" > /mc/eula.txt

EXPOSE 25565

CMD ["/opt/jre/bin/java", "-Xmx1024M", "-Xms1024M", "-jar", "minecraft_server.1.21.10.jar", "nogui"]
