.PHONY: django-uv-mysql, django-uv-postgres

PROJECT_NAME = django-uv
TARGET_BUILD = docker build --target

django-uv-mysql:
	$(TARGET_BUILD) base-uv-mysql -t $(PROJECT_NAME):mysql-version .

django-uv-postgres:
	$(TARGET_BUILD) base-uv-postgres -t $(PROJECT_NAME):postgres-version .