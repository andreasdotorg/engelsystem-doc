---
title: "Schedule Import"
weight: 30
---

Engelsystem can import event schedules from Frab or Pretalx to automatically create shifts based on talks and sessions. This links volunteer shifts to the event program, so angels can sign up to help with specific talks.

## How It Works

External event management systems like Frab and Pretalx publish schedules as XML feeds. Engelsystem fetches these feeds and creates shifts for each event, with configurable timing before and after the scheduled time.

For example, if a talk starts at 14:00 and runs until 15:00, you might create a shift from 13:30 to 15:15 to cover setup and teardown.

## Configuration

### Adding a Schedule

1. Navigate to **Admin > Schedule Import**
2. Click **Add Schedule**
3. Enter the schedule details

### Schedule Properties

| Property | Description |
|----------|-------------|
| Name | Display name for the schedule |
| URL | XML feed URL from Frab/Pretalx |
| Shift Type | Default shift type for imported shifts |
| Minutes Before | How long before events shifts should start |
| Minutes After | How long after events shifts should end |

### Angel Type Requirements

Configure which angel types are needed for imported shifts:

**From Shift Type.** Use the default requirements defined on the shift type. All imported shifts get the same requirements.

**Custom.** Define specific requirements for this schedule's shifts.

## Running Import

### Manual Import

1. Navigate to **Admin > Schedule Import**
2. Select the schedule
3. Click **Import**
4. Review created/updated shifts

### Automatic Updates

Schedules can be re-imported to pick up changes. When re-importing:

- New events create new shifts
- Changed events update existing shifts
- Removed events keep their shifts (manual deletion required)

## Shift Properties from Import

Imported shifts inherit properties from the schedule event:

| Shift Property | Source |
|---------------|--------|
| Title | Event title |
| Description | Event description/abstract |
| Start/End | Event time ± configured minutes |
| Location | Requires manual mapping or location matching |
| URL | Link to event details in schedule |

## Location Mapping

Frab/Pretalx rooms need to map to Engelsystem locations. Options:

**Automatic matching.** If location names match exactly, they're linked automatically.

**Manual configuration.** Create locations in Engelsystem that match the schedule's room names.

**Ignore locations.** Assign all shifts to a single location.

## Managing Imported Shifts

Imported shifts are linked to their schedule. You can:

- Edit shift details (changes persist through re-imports)
- Add or remove angel type requirements
- Delete individual shifts

Deleting a schedule removes the link but doesn't delete the shifts.

## Common Workflows

### Initial Event Setup

1. Create locations matching your venue
2. Create shift types for different kinds of work
3. Add the schedule URL
4. Configure timing (minutes before/after)
5. Run initial import
6. Review and adjust shifts as needed

### Ongoing Updates

1. Re-import when the external schedule changes
2. Check for new shifts
3. Verify angel type requirements
4. Notify angels of changes if significant

{{% notice note %}}
Schedule URLs must be accessible from your server. If the schedule is behind authentication, you may need to use a public URL or configure access.
{{% /notice %}}

## Troubleshooting

**Import finds no events.** Check the URL is correct and accessible. Verify the XML format matches Frab/Pretalx specification.

**Locations don't match.** Room names in the schedule must exactly match location names in Engelsystem (or be mapped manually).

**Shifts have wrong times.** Adjust the minutes before/after settings on the schedule.
