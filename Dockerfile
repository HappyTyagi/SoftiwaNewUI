# Stage 1: Build Angular Application
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the Angular application code
COPY . .

# Build the Angular app in production mode
RUN npm run build --prod

# Stage 2: Serve Angular Application
FROM nginx:alpine

# Copy the build output from the build stage to NGINX's default public folder
COPY --from=build /app/dist/sakai-ng /usr/share/nginx/html

# Expose port 80 for the container
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
