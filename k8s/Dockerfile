# Use a lightweight Node.js base image
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies (adjust if you use yarn)
RUN npm install

# Copy rest of the application code
COPY . .

# Use a smaller image for production
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy only the production dependencies
COPY --from=builder /app/node_modules /app/node_modules

# Copy your application code
COPY . .

# Expose port (adjust if your app listens on a different port)
EXPOSE 3000

# Start command (adjust if your app uses a different start script)
CMD [ "node", "app.js" ]
