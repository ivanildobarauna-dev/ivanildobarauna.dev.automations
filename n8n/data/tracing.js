const tracer = require('./node_modules/dd-trace').init({
  service: 'n8n',
  hostname: process.env.DD_AGENT_HOST || 'localhost',
  env: process.env.DD_ENV || 'development',
  version: process.env.DD_VERSION || 'local',
  logInjection: true,
  runtimeMetrics: true,
  analytics: true
});

console.log('[dd-trace] Tracing initialized ✅');

tracer.trace('n8n.boot', { resource: 'post-start tracer' }, (span) => {
  span.setTag('startup', true);
  span.setTag('origin', 'manual tracer exec');
  span.finish();
});
