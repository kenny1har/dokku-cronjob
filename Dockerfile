FROM nginx:alpine
COPY cron /etc/crontabs/root
COPY index.txt /usr/share/nginx/html
RUN apk add --no-cache tzdata
ENV TZ Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN sed -i -e 's/localhost/_/g' /etc/nginx/conf.d/default.conf
RUN sed -i -e 's/index.html/index.txt index.html/g' /etc/nginx/conf.d/default.conf
CMD nginx && crond -f -d 8
