#!/bin/bash

file=$(find . -type f -iname "*$1")
suite_name=$(echo "$1" | sed 's/_test_output.log//' | tr '[:lower:]' '[:upper:]')

if [[ ! -f "$file" ]]; then
  echo "### :warning: No test log file found: $1" >> $GITHUB_STEP_SUMMARY
  exit 1
fi

# Count test results from JSON output
total=$(grep -c '"Action":"run"' "$file" 2>/dev/null || echo "0")
passed=$(grep -c '"Action":"pass"' "$file" 2>/dev/null || echo "0")
failed=$(grep -c '"Action":"fail"' "$file" 2>/dev/null || echo "0")
skipped=$(grep -c '"Action":"skip"' "$file" 2>/dev/null || echo "0")

# Get test-level counts (exclude package-level results)
test_passed=$(grep '"Action":"pass"' "$file" | grep '"Test":' | wc -l | tr -d ' ')
test_failed=$(grep '"Action":"fail"' "$file" | grep '"Test":' | wc -l | tr -d ' ')
test_total=$((test_passed + test_failed))

# Generate summary
if grep -qi "Returning due to fatal error:" "$file"; then
  echo "## :x: $suite_name Tests - FAILED" >> $GITHUB_STEP_SUMMARY
  echo "" >> $GITHUB_STEP_SUMMARY
  echo "| Metric | Count |" >> $GITHUB_STEP_SUMMARY
  echo "|--------|-------|" >> $GITHUB_STEP_SUMMARY
  echo "| :white_check_mark: Passed | $test_passed |" >> $GITHUB_STEP_SUMMARY
  echo "| :x: Failed | $test_failed |" >> $GITHUB_STEP_SUMMARY
  echo "| **Total** | **$test_total** |" >> $GITHUB_STEP_SUMMARY
  
  # List failed tests
  if [[ "$test_failed" -gt 0 ]]; then
    echo "" >> $GITHUB_STEP_SUMMARY
    echo "### Failed Tests" >> $GITHUB_STEP_SUMMARY
    grep '"Action":"fail"' "$file" | grep '"Test":' | jq -r '.Test' 2>/dev/null | sort -u | while read test_name; do
      echo "- :x: \`$test_name\`" >> $GITHUB_STEP_SUMMARY
    done
  fi
  
  exit 1
else
  echo "## :white_check_mark: $suite_name Tests - ALL PASSED" >> $GITHUB_STEP_SUMMARY
  echo "" >> $GITHUB_STEP_SUMMARY
  echo "| Metric | Count |" >> $GITHUB_STEP_SUMMARY
  echo "|--------|-------|" >> $GITHUB_STEP_SUMMARY
  echo "| :white_check_mark: Passed | $test_passed |" >> $GITHUB_STEP_SUMMARY
  echo "| :x: Failed | $test_failed |" >> $GITHUB_STEP_SUMMARY
  echo "| **Total** | **$test_total** |" >> $GITHUB_STEP_SUMMARY
fi
