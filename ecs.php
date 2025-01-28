<?php
    
    // FILE - ecs.php
    // Location - Magento Root Directory
    
    use PhpCsFixer\Fixer\Basic\BracesFixer;
    use PhpCsFixer\Fixer\Basic\NoMultipleStatementsPerLineFixer;
    use PhpCsFixer\Fixer\ClassNotation\OrderedClassElementsFixer;
    use PhpCsFixer\Fixer\FunctionNotation\MethodArgumentSpaceFixer;
    use PhpCsFixer\Fixer\Operator\NotOperatorWithSuccessorSpaceFixer;
    use PhpCsFixer\Fixer\Phpdoc\GeneralPhpdocAnnotationRemoveFixer;
    use PhpCsFixer\Fixer\Phpdoc\NoSuperfluousPhpdocTagsFixer;
    use PhpCsFixer\Fixer\Phpdoc\PhpdocNoEmptyReturnFixer;
    use PhpCsFixer\Fixer\Whitespace\LineEndingFixer;
    use PhpCsFixer\Fixer\Whitespace\MethodChainingIndentationFixer;
    use PhpCsFixer\Fixer\Whitespace\NoWhitespaceInBlankLineFixer;
    use PhpCsFixer\Fixer\Whitespace\StatementIndentationFixer;
    use Symplify\CodingStandard\Fixer\LineLength\LineLengthFixer;
    use Symplify\CodingStandard\Fixer\Spacing\MethodChainingNewlineFixer;
    use Symplify\EasyCodingStandard\Config\ECSConfig;
    use Symplify\EasyCodingStandard\ValueObject\Option;
    use Symplify\EasyCodingStandard\ValueObject\Set\SetList;
    
    $phtmlPattern = [
        '*.phtml',
    ];
    
    return ECSConfig::configure()
        ->withFileExtensions([
            'php',
            'phtml',
        ])
        ->withSpacing(indentation: Option::INDENTATION_SPACES, lineEnding: PHP_EOL)
        ->withSets([
            SetList::PSR_12,
            SetList::CLEAN_CODE,
            SetList::SYMPLIFY,
            SetList::ARRAY,
            SetList::COMMON,
            SetList::COMMENTS,
            SetList::CONTROL_STRUCTURES,
            SetList::DOCBLOCK,
            SetList::NAMESPACES,
            SetList::SPACES,
        ])
        ->withPhpCsFixerSets(
            php82Migration: true
        )
        ->withSkip([
            NoWhitespaceInBlankLineFixer::class,
            LineEndingFixer::class,
            NotOperatorWithSuccessorSpaceFixer::class,
            GeneralPhpdocAnnotationRemoveFixer::class,
            NoSuperfluousPhpdocTagsFixer::class,
            PhpdocNoEmptyReturnFixer::class,
            OrderedClassElementsFixer::class,
            StatementIndentationFixer::class => [
                "*.phtml",
            ],
            MethodArgumentSpaceFixer::class => $phtmlPattern,
            BracesFixer::class => $phtmlPattern,
            NoMultipleStatementsPerLineFixer::class => $phtmlPattern,
            MethodChainingIndentationFixer::class => $phtmlPattern,
            LineLengthFixer::class => $phtmlPattern,
            MethodChainingNewlineFixer::class => $phtmlPattern,
        ]);