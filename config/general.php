<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

return [
    // Global settings
    '*' => [
        // Default Week Start Day (0 = Sunday, 1 = Monday...)
        'defaultWeekStartDay' => 1,

        // Whether generated URLs should omit "index.php"
        'omitScriptNameInUrls' => true,

        // Control Panel trigger word
        'cpTrigger' => 'admin',

        // The secure key Craft will use for hashing and encrypting data
        'securityKey' => getenv('SECURITY_KEY'),

        // Whether to save the project config out to config/project.yaml
        // (see https://docs.craftcms.com/v3/project-config.html)
        'useProjectConfigFile' => false,
    ],

    // Dev environment settings
    'dev' => [
        // Base site URL
        'siteUrl' => null,
        // Dev Mode (see https://craftcms.com/support/dev-mode)
        'devMode' => true,
        // Set this to `false` to prevent administrative changes from being made on staging
        'allowAdminChanges' => true,
    ],

    // Production environment settings
    'production' => [
        // Base site URL
        'siteUrl' => 'https://bowerycap.com/',
        // Dev Mode (see https://craftcms.com/support/dev-mode)
        'devMode' => false,
        // Set this to `false` to prevent administrative changes from being made on staging
        'allowAdminChanges' => true,
    ],
];
