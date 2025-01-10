file=$(find . -type f -iname "*suite.log")

if grep -q Error "$file"; then
  echo "### Tests are failed !!! Please verify report" >> $GITHUB_STEP_SUMMARY
  exit 1
else
  echo "### Tests are passed !!! ::rocket::" >> $GITHUB_STEP_SUMMARY
fi