# A small static site image using Nginx's maintained Alpine distribution.
FROM nginx:alpine

COPY public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
