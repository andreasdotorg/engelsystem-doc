---
title: "Voucher Angel Guide"
weight: 26
---

Voucher Angels distribute vouchers to volunteers who have earned them through their work. These might be food vouchers, drink tokens, or other rewards your event offers.

## What Voucher Angels Do

Your role is to verify eligibility and record voucher distribution. Volunteers come to you after working shifts, and you check whether they've earned vouchers and mark them as distributed in the system.

## Required Permissions

To function as a Voucher Angel, you need to be a member of the **Voucher Angel** group. This group grants:

| Privilege | What it does |
|-----------|--------------|
| `voucher.edit` | Edit voucher counts for users |
| `users.arrive.list` | Access user lists for voucher distribution |
| `user.info.hint` | See indicators when a user's personal info is restricted |

You should also be in the **Angel** group for basic system access.

## How Vouchers Work

The voucher system varies by event configuration:

- **Earning vouchers** - Volunteers typically earn vouchers based on hours worked
- **Initial vouchers** - Some events give vouchers upon arrival
- **Force vouchers** - Coordinators can manually award vouchers

The exact number of vouchers earned depends on your event's configuration (hours required per voucher, maximum vouchers, etc.).

## Getting Started

1. **Access the user list** - Navigate to the arrival/user list
2. **Find the volunteer** - Search by name or nickname
3. **Check eligibility** - View their current voucher count and eligibility
4. **Record distribution** - Update the voucher count when you hand out vouchers

## Documentation

- [Distributing Vouchers](voucher-distribution/) - Step-by-step guide for voucher distribution

{{% notice tip %}}
Keep track of your physical voucher stock. The system tracks what's been recorded as distributed, but you need to ensure you have vouchers to hand out.
{{% /notice %}}
