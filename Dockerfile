# Use the official Nginx image
FROM nginx:alpine

# Install sed
RUN apk add --no-cache sed

# Set the working directory to where Nginx serves files
WORKDIR /usr/share/nginx/html

# Copy all HTML/HTM files from your project to the working directory
COPY root/ .

# Inject tracking code into all .html and .htm files
RUN find . -type f \( -iname "*.html" -o -iname "*.htm" \) -exec \
  sed -i '/<\/head>/i\<script defer src="https://umami.app.lyttle.dev/script.js" data-website-id="a7bf0345-2819-4abe-9297-5a9ba766d527"><\/script>' {} +

# Copy the custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
