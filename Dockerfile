FROM ruby:2.5.1

RUN apt-get update && \
    apt-get install -y net-tools

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
ENV PORT 3004
EXPOSE 3000
#CMD ["ruby", "hello.rb"]
CMD ["bundle", "exec", "puma", "-t", "5:5", "-w", "20", "config.ru"]
#CMD ["rackup", "-s", "agoo", "-O", "wc=4"]
#CMD ["rackup", "-s", "iodine"]
#CMD ["iodine", "-p", "9292", "-t", "16", "-w", "4"]
