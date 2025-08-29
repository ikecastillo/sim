#!/bin/bash

# Sim Studio Development Startup Script
# This script sets up and starts Sim Studio with your external PostgreSQL and local Ollama

echo "🚀 Starting Sim Studio Development Environment..."
echo ""

# Check if Ollama is running
echo "📡 Checking Ollama connection..."
if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
    echo "✅ Ollama is running on http://localhost:11434"
    echo "📋 Available models:"
    curl -s http://localhost:11434/api/tags | python3 -m json.tool | grep '"name"' | head -5
else
    echo "❌ Ollama is not running on http://localhost:11434"
    echo "Please start Ollama first:"
    echo "  ollama serve"
    exit 1
fi

echo ""

# Check PostgreSQL connection
echo "🐘 Testing PostgreSQL connection..."
DB_URL="postgresql://i.castillo2:Rufus!7415@psqldb-k-kashmiryclust-kkashmiry0641.dbuser:5432/SnowLeopard"

# Test connection (this will work if psql is installed, otherwise we'll skip)
if command -v psql &> /dev/null; then
    if psql "$DB_URL" -c "SELECT 1;" > /dev/null 2>&1; then
        echo "✅ PostgreSQL connection successful"
    else
        echo "⚠️  Could not test PostgreSQL connection (will be tested during startup)"
    fi
else
    echo "⚠️  psql not found - PostgreSQL connection will be tested during startup"
fi

echo ""

# Check if Docker is running
echo "🐳 Checking Docker..."
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop first."
    exit 1
fi
echo "✅ Docker is running"

echo ""

# Start the services
echo "🔧 Starting Sim Studio services..."
echo "This will:"
echo "  1. Build the Docker images (first time only)"
echo "  2. Run database migrations on your PostgreSQL"
echo "  3. Start the main application on http://localhost:3000"
echo "  4. Start the realtime server on http://localhost:3002"
echo ""

read -p "Press Enter to continue or Ctrl+C to cancel..."

# Start services
docker compose -f docker-compose.dev.yml up -d --build

echo ""
echo "🎉 Sim Studio is starting up!"
echo ""
echo "📍 Services:"
echo "   Main App:      http://localhost:3000"
echo "   Realtime:      http://localhost:3002"
echo "   Database:      External PostgreSQL (SnowLeopard)"
echo "   Ollama:        http://localhost:11434"
echo ""
echo "📊 To check status:"
echo "   docker compose -f docker-compose.dev.yml ps"
echo ""
echo "📝 To view logs:"
echo "   docker compose -f docker-compose.dev.yml logs -f"
echo ""
echo "🛑 To stop:"
echo "   docker compose -f docker-compose.dev.yml down"
echo ""
echo "⏳ Wait 1-2 minutes for services to fully start, then visit http://localhost:3000"
