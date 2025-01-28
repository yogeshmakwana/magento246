#!/bin/bash

# Create directories for tools and reports
mkdir -p tools/compatibility
mkdir -p reports

# Install development tools
composer require --dev \
    phpstan/phpstan \
    squizlabs/php_codesniffer \
    phpmd/phpmd \
    rector/rector \
    vimeo/psalm

# Create PHPStan configuration
cat > phpstan.neon << EOL
parameters:
    level: 5
    paths:
        - app/code/Namicargo/Shipping
    phpVersion: 80200
    checkMissingIterableValueType: false
    checkGenericClassInNonGenericObjectType: false
    ignoreErrors:
        - '#Property .* has no type specified#'
EOL

# Create PHPCS configuration
cat > phpcs.xml << EOL
<?xml version="1.0"?>
<ruleset name="Magento2">
    <description>Magento 2 Coding Standard</description>
    <rule ref="PSR2"/>
    <file>app/code/Namicargo/Shipping</file>
    <arg name="extensions" value="php"/>
    <arg name="report" value="full"/>
    <arg name="colors"/>
</ruleset>
EOL

# Create Rector configuration
cat > rector.php << EOL
<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;
use Rector\Set\ValueObject\SetList;
use Rector\Set\ValueObject\LevelSetList;

return static function (RectorConfig \$rectorConfig): void {
    \$rectorConfig->paths([
        __DIR__ . '/app/code/Namicargo/Shipping'
    ]);

    \$rectorConfig->sets([
        SetList::PHP_82,
        LevelSetList::UP_TO_PHP_82
    ]);
};
EOL

# Create Psalm configuration
cat > psalm.xml << EOL
<?xml version="1.0"?>
<psalm
    errorLevel="4"
    resolveFromConfigFile="true"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="https://getpsalm.org/schema/config"
    xsi:schemaLocation="https://getpsalm.org/schema/config vendor/vimeo/psalm/config.xsd"
>
    <projectFiles>
        <directory name="app/code/Namicargo/Shipping" />
    </projectFiles>
</psalm>
EOL

# Create optimization script
cat > optimize-extension.sh << EOL
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
EOL

chmod +x optimize-extension.sh
