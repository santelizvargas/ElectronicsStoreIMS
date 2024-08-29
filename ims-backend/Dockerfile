# Usa Ubuntu 22.04 como imagen base
FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
ARG PORT=${PORT}
ARG DATABASE_URL=${DATABASE_URL}
ARG BASE_URL=${BASE_URL}
ARG API_PREFIX=${API_PREFIX}
ARG API_VERSION=${API_VERSION}
ARG JWT_SECRET=${JWT_SECRET}
ARG S3_ACCESS_SECRET=${S3_ACCESS_SECRET}
ARG S3_ACCESS_KEY=${S3_ACCESS_KEY}
ARG S3_REGION=${S3_REGION}
ARG S3_BUCKET_NAME=${S3_BUCKET_NAME}
ARG PG_USER=${PG_USER}
ARG PG_NAME=${PG_NAME}
ARG PG_HOST=${PG_HOST}
ARG PG_PORT=${PG_PORT}
ARG PGPASSWORD=${PGPASSWORD}

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
  curl \
  wget \
  gnupg2 \
  nano \
  && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /etc/apt/keyrings/yarn.gpg >/dev/null \
  && echo "deb [signed-by=/etc/apt/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
  && curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /etc/apt/keyrings/pgdg.gpg >/dev/null \
  && echo "deb [signed-by=/etc/apt/keyrings/pgdg.gpg] http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && apt-get install -y \
  postgresql-client-15 \
  postgresql-client-common \
  libpq-dev \
  postgresql \
  tzdata \
  nodejs \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . .

RUN npm ci

RUN npm run build

RUN npx prisma db push --schema ./src/apps/core/prisma

EXPOSE ${PORT}

CMD ["npm", "start"]
