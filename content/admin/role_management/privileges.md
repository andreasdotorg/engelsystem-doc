---
title: "Privileges Reference"
date: 2025-01-01T12:00:00+01:00
weight: 10
---

This page provides comprehensive documentation for every privilege in Engelsystem. Each entry describes what the privilege controls, what specific operations it enables, and which groups have it by default.

## How to Use This Reference

- **Privilege name** - The identifier used in the database and code
- **Operations Enabled** - Specific pages, buttons, or actions unlocked by this privilege
- **Default Groups** - Groups that have this privilege in a standard installation
- **Related Privileges** - Other privileges commonly needed together
- **Security Notes** - Warnings for sensitive privileges

---

## Authentication & Navigation

### `start`

**Description:** Access the landing/start page of Engelsystem.

**Operations Enabled:**
- View the main landing page (`/`)
- See event information and statistics
- Access the login/registration links (if not logged in)

**Default Groups:** Guest

---

### `login`

**Description:** Display the login form.

**Operations Enabled:**
- View the login page (`/login`)
- Submit login credentials
- Access password recovery (if enabled)

**Default Groups:** Guest

---

### `logout`

**Description:** End the current session.

**Operations Enabled:**
- Click the logout button/link in the navigation
- Terminate the session and clear authentication

**Default Groups:** Angel

---

### `register`

**Description:** Access the self-registration form for new users.

**Operations Enabled:**
- View the registration page (`/register`)
- Submit registration form to create a new account
- Register other users manually (for coordinators)

**Default Groups:** Guest, Shift Coordinator

**Related Privileges:**
- When combined with `admin_user`, allows registering users directly into specific groups

{{% notice note %}}
Registration can be disabled system-wide in configuration. When disabled, this privilege has no effect for self-registration.
{{% /notice %}}

---

## News & Communication

### `news`

**Description:** View the news feed.

**Operations Enabled:**
- Access the news page (`/news`)
- Read all published news posts
- See news post details including comments

**Default Groups:** Angel

**Related Privileges:**
- `news_comments` - Needed to post comments on news
- `admin_news` - Needed to create/edit news posts

---

### `news_comments`

**Description:** Post comments on news items.

**Operations Enabled:**
- See the comment form on news posts
- Submit new comments
- View existing comments from other users

**Default Groups:** Angel

**Related Privileges:**
- `news` - Required to view news posts first

---

### `admin_news`

**Description:** Create, edit, and delete news posts.

**Operations Enabled:**
- "Create news" button on news page
- Edit button on existing news posts
- Delete button on news posts
- Set news post visibility (public/private)
- Schedule news posts for future publication

**Default Groups:** Shift Coordinator

**Related Privileges:**
- `news.highlight` - Needed to mark posts as highlighted

---

### `news.highlight`

**Description:** Mark news posts as highlighted/important.

**Operations Enabled:**
- "Highlight" checkbox when creating/editing news
- Highlighted posts appear at the top of the news feed
- Highlighted posts have visual emphasis

**Default Groups:** Bureaucrat

**Related Privileges:**
- `admin_news` - Required to edit news posts

---

### `user_messages`

**Description:** Send and receive direct messages between users.

**Operations Enabled:**
- Access the messages page (`/messages`)
- Send new messages to other users
- Read received messages
- View message history
- "Send message" button on user profiles

**Default Groups:** Angel

---

### `user_meetings`

**Description:** View meeting schedules.

**Operations Enabled:**
- Access the meetings page (`/meetings`)
- View scheduled meetings and their details
- See meeting locations and times

**Default Groups:** Angel

---

## Shifts & Scheduling

### `user_shifts`

**Description:** View the shift calendar and sign up for shifts.

**Operations Enabled:**
- Access the shifts page (`/user-shifts`)
- View the shift calendar/schedule
- See available shifts and their details
- Sign up for shifts (subject to angel type requirements)
- Filter shifts by location, time, angel type

**Default Groups:** Angel

**Related Privileges:**
- `user_myshifts` - View own signups
- `user_shifts_admin` - Admin operations on shift entries

---

### `user_myshifts`

**Description:** View own shift signups.

**Operations Enabled:**
- Access personal shift list (`/user-myshifts`)
- View shifts you're signed up for
- See shift details and location information
- Cancel own signups (if allowed by configuration)

**Default Groups:** Angel

---

### `user_shifts_admin`

**Description:** Administrative operations on shift entries.

**Operations Enabled:**
- Sign up other users for shifts
- Remove users from shifts they signed up for
- View filled shifts in the calendar (normally hidden)
- Override angel type requirements when signing up users
- Edit shift entry comments

