# Use official Node.js image
FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy app source code
COPY . .

# Expose port (the app listens on 3000)
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
