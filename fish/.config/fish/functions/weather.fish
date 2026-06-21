function weather -d "Show weather from wttr.in"
  curl -s 'wttr.in' | head -n-2
end
