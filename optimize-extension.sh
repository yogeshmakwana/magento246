#!/bin/bash

echo "Starting extension optimization..."

# Run PHPStan
echo "Running PHPStan..."
./vendor/bin/phpstan analyse -c phpstan.neon > reports/phpstan.txt

# Run PHP CodeSniffer
echo "Running PHP CodeSniffer..."
./vendor/bin/phpcs --standard=phpcs.xml > reports/phpcs.txt

# Run PHP Mess Detector
echo "Running PHP Mess Detector..."
./vendor/bin/phpmd app/code/Namicargo/Shipping text cleancode,codesize,controversial,design,naming,unusedcode > reports/phpmd.txt

# Run Rector
echo "Running Rector..."
./vendor/bin/rector process app/code/Namicargo/Shipping --dry-run > reports/rector.txt

# Run Psalm
echo "Running Psalm..."
./vendor/bin/psalm --show-info=true > reports/psalm.txt

echo "Optimization analysis complete. Check the reports directory for results."
