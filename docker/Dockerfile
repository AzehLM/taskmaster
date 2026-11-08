# syntax=docker/dockerfile:1

FROM golang:1.27-bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        supervisor \
		rsyslog \
		# utilitaires pour faire joujou avec les process supervisés
        procps psmisc less vim-tiny \
        # packages needed for demonstration
        nginx \
    && rm -rf /var/lib/apt/lists/*

# rsyslog sans systemd : pas d'accès au log noyau dans un conteneur
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

# Utilisateurs de test pour le privilege de-escalation
# Tu valides les username ?
RUN useradd -m -s /bin/bash louisleGOAT6767 \
    && useradd -m -s /bin/bash guizer \
    && mkdir -p /var/log/taskmaster

WORKDIR /app
