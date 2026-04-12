# Stage 1: Build
FROM 891377131628.dkr.ecr.us-east-1.amazonaws.com/node:18-alpine AS build
WORKDIR /app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build
RUN ls -l && ls -l dist

# Stage 2: Serve with Nginx
FROM 891377131628.dkr.ecr.us-east-1.amazonaws.com/nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/
COPY --from=build /app/dist /usr/share/nginx/html
RUN ls -l /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
