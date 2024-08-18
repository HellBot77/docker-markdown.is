FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/gtalarico/markdown.is.git && \
    cd markdown.is && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM node:16-alpine AS build

WORKDIR /markdown.is
COPY --from=base /git/markdown.is .
RUN npm install && \
    npm run build

FROM lipanski/docker-static-website

COPY --from=build /markdown.is/dist .
