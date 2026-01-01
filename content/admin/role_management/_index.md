---
title: "Role Management"
date: 2019-02-13T19:37:52+01:00
lastmod: 2025-01-01T12:00:00+01:00
weight: 40
---

Engelsystem uses a group-based permission system. Users belong to groups, and groups have privileges that control what actions users can take. This page documents all groups, their intended purpose, and their assigned privileges.

## How Permissions Work

### Flat Group Model

Engelsystem uses a flat permission model with no hierarchy between groups. When a user belongs to multiple groups, their effective permissions are the union of all privileges from all their groups.

For example, if a user is both a **Welcome Angel** (can mark arrivals) and a **Voucher Angel** (can edit vouchers), they can perform both operations.

### Group Membership

Users are assigned to groups in several ways:

1. **Registration** - New users automatically join the configured default group (typically "Angel")
2. **OAuth/SSO** - External authentication providers can specify which groups to assign
3. **Manual assignment** - Administrators add users to groups via the user profile
4. **Self-service** - For angel types with `no_self_signup = false`, users can request membership

### Privilege Checks

The system checks privileges at multiple levels:

- **Page access** - The navigation menu only shows pages the user can access
- **Controller actions** - Each action verifies the required privilege before execution
- **UI elements** - Buttons and forms are conditionally rendered based on permissions

### Supporter: A Different Kind of Permission

**Important:** "Supporter" is **not** a group. It's a per-angel-type capability that exists separately from the group system.

When a user is marked as a supporter for an angel type:
- They can approve/deny membership requests for that specific angel type
- They can add or remove members from that angel type
- They can sign up team members for shifts requiring that angel type
- They can edit the angel type's description (but not other settings)

A user might be a supporter for "Bar" while being just a regular member of "Security." The supporter capability is independent of group membership - it doesn't require any special group.

**Who can make someone a supporter:**
- Users with the `admin_user_angeltypes` privilege (typically Shift Coordinators)
- Existing supporters for that angel type (if `supporters_can_promote` is enabled in config)

For user-facing documentation about being a supporter, see the [Supporter Guide]({{% relref "/supporter" %}}).

## Groups

Engelsystem includes eight predefined groups. Each event can customize these or create additional groups.

### Guest

**ID:** 10

**Purpose:** Provides access for unauthenticated visitors before they log in or register.

**Typical users:** Anyone visiting the site who hasn't logged in.

**Capabilities:**
- View the landing page
- Access the login form
- Register a new account (if registration is enabled)
- View the FAQ

**Privileges:**
| Privilege | Description |
|-----------|-------------|
| `start` | Access the landing page |
| `login` | Display the login form |
| `register` | Self-registration form |
| `faq.view` | View FAQ entries |

---

### Angel

**ID:** 20

**Purpose:** Base role for all registered volunteers. Every logged-in user should have at least this group.

**Typical users:** All registered volunteers at the event.

**Capabilities:**
- View and sign up for shifts
- View their own shift schedule
- Manage their profile settings
- Read and comment on news
- Send and receive messages
- View angel types and apply for memberships
- View location information
- Export personal calendar (iCal)
- Ask questions via the Q&A system

**Privileges:**
| Privilege | Description |
|-----------|-------------|
| `angeltypes` | View the angel types list |
| `atom` | Access the news Atom feed |
| `faq.view` | View FAQ entries |
| `ical` | Export personal shift calendar |
| `locations.view` | View location list and details |
| `logout` | End the current session |
| `news` | View news feed |
| `news_comments` | Post comments on news items |
| `question.add` | Submit questions to organizers |
| `shifts_json_export` | Export shift data as JSON |
| `user_angeltypes` | Manage own angel type memberships |
| `user_meetings` | View meeting schedules |
| `user_messages` | Send and receive direct messages |
| `user_myshifts` | View own shift signups |
| `user_settings` | Edit own profile settings |
| `user_shifts` | View shift calendar and sign up |

---

### Welcome Angel

**ID:** 30

**Purpose:** Staff at the arrival/registration desk who check in volunteers when they arrive at the event.

