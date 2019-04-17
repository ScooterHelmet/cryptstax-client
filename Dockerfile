FROM node:10

# Define where to hold the application code inside the image - Create app directory
WORKDIR /usr/src/app

# Use npm binary to install dependencies - Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# Install Production Runtime and Process Manager for Node.js
RUN npm install -g serve

# Development Build
RUN npm install

# Bundle app source
COPY . .

#Set ENV Variable 
ENV NODE = "production"

# Add ENV value to be used
ADD . $NODE

# Build production static files to be served
RUN npm run build 

# Clean up
RUN rm -rf ./src

# Run production
CMD ["serve","-s","build"]

# Bind ports to have mapped by the docker daemon
EXPOSE 5000
