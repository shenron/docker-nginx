# reverse proxy

Use case :

- the application needs two backends with different versions of PHP (5.6.x and 7.1.x). Nginx uses upstream configuration to locate PHP services
 > hosts of PHP services, `front` and `front-lgcy` 
- gzip static files from an other nginx
> host: `static`