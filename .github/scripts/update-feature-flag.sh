echo "Connection String: $CONNECTION_STRING"
echo "Environment: $ENVIRONMENT"

# Load the JSON data from the file
feature_flags=$(cat ../data/feature-flags.json)

# Iterate over each item in the JSON array
for row in $(echo "${feature_flags}" | jq -c '.[]'); do
  # Extract the key, value, and content_type fields
  key=$(echo $row | jq -r '.key')
  value=$(echo $row | jq -r '.value | tostring')
  content_type=$(echo $row | jq -r '.content_type')

  # Run the az command with the extracted values
  az appconfig kv set --connection-string $CONNECTION_STRING --content-type $content_type --label $ENVIRONMENT --key $key --value $value --yes
done
