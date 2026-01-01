---
title: "Administration"
date: 2019-02-12T20:35:11+01:00
weight: 40
---

This section covers everything you need to deploy, configure, and maintain an Engelsystem instance for your event. Whether you're setting up a small hackathon or coordinating thousands of volunteers at a major conference, this guide will help you get Engelsystem running smoothly.

## What You'll Find Here

**[Installation](installation/)** covers deploying Engelsystem using Docker, Kubernetes, NixOS, or a traditional PHP web server setup. Each method includes step-by-step instructions and production-ready configurations.

**[Configuration](configuration/)** explains all available settings, from database connections and email delivery to shift scheduling rules and reward calculations. Learn how to customize Engelsystem for your event's specific needs.

**[Role Management](role_management/)** describes the permission system. Understand how groups, privileges, and user roles work together to control access to different features.

**[Schedule Import](schedule-import/)** shows how to automatically create shifts from external event schedules like Frab or Pretalx. This is especially useful for conferences where volunteer shifts should align with talks and sessions.

**[OAuth Configuration](oauth/)** covers integrating external authentication providers, allowing users to log in with existing accounts from services like GitHub, Google, or your organization's identity provider.

**[Translation](translation/)** explains how to customize or override the default interface text, useful for adapting terminology to your event's culture or adding support for additional languages.

## Before You Begin

To successfully deploy Engelsystem, you should be comfortable with:

- Basic server administration (Linux command line, file permissions)
- Database management (MySQL/MariaDB basics)
- Web server configuration (nginx or Apache) if not using Docker
- Your chosen deployment method (Docker, Kubernetes, or NixOS)

You'll need access to:

- A server or container platform to run the application
- A MySQL 5.7+ or MariaDB 10.2+ database server
- SMTP server or email service for sending notifications (optional but recommended)

## Deployment Overview

Engelsystem is a PHP application that requires:

1. **Web server** - nginx or Apache to handle HTTP requests
2. **PHP runtime** - PHP 8.2 or newer with required extensions
3. **Database** - MySQL or MariaDB for persistent storage
4. **Background jobs** - Optional, for scheduled tasks

For production deployments, we recommend:

- **Docker or Kubernetes** for reproducible deployments and easy updates
- **HTTPS** with valid certificates (required for security headers)
- **Regular backups** of the database and configuration

## Quick Start

If you're setting up Engelsystem for the first time:

1. Choose your [deployment method](installation/) based on your infrastructure
2. Follow the installation guide to get the application running
3. Log in with the default admin credentials (change these immediately!)
4. Configure [essential settings](configuration/) like your event name and timezone
5. Set up [user roles](role_management/) appropriate for your team structure
6. Optionally configure [OAuth](oauth/) for easier user authentication

## Getting Help

- **GitHub Issues**: Report bugs or request features at [engelsystem/engelsystem](https://github.com/engelsystem/engelsystem/issues)
- **Source Code**: Browse the implementation at [github.com/engelsystem/engelsystem](https://github.com/engelsystem/engelsystem)

{{% notice tip %}}
Before your event, run a test deployment and have team leads verify they can perform their tasks. It's much easier to fix configuration issues before hundreds of volunteers are trying to sign up for shifts.
{{% /notice %}}