**Default Groups:** Shift Coordinator

**Related Privileges:**
- `admin_shifts` - Create/edit the shifts themselves
- `admin_user_angeltypes` - Override angel type membership

---

### `admin_shifts`

**Description:** Create, edit, and delete shifts.

**Operations Enabled:**
- Access "Create shifts" page (`/admin-shifts`)
- Create new shifts with title, time, location, required angels
- Edit existing shift details
- Delete shifts
- Copy shifts to create similar ones
- Bulk shift creation
- View schedule overview

**Default Groups:** Shift Coordinator

**Related Privileges:**
- `user_shifts_admin` - Manage who is signed up
- `schedule.import` - Import shifts from external schedules
- `shifttypes.view` - View available shift types
- `locations.edit` - Create new locations for shifts

---

### `schedule.import`

**Description:** Import shifts from external schedule sources (Frab/Pretalx).

**Operations Enabled:**
- Access the schedule import page (`/admin/schedule`)
- Configure schedule import URLs
- Import shifts from Frab XML or Pretalx feeds
- View import status and conflicts
- Map imported sessions to angel types

**Default Groups:** (Not assigned by default)

**Related Privileges:**
- `admin_shifts` - Usually needed together for full shift management

{{% notice info %}}
Schedule import is typically used for conferences where talks/sessions from a schedule system should appear as shifts volunteers can sign up for.
{{% /notice %}}

---

### `shifttypes.view`

**Description:** View shift type definitions.

**Operations Enabled:**
- Access the shift types page (`/admin/shifttypes`)
- View list of all shift types
- See shift type details (name, description)

**Default Groups:** Shift Coordinator

**Related Privileges:**
- `shifttypes.edit` - Needed to create/modify shift types

---

### `shifttypes.edit`

**Description:** Create and edit shift types.

**Operations Enabled:**
- "Create shift type" button
- Edit existing shift type name and description
- Delete shift types (if not in use)
- Set default angel type requirements per shift type

**Default Groups:** Bureaucrat

**Related Privileges:**
- `shifttypes.view` - View existing shift types

---

### `ical`

**Description:** Export personal shift calendar in iCal format.

**Operations Enabled:**
- Access the iCal feed URL for personal shifts
- Import shifts into external calendar applications (Google Calendar, Apple Calendar, etc.)
- The feed URL is displayed on the user profile

**Default Groups:** Angel

{{% notice note %}}
The iCal URL contains an authentication token. Users should keep this URL private.
{{% /notice %}}

---

### `atom`

**Description:** Access the news Atom feed.

**Operations Enabled:**
- Access the Atom feed URL (`/atom`)
- Subscribe to news updates in RSS/Atom readers
- Programmatic access to news content

**Default Groups:** Angel

---

### `shifts_json_export`

**Description:** Export shift data as JSON.

**Operations Enabled:**
- Access the JSON export endpoint
- Download shift data for external tools or analysis
- The export URL is displayed on the user profile

**Default Groups:** Angel

---

## Angel Types

### `angeltypes`

**Description:** View the list of angel types.

**Operations Enabled:**
- Access the angel types page (`/angeltypes`)
- View all angel types and their descriptions
- See requirements and restrictions for each type
- View which angel types you're a member of

**Default Groups:** Angel

---

### `user_angeltypes`

**Description:** Manage own angel type memberships.

**Operations Enabled:**
- Request membership in angel types
- Leave angel types
- View pending membership requests
- See which angel types require confirmation

**Default Groups:** Angel

**Related Privileges:**
- `admin_user_angeltypes` - Manage other users' memberships

---

### `admin_angel_types`

**Description:** Create, edit, and delete angel types.

**Operations Enabled:**
- "Create angel type" button on angel types page
- Edit angel type name, description, and requirements
- Delete angel types (if no members)
- Configure self-signup settings
- Set whether the type requires confirmation
- Configure contact information (DECT, email)
- Set shift self-signup options

**Default Groups:** Bureaucrat

**Related Privileges:**
- `admin_user_angeltypes` - Manage memberships in the types you create

---

### `admin_user_angeltypes`

**Description:** Manage other users' angel type memberships.

**Operations Enabled:**
- Confirm pending angel type membership requests
- Add users to angel types directly
- Remove users from angel types
- Set users as supporters for an angel type
- Override the confirmation requirement
- "Manage members" button on angel type pages

**Default Groups:** Shift Coordinator

