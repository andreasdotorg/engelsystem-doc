---
title: "OAuth Configuration"
weight: 25
---

Engelsystem supports OAuth 2.0 for external authentication providers. This allows users to log in using accounts from identity providers like Keycloak, GitHub, or other OAuth-compatible services.

## How OAuth Works

When OAuth is configured, users see additional login buttons on the login page. Clicking one redirects them to the external provider, where they authenticate. After successful authentication, they're redirected back to Engelsystem with their profile information.

For new users, an account is automatically created. For existing users who connect their OAuth account, the systems link together.

## Configuration

OAuth providers are configured in `config/config.php`:

```php
'oauth' => [
    'keycloak' => [
        'client_id'     => 'engelsystem',
        'client_secret' => 'your-client-secret',
        'url_auth'      => 'https://keycloak.example.com/realms/myrealm/protocol/openid-connect/auth',
        'url_token'     => 'https://keycloak.example.com/realms/myrealm/protocol/openid-connect/token',
        'url_info'      => 'https://keycloak.example.com/realms/myrealm/protocol/openid-connect/userinfo',
        'id'            => 'sub',
        'username'      => 'preferred_username',
        'email'         => 'email',
        'first_name'    => 'given_name',
        'last_name'     => 'family_name',
        'groups'        => [1],
        'mark_arrived'  => false,
    ],
],
```

### Configuration Options

| Option | Description |
|--------|-------------|
| `client_id` | OAuth client ID from your provider |
| `client_secret` | OAuth client secret |
| `url_auth` | Authorization endpoint URL |
| `url_token` | Token exchange endpoint URL |
| `url_info` | User info endpoint URL |
| `id` | Field in user info containing unique user ID |
| `username` | Field containing username |
| `email` | Field containing email address |
| `first_name` | Field containing first name |
| `last_name` | Field containing last name |
| `url` | Custom button URL (optional) |
| `nested_info` | Set true if user info has nested structure |
| `hidden` | Hide from login page (for API-only use) |
| `mark_arrived` | Auto-mark OAuth users as arrived |
| `groups` | Default group IDs for new users |

## Setting Up Providers

### Keycloak

1. Create a new client in your Keycloak realm
2. Set the client protocol to `openid-connect`
3. Configure the redirect URI: `https://your-engelsystem.example.com/oauth/keycloak`
4. Copy the client ID and secret to your config

### Generic OAuth 2.0

For other providers:

1. Register Engelsystem as an OAuth application
2. Set the callback URL to `https://your-domain.com/oauth/{provider_name}`
3. Note the client ID and secret
4. Find the provider's authorization, token, and userinfo endpoints
5. Identify which fields contain user information

## Multiple Providers

You can configure multiple OAuth providers. Each appears as a separate login button:

```php
'oauth' => [
    'keycloak' => [
        // Keycloak configuration
    ],
    'github' => [
        // GitHub configuration
    ],
],
```

## User Management

### New Users

When a user authenticates via OAuth for the first time:

1. A new account is created automatically
2. Profile fields are populated from OAuth data
3. The user is added to the groups specified in `groups`
4. If `mark_arrived` is true, they're marked as arrived

### Existing Users

Users with existing accounts can connect OAuth in their profile settings. After connecting, they can use either local password or OAuth to log in.

### Account Linking

OAuth accounts are linked by the unique ID from the provider. If a user's OAuth ID changes (rare), they'll appear as a new user.

## Security Considerations

- Store `client_secret` securely, not in version control
- Use environment variables for secrets in production
- Ensure OAuth providers use HTTPS
- Regularly rotate client secrets

{{% notice tip %}}
Test OAuth configuration with a staging environment before enabling in production. Misconfiguration can lock users out or create duplicate accounts.
{{% /notice %}}
