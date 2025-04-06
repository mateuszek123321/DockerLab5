FROM scratch AS build

ADD alpine.tar /

WORKDIR /usr/app

ARG VERSION="1.0.0"

RUN touch index.html && \
		echo "Adres ip: $(hostname -i)" >> index.html && \
        echo "Nazwa serwera: $(hostname)" >> index.html && \
        echo "Wersja: $VERSION" >> index.html
    
FROM nginx

WORKDIR /usr/share/nginx/html

COPY --from=build /usr/app/index.html .

EXPOSE 80

HEALTHCHECK --interval=10s --timeout=1s \
  	CMD curl -f http://localhost:80/ || exit 1

    
CMD ["nginx", "-g", "daemon off;"]