**Related Privileges:**
- `admin_angel_types` - Create/edit the types themselves

{{% notice note %}}
Supporters of an angel type can also confirm members for their type, even without this privilege.
{{% /notice %}}

---

### `angeltype.goodie.list`

**Description:** View goodie eligibility lists per angel type.

**Operations Enabled:**
- Access goodie list view on angel type pages
- See which members have earned goodies
- View hours worked per member
- Filter by goodie status (received/not received)

**Default Groups:** Goodie Manager

**Related Privileges:**
- `user.goodie.edit` - Mark users as having received goodies

---

## Locations

### `locations.view`

**Description:** View the list of locations.

**Operations Enabled:**
- Access the locations page (`/locations`)
- View location names and descriptions
- See location details (map links, capacity, etc.)
- View which shifts are scheduled at each location

**Default Groups:** Angel

---

### `locations.edit`

**Description:** Create, edit, and delete locations.

**Operations Enabled:**
- "Create location" button on locations page
- Edit location name, description, and details
- Set location map URL
- Delete locations (if no shifts scheduled)
- Configure default angel type requirements per location

**Default Groups:** Bureaucrat

---

## User Management

### `admin_user`

**Description:** Full user administration access.

**Operations Enabled:**
- Access the full user list (`/users`)
- Search and filter users
- View any user's complete profile
- Edit user profile information (name, email, DECT, etc.)
- Change user passwords
- Delete user accounts
- View user's shift history
- View user's work log
- Edit user's group memberships
- Force-activate users for goodies
- View voucher status

**Default Groups:** Shift Coordinator

**Related Privileges:**
- `admin_groups` - Needed to change which groups exist
- `user.info.view` - Subset for viewing only
- `admin_active` - Subset for goodie activation only

{{% notice warning %}}
Users with `admin_user` can add themselves to any group by editing their own profile. This effectively grants them all privileges. Only assign to highly trusted staff.
{{% /notice %}}

---

### `user_settings`

**Description:** Edit own profile settings.

**Operations Enabled:**
- Access personal settings page (`/settings`)
- Change own password
- Update email address
- Configure notification preferences
- Set language preference
- Set theme preference
- Update contact information (DECT, mobile)
- Generate/regenerate API key

**Default Groups:** Angel

---

### `user.nick.edit`

**Description:** Change usernames.

**Operations Enabled:**
- Edit the username/nickname field on user profiles
- Rename users (as admin)

**Default Groups:** (Not assigned by default - merged into `admin_user`)

---

### `user.info.view`

**Description:** View sensitive user information fields.

**Operations Enabled:**
- See user's full name (first and last)
- View pronoun information
- View planned arrival/departure dates
- View personal contact details
- See user notes field

**Default Groups:** Goodie Manager, Shift Coordinator

**Related Privileges:**
- `user.info.edit` - Also edit these fields
- `user.info.hint` - See indicators that fields exist but are hidden

---

### `user.info.edit`

**Description:** Edit sensitive user information fields.

**Operations Enabled:**
- Edit user's full name
- Edit pronoun information
- Edit planned dates
- Edit personal notes field
- All operations from `user.info.view`

**Default Groups:** Bureaucrat

---

### `user.info.hint`

**Description:** See hints/indicators when user info fields are restricted.

**Operations Enabled:**
- See "(restricted)" indicators on profile fields you can't view
- Know that additional information exists without seeing it
- Useful for knowing when to escalate to someone with more access

**Default Groups:** Welcome Angel, Voucher Angel, Goodie Manager, Shift Coordinator

---

### `user.goodie.edit`

**Description:** Mark users as having received goodies (t-shirts, etc.).

**Operations Enabled:**
- "Goodie received" checkbox on user profiles
- Mark users as having received their t-shirt/merch
- View goodie status on user profiles
- Button on user profile to toggle goodie status

**Default Groups:** Goodie Manager, Shift Coordinator

**Related Privileges:**
- `admin_active` - Mark users as eligible for goodies

---

### `user.drive.edit`

**Description:** Edit driver license information.

**Operations Enabled:**
- Edit driver license fields on user profiles
- Mark users as having car/truck/forklift licenses
- View driver license status
- Edit license details (license number, expiry)

**Default Groups:** Shift Coordinator

{{% notice info %}}
Users who are supporters of angel types that require driving can also edit driver licenses for their members.
{{% /notice %}}

---

### `user.ifsg.edit`

**Description:** Edit IFSG (Infektionsschutzgesetz) certificate status.

