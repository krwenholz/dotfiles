#!/bin/sh
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp --scope user || true
claude mcp add --transport http figma https://mcp.figma.com/mcp --scope user || true
claude mcp add --transport http github https://api.githubcopilot.com/mcp -H "Authorization: Bearer YOUR_GITHUB_PA" --scope user || true
