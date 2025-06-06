.PHONY: django-uv-mysql-drf, django-uv-postgres-drf

PROJECT_NAME = django-uv
TARGET_BUILD = docker build --target

dj-uv-mysql-drf:
	$(TARGET_BUILD) base-uv-mysql-drf -t $(PROJECT_NAME):mysql-drf-version .

dj-uv-psql-drf:
	$(TARGET_BUILD) base-uv-psql-drf -t $(PROJECT_NAME):postgres-drf-version .