**Operations Enabled:**
- Edit IFSG certificate fields on user profiles
- Mark users as having valid IFSG certification
- Set certificate date

**Default Groups:** Shift Coordinator

{{% notice info %}}
IFSG certificates are required in Germany for handling food. Users who are supporters of angel types that require IFSG can also edit this for their members.
{{% /notice %}}

---

### `user.fa.edit`

**Description:** Edit first aid certification status.

**Operations Enabled:**
- Edit first aid certification on user profiles
- Mark users as having first aid training
- Set certification expiry date

**Default Groups:** Bureaucrat

---

### `user.ff.edit`

**Description:** Edit "free-from" status (dietary/allergy information).

**Operations Enabled:**
- Edit free-from fields on user profiles
- Record dietary restrictions and allergies
- Mark specific free-from categories

**Default Groups:** Shift Coordinator

---

### `admin_active`

**Description:** Mark users as "active" for goodie eligibility.

**Operations Enabled:**
- Access the "Active angels" page (`/admin-active`)
- View which users have worked enough hours
- Force-mark users as active (override hour requirements)
- Mark users as inactive
- Bulk activation operations

**Default Groups:** Goodie Manager, Shift Coordinator

**Related Privileges:**
- `user.goodie.edit` - Mark goodies as actually received

---

### `admin_arrive`

**Description:** Mark users as arrived at the event.

**Operations Enabled:**
- "Mark as arrived" button on user profiles
- Set arrival timestamp
- Access arrival-related features on the arrival page

**Default Groups:** Welcome Angel, Goodie Manager, Shift Coordinator

**Related Privileges:**
- `users.arrive.list` - View the list of users to arrive

{{% notice note %}}
If `autoarrive` is enabled in configuration, users are automatically marked as arrived on first login, making this privilege less relevant.
{{% /notice %}}

---

### `users.arrive.list`

**Description:** View the arrival list page.

**Operations Enabled:**
- Access the arrivals page (`/admin-arrive`)
- View list of users who haven't arrived yet
- View list of users who have arrived
- Search for users by name
- Filter by arrival status

**Default Groups:** Welcome Angel, Voucher Angel, Goodie Manager, Shift Coordinator

---

### `admin_free`

**Description:** View and manage free/available angels.

**Operations Enabled:**
- Access the "Free angels" page (`/admin-free`)
- View which users are currently not on shift
- See users who are available for immediate assignment
- Filter by angel type

**Default Groups:** Shift Coordinator

---

### `admin_user_worklog`

**Description:** Edit work hour logs.

**Operations Enabled:**
- Access worklog section on user profiles
- Create manual worklog entries
- Edit existing worklog entries
- Delete worklog entries
- Add hours for work not tracked through shifts

**Default Groups:** Shift Coordinator, Bureaucrat

---

### `voucher.edit`

**Description:** Edit voucher distribution for users.

**Operations Enabled:**
- Edit voucher count on user profiles
- Record vouchers given to users
- View voucher status
- Button to give/take vouchers

**Default Groups:** Voucher Angel, Shift Coordinator

---

## System Administration

### `admin_groups`

**Description:** Manage user groups and assign privileges to groups.

**Operations Enabled:**
- Access the "Group rights" page (`/admin-groups`)
- View all groups and their privileges
- Create new groups
- Delete groups (use caution)
- Add/remove privileges from groups
- Change group names

**Default Groups:** Developer

{{% notice warning %}}
This is the most powerful privilege. Users with `admin_groups` can grant themselves any other privilege by modifying group assignments. Restrict to system administrators only.
{{% /notice %}}

---

### `admin_log`

**Description:** View audit logs.

**Operations Enabled:**
- Access the logs page (`/admin/logs`)
- View system activity log
- See who performed which actions
- Filter logs by user or action type
- Search log entries

**Default Groups:** Shift Coordinator, Bureaucrat

**Related Privileges:**
- `logs.all` - View sensitive log entries

---

### `logs.all`

**Description:** View all log entries including sensitive ones.

**Operations Enabled:**
- See log entries that are normally hidden
- View security-related log entries
- Access complete audit trail

**Default Groups:** Bureaucrat

**Related Privileges:**
- `admin_log` - Basic log viewing

---

### `config.edit`

**Description:** Edit event configuration.

**Operations Enabled:**
- Access the configuration page (`/admin/config`)
- Edit event name and dates
- Configure registration settings
- Set goodie/t-shirt options
- Configure voucher settings
- Enable/disable features
- Set theme and appearance
- Configure contact information

**Default Groups:** Shift Coordinator, Developer

