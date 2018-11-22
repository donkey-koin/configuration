FROM java:8-jre
ADD exchange.jar /apps/exchange/exchange.jar
ADD application.properties /apps/exchange/application.properties
ENTRYPOINT java -Dspring.config.location=/apps/exchange/application.properties -jar /apps/exchange/exchange.jar