---
title: "Managing Shifts"
weight: 10
---

# Managing Shifts

This page covers how to create, edit, and organize shifts in the Engelsystem.

## Creating Shifts

### Manual Creation

To create individual shifts:

1. Navigate to **Admin > Shifts**
2. Select the date and time range for the shift
3. Choose the location where the shift will take place
4. Select a shift type that matches the work
5. Enter a title and optional description
6. Define which angel types are needed and how many of each
7. Save the shift

The shift becomes immediately available for angels to sign up (assuming they have the required angel types).

### Bulk Creation

When you need many similar shifts, bulk creation saves time:

1. Navigate to **Admin > Shifts > Bulk**
2. Define the shift pattern - start times, duration, and which days
3. Select one or more locations
4. Set the angel type requirements
5. Generate all shifts at once

This is useful for recurring shifts like entrance coverage that follows the same pattern each day.

### Schedule Import

For events using Frab or Pretalx, you can import talks and sessions as shifts automatically. This creates shifts that match the event program, so angels can sign up to help with specific talks.

See [Schedule Import]({{% ref "/admin/schedule-import" %}}) in the administration guide for setup details.

## Shift Properties

Each shift has these properties:

| Property | Description |
|----------|-------------|
| Title | Display name for the shift |
| Description | Optional details about the work |
| Start/End | When the shift runs |
| Location | Where the shift takes place |
| Shift Type | Category of work |
| URL | Optional link to more information |

## Setting Angel Type Requirements

A shift needs to specify which angel types can work it and how many:

**Direct Requirements.** Set on the shift itself. Most flexible but requires setting each shift individually.

**Location Defaults.** Set on the location. All shifts at that location inherit these requirements unless overridden.

**Shift Type Defaults.** Set on the shift type. All shifts of that type inherit these requirements.

**Schedule Import.** Imported shifts can inherit requirements from their schedule configuration.

The system checks requirements in this order: shift-specific first, then location, then shift type, then schedule.

## Night Shifts

Shifts during night hours receive bonus multipliers to recognize the difficulty of working late. By default, night hours are 2:00 to 6:00, and the multiplier is 2x.

A shift counts as a night shift if any part of it falls within night hours.

The night shift configuration is set by administrators in the system configuration.

## Editing Shifts

To modify an existing shift:

1. Navigate to the shift's detail page (click on it in the schedule view)
2. Click **Edit**
3. Make your changes
4. Save

You cannot reduce angel counts below the number already signed up. If you need fewer angels, you'll need to remove signups first.

## Deleting Shifts

Before deleting a shift, consider the impact on angels who have signed up. When you delete a shift:

- All signed-up angels are removed from the shift
- Angels receive notification that the shift was cancelled
- Work hours are not credited (the shift didn't happen)

To delete:

1. Navigate to the shift's detail page
2. Click **Delete**
3. Confirm the deletion

## Working with Shift States

Shifts progress through states automatically based on time:

1. **Created** - Shift exists but may not be visible
2. **Open** - Angels can sign up
3. **Filled** - All spots are taken (angels can still join waitlists if enabled)
4. **In Progress** - Shift is currently running
5. **Completed** - Shift has ended

You don't manually change these states - they update based on time and signup status.

{{% notice tip %}}
When creating shifts for a new event, start with location defaults for common requirements. This saves time and ensures consistency. Override on individual shifts only when needed.
{{% /notice %}}
