# Use Node.js base image
FROM node:20-alpine as build

# Set working directory
WORKDIR /app

# Install app dependencies
COPY package.json package-lock.json ./
RUN npm install

# Bundle app source
COPY . .
RUN npm run build

FROM node:20-alpine
COPY --from=build /app/build ./
COPY . .
RUN npm install
RUN npm install -g serve
CMD ["serve" , "-s",  "build"]
