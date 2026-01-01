---
title: "Distributing Goodies"
weight: 10
---

This guide covers the process of checking eligibility, marking active status, and recording goodie distribution.

## Understanding the Goodie System

Most events use a two-step process:

1. **Active status** - Volunteer is marked as having worked enough hours to qualify
2. **Goodie received** - Volunteer is marked as having received their physical goodie

This separation allows flexibility - someone might be eligible (active) but hasn't picked up their goodie yet.

## Checking Eligibility

When a volunteer requests their goodie:

1. **Find them in the system** - Search by name or nickname
2. **Check their status**:
   - Hours worked (from shifts and worklogs)
   - Current active status
   - Whether they've already received a goodie

{{% notice note %}}
The `user.info.view` privilege lets you see personal details like real names. This helps verify identity before distribution.
{{% /notice %}}

## Setting Active Status

If a volunteer has worked enough hours but isn't marked active:

1. Verify their worked hours meet the threshold
2. Mark them as "active"
3. This makes them eligible for goodies

{{% notice info %}}
"Active" status may also affect other things at your event, like appearing on certain lists or earning privileges. Check with your coordinators about what active status means at your event.
{{% /notice %}}

## Recording Distribution

When handing out a goodie:

1. Verify the person matches the account
2. Check their t-shirt size preference (if applicable)
3. Hand over the physical item
4. Mark "goodie received" in the system

## Per-Angel-Type Goodie Lists

The `angeltype.goodie.list` privilege gives you access to goodie lists organized by angel type. This is useful for:

- Planning distribution by team
- Tracking sizes needed per team
- Organizing distribution during team meetings

## Handling Special Cases

### Not Enough Hours

If someone hasn't worked enough hours yet:
- Explain the hours threshold
- Show them their current count
- Suggest signing up for more shifts

### Already Received

If the system shows they already got their goodie:
- Someone else may have recorded it
- They may have picked it up at another distribution point
- Check with coordinators if they claim it's an error

### Wrong Size

If someone's registered size differs from what they want:
- Check your stock availability
- Update their preference if possible
- Document any exchanges

### Not Arrived

If someone isn't marked as arrived:
- They should check in at the Welcome Angel desk first
- Some events require arrival before goodie distribution

## Tips for Distribution Events

When distributing during a concentrated period (like event wrap-up):

- **Pre-sort by size** - Have stacks organized
- **Print lists** - Have backup lists in case of connectivity issues
- **Two-person teams** - One checks eligibility, one retrieves items
- **Mark immediately** - Update the system as you hand out, not afterward

## Related Topics

- [Role Management]({{% relref "/admin/role_management" %}}) - Understanding Goodie Manager privileges
