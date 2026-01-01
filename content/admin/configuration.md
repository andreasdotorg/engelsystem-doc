---
title: "Configuration"
date: 2019-02-13T19:39:21+01:00
weight: 20
---

Engelsystem configuration lives in PHP files under the `config/` directory. The main configuration file is `config/config.php`, which overrides the defaults in `config/config.default.php`. Many settings can also be controlled through environment variables, making it easy to configure deployments via Docker or Kubernetes.

## How Configuration Works

Engelsystem loads configuration in this order:

1. **`config/config.default.php`** - Ships with sensible defaults. Never edit this file directly as updates will overwrite your changes.
2. **`config/config.php`** - Your local overrides. Copy settings from the default file and modify them here.
3. **Environment variables** - Many settings check for environment variables first, allowing container-based configuration.

The `env()` helper function checks for environment variables with a fallback value:

```php
// Uses TIMEZONE env var if set, otherwise 'Europe/Berlin'
'timezone' => env('TIMEZONE', 'Europe/Berlin'),
```

For a complete list of all options, see the comments in `config/config.default.php`.

## Essential Settings

These settings must be configured for any deployment.

### Database Connection

Engelsystem requires MySQL 5.7+ or MariaDB 10.2+. Configure your database credentials:

```php
'database' => [
    'host'     => env('MYSQL_HOST', 'localhost'),
    'database' => env('MYSQL_DATABASE', 'engelsystem'),
    'username' => env('MYSQL_USER', 'engelsystem'),
    'password' => env('MYSQL_PASSWORD', ''),
],
```

The database user needs SELECT, INSERT, UPDATE, and DELETE privileges. For migrations during updates, it also needs CREATE, ALTER, DROP, and INDEX privileges.

{{% notice warning %}}
Never commit database passwords to version control. Use environment variables or a `.env` file that's excluded from git.
{{% /notice %}}

### Application Name

Customize the application name shown in the interface and emails:

```php
'app_name' => env('APP_NAME', 'Engelsystem'),
```

Most events rename this to something meaningful like "Heaven" or "[Event Name] Angel System".

### Timezone

Set your event's timezone. All shift times display in this timezone:

```php
'timezone' => env('TIMEZONE', 'Europe/Berlin'),
```

