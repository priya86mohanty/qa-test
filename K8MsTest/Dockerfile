FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./

RUN dotnet build --configuration Release

# RUN dotnet test --configuration Release --no-build --logger "trx;LogFileName=test_results.trx"

CMD ["dotnet", "test", "--no-build"]
