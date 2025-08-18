.PHONY: deploy-development
deploy-development: TEMP_VAULT_PASSWORD_FILE := $(shell mktemp)
deploy-development: HOSTS_FILE := inventories/development/hosts.yml
deploy-development: HOSTS_TEMPLATE := inventories/development/hosts.yml.template
deploy-development:
	@# Validate required environment variables
	@if [ -z "$$DEVELOPMENT_HOST" ]; then \
		echo "Error: DEVELOPMENT_HOST environment variable is not set"; \
		exit 1; \
	fi
	@if [ -z "$$ANSIBLE_VAULT_PASSWORD" ]; then \
		echo "Error: ANSIBLE_VAULT_PASSWORD environment variable is not set"; \
		exit 1; \
	fi

	@# Create hosts file from template
	cp $(HOSTS_TEMPLATE) $(HOSTS_FILE)
	sed -i '' "s|<DEVELOPMENT_HOST>|$$DEVELOPMENT_HOST|g" $(HOSTS_FILE)

	@# Run playbook with vault password
	echo "$$ANSIBLE_VAULT_PASSWORD" > "$(TEMP_VAULT_PASSWORD_FILE)"
	ansible-playbook \
		-i $(HOSTS_FILE) \
		deploy_development.yml \
        --extra-vars "service_name=auto-go-app" \
		--vault-password-file "$(TEMP_VAULT_PASSWORD_FILE)"

	@# Cleanup
	rm -f "$(TEMP_VAULT_PASSWORD_FILE)" $(HOSTS_FILE)
