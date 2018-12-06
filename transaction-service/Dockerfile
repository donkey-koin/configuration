FROM java:8-jre
ADD transaction.jar /apps/transaction/transaction.jar
ADD application.properties /apps/transaction/application.properties
ENTRYPOINT java -Dspring.config.location=/apps/transaction/application.properties -jar /apps/transaction/transaction.jar