**Typical users:** Volunteers staffing the info desk or arrival station.

**Capabilities:**
- View the list of expected arrivals
- Mark users as arrived at the event
- See hints about users with restricted information

**Privileges:**
| Privilege | Description |
|-----------|-------------|
| `admin_arrive` | Mark users as arrived |
| `user.info.hint` | See indicators when user info fields are restricted |
| `users.arrive.list` | View the arrival list page |

{{% notice note %}}
Welcome Angels inherit Angel privileges through group membership. Users in this group should also be in the Angel group.
{{% /notice %}}

---

### Voucher Angel

**ID:** 35

**Purpose:** Distribute vouchers (e.g., food vouchers, drink tokens) to volunteers who have earned them.

**Typical users:** Volunteers at voucher distribution points.

**Capabilities:**
- View who is eligible for vouchers
- Record voucher distribution to users
- See hints about users with restricted information

**Privileges:**
| Privilege | Description |
|-----------|-------------|
| `user.info.hint` | See indicators when user info fields are restricted |
| `users.arrive.list` | View user lists for voucher distribution |
| `voucher.edit` | Edit voucher counts for users |

---

### API

**ID:** 40

**Purpose:** Grants access to the programmatic API for external integrations.

**Typical users:** Service accounts for external systems, automation scripts, or third-party tools.

**Capabilities:**
- Access API endpoints for reading and writing data programmatically

**Privileges:**
| Privilege | Description |
|-----------|-------------|
| `api` | Access the API |

{{% notice note %}}
API access uses the user's API key for authentication. The API key can be found in user settings.
{{% /notice %}}

---

### Goodie Manager

**ID:** 50

**Purpose:** Handle t-shirt and goodie distribution. Track who has worked enough hours to receive goodies and mark them as distributed.

**Typical users:** Volunteers staffing the t-shirt/merchandise distribution point.

**Capabilities:**
- View arrival status of volunteers
- Mark users as arrived
- View user information needed for goodie distribution
- Mark users as "active" (eligible for goodies based on hours worked)
- Record when users have received their goodies
- View goodie eligibility lists per angel type

**Privileges:**
| Privilege | Description |
|-----------|-------------|
| `admin_active` | Mark users as active for goodie eligibility |
| `admin_arrive` | Mark users as arrived |
| `angeltype.goodie.list` | View goodie lists per angel type |
| `user.goodie.edit` | Mark users as having received goodies |
| `user.info.hint` | See indicators when user info fields are restricted |
| `user.info.view` | View sensitive user information (name, contact) |
| `users.arrive.list` | View arrival list |

---

### Shift Coordinator

**ID:** 60

**Purpose:** Core event operations role. Manages shifts, users, and day-to-day operations during the event.

**Typical users:** Team leads, shift managers, operations coordinators.

**Capabilities:**
- Full user administration (view, edit, delete users)
- Create, edit, and delete shifts
- Manage shift entries (sign up/remove users from shifts)
- Edit work logs and vouchers
- Post news announcements
- Answer questions from volunteers
- Edit FAQ entries
- View and edit user certifications (IFSG, driver license, first aid)
- Configure event settings
- View audit logs
- Register new users manually

**Privileges:**
| Privilege | Description |
|-----------|-------------|
| `admin_active` | Mark users as active for goodies |
| `admin_arrive` | Mark users as arrived |
| `admin_free` | View and manage free/available angels |
| `admin_log` | View audit logs |
| `admin_news` | Create, edit, and delete news posts |
| `admin_shifts` | Create, edit, and delete shifts |
| `admin_user` | Full user administration |
| `admin_user_angeltypes` | Manage users' angel type memberships |
| `admin_user_worklog` | Edit work hour logs |
| `config.edit` | Edit event configuration |
| `faq.edit` | Create and edit FAQ entries |
| `question.edit` | Answer and edit questions |
| `register` | Register new users |
| `shifttypes.view` | View shift type definitions |
| `tag.edit` | Edit tags |
| `user.drive.edit` | Edit driver license information |
| `user.ff.edit` | Edit free-from status |
| `user.goodie.edit` | Mark goodies as received |
| `user.ifsg.edit` | Edit IFSG certificate status |
| `user.info.hint` | See user info restriction hints |
| `user.info.view` | View sensitive user fields |
| `user_shifts_admin` | Admin shift entry operations |
| `users.arrive.list` | View arrival list |
| `voucher.edit` | Edit voucher distribution |

