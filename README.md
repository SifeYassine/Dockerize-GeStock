## Laravel GeStock REST API app's Build Process:

1. **Configure the .env file**

```bach
DB_CONNECTION=mysql
DB_HOST=mysql_db
DB_PORT=3306
DB_DATABASE=GeStock
DB_USERNAME=root
DB_PASSWORD=rootpassword
```

2. **Build The Image:**

```bash
docker-compose build
```

3. **Up The Container:**

```bash
docker-compose up
```

## Serving The Application

1. **Generate The Key:**

```bash
docker exec laravel-docker php artisan key:generate
```

2. **Migrate The Tables:**

```bash
docker exec laravel-docker php artisan migrate
```
