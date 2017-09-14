mariadb:
        image: mariadb
        ports:
        - "3306:3306"
        environment:
        - MYSQL_ROOT_PASSWORD=123456
php-fpm:
        volumes:
        - /data/php-fpm/etc/php-fpm.conf:/usr/local/etc/php-fpm.conf
        - /data/php-fpm/etc/php-fpm.d/:/usr/local/etc/php-fpm.d
        image: php-fpm
nginx:
        volumes:
        - /data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf
        - /data/nginx/conf.d:/etc/nginx/conf.d
        - /www:/www
        links:
        - php-fpm 
        image: nginx
redis:   
        image: redis
