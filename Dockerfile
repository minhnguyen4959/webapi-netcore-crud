# Sử dụng .NET SDK để build ứng dụng
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy toàn bộ project vào container
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Sử dụng .NET runtime để chạy ứng dụng

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Thiết lập biến môi trường PORT và expose cổng 9999
ENV PORT=9999
EXPOSE 9999

# Chạy API.
CMD ["dotnet", "user-crud.dll"] 
