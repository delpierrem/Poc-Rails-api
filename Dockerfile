FROM ruby:2.5

RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev


RUN mkdir /app
WORKDIR /app
ENV HOME /app

ENV PATH /app/bin:/app/.bundle/vendor/bin:$PATH
ENV BUNDLE_PATH /app/.bundle/vendor
ENV BUNDLE_APP_CONFIG $BUNDLE_PATH
ENV GEM_HOME $BUNDLE_PATH

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000
EXPOSE 3035
