FROM ruby:2.5.3

LABEL "com.github.actions.name"="Check Licenses"
LABEL "com.github.actions.description"="Displays a gif of Conan shaking his finger to a pull request on fail"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="yellow"

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev cmake

COPY Gemfile .
RUN bundle install

COPY check-licenses.sh /usr/bin/check-licenses

ENTRYPOINT ["check-licenses"]
