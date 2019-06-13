# use ruby version 2.6.3
FROM ruby:2.6.3

# using japanese on rails console
ENV LANG C.UTF-8

# remove warn
ENV DEBCONF_NOWARNINGS yes
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE yes
ENV XDG_CACHE_HOME /tmp
EXPOSE 3000

# install package to docker container
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# setting work directory
RUN mkdir /belion
WORKDIR /belion
COPY . /belion

RUN gem install bundler && bundle install
