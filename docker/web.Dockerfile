# Use an official Dart runtime as a parent image
FROM dart:stable AS build

# Set the working directory to /app
WORKDIR /cal-flutter

# Copy the build output to the container's /app directory
COPY build/web ./

# Expose port 8080 for the app to listen on
EXPOSE 8080

# Start the app when the container launches
CMD ["dart", "bin/server.dart"]