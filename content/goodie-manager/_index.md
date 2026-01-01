---
title: "Goodie Manager Guide"
weight: 27
---

Goodie Managers handle the distribution of t-shirts, merchandise, and other physical rewards to volunteers. You verify that volunteers have worked enough hours to qualify, and track who has received their goodies.

## What Goodie Managers Do

Your role combines several responsibilities:
- **Check eligibility** - Verify volunteers have worked required hours
- **Mark active status** - Designate volunteers as "active" for goodie eligibility
- **Track distribution** - Record when goodies have been handed out
- **Manage arrivals** - You can also mark volunteers as arrived

## Required Permissions

To function as a Goodie Manager, you need to be a member of the **Goodie Manager** group. This group grants:

| Privilege | What it does |
|-----------|--------------|
| `admin_active` | Mark users as active for goodie eligibility |
| `admin_arrive` | Mark users as arrived |
| `user.goodie.edit` | Mark users as having received goodies |
| `user.info.view` | View sensitive user information (name, contact) |
| `user.info.hint` | See indicators when user info is restricted |
| `users.arrive.list` | Access the arrival list |
| `angeltype.goodie.list` | View goodie lists per angel type |

You should also be in the **Angel** group for basic system access.

## Understanding Eligibility

The goodie system typically works like this:

1. **Hours threshold** - Volunteers must work a minimum number of hours
2. **Active status** - Someone marks them as "active" (eligible for goodies)
3. **Distribution** - Goodie Manager records that they received their goodie

The exact requirements depend on your event's configuration.

## Getting Started

1. **Access the user list** - Navigate to the arrival or user management area
2. **View eligibility** - Check volunteer work hours
3. **Mark as active** - Set active status for eligible volunteers
4. **Record distribution** - Mark when goodies are handed out

## Documentation

- [Distributing Goodies](goodies/) - Step-by-step guide for goodie distribution

{{% notice tip %}}
Have a system for tracking t-shirt sizes. You'll want to know what's been requested before volunteers arrive at your distribution point.
{{% /notice %}}