{{% notice note %}}
Some configuration options require additional privileges. The config page shows only options the user can edit.
{{% /notice %}}

---

### `faq.view`

**Description:** View FAQ entries.

**Operations Enabled:**
- Access the FAQ page (`/faq`)
- Read all published FAQ entries
- Search FAQ content

**Default Groups:** Guest, Angel

---

### `faq.edit`

**Description:** Create and edit FAQ entries.

**Operations Enabled:**
- "Create FAQ" button
- Edit existing FAQ entries
- Delete FAQ entries
- Reorder FAQ entries

**Default Groups:** Shift Coordinator

---

### `question.add`

**Description:** Submit questions to organizers.

**Operations Enabled:**
- Access the questions page (`/questions`)
- Submit new questions
- View own submitted questions
- See answers to own questions

**Default Groups:** Angel

---

### `question.edit`

**Description:** Answer and edit submitted questions.

**Operations Enabled:**
- Access "Answer questions" page (`/admin/questions`)
- View all submitted questions
- Write answers to questions
- Edit existing answers
- Delete questions
- Notification when new questions arrive

**Default Groups:** Shift Coordinator

---

### `api`

**Description:** Access the programmatic API.

**Operations Enabled:**
- Use API endpoints with API key authentication
- Read data programmatically (users, shifts, etc.)
- Write data through API (depending on other privileges)
- The API key is shown in user settings

**Default Groups:** API

{{% notice info %}}
API access respects other privileges. The API only allows operations the user's other group memberships permit.
{{% /notice %}}

---

### `tag.edit`

**Description:** Edit tags used for categorization.

**Operations Enabled:**
- Access the tags page (`/admin/tags`)
- Create new tags
- Edit tag names and colors
- Delete unused tags

**Default Groups:** Shift Coordinator

---

## Privilege Quick Reference

### By Function

| Function | View | Edit | Admin |
|----------|------|------|-------|
| News | `news` | `news_comments` | `admin_news`, `news.highlight` |
| Shifts | `user_shifts`, `user_myshifts` | - | `admin_shifts`, `user_shifts_admin` |
| Shift Types | `shifttypes.view` | `shifttypes.edit` | - |
| Angel Types | `angeltypes` | `user_angeltypes` | `admin_angel_types`, `admin_user_angeltypes` |
| Locations | `locations.view` | - | `locations.edit` |
| Users | - | `user_settings` | `admin_user` |
| User Info | `user.info.view`, `user.info.hint` | `user.info.edit` | - |
| User Certs | - | `user.drive.edit`, `user.ifsg.edit`, `user.fa.edit` | - |
| Goodies | - | `user.goodie.edit` | `admin_active` |
| Arrivals | `users.arrive.list` | `admin_arrive` | - |
| Worklogs | - | `admin_user_worklog` | - |
| Vouchers | - | `voucher.edit` | - |
| FAQ | `faq.view` | `faq.edit` | - |
| Questions | `question.add` | `question.edit` | - |
| Logs | `admin_log` | - | `logs.all` |
| Config | - | `config.edit` | - |
| Groups | - | - | `admin_groups` |

### By Risk Level

**Low Risk** - Information access only:
- `start`, `login`, `logout`, `register`
- `news`, `news_comments`, `atom`
- `user_shifts`, `user_myshifts`, `ical`, `shifts_json_export`
- `angeltypes`, `user_angeltypes`
- `locations.view`
- `user_settings`, `user_messages`, `user_meetings`
- `faq.view`, `question.add`

**Medium Risk** - Can modify data:
- `admin_news`, `news.highlight`
- `admin_shifts`, `user_shifts_admin`, `schedule.import`
- `shifttypes.view`, `shifttypes.edit`
- `admin_angel_types`, `admin_user_angeltypes`
- `locations.edit`
- `user.info.view`, `user.info.edit`, `user.info.hint`
- `user.goodie.edit`, `user.drive.edit`, `user.ifsg.edit`, `user.fa.edit`, `user.ff.edit`
- `admin_active`, `admin_arrive`, `users.arrive.list`, `admin_free`
- `admin_user_worklog`, `voucher.edit`
- `faq.edit`, `question.edit`, `tag.edit`
- `api`, `angeltype.goodie.list`

**High Risk** - Broad system access:
- `admin_user` - Can edit any user including group memberships
- `admin_log`, `logs.all` - Can see sensitive activity
- `config.edit` - Can change system behavior

**Critical Risk** - Full system control:
- `admin_groups` - Can grant any privilege
