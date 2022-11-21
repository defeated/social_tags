# syntax=docker/dockerfile:1
### Build Stage: Environment: Development
FROM ruby:3.1.2-alpine3.16 AS app-development

WORKDIR /app

# Install compiled dependencies
RUN apk add --no-cache --virtual .vruntime sqlite-dev tzdata curl gzip && \
    apk add --no-cache --virtual .vbuildtime build-base gcompat

# Install Node/Yarn from base-node stage
COPY --link --from=node:18.12.1-alpine3.16 /opt/yarn-v1.22.19/ /opt/yarn-v1.22.19/
COPY --link --from=node:18.12.1-alpine3.16 /usr/local/bin/ /usr/local/bin/
COPY --link --from=node:18.12.1-alpine3.16 /usr/local/lib/node_modules/ /usr/local/lib/node_modules/

### Build Stage: Environment: Production
FROM app-development AS app-production

# configure rails app for Production
ENV RAILS_ENV=production \
    RACK_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RUBYOPT=--enable-frozen-string-literal \
    NODE_ENV=production

# Install production dependencies, then cleanup
COPY --link Gemfile* package.json yarn.lock ./
RUN yarn install --check-files --frozen-lockfile && \
    yarn cache clean && \
    bundle install --frozen --without "development test" --jobs $(nproc) && \
    rm -rf /usr/local/bundle/cache/* && \
    apk del .vbuildtime

# Install the rest of the app
COPY --link ./ ./

# Rails asset compilation
RUN ASSETS_ONLY=true ./bin/rails assets:precompile && \
    gzip --recursive --keep --best --force ./public/assets/*.css ./public/assets/*.js

# run puma directly in production
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
