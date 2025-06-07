# Plate: Next.js 15 + Payload CMS v3 Boilerplate

A comprehensive, server-first boilerplate leveraging Payload CMS v3's revolutionary Next.js-native architecture. Unlike traditional CMS solutions that require separate backend services, Payload v3 installs directly into your Next.js `/app` folder, enabling true server-first development with **local API access that eliminates HTTP overhead entirely**.

## Features

- **Server-First Architecture**: 80-90% server-rendered components with strategic client-side hydration
- **Dual Authentication System**: Super admin (Payload) and application users (custom frontend)
- **Feature-Based Modular Architecture**: Organized into core and extended features
- **Automatic Collection Registration**: No manual configuration required
- **shadcn/ui Integration**: Beautiful UI components with theme support
- **Docker Setup**: Development and production configurations ready to go

## Project Structure

```
src/
├── app/                        # Next.js App Router
│   ├── (frontend)/            # Public-facing application
│   │   ├── account/           # User account management
│   │   ├── auth/              # User authentication
│   │   └── dashboard/         # User dashboard
│   └── (payload)/             # Payload admin routes (super admin only)
├── features/
│   ├── core/                  # Essential system features
│   │   ├── auth/              # User authentication system
│   │   ├── users/             # Application user management
│   │   ├── accounts/          # Account management features
│   │   └── admin/             # Super admin features
│   └── extend/                # Custom business features
├── shared/
│   ├── components/            # Reusable UI components
│   ├── lib/                   # Utility functions
│   └── types/                 # Shared TypeScript types
└── payload.config.ts          # Payload configuration
```

## Quick Start

### Development

1. Clone this repository
2. Copy the environment variables: `cp .env.example .env`
3. Update the `.env` file with your MongoDB connection string

3. `pnpm install && pnpm dev` to install dependencies and start the dev server
4. Open `http://localhost:3000` to access the app in your browser
5. Navigate to `http://localhost:3000/admin` to access the Payload CMS admin panel

### Docker Development

```bash
# Start the development environment with Docker
docker-compose up -d

# View logs
docker-compose logs -f
```

### Production Deployment

```bash
# Build the production Docker image
docker build -t plate .

# Run the container
docker run -p 3000:3000 plate
```

## Task Management

This project follows a structured task management approach (Task First Approach). All development work is organized in the `tasks/` directory:

- **Phase-based organization**: Tasks are organized by implementation phase in `tasks/phases/`
- **Kanban workflow**: Tasks progress through backlog → in-progress → review → completed
- **Prioritization system**: Tasks are prioritized as P0 (Critical) to P3 (Low)

Refer to the task management system before making any code changes.

## Technology Stack

- **Next.js 15**: App Router, Server Components, Server Actions
- **Payload CMS v3**: Headless CMS with local API access
- **MongoDB**: Database adapter
- **shadcn/ui**: Component library with theme support (to be integrated)
- **Docker**: Development and production containerization

## Feature-Based Architecture

The boilerplate implements a dual-module system distinguishing between core functionality and extensible features:

- **Core Features**: Essential system functionality (auth, users, etc.)
- **Extended Features**: Custom business functionality that can be easily added or removed

Each feature follows a standardized structure enabling automatic registration and consistent patterns across the codebase.

## Collections

The initial setup includes the following collections:

- **Users**: Authentication-enabled collection for admin access
- **Media**: Handles file uploads with image optimization

Additional collections will be created as part of the feature-based architecture implementation.

## Project Implementation Phases

1. **Foundation Enhancement**: Setup and organize project structure
2. **Core Feature Enhancements**: Authentication, account management, email verification
3. **Extended Features**: Blog, dashboard, file uploads, code generation
4. **Production Optimization**: Performance, documentation, deployment

Refer to the `tasks/phases/` directory for detailed implementation plans for each phase.
