---
title: "Engelsystem Documentation"
---

Engelsystem is a volunteer management and shift planning system for events. It helps organizers coordinate volunteers by managing shift schedules, tracking qualifications, recording work hours, and distributing rewards.

## Core Concepts

**Volunteers** register accounts, join angel types matching their skills, and sign up for shifts. The system tracks their hours and manages reward eligibility.

**Angel Types** represent categories of volunteer work. Some are open to anyone, others require approval or specific qualifications.

**Shifts** are time-bounded work assignments at specific locations. Volunteers sign up for shifts that match their angel types.

**Locations** define where shifts take place - rooms, entrances, stations, or any area at your event.

## Permission Groups

Engelsystem uses groups to control what users can do. Users are assigned to one or more groups:

| Group | Purpose |
|-------|---------|
| Angel | Base volunteer - sign up for shifts, track hours, earn rewards |
| Welcome Angel | Check-in desk - mark volunteer arrivals |
| Voucher Angel | Distribute food and drink vouchers |
| Goodie Manager | Handle t-shirt and merchandise distribution |
| Shift Coordinator | Create shifts, manage users, answer questions |
| Bureaucrat | Configure event structure (angel types, locations, shift types) |
| API | Access the programmatic API for integrations |
| Developer | Full system administration and configuration |

Most volunteers only need the **Angel** group. Specialized roles get additional groups as needed.

### Supporter Capability

**Supporter** is different from groups above - it's a per-angel-type capability, not a system-wide role. Any Angel can be made a Supporter for specific angel types they belong to. Supporters can approve membership requests and manage shifts for their team. See the [Supporter Guide](supporter/) for details.

## Getting Started

1. **Register** an account in the Engelsystem for your event
2. **Complete your profile** with contact information
3. **Join angel types** that match your skills or interests
4. **Browse shifts** and sign up for available slots
5. **Work your shifts** and earn hours toward rewards

## Documentation Sections

### User Guides

- **[User Guide](user/)** - For all volunteers: registration, shifts, profile, and messaging
- **[Supporter Guide](supporter/)** - For team leads: managing angel type membership and team shifts
- **[Welcome Angel Guide](welcome-angel/)** - For check-in desk: marking arrivals
- **[Voucher Angel Guide](voucher-angel/)** - For voucher distribution
- **[Goodie Manager Guide](goodie-manager/)** - For t-shirt and merchandise distribution
- **[Shift Coordinator Guide](shift-coordinator/)** - For coordinators: shifts, users, FAQ, and worklogs
- **[Bureaucrat Guide](bureaucrat/)** - For organizers: angel types, locations, and event structure

### Technical Documentation

- **[Administration](admin/)** - Server setup, configuration, and role management
- **[Development](developer/)** - Technical architecture and contribution guide
- **[API Reference](api/)** - REST API for integrations
