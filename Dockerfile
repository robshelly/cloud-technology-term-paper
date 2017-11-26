FROM node:boron

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./

# Bundle app source
COPY . /usr/src/app

RUN npm run build

EXPOSE 5000
CMD [ "npm", "run", "serve:build" ]