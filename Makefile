BIN_DIR   := bin
DAEMON    := $(BIN_DIR)/taskmasterd
CLIENT    := $(BIN_DIR)/taskmaster
SOURCES   := $(shell find . -name '*.go' -not -path './vendor/*') $(wildcard go.mod go.sum)

COMPOSE   := docker compose
SVC       := dev

# Build Go : fonctionne dans le conteneur comme sur la VM de soutenance
.PHONY: all
all: $(DAEMON) $(CLIENT)

$(DAEMON): $(SOURCES)
	go build -o $@ ./cmd/taskmasterd

$(CLIENT): $(SOURCES)
	go build -o $@ ./cmd/taskmaster

.PHONY: clean
clean:
	go clean

.PHONY: fclean
fclean: clean
	rm -rf $(BIN_DIR)

.PHONY: re
re: fclean all


# Environnement Docker
.PHONY: up
up:
	$(COMPOSE) up -d --build

.PHONY: down
down:
	$(COMPOSE) down

.PHONY: shell
shell: up
	$(COMPOSE) exec $(SVC) bash

.PHONY: bash
bash:
	$(COMPOSE) exec $(SVC) bash

# Compile dans le conteneur sans y entrer
.PHONY: dbuild
dbuild: up
	$(COMPOSE) exec $(SVC) make all

.PHONY: docker-clean
docker-clean:
	$(COMPOSE) down -v --rmi local
