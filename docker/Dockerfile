# Base
FROM node:22-alpine AS base
ENV NEXT_TELEMETRY_DISABLED=1

# Dependencies
FROM base AS deps

# Installer git
RUN apk add --no-cache git
WORKDIR /app

RUN git clone https://github.com/enricoros/big-AGI.git .



# Dependency files

COPY package*.json ./
COPY src/server/prisma ./src/server/prisma

# link ssl3 for latest Alpine
RUN sh -c '[ ! -e /lib/libssl.so.3 ] && ln -s /usr/lib/libssl.so.3 /lib/libssl.so.3 || echo "Link already exists"'

# Install dependencies, including dev (release builds should use npm ci)
ENV NODE_ENV=development
RUN npm ci


# Builder
FROM base AS builder
WORKDIR /app

# Deployment type marker
ENV NEXT_PUBLIC_DEPLOYMENT_TYPE=docker

# Optional build version arguments at build time
ARG NEXT_PUBLIC_BUILD_HASH
ENV NEXT_PUBLIC_BUILD_HASH=${NEXT_PUBLIC_BUILD_HASH}
ARG NEXT_PUBLIC_BUILD_REF_NAME
ENV NEXT_PUBLIC_BUILD_REF_NAME=${NEXT_PUBLIC_BUILD_REF_NAME}

# Optional argument to configure GA4 at build time (see: docs/deploy-analytics.md)
ARG NEXT_PUBLIC_GA4_MEASUREMENT_ID
ENV NEXT_PUBLIC_GA4_MEASUREMENT_ID=${NEXT_PUBLIC_GA4_MEASUREMENT_ID}

# Optional argument to configure PostHog at build time (see: docs/deploy-analytics.md)
ARG NEXT_PUBLIC_POSTHOG_KEY
ENV NEXT_PUBLIC_POSTHOG_KEY=${NEXT_PUBLIC_POSTHOG_KEY}

# Copy development deps and source
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# link ssl3 for latest Alpine
RUN sh -c '[ ! -e /lib/libssl.so.3 ] && ln -s /usr/lib/libssl.so.3 /lib/libssl.so.3 || echo "Link already exists"'

# Build the application
ENV NODE_ENV=production
RUN npm run build

# Reduce installed packages to production-only
RUN npm prune --production


# Runner
FROM base AS runner
WORKDIR /app

# As user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copy Built app
COPY --from=builder --chown=nextjs:nodejs /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nextjs:nodejs /app/src/server/prisma ./src/server/prisma

# Minimal ENV for production
ENV NODE_ENV=production
ENV PATH=$PATH:/app/node_modules/.bin

# Run as non-root user
USER nextjs

# Expose port 3000 for the application to listen on
EXPOSE 3000

# Start the application
CMD ["next", "start"]