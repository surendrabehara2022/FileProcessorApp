# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS base
USER $APP_UID
WORKDIR /app

RUN dotnet --info
RUN dotnet --list-runtimes || echo "No .NET runtimes found"

# This stage is used to build the service project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
RUN dotnet --version || echo ".NET not installed"
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["FileProcessorApp/FileProcessorApp.csproj", "FileProcessorApp/"]
RUN dotnet restore "./FileProcessorApp/FileProcessorApp.csproj"

# List all restored packages after restore
RUN dotnet list package
COPY . .
WORKDIR "/src/FileProcessorApp"
RUN dotnet build "./FileProcessorApp.csproj" -c $BUILD_CONFIGURATION -o /app/build
RUN dotnet --info

# This stage is used to publish the service project to be copied to the final stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./FileProcessorApp.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "FileProcessorApp.dll"]
