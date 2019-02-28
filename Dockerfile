FROM ruby:2.5.3

LABEL "com.github.actions.name"="Check Licenses"
LABEL "com.github.actions.description"="Checks open source licenses in a project"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="yellow"

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN apt-get update -qq
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev cmake locales python3.6 locales-all bash curl

RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs

ADD https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz /tmp/go.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz
ENV PATH $PATH:/usr/local/go/bin

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
RUN gem install licensed

# We need to install our NPM dependencies as necessary.
COPY package.json .
COPY package-lock.json .

COPY check-licenses.sh /usr/bin/check-licenses

ENTRYPOINT ["check-licenses"]
