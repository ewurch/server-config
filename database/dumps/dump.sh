databases=($(psql -U admin -lqt | awk -F '|' '{print $1}' | grep -vE 'template[01]' | sed -e 's/ //g'))

if [ ${#databases[@]} -eq 0 ]; then
  echo "No databases found."
  exit 1
fi

# Prompt the user to choose a database
echo "Available databases:"
for ((i=0; i<${#databases[@]}; i++)); do
  echo "$((i+1)). ${databases[$i]}"
done

read -p "Enter the number of the database you want to use: " choice

# Validate the user's choice
if [[ ! $choice =~ ^[0-9]+$ || $choice -lt 1 || $choice -gt ${#databases[@]} ]]; then
  echo "Invalid choice. Please enter a valid number."
  exit 1
fi

# Use the selected database
selected_database="${databases[$((choice-1))]}"

read -p "Do you want to use the current date as a variable? (yes/no): " answer

if [ "$answer" = "yes" ]; then
  date_variable=$(date +'%d_%m_%Y')
else
  read -p "Enter a date in the format dd_mm_yyyy: " custom_date
  date_variable=$custom_date
fi

dump_name="/var/lib/postgresql/dumps/${selected_database}_${date_variable}.sql"
echo "The dump name is: $date_variable"
echo "Dumping $dump_name into dumps folder"
pg_dump -U admin "$selected_database" > "$dump_name"
