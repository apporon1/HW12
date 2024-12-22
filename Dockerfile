# Используем .NET SDK для сборки приложения
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Копируем все файлы в контейнер
COPY . ./

# Восстанавливаем зависимости и публикуем приложение
RUN dotnet restore
RUN dotnet publish -c Release -o /app/out

# Используем минимальный образ для запуска
FROM mcr.microsoft.com/dotnet/runtime:9.0
WORKDIR /app

# Копируем опубликованное приложение из предыдущего этапа
COPY --from=build /app/out .

# Указываем команду для запуска приложения
ENTRYPOINT ["dotnet", "HW12.dll"]
