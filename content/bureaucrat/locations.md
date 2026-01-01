---
title: "Locations"
weight: 30
---

Locations define where shifts take place at your event. Bureaucrats manage the list of locations and their properties.

## Required Privilege

You need the `locations.edit` privilege to manage locations. This is included in the Bureaucrat group.

## What Locations Represent

Locations are physical or virtual places where work happens:

- **Rooms** - Conference rooms, workshops, stages
- **Entrances** - Gates, doors, checkpoints
- **Stations** - Info desks, merchandise tables
- **Areas** - Outdoor spaces, hallways
- **Virtual** - Online shifts for remote events

## Creating a Location

To create a new location:

1. Navigate to **Admin > Locations**
2. Click **Create**
3. Enter location details:
   - **Name** - How it appears in the system
   - **Description** - Additional details or directions
   - **Map URL** (optional) - Link to map showing the location
4. Save

## Location Properties

### Basic Information
- **Name** - Short, recognizable name
- **Description** - Details that help volunteers find it

### Map Integration
If your event has a venue map, you can link locations to map positions. This helps volunteers navigate to their shifts.

### Visibility
Some systems allow hiding locations from general view or restricting which angel types can see them.

## Editing Locations

To modify a location:

1. Navigate to **Admin > Locations**
2. Find the location
3. Click edit
4. Make changes
5. Save

{{% notice note %}}
Changing a location name updates all future shifts at that location. Past shifts retain historical data.
{{% /notice %}}

## Best Practices

### Naming Conventions
- Use consistent naming (e.g., "Room A1" not "A1" in some places and "Room A-1" in others)
- Include building names if you have multiple buildings
- Keep names short but descriptive

### Descriptions
- Include how to find the location
- Note any special access requirements
- Mention nearby landmarks

### Organization
- Group similar locations together
- Consider creating "virtual" locations for coordination tasks
- Review and clean up unused locations after events

## Deleting Locations

Before deleting a location:
- Check for existing shifts at that location
- Move or cancel shifts first
- Consider if historical data should be preserved

{{% notice warning %}}
Deleting a location with active shifts will affect those shifts. Move shifts to a different location first.
{{% /notice %}}

## Related Topics

- [Managing Shifts]({{% relref "/shift-coordinator/shifts" %}}) - Creating shifts at locations
- [Role Management]({{% relref "/admin/role_management" %}}) - Bureaucrat privileges
