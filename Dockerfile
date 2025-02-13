FROM node:14-alpine3.14

# Install Python 2 and other build dependencies
RUN apk add --no-cache python2 make g++ gcc

RUN mkdir /app
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies with Python 2 explicitly set
ENV PYTHON=/usr/bin/python2
RUN npm install --legacy-peer-deps

# Copy rest of the application
COPY . .

# Build the React app
RUN REACT_APP_IS_SAVE_TO_FILE_ENABLED=true npm run build

# Setup and run server
WORKDIR /app/server
RUN npm install
CMD ["npm", "start"]

EXPOSE 9000
