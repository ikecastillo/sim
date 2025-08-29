# 🚀 Sim Studio Development Setup

## Quick Start

Your Sim Studio instance is configured to use:
- **Database**: Your external PostgreSQL (`SnowLeopard` database)
- **AI Models**: Local Ollama server with `llama3.2:latest`
- **Environment**: Development mode with full logging

### 1. Prerequisites ✅

- [x] Docker Desktop running
- [x] Ollama running on `http://localhost:11434`
- [x] PostgreSQL database accessible
- [x] Available models: `llama3.2:latest`

### 2. Start the Application

```bash
# Simple startup (recommended)
./start-sim-dev.sh

# Or manually with Docker Compose
docker compose -f docker-compose.dev.yml up -d --build
```

### 3. Access Points

- **Main Application**: http://localhost:3000
- **Realtime Server**: http://localhost:3002
- **Ollama API**: http://localhost:11434

### 4. Configuration Details

#### Database Configuration
```
Host: psqldb-k-kashmiryclust-kkashmiry0641.dbuser:5432
Database: SnowLeopard
User: i.castillo2
```

#### Generated Secrets
- **BETTER_AUTH_SECRET**: `9d041...19c2` (64 chars)
- **ENCRYPTION_KEY**: `36150...33c8` (64 chars)

#### AI Provider
- **Provider**: Ollama (Local)
- **URL**: http://localhost:11434
- **Available Models**: llama3.2:latest

### 5. Development Commands

```bash
# View service status
docker compose -f docker-compose.dev.yml ps

# View logs (all services)
docker compose -f docker-compose.dev.yml logs -f

# View logs (specific service)
docker compose -f docker-compose.dev.yml logs -f simstudio

# Stop services
docker compose -f docker-compose.dev.yml down

# Rebuild and restart
docker compose -f docker-compose.dev.yml up -d --build --force-recreate
```

### 6. Adding More Ollama Models

```bash
# Pull additional models
ollama pull llama3.1:8b
ollama pull codellama:7b
ollama pull mistral:7b

# List available models
ollama list
```

### 7. Troubleshooting

#### If app won't start:
1. Check Docker is running: `docker info`
2. Check Ollama is running: `curl http://localhost:11434/api/tags`
3. Check database connectivity (if possible)
4. View logs: `docker compose -f docker-compose.dev.yml logs`

#### If database migrations fail:
- Ensure your PostgreSQL user has CREATE privileges
- Check network connectivity to the database host
- Verify the database `SnowLeopard` exists

#### If Ollama integration fails:
- Restart Ollama: `ollama serve`
- Check models are available: `ollama list`
- Verify port 11434 is not blocked

### 8. Production Deployment (Work PC)

When moving to your work PC:
1. Copy `docker-compose.dev.yml`
2. Update database URL to your work environment
3. Ensure Ollama is installed and running
4. Run the same startup process

### 9. Optional Features (Currently Disabled)

You can enable these later by updating the environment variables:

- **Email Services**: Set `RESEND_API_KEY`
- **OAuth Login**: Set Google/GitHub client credentials
- **Billing**: Set `BILLING_ENABLED=true`
- **Background Jobs**: Set `TRIGGER_DEV_ENABLED=true`

---

## 🎯 Next Steps

1. Run `./start-sim-dev.sh`
2. Wait 1-2 minutes for services to start
3. Visit http://localhost:3000
4. Create your first account
5. Start building AI workflows!

---

*Generated for development setup with external PostgreSQL and local Ollama*
