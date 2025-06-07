# Plate: Next.js 15 + Payload CMS v3 Boilerplate
# Optimized multi-stage Dockerfile for production deployments

FROM node:20-alpine AS base

# Install dependencies only when needed
FROM base AS deps
# Add additional dependencies and security patches
RUN apk update && \
    apk add --no-cache \
    libc6-compat \
    ca-certificates \
    curl \
    tzdata \
    git && \
    update-ca-certificates

WORKDIR /app

# Install dependencies based on the preferred package manager
COPY package.json pnpm-lock.yaml* ./
RUN corepack enable pnpm && \
    pnpm config set store-dir /.pnpm-store && \
    pnpm install --prod --frozen-lockfile --prefer-offline


# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app

# Add development dependencies for build
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Disable Next.js telemetry during build
ENV NEXT_TELEMETRY_DISABLED 1

# Build the application
RUN corepack enable pnpm && \
    pnpm run build

# Production image, copy all the files and run next
FROM base AS runner
WORKDIR /app

# Set production environment and disable telemetry
ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1

# Create a non-root user for security
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs --ingroup nodejs && \
    mkdir -p /app/.next && \
    chown -R nextjs:nodejs /app

# Copy public assets if they exist
COPY --from=builder /app/public ./public

# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# Copy Payload-specific files needed for production
COPY --from=builder --chown=nextjs:nodejs /app/src/payload.config.ts ./src/payload.config.ts
COPY --from=builder --chown=nextjs:nodejs /app/dist ./dist
COPY --from=builder --chown=nextjs:nodejs /app/src/collections ./src/collections

# Extra security hardening
RUN find /app -type d -exec chmod 755 {} \; && \
    find /app -type f -exec chmod 644 {} \;

# Switch to non-root user
USER nextjs

# Expose the application port
EXPOSE 3000

# Set environment variables
ENV PORT 3000
ENV HOSTNAME "0.0.0.0"
ENV PAYLOAD_CONFIG_PATH dist/payload.config.js

# Health check for container orchestration
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:3000/api/health || exit 1

# Start the application
CMD ["node", "server.js"]
