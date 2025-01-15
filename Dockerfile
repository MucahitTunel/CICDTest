# Use Node.js LTS version as base image
FROM node:18-alpine

# Install system dependencies
RUN apk add --no-cache \
    ruby \
    ruby-dev \
    build-base \
    git \
    python3 \
    bash

# Set working directory
WORKDIR /app

# Install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Install Node.js dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Set environment variables
ENV NODE_ENV=production

# Expose port if needed (for dev server)
EXPOSE 8081

# Default command
CMD ["npm", "start"] 