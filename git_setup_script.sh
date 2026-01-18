#!/bin/bash

# FreightOps - GitHub Repository Setup Script
# This script helps you set up and publish FreightOps to GitHub

set -e

echo "🚚 FreightOps - GitHub Repository Setup"
echo "========================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed. Please install git first.${NC}"
    exit 1
fi

# Get GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo -e "${RED}Error: GitHub username is required${NC}"
    exit 1
fi

# Get repository name (default: freightops)
read -p "Enter repository name (default: freightops): " REPO_NAME
REPO_NAME=${REPO_NAME:-freightops}

echo ""
echo -e "${YELLOW}Creating repository structure...${NC}"

# Initialize git repository if not already initialized
if [ ! -d .git ]; then
    git init
    echo -e "${GREEN}✓ Git repository initialized${NC}"
else
    echo -e "${GREEN}✓ Git repository already exists${NC}"
fi

# Create .gitignore if it doesn't exist
if [ ! -f .gitignore ]; then
    cat > .gitignore << 'EOF'
# Environment Variables
.env
.env.local
.env.production
*.env

# Dependencies
node_modules/
npm-debug.log*

# Production builds
/frontend/build
/backend/dist

# Testing
coverage/

# IDE
.vscode/
.idea/
*.swp
.DS_Store

# Logs
logs/
*.log

# Database
*.sql.gz
/database/backups/

# Uploads
/backend/uploads/*
!/backend/uploads/.gitkeep

# SSL Certificates
/nginx/ssl/*.key
/nginx/ssl/*.pem

# Secrets
secrets/
EOF
    echo -e "${GREEN}✓ Created .gitignore${NC}"
fi

# Create .env.example
if [ ! -f .env.example ]; then
    cat > .env.example << 'EOF'
# Database
DB_PASSWORD=change_this_password
DATABASE_URL=postgresql://fleetuser:password@postgres:5432/trucking_fleet

# Redis
REDIS_URL=redis://redis:6379

# JWT
JWT_SECRET=change_this_secret_min_32_chars

# Microsoft Entra ID
ENTRA_CLIENT_ID=your_client_id
ENTRA_CLIENT_SECRET=your_client_secret
ENTRA_TENANT_ID=your_tenant_id
ENTRA_REDIRECT_URI=http://localhost:3000/api/auth/entra/callback

# API
NODE_ENV=production
PORT=3000
REACT_APP_API_URL=http://localhost:3000
EOF
    echo -e "${GREEN}✓ Created .env.example${NC}"
fi

# Create directory structure
mkdir -p .github/workflows
mkdir -p .github/ISSUE_TEMPLATE
mkdir -p docs
mkdir -p frontend/src
mkdir -p backend/auth
mkdir -p backend/routes
mkdir -p database
mkdir -p nginx

echo -e "${GREEN}✓ Directory structure created${NC}"

# Create placeholder files for uploads and reports
mkdir -p backend/uploads backend/reports
touch backend/uploads/.gitkeep
touch backend/reports/.gitkeep

# Stage all files
git add .

# Create initial commit
if ! git rev-parse HEAD > /dev/null 2>&1; then
    git commit -m "Initial commit: FreightOps Fleet Management System

- Complete fleet management application
- Microsoft Entra ID authentication
- Docker containerized deployment
- React frontend with Tailwind CSS
- Node.js/Express backend API
- PostgreSQL database with Redis cache
- IFTA reporting and DOT compliance
- Comprehensive documentation"
    echo -e "${GREEN}✓ Initial commit created${NC}"
else
    echo -e "${YELLOW}! Repository already has commits${NC}"
fi

# Set main branch
git branch -M main

echo ""
echo -e "${YELLOW}Repository setup complete!${NC}"
echo ""
echo "Next steps:"
echo ""
echo "1. Create a new repository on GitHub:"
echo -e "   ${GREEN}https://github.com/new${NC}"
echo "   Repository name: ${REPO_NAME}"
echo ""
echo "2. Run these commands to push to GitHub:"
echo ""
echo -e "   ${GREEN}git remote add origin https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git${NC}"
echo -e "   ${GREEN}git push -u origin main${NC}"
echo ""
echo "3. Optional: Enable GitHub Actions"
echo "   - Go to repository Settings > Actions > General"
echo "   - Enable 'Allow all actions and reusable workflows'"
echo ""
echo "4. Optional: Set up branch protection"
echo "   - Go to Settings > Branches"
echo "   - Add rule for 'main' branch"
echo "   - Enable 'Require pull request reviews before merging'"
echo ""
echo "5. Configure secrets for CI/CD (if using):"
echo "   - Go to Settings > Secrets and variables > Actions"
echo "   - Add secrets for production deployment"
echo ""
echo -e "${GREEN}Happy shipping! 🚚${NC}"