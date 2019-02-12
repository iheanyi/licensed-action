FROM ruby:latest

LABEL "com.github.actions.name"="Cache Licenses"
LABEL "com.github.actions.description"="Displays a gif of Conan shaking his finger to a pull request on fail"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="yellow"

COPY Gemfile .
RUN bundle install

COPY check-licenses.sh /usr/bin/check-licenses

ENTRYPOINT ["check-licenses"]
