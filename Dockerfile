FROM djbingham/licensed:latest

LABEL "com.github.actions.name"="Check Licenses"
LABEL "com.github.actions.description"="Checks open source licenses in a project"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="yellow"

RUN apk update
RUN apk add -y build-essential libpq-dev cmake language-pack-en bash curl

RUN gem install licensed

COPY check-licenses.sh /usr/bin/check-licenses

ENTRYPOINT ["check-licenses"]
