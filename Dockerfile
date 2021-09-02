FROM ruby:2.7-slim

COPY LICENSE README.md /

RUN gem install spicy-proton -v '2.1.9'

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
