# FreightOps 🚚

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![React](https://img.shields.io/badge/React-18+-blue.svg)](https://reactjs.org/)

**FreightOps** is a comprehensive fleet management system designed specifically for the trucking industry. It provides commercial mileage tracking, routing, dispatch management, IFTA fuel tax reporting, and DOT permit compliance—all in one integrated platform.

![FreightOps Dashboard](docs/images/dashboard-screenshot.png)

## ✨ Features

### 🎯 Core Functionality
- **Fleet Management** - Track vehicles, drivers, and equipment status in real-time
- **Dispatch & Routing** - Plan and optimize routes with automated mileage calculation
- **IFTA Reporting** - Automated quarterly fuel tax reports by jurisdiction
- **DOT Compliance** - Permit tracking with automatic expiration notifications
- **Commercial Mileage** - Comprehensive trip logging and odometer tracking
- **Fuel Tax Management** - State-by-state fuel purchase tracking and MPG analytics

### 🔐 Enterprise Authentication
- **Microsoft Entra ID (Azure AD)** - Single Sign-On with OAuth 2.0
- **Multi-tenant Support** - Separate data for different organizations
- **Role-Based Access Control** - Admin, Dispatcher, and Driver roles
- **Just-in-Time Provisioning** - Automatic user creation on first login

### 🏗️ Technical Architecture
- **Modern React Frontend** - Responsive UI with Tailwind CSS
- **Node.js/Express API** - RESTful backend with JWT authentication
- **PostgreSQL Database** - Robust relational data storage
- **Redis Cache** - High-performance caching layer
- **Docker Containers** - Fully containerized deployment
- **Microservices Ready** - Modular architecture for scaling

## 🚀 Quick Start

### Prerequisites

- Docker 20.10+ and Docker Compose 2.0+
- Node.js 18+ (for local development)
- Azure AD tenant (for Entra ID authentication)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/freightops.git
   cd freightops
   ```

2. **Configure environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Start the application**
   ```bash
   docker-compose up -d
   ```

4. **Access FreightOps**
   - Frontend: http://localhost
   - API: http://localhost:3000
   - Database: localhost:5432

### Configuration

Create a `.env` file with the following variables:

```bash
# Database
DB_PASSWORD=your_secure_password
DATABASE_URL=postgresql://fleetuser:your_password@postgres:5432/trucking_fleet

# Redis
REDIS_URL=redis://redis:6379

# Authentication
JWT_SECRET=your_jwt_secret_min_32_characters

# Microsoft Entra ID (Azure AD)
ENTRA_CLIENT_ID=your_application_client_id
ENTRA_CLIENT_SECRET=your_client_secret
ENTRA_TENANT_ID=your_tenant_id
ENTRA_REDIRECT_URI=http://localhost:3000/api/auth/entra/callback

# API
NODE_ENV=production
PORT=3000
```

## 📚 Documentation

- [Deployment Guide](docs/DEPLOYMENT.md) - Complete deployment instructions
- [Entra ID Setup](docs/ENTRA_SETUP.md) - Microsoft authentication configuration
- [API Documentation](docs/API.md) - REST API endpoints and usage
- [Database Schema](docs/DATABASE.md) - Database structure and relationships
- [Development Guide](docs/DEVELOPMENT.md) - Local development setup
- [Contributing Guidelines](CONTRIBUTING.md) - How to contribute

## 🏗️ Project Structure

```
freightops/
├── frontend/                 # React application
│   ├── src/
│   │   ├── components/      # React components
│   │   ├── App.jsx          # Main application
│   │   └── index.js         # Entry point
│   ├── Dockerfile
│   └── package.json
├── backend/                  # Node.js API
│   ├── auth/                # Authentication modules
│   │   └── entraAuth.js     # Entra ID integration
│   ├── routes/              # API routes
│   │   └── auth.js          # Auth endpoints
│   ├── server.js            # Express server
│   ├── Dockerfile
│   └── package.json
├── database/                 # Database files
│   └── init.sql             # Schema initialization
├── nginx/                    # Nginx configuration
│   └── nginx.conf
├── docs/                     # Documentation
├── .github/                  # GitHub configuration
│   ├── workflows/           # CI/CD workflows
│   └── ISSUE_TEMPLATE/      # Issue templates
├── docker-compose.yml        # Container orchestration
└── README.md
```

## 🔧 Development

### Local Development Setup

1. **Frontend Development**
   ```bash
   cd frontend
   npm install
   npm start
   # Runs on http://localhost:3000
   ```

2. **Backend Development**
   ```bash
   cd backend
   npm install
   npm run dev
   # Runs on http://localhost:3000
   ```

3. **Database Setup**
   ```bash
   # Start PostgreSQL
   docker-compose up -d postgres
   
   # Run migrations
   npm run migrate
   ```

### Running Tests

```bash
# Backend tests
cd backend
npm test

# Frontend tests
cd frontend
npm test

# Integration tests
docker-compose -f docker-compose.test.yml up --abort-on-container-exit
```

## 🐳 Docker Deployment

### Production Deployment

```bash
# Build images
docker-compose build

# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Kubernetes Deployment

```bash
# Generate Kubernetes manifests
kompose convert -f docker-compose.yml

# Deploy to cluster
kubectl apply -f k8s/ -n freightops

# Check status
kubectl get pods -n freightops
```

## 📊 Database Schema

Key tables:
- **companies** - Organization information
- **users** - User accounts with Entra ID integration
- **vehicles** - Fleet vehicle records
- **drivers** - Driver information
- **trips** - Trip logging and mileage
- **fuel_records** - Fuel purchases by state
- **ifta_reports** - Quarterly tax reports
- **permits** - DOT permits and compliance

See [Database Documentation](docs/DATABASE.md) for complete schema.

## 🔐 Security

- JWT-based authentication
- Password hashing with bcrypt
- OAuth 2.0 / OpenID Connect for Entra ID
- CSRF protection
- SQL injection prevention with parameterized queries
- XSS protection with Helmet.js
- Rate limiting on API endpoints
- Secure session management

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [React](https://reactjs.org/)
- Backend powered by [Express.js](https://expressjs.com/)
- Database: [PostgreSQL](https://www.postgresql.org/)
- Cache: [Redis](https://redis.io/)
- Icons by [Lucide](https://lucide.dev/)
- Styling with [Tailwind CSS](https://tailwindcss.com/)

## 📞 Support

- 📧 Email: support@freightops.io
- 💬 Discord: [Join our community](https://discord.gg/freightops)
- 📖 Documentation: [docs.freightops.io](https://docs.freightops.io)
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/freightops/issues)

## 🗺️ Roadmap

- [ ] Mobile application (iOS/Android)
- [ ] Real-time GPS tracking integration
- [ ] Advanced analytics and reporting
- [ ] Electronic Logging Device (ELD) integration
- [ ] Load board integration
- [ ] Automated billing and invoicing
- [ ] Driver mobile app
- [ ] API webhooks for third-party integrations

## 📈 Status

- ✅ Core fleet management
- ✅ IFTA reporting
- ✅ DOT compliance tracking
- ✅ Microsoft Entra ID authentication
- ✅ Containerized deployment
- 🚧 Mobile app (in progress)
- 🚧 GPS tracking (planned)
- 🚧 ELD integration (planned)

---

Made with ❤️ for the trucking industry

⭐ Star us on GitHub if FreightOps helps your fleet!