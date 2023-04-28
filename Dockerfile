# ─── Build Phase ────────────────────────────────────────────────────────────

#specify a base image
FROM node:16-alpine as builder

#specify a working dir inside the container
WORKDIR '/app'


#install some dependencies
COPY package.json .
RUN npm install

#copy local files
COPY . .

#run default command
RUN npm run build


# ─── Run Phase ─────────────────────────────────────────────────────────────

#specify a base image
FROM nginx as runner

#copy output of build phase
COPY --from=builder /app/build /usr/share/nginx/html

#no need for run command for nginx to start