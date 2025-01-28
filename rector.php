<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;
use Rector\Set\ValueObject\SetList;
use Rector\Set\ValueObject\LevelSetList;

return static function (RectorConfig $rectorConfig): void {
    $rectorConfig->paths([
        __DIR__ . '/app/code/Namicargo/Shipping'
    ]);

    $rectorConfig->sets([
        SetList::PHP_82,
        LevelSetList::UP_TO_PHP_82
    ]);
};
