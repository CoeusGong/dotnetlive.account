start_web:
	systemctl start kestrel-dotnetlive-account-web.service

stop_web:
	systemctl stop kestrel-dotnetlive-account-web.service

start_api:
	systemctl start kestrel-dotnetlive-account-web.service

stop_api:
	systemctl stop kestrel-dotnetlive-account-web.service

delete_current_build:
	rm -rf /var/dotnetlive/pubsite/dotnetlive.accountweb/

publish_web:
	git clean -df
	git pull
	dotnet restore src/AccountWeb/DotNetLive.AccountWeb.sln 
	cd src/AccountWeb/DotNetLive.AccountWeb && npm install && bower install --allow-root && gulp default
	dotnet publish src/AccountWeb/DotNetLive.AccountWeb/DotNetLive.AccountWeb.csproj -c "Release" -o /var/dotnetlive/pubsite/dotnetlive.accountweb/ 

publish_api:
	git clean -df
	git pull
	dotnet restore src/AccountApi/DotNetLive.AccountApi.sln 
	dotnet publish src/AccountApi/DotNetLive.AccountApi/DotNetLive.AccountApi.csproj -c "Release" -o /var/dotnetlive/pubsite/dotnetlive.accountapi/ 

deploy: stop publish_web publish_api start
