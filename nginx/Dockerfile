FROM nginx
RUN apt-get update -qq && apt-get install apache2-utils -y
RUN apt-get update -qq && apt-get  install zip -y
ENV RAILS_ROOT /var/www/app
WORKDIR $RAILS_ROOT
RUN mkdir -p log
COPY nginx/app.conf /tmp/docker_example.nginx
RUN envsubst '$RAILS_ROOT' < /tmp/docker_example.nginx > /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
