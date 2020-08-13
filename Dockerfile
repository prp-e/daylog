FROM ruby:2.6.6

CMD apt update 
CMD gem install bundle 

CMD curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
CMD echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
CMD apt update 
CMD apt install yarn

ENV RAILS_ENV=production

RUN mkdir /app
ADD . /app 
WORKDIR /app

RUN bundle --update bundler

RUN bundle 
RUN rake db:create 
RUN rake db:migrate 
ENV SECRET_KEY_BASE='$(rake secret)'

CMD rails s -b 0.0.0.0 -e production 