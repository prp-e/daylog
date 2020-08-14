FROM ruby:2.6.6

RUN apt update 
RUN apt install build-essential
RUN gem install bundler:2.1.4

RUN RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt update
RUN apt install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list
RUN apt update 
RUN apt install -y yarn

ENV RAILS_ENV=production

RUN mkdir /app
ADD . /app 
WORKDIR /app

#RUN bundle --update bundler

RUN bundle 
ENV SECRET_KEY_BASE='$(rake secret)'
RUN rake db:setup
RUN rails assets:precompile
#RUN rake db:migrate 
#ENV SECRET_KEY_BASE='$(rake secret)'

#RUN rails s -b 0.0.0.0 -e production 
