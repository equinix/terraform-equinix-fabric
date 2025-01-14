
file=$(find . -type f -iname "*$1")

if grep -q error "$file"; then
  echo "### Tests are failed !!! Please verify report and log file $file" >> $GITHUB_STEP_SUMMARY
  exit 1
else
  echo "### Tests are passed !!! ::rocket::" >> $GITHUB_STEP_SUMMARY
fi