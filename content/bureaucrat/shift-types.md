---
title: "Shift Types"
weight: 40
---

Shift types define categories of shifts with common properties. They help standardize shift creation and provide consistent naming across your event.

## Required Privilege

You need the `shifttypes.edit` privilege to manage shift types. This is included in the Bureaucrat group. The `shifttypes.view` privilege (included in Shift Coordinator) allows viewing but not editing.

## What Shift Types Are For

Shift types categorize shifts by their purpose:

- **Regular Shift** - Standard work shifts
- **Setup** - Pre-event preparation
- **Teardown** - Post-event cleanup
- **Meeting** - Team meetings and briefings
- **Training** - Educational sessions

Using shift types helps:
- Standardize shift naming
- Apply default settings
- Filter and report on shift categories
- Group similar shifts visually

## Creating a Shift Type

To create a new shift type:

1. Navigate to **Admin > Shift Types**
2. Click **Create**
3. Enter:
   - **Name** - How the shift type appears
   - **Description** - What characterizes this type of shift
4. Save

## Editing Shift Types

To modify a shift type:

1. Navigate to **Admin > Shift Types**
2. Find the shift type
3. Click edit
4. Make changes
5. Save

{{% notice note %}}
Changing a shift type name or properties affects how existing shifts of that type are displayed.
{{% /notice %}}

## Using Shift Types

When creating shifts, coordinators select a shift type. This:
- Applies the type's default settings
- Categorizes the shift for filtering
- Provides consistent naming

## Planning Shift Types

Before your event, plan which shift types you need:

1. **List the kinds of work** - What categories of shifts exist?
2. **Identify common patterns** - What settings are shared?
3. **Create logical groupings** - Don't create too many types
4. **Document the purpose** - Make sure coordinators know when to use each type

## Best Practices

- **Keep it simple** - A few well-defined types are better than many overlapping ones
- **Use clear names** - "Setup" is better than "Type A"
- **Document usage** - Write descriptions that explain when to use each type
- **Review regularly** - Remove unused types, add new ones as needed

## Deleting Shift Types

Before deleting a shift type:
- Check for existing shifts using that type
- Assign those shifts to a different type
- Consider historical reporting needs

{{% notice warning %}}
Shifts may become orphaned if their shift type is deleted. Reassign shifts first.
{{% /notice %}}

## Related Topics

- [Managing Shifts]({{% relref "/shift-coordinator/shifts" %}}) - Creating shifts with shift types
- [Role Management]({{% relref "/admin/role_management" %}}) - Bureaucrat privileges
