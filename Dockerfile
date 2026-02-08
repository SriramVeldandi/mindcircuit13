##artifact build stage
FROM maven AS buildstage
RUN mkdir /opt/mindcircuit13
WORKDIR /opt/mindcircuit13
COPY . .
RUN mvn clean install    ## artifact -- .war

### tomcat deploy stage
FROM tomcat:11.0.18-jdk25-temurin-noble
WORKDIR webapps
COPY --from=buildstage /opt/mindcircuit13/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
