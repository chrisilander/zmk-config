##@ General

.PHONY: help
help: ## Display usage
	@awk 'BEGIN { \
		FS = ":.*##"; \
		TEXT_CYAN = "\033[36m"; \
		TEXT_BOLD = "\033[1m"; \
		TEXT_RESET = "\033[0m"; \
		printf "\nUsage:\n  make %s<target>%s\n", TEXT_CYAN, TEXT_RESET; \
	} \
	/^##@/ { \
		printf "\n%s%s%s\n", TEXT_BOLD, substr($$0, 5), TEXT_RESET; \
	} \
	/^[a-zA-Z0-9\/_-]+:.*##/ { \
		gsub(/^[ \t]+/, "", $$2); \
		printf "  %s%-30s%s %s\n", TEXT_CYAN, $$1, TEXT_RESET, $$2; \
	}' $(MAKEFILE_LIST)

##@ Keymap drawing

.PHONY: draw
draw: ## Draw keymap
	keymap -c keymap-drawer.yaml parse --zmk-keymap config/corne.keymap >keymap-drawer/keymap.yaml
	keymap -c keymap-drawer.yaml draw keymap-drawer/keymap.yaml >keymap-drawer/keymap.svg
