# Stage 0: Build de Javascript distributable artifact
FROM node:alpine as buildstage
 
USER node
 
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
 
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

RUN npm run build

# Stage 1: Start serving the content build in stage 0 with Nginx
FROM nginx
COPY --from=buildstage /home/node/app/build /usr/share/nginx/html
