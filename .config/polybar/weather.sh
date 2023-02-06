  forecast=$(curl "http://wttr.in/Los+Angeles?format=%C+%t")
  if [ "$(curl -s -o /dev/null -w "%{http_code}" wttr.in)" = "503" ]; then
    echo " "
    exit
  fi
  declare -A wicon
  wicon["Unknown"]=""
  wicon["Cloudy"]=""
  wicon["Fog"]=""
  wicon["Clear"]=""
  wicon["HeavyRain"]=""
  wicon["HeavyShowers"]=""
  wicon["HeavySnow"]=""
  wicon["HeavySnowShowers"]=""
  wicon["LightRain"]=""
  wicon["LightShowers"]=""
  wicon["LightSleet"]=""
  wicon["LightSleetShowers"]=""
  wicon["LightSnow"]=""
  wicon["LightSnowShowers"]=""
  wicon["Partly cloudy"]=""
  wicon["Sunny"]=""
  wicon["Overcast"]=""
  wicon["ThunderyHeavyRain"]=""
  wicon["ThunderyShowers"]=""
  wicon["ThunderySnowShowers"]=""
  wicon["VeryCloudy"]=""
  wicon["Haze"]=""
  state=$(echo $forecast | sed 's/ +.*$//')
  temp=$(echo $forecast | sed 's/^[^+]*+/+/')
  icon="${wicon["$state"]} ${temp} "
  echo "$icon"

