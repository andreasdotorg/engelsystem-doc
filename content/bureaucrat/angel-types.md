---
title: "Angel Types"
weight: 20
---

Angel types define the categories of volunteer work at your event. Bureaucrats can create, edit, and configure angel types to match your event's needs.

## Required Privilege

You need the `admin_angel_types` privilege to manage angel types. This is included in the Bureaucrat group.

## What Angel Types Represent

Each angel type is a category of work that volunteers can sign up for:

- **Bar** - Serving drinks
- **Security** - Access control
- **Info Desk** - Answering questions
- **Tech Support** - Technical assistance
- **Transport** - Moving equipment

Your event will have its own angel types based on the work that needs doing.

## Creating an Angel Type

To create a new angel type:

1. Navigate to **Admin > Angel Types**
2. Click **Create**
3. Configure the settings (see below)
4. Save

### Basic Settings

- **Name** - The angel type's display name
- **Description** - What this work involves (visible to volunteers)
- **Restricted** - Whether joining requires approval

### Membership Options

- **no_self_signup** - If true, volunteers cannot join on their own; they must be added by supporters or coordinators
- **requires_driver_license** - Only volunteers with driver licenses can join
- **requires_ifsg_certificate** - Only volunteers with food handling certification can join

### Display Options

- **show_on_dashboard** - Whether to display on the main dashboard
- **hide_register** - Hide from the registration angel type selection

## Editing Angel Types

To modify an existing angel type:

1. Navigate to **Admin > Angel Types**
2. Find the angel type
3. Click edit
4. Make changes
5. Save

{{% notice warning %}}
Changing restrictions on an existing angel type doesn't remove existing members who don't meet the new criteria. Review membership after changing requirements.
{{% /notice %}}

## Restricted vs Open Angel Types

### Open Angel Types
- Anyone can join immediately
- Good for work that doesn't require special skills
- Examples: Setup, Cleanup, General Help

### Restricted Angel Types
- Joining requires approval from a supporter
- Good for specialized or sensitive work
- Examples: Security, Cash Handling, Medical

## Supporters for Angel Types

Each angel type can have supporters - team leads who:
- Approve/deny membership requests
- Add or remove members
- Sign up team members for shifts

To manage supporters:
1. View the angel type
2. Find a member to promote
3. Mark them as supporter

See the [Supporter Guide]({{% relref "/supporter" %}}) for what supporters can do.

## Deleting Angel Types

Before deleting an angel type:
- Ensure no future shifts require it
- Consider what happens to existing members
- Check if any volunteers have only this angel type

{{% notice warning %}}
Deleting an angel type may affect shift coverage and volunteer eligibility. Plan carefully.
{{% /notice %}}

## Related Topics

- [Supporter Guide]({{% relref "/supporter" %}}) - How supporters manage angel types
- [Role Management]({{% relref "/admin/role_management" %}}) - Bureaucrat privileges