{{% notice warning %}}
The `admin_user` privilege allows editing group memberships. Users with this privilege could add themselves to higher-privilege groups. Only assign to trusted staff.
{{% /notice %}}

---

### Bureaucrat

**ID:** 80

**Purpose:** High-level administrative tasks that affect the structure of the event (angel types, locations, shift types).

**Typical users:** Senior organizers, department heads, event architects.

**Capabilities:**
- Create and modify angel types
- Create and modify locations
- Create and modify shift types
- Edit sensitive user information
- Highlight important news posts
- View complete audit logs (including sensitive entries)
- Edit first aid certification status

**Privileges:**
| Privilege | Description |
|-----------|-------------|
| `admin_angel_types` | Create, edit, and delete angel types |
| `admin_log` | View audit logs |
| `admin_user_worklog` | Edit work hour logs |
| `locations.edit` | Create, edit, and delete locations |
| `logs.all` | View all log entries including sensitive ones |
| `news.highlight` | Mark news as highlighted/important |
| `shifttypes.edit` | Create and edit shift types |
| `user.fa.edit` | Edit first aid certification status |
| `user.info.edit` | Edit sensitive user fields |

---

### Developer

**ID:** 90

**Purpose:** Full system access for technical administrators. This is the highest privilege level.

**Typical users:** System administrators, technical leads.

**Capabilities:**
- Manage user groups and privileges
- Full event configuration access

**Privileges:**
| Privilege | Description |
|-----------|-------------|
| `admin_groups` | Manage user groups and assign privileges |
| `config.edit` | Edit event configuration |

{{% notice warning %}}
Users with `admin_groups` can modify any group's privileges, including granting themselves full access. This should be restricted to system administrators only.
{{% /notice %}}

---

## Managing Groups

### Viewing Groups

Navigate to **Admin > Group rights** to see all groups and their privileges.

### Adding Users to Groups

1. Navigate to the user's profile (search in **Admin > All Angels**)
2. Click **Edit**
3. In the groups section, check the groups to assign
4. Save changes

Changes take effect on the user's next page load.

### Creating Custom Groups

You can create custom groups for your event's specific needs:

1. Navigate to **Admin > Group rights**
2. Create a new group with a descriptive name
3. Assign the needed privileges
4. Add users to the group

Common custom groups:
- **Press Contact** - Limited access for media representatives
- **Sponsor** - Access for event sponsors
- **Department Lead** - Custom combination of shift and angel type management

### OAuth Auto-Assignment

When using OAuth/SSO, you can configure automatic group assignment based on the identity provider's response. See the [Configuration]({{% relref "/admin/configuration" %}}) page for details.

## Privilege Reference

For detailed documentation of each privilege including all operations it enables, see the [Privileges Reference]({{% relref "privileges" %}}).

## Best Practices

### Least Privilege

Give users only the permissions they need for their role. Start with the base Angel group and add specific groups as needed.

### Use Groups, Not Direct Privileges

Always manage permissions through groups rather than assigning privileges directly to users. This makes permission management clearer and easier to audit.

### Pre-Event Review

Before major events, review group memberships:

1. Verify all coordinators have appropriate access
2. Remove access from users who no longer need it
3. Test that new volunteers can register and sign up for shifts

### Security Considerations

| Privilege | Risk | Recommendation |
|-----------|------|----------------|
| `admin_groups` | Can grant any permission | Restrict to system admins only |
| `admin_user` | Can edit group memberships | Limit to trusted coordinators |
| `config.edit` | Can change system behavior | Restrict to senior organizers |
| `logs.all` | Can view sensitive data | Only for security/audit roles |

### Document Custom Groups

If you create event-specific groups, document:
- The group's purpose
- Who should be assigned to it
- What privileges it includes
- When to remove users from it
