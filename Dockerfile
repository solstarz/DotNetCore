FROM microsoft/aspnetcore
WORKDIR /app
EXPOSE 80

FROM microsoft/aspnetcore-build
WORKDIR /src
COPY *.sln ./
COPY WebApplication1/WebApplication1.csproj WebApplication1/
RUN dotnet restore
COPY . .
WORKDIR /src/WebApplication1
RUN dotnet build -c Release -o /app

FROM build AS publish
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
