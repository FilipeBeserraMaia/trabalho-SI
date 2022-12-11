FROM ruby:2.7.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /app
WORKDIR /app
COPY app/Gemfile /app/Gemfile
# COPY entrypoint.sh /myapp/entrypoint.sh
COPY app/Gemfile.lock /app/Gemfile.lock

RUN gem install bundler

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs
RUN gem install byebug -v '11.0.1' --source 'https://rubygems.org/'
RUN gem install nokogiri -v '1.10.5' --source 'https://rubygems.org/' 
RUN gem install nio4r -v '2.5.2' --source 'https://rubygems.org/'
RUN gem install bcrypt -v '3.1.13' --source 'https://rubygems.org/'
RUN gem install websocket-driver -v '0.7.1' --source 'https://rubygems.org/'
# RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
RUN gem install bindex -v '0.8.1' --source 'https://rubygems.org/'
RUN gem install msgpack -v '1.3.1' --source 'https://rubygems.org/'
RUN gem install bootsnap -v '1.4.5' --source 'https://rubygems.org/'
RUN gem install ffi -v '1.11.1' --source 'https://rubygems.org/'
RUN #gem install mini_racer -v '0.2.6' --source 'https://rubygems.org/'
RUN gem install json -v '2.2.0' --source 'https://rubygems.org/'
#RUN gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/'
#RUN #gem install mini_racer -v '0.2.6' --source 'https://rubygems.org/'
RUN gem install puma -v '3.12.1' --source 'https://rubygems.org/'
run gem install ffi -v '1.11.1' --source 'https://rubygems.org/'
#RUN gem install sassc -v '2.2.1' --source 'https://rubygems.org/'
RUN bundle install
COPY app /app


# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoindt.sh"]
EXPOSE 3000

# Start the main process.
# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
