# Stage 1: Build stage using the SDK image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release

# Set the working directory inside the container
WORKDIR /src

# Copy the .csproj file and restore dependencies
COPY FileProcessorApp/FileProcessorApp.csproj ./FileProcessorApp/
RUN dotnet restore ./FileProcessorApp/FileProcessorApp.csproj

# Copy the rest of the application source code
COPY . .

# Set the working directory to the project folder and build the app
WORKDIR /src/FileProcessorApp
RUN dotnet build FileProcessorApp.csproj -c $BUILD_CONFIGURATION -o /app/build

# Stage 2: Publish the app to be used in the final image
FROM build AS publish
RUN dotnet publish FileProcessorApp.csproj -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# Stage 3: Final runtime image
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS base
WORKDIR /app

# Copy the published app from the previous stage
COPY --from=publish /app/publish .

# Entry point to run the application
ENTRYPOINT ["dotnet", "FileProcessorApp.dll"]
