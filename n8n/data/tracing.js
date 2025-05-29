const tracer = require('dd-trace').init({
    service: 'n8n',
    hostname: process.env.DD_AGENT_HOST || 'localhost',
    env: process.env.DD_ENV || 'development',
    version: process.env.DD_VERSION || 'local',
    logInjection: true,
    runtimeMetrics: true,
    analytics: true
  });

console.log('[dd-trace] Tracing initialized ✅');