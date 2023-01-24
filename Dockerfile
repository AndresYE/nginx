#Escuela Politécnica Nacional
#Tema: Servicios de Red Basado en Contenedores
#Autor: Andrés Lenin Yazán Endara
#Servicio: Web (Nginx)
#Archivo: Dockerfile
#Implementación Servidores Web Virtuales

## Imagen Base
# El servicio vsftpd se implementara sobre una imagen base Nginx basada en Alpine Linux
# versión 3.14
FROM nginx:1.22.1-alpine

##Archivos de Configuración
# Copiar archivo nginx.conf
COPY ./etc/nginx/nginx.conf ./etc/nginx/nginx.conf

#Copiar carpeta  de configuraciones de sitios web Nginx
COPY ./etc/nginx/sites-E ./etc/nginx/sites-E

## Carpetas de Sitio Web
#Carpeta compartida de Nginx
COPY ./usr/share/nginx ./usr/share/nginx
#Propietario de carpeta compartida de Nginx
RUN chown -R root:root /usr/share/nginx
#Permisos de carpeta compartida de Nginx
RUN chmod -R 0755 /usr/share/nginx

##Archivos de Log
#Copiar Archivos de nginx
COPY ./var/log/nginx ./var/log/nginx
#Propietario de carpeta log de  Nginx
RUN chown -R nginx:nginx /var/log/nginx
#Permisos de carpeta log de  Nginx
RUN chmod -R 0755 /var/log/nginx

## Directorio de Trabajo
#Establecemos el directorio de trabajo en el direcotrio raiz /
WORKDIR ./

## Puertos de Escucha de Contenedor
# Exponemos los puertos requeridos para las respuestas del servidor nginx
EXPOSE 80/tcp 80/udp 443/tcp 443/udp 

#Nginx 
##ENTRYPOINT
ENTRYPOINT ["nginx"]
##CMD
# Configuramos comandos para el despligue del contenedor
CMD ["-c","/etc/nginx/nginx.conf","-g", "daemon off;"]