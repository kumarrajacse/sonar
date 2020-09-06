FROM tomcat:9

COPY ./webapp/target/*.war /usr/local/tomcat/webapps/

EXPOSE 8081

CMD ["catalina.sh","run"]

