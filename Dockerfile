# build ombi for musl
FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS builder

# environment settings
ARG VERSION

RUN \
	echo "**** install runtime packages ****" && \
	apt-get update && \
	apt-get install -y \
		binutils \
		musl-tools \
          jq && \
	if [ -z ${VERSION+x} ]; then \
		VERSION=$(curl -sL "https://api.github.com/repos/Ombi-app/Ombi/releases" | jq -r 'first(.[] | select(.prerelease == true)) | .tag_name' | cut -c 2-); \
	fi && \
	curl --silent -o \
		/tmp/ombi.tar.gz -L \
		"https://github.com/Ombi-app/Ombi/archive/v${VERSION}.tar.gz" && \
	tar xzf \
		/tmp/ombi.tar.gz -C \
		/tmp/ --strip-components=1 && \
	if [ "$(arch)" = "x86_64" ]; then \
		ARCH="x64"; \
	elif [ "$(arch)" == "aarch64" ]; then \
		ARCH="arm64"; \
	fi && \
	dotnet publish /tmp/src/Ombi \
		-f net5.0 \
		--self-contained \
		-c Release \
		-r linux-musl-${ARCH} \
		/p:TrimUnusedDependencies=true \
		/p:PublishTrimmed=true \
		-o /out && \
	echo "**** cleanup ****" && \
	chmod +x /out/Ombi && \
     echo "**** done building ombi ****"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# runtime stage
FROM vcxpz/baseimage-alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Ombi version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

RUN \
	echo "**** install runtime packages ****" && \
	apk add --no-cache --upgrade \
		libintl \
		libssl1.1 \
		libstdc++ \
		icu-libs && \
	echo "**** cleanup ****" && \
	rm -rf \
		/tmp/*

# copy files from builder
COPY --from=builder /out /app/ombi

# add local files
COPY root/ /

# ports and volumes
VOLUME /config
EXPOSE 3579
