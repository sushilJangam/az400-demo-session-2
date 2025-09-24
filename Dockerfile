FROM node:22-slim

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --production


COPY . .

EXPOSE 4500

#1-65655

ENV PORT=4500
# From start application iniside container
CMD ["npm", "start"]