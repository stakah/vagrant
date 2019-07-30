agents=$(ps -A | grep ssh-agent | wc -l)

echo "Agents: $agents"

if  (( $agents==0 )) ; then
  echo "creating agent"
  eval `ssh-agent`
fi

ps -A | grep ssh-agent

