---
title: "Role Management"
date: 2019-02-13T19:37:52+01:00
lastmod: 2024-04-08T23:50:00+02:00
weight: 40
---

# Role Management

Engelsystem uses a group-based permission system. Users belong to groups, and groups have privileges that control what actions users can take.

## Groups

Groups are collections of privileges. Users can belong to multiple groups, and their effective permissions are the union of all their groups' privileges.

### Default Groups

| Group | Purpose |
|-------|---------|
| Guest | Unauthenticated visitors (view-only) |
| Angel | Registered volunteers (default for new users) |
| Shift Coordinator | Can manage shifts |
| Supporter | Can approve angel type applications |
| Bureaucrat | Administrative tasks |
| Developer | System administration (full access) |

The exact groups and their privileges can be customized for your event.

### Managing Groups

Navigate to **Admin > Groups** to:

- View existing groups and their members
- Create new groups
- Edit group privileges
- Delete groups (use caution)

## Privileges

Privileges are fine-grained permissions that control specific actions. Each privilege enables a particular capability.

### Common Privileges

| Privilege | Description |
|-----------|-------------|
| `user.arrive` | Mark users as arrived at the event |
| `user.edit` | Edit user profiles |
| `user.goodie` | Manage goodie/t-shirt status |
| `user.worklog` | View and edit work logs |
| `shifts.edit` | Create, edit, and delete shifts |
| `angel_types` | Manage angel types |
| `angel_types.edit` | Create and modify angel types |
| `admin_groups` | Manage user groups |
| `admin_user` | Full user administration |
| `admin_news` | Post news announcements |
| `admin_faq` | Edit FAQ entries |
| `admin_questions` | Answer user questions |
| `admin_config` | System configuration |
| `admin_logs` | View system logs |

### Assigning Privileges

1. Navigate to **Admin > Groups**
2. Select the group to modify
3. Check or uncheck privileges
4. Save changes

Changes take effect on the user's next page load.

## User Group Membership

### Adding Users to Groups

Navigate to the user's profile and edit their group memberships. You can also bulk-assign users to groups through the admin user list.

### Automatic Group Assignment

When users register or authenticate via OAuth, they're automatically added to configured default groups. OAuth providers can specify different default groups.

## Role Hierarchy

There's no strict hierarchy - groups are flat. However, in practice:

1. **Angel** is the base role for all registered users
2. **Supporter** adds team management capabilities
3. **Shift Coordinator** adds shift management
4. **Bureaucrat** adds broader administrative access
5. **Developer** has full system access

A user might be both a Supporter (for their team) and a Shift Coordinator (for scheduling).

## Best Practices

**Least privilege.** Give users only the permissions they need. Start with minimal access and add as needed.

**Use groups, not individual privileges.** Create meaningful groups rather than assigning privileges directly to users. This makes permission management clearer.

**Document custom groups.** If you create event-specific groups, document what they're for and who should have them.

**Review before events.** Before major events, review group memberships to ensure the right people have the right access.

{{% notice warning %}}
Be careful with `admin_user` and `admin_groups` privileges. Users with these can grant themselves additional permissions.
{{% /notice %}}