Use PHP timezone identifiers like `America/New_York`, `Asia/Tokyo`, or `UTC`. See the [PHP timezone list](https://www.php.net/manual/en/timezones.php) for all options.

### Environment Mode

Controls error display and debugging:

```php
'environment' => env('ENVIRONMENT', 'production'),
```

| Value | Behavior |
|-------|----------|
| `production` | Hides detailed errors, optimizes for performance |
| `development` | Shows detailed error messages and stack traces |

{{% notice warning %}}
Never run `development` mode in production. Detailed errors can expose sensitive information.
{{% /notice %}}

## User Registration Settings

Control how volunteers can register and what information they provide.

### Enable Registration

Toggle whether new users can register:

```php
'registration_enabled' => (bool)env('REGISTRATION_ENABLED', true),
```

Disable this after your volunteer signup deadline or if you manage accounts manually.

### Arrival Requirement

Require volunteers to be marked as "arrived" before signing up for shifts:

```php
'signup_requires_arrival' => false,
```

Enable this to prevent people from taking shifts before they've physically arrived at the event. Staff at your info desk mark users as arrived when they check in.

### Password Requirements

Configure password security:

```php
// Minimum password length
'min_password_length' => 8,

// Hashing algorithm (use PASSWORD_DEFAULT for best security)
'password_algorithm' => PASSWORD_DEFAULT,
```

The `PASSWORD_DEFAULT` constant automatically uses PHP's recommended algorithm (currently bcrypt, may change in future PHP versions). Existing passwords are automatically re-hashed when users log in.

## Shift and Scheduling Settings

These settings control how shifts work and how volunteers interact with them.

### Shift Unsubscribe Window

How many hours before a shift starts can volunteers still cancel:

```php
'last_unsubscribe' => 3,
```

Set this high enough that coordinators have time to find replacements, but low enough that volunteers have flexibility. Common values are 2-6 hours.

### Freeloading Protection

Prevent volunteers from repeatedly signing up for shifts and not showing up:

```php
'max_freeloadable_shifts' => 2,
```

After this many freeloaded shifts, the user is locked from signing up for more shifts. Supporters or bureaucrats can clear the freeload marks to unlock them.

### Night Shift Bonus

Give extra credit for shifts during unsociable hours:

```php
'night_shifts' => [
    'enabled'    => true,
    'start'      => 2,    // Night period starts at 2:00
    'end'        => 8,    // Night period ends at 8:00
    'multiplier' => 2,    // Hours count double
],
```

A 3-hour shift from 3:00-6:00 would count as 6 hours toward rewards when enabled. Disable if all shifts should count equally regardless of time.

### Voucher Calculation

Configure how volunteers earn vouchers (meal tickets, drink tokens, etc.):

```php
'voucher_settings' => [
    'initial_vouchers'   => 0,    // Vouchers given at registration
    'shifts_per_voucher' => 1,    // Vouchers earned per shift
    'hours_per_voucher'  => 2,    // OR hours required per voucher
    'voucher_start'      => null, // Start date (Y-m-d format)
],
```

**Example scenarios:**

- **One voucher per shift**: Set `shifts_per_voucher` to 1
- **Voucher every 4 hours worked**: Set `hours_per_voucher` to 4
- **Two starter vouchers**: Set `initial_vouchers` to 2
- **Vouchers only during event**: Set `voucher_start` to your event's start date

## Rewards and Goodies

Configure how volunteers earn and receive rewards.

### Goodie Type

What kind of rewards does your event offer?

```php
'goodie_type' => 'tshirt',
```

| Value | Behavior |
|-------|----------|
| `none` | No goodies, reward tracking disabled |
| `goodie` | Generic reward without size options |
| `tshirt` | T-shirt rewards with size selection |

### T-Shirt Sizes

If using `tshirt` goodie type, define available sizes:

```php
'tshirt_sizes' => [
    'S'    => 'Small Straight-Cut',
    'S-G'  => 'Small Fitted-Cut',
    'M'    => 'Medium Straight-Cut',
    'M-G'  => 'Medium Fitted-Cut',
    'L'    => 'Large Straight-Cut',
    'L-G'  => 'Large Fitted-Cut',
    'XL'   => 'XLarge Straight-Cut',
    'XL-G' => 'XLarge Fitted-Cut',
    '2XL'  => '2XLarge Straight-Cut',
    '3XL'  => '3XLarge Straight-Cut',
    '4XL'  => '4XLarge Straight-Cut',
],
```

Customize this list to match what your event actually has in stock. Remove sizes you don't offer.

## Communication Settings

Configure how Engelsystem sends emails.

### Email Configuration

```php
'email' => [
    'driver' => env('MAIL_DRIVER', 'mail'),
    'from'   => [
        'address' => env('MAIL_FROM_ADDRESS', 'noreply@engelsystem.de'),
        'name'    => env('MAIL_FROM_NAME', env('APP_NAME', 'Engelsystem')),
    ],
    // SMTP settings (when driver is 'smtp')
    'host'       => env('MAIL_HOST', 'localhost'),
    'port'       => env('MAIL_PORT', 587),
    'encryption' => env('MAIL_ENCRYPTION', null),  // 'tls' or 'ssl'
    'username'   => env('MAIL_USERNAME'),
    'password'   => env('MAIL_PASSWORD'),
    // Sendmail path (when driver is 'sendmail')
    'sendmail'   => env('MAIL_SENDMAIL', '/usr/sbin/sendmail -bs'),
],
```

**Available drivers:**

| Driver | Use Case |
|--------|----------|
| `mail` | PHP's built-in mail function (requires local mail server) |
| `smtp` | External SMTP server (recommended for production) |
| `sendmail` | Local sendmail binary |
| `log` | Writes emails to log instead of sending (for testing) |

**SMTP example for common providers:**

```php
// Gmail (requires app password)
'email' => [
    'driver'     => 'smtp',
    'host'       => 'smtp.gmail.com',
    'port'       => 587,
    'encryption' => 'tls',
    'username'   => 'your-email@gmail.com',
    'password'   => 'your-app-password',
],

// Mailgun
'email' => [
    'driver'     => 'smtp',
    'host'       => 'smtp.mailgun.org',
    'port'       => 587,
    'encryption' => 'tls',
    'username'   => 'postmaster@your-domain.mailgun.org',
    'password'   => 'your-mailgun-password',
],
```

### Footer Links

Add custom links to the page footer:

```php
'footer_items' => [
    'FAQ'     => 'https://your-event.org/volunteers/faq',
    'Contact' => 'mailto:volunteers@your-event.org',
],
```

Use this for links to your event's volunteer FAQ, contact info, or code of conduct.

## Localization Settings

Configure language support.

### Available Languages

```php
'locales' => [
    'de_DE.UTF-8' => 'Deutsch',
    'en_US.UTF-8' => 'English',
],
```

Users can switch between these languages in their settings. Remove languages you don't want to offer.

### Default Language

```php
'default_locale' => env('DEFAULT_LOCALE', 'en_US.UTF-8'),
```

New users and logged-out visitors see this language.

## Appearance Settings

Customize the visual appearance.

### Theme

```php
'theme' => env('THEME', 1),
```

Set the default theme by number. Available themes are defined in the `themes` setting. Users can override this in their personal settings.

### Available Themes

```php
'themes' => [
    '0' => 'Engelsystem light',
    '1' => 'Engelsystem dark',
    // Historical Congress themes
    '7' => 'Engelsystem 35c3 dark (2018)',
    '6' => 'Engelsystem 34c3 dark (2017)',
    // ... more themes
],
```

## Security Settings

These settings affect application security.

### API Key

Protects API endpoints from unauthorized access:

```php
'api_key' => '<your-random-api-key>',
```

Generate a random string (32+ characters recommended). API requests must include this as the `api_key` parameter.

{{% notice warning %}}
Use a strong, random API key. Never use simple strings like "secret" or "api-key".
{{% /notice %}}

### Session Configuration

```php
'session' => [
    'driver'   => env('SESSION_DRIVER', 'pdo'),
    'name'     => 'session',
    'lifetime' => env('SESSION_LIFETIME', 30),  // Days
],
```

| Driver | Storage |
|--------|---------|
| `pdo` | Database (recommended, works with load balancing) |
| `native` | PHP session files |

### Trusted Proxies

If Engelsystem runs behind a reverse proxy or load balancer, configure trusted proxy IPs:

```php
'trusted_proxies' => env('TRUSTED_PROXIES', ['127.0.0.0/8', '::1/128']),
```

This ensures forwarded headers (like `X-Forwarded-For`) are trusted only from known proxies. For Kubernetes, you may need to trust your cluster's pod network range.

### Security Headers

Engelsystem adds security headers by default:

```php
'add_headers' => (bool)env('ADD_HEADERS', true),
'headers'     => [
    'X-Content-Type-Options'  => 'nosniff',
    'X-Frame-Options'         => 'sameorigin',
    'Referrer-Policy'         => 'strict-origin-when-cross-origin',
    'Content-Security-Policy' => 'default-src \'self\'; style-src \'self\' \'unsafe-inline\'; img-src \'self\' data:;',
    'X-XSS-Protection'        => '1; mode=block',
    // Uncomment for HTTPS-only sites:
    // 'Strict-Transport-Security' => 'max-age=7776000',
],
```

Set any header to `null` to disable it. Enable `Strict-Transport-Security` only if your site is HTTPS-only.

## Maintenance Mode

Take the system offline for maintenance:

```php
'maintenance' => env('MAINTENANCE', false),
```

When enabled, users see the content from `resources/views/layouts/maintenance.html` and cannot access any features. Useful during database migrations or major updates.

## Interface Settings

### News Pagination

How many news items appear per page:

```php
'display_news' => 10,
```

### Credits Page

Customize the credits/about page:

```php
'credits' => [
    'Contribution' => 'Please visit [engelsystem/engelsystem](https://github.com/engelsystem/engelsystem) for contributions and bug reports.'
],
```

## Environment Variables Reference

For container deployments, these environment variables are commonly used:

| Variable | Purpose | Default |
|----------|---------|---------|
| `MYSQL_HOST` | Database hostname | `localhost` |
| `MYSQL_DATABASE` | Database name | `engelsystem` |
| `MYSQL_USER` | Database username | `engelsystem` |
| `MYSQL_PASSWORD` | Database password | (empty) |
| `APP_NAME` | Application name | `Engelsystem` |
| `ENVIRONMENT` | `production` or `development` | `production` |
| `TIMEZONE` | PHP timezone identifier | `Europe/Berlin` |
| `THEME` | Default theme number | `1` |
| `REGISTRATION_ENABLED` | Allow new registrations | `true` |
| `MAIL_DRIVER` | Email driver | `mail` |
| `MAIL_HOST` | SMTP hostname | `localhost` |
| `MAIL_PORT` | SMTP port | `587` |
| `MAIL_ENCRYPTION` | `tls`, `ssl`, or empty | (none) |
| `MAIL_USERNAME` | SMTP username | (none) |
| `MAIL_PASSWORD` | SMTP password | (none) |
| `MAIL_FROM_ADDRESS` | Sender email address | `noreply@engelsystem.de` |
| `MAIL_FROM_NAME` | Sender name | (uses APP_NAME) |
| `SESSION_DRIVER` | `pdo` or `native` | `pdo` |
| `SESSION_LIFETIME` | Session lifetime in days | `30` |
| `TRUSTED_PROXIES` | Trusted proxy IPs | `127.0.0.0/8` |
| `MAINTENANCE` | Enable maintenance mode | `false` |
| `DEFAULT_LOCALE` | Default language | `en_US.UTF-8` |

## Common Configuration Scenarios

### Small Hackathon (50-100 volunteers)

```php
return [
    'app_name'                => 'HackHelper',
    'registration_enabled'    => true,
    'signup_requires_arrival' => false,
    'goodie_type'             => 'none',
    'last_unsubscribe'        => 1,
    'night_shifts'            => ['enabled' => false],
];
```

### Large Conference (500+ volunteers)

```php
return [
    'app_name'                => 'Conference Angels',
    'signup_requires_arrival' => true,
    'goodie_type'             => 'tshirt',
    'last_unsubscribe'        => 4,
    'max_freeloadable_shifts' => 2,
    'night_shifts'            => [
        'enabled'    => true,
        'start'      => 2,
        'end'        => 8,
        'multiplier' => 2,
    ],
    'voucher_settings'        => [
        'initial_vouchers'   => 1,
        'hours_per_voucher'  => 6,
    ],
];
```

