# Contributing to FreightOps

First off, thank you for considering contributing to FreightOps! It's people like you that make FreightOps such a great tool for the trucking industry.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to conduct@freightops.io.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps to reproduce the problem**
* **Provide specific examples to demonstrate the steps**
* **Describe the behavior you observed and what you expected**
* **Include screenshots or animated GIFs** if relevant
* **Include your environment details** (OS, browser, Docker version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a detailed description of the suggested enhancement**
* **Provide specific examples to demonstrate the feature**
* **Describe the current behavior** and **explain the expected behavior**
* **Explain why this enhancement would be useful**

### Pull Requests

* Fill in the required template
* Follow the coding style guidelines
* Include appropriate test coverage
* Update documentation as needed
* End all files with a newline

## Development Process

### Setting Up Your Development Environment

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR-USERNAME/freightops.git
   cd freightops
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/ORIGINAL-OWNER/freightops.git
   ```

4. **Install dependencies**
   ```bash
   # Backend
   cd backend
   npm install
   
   # Frontend
   cd ../frontend
   npm install
   ```

5. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your local configuration
   ```

6. **Start development servers**
   ```bash
   # Option 1: Using Docker
   docker-compose up -d
   
   # Option 2: Local development
   # Terminal 1 - Backend
   cd backend
   npm run dev
   
   # Terminal 2 - Frontend
   cd frontend
   npm start
   ```

### Making Changes

1. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Make your changes**
   - Write clean, readable code
   - Follow existing code style
   - Add comments for complex logic
   - Update tests as needed

3. **Test your changes**
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

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: description of your changes"
   ```
   
   **Commit message format:**
   - `Add:` for new features
   - `Fix:` for bug fixes
   - `Update:` for updates to existing features
   - `Refactor:` for code refactoring
   - `Docs:` for documentation changes
   - `Test:` for test-related changes

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the original repository on GitHub
   - Click "New Pull Request"
   - Select your fork and branch
   - Fill in the PR template with details

### Pull Request Guidelines

* **Keep PRs focused** - One feature/fix per PR
* **Update documentation** - If you change functionality, update docs
* **Add tests** - All new features should include tests
* **Follow code style** - Match the existing code style
* **Keep commits clean** - Squash commits if needed
* **Update CHANGELOG** - Add entry for your changes

## Code Style Guidelines

### JavaScript/Node.js

```javascript
// Use ES6+ features
const myFunction = async (param1, param2) => {
  // Use const for variables that won't be reassigned
  const result = await someAsyncOperation();
  
  // Use let for variables that will change
  let counter = 0;
  
  // Use descriptive variable names
  const userData = await fetchUser(userId);
  
  // Add JSDoc comments for functions
  /**
   * Calculate total mileage for a trip
   * @param {string} origin - Origin location
   * @param {string} destination - Destination location
   * @returns {number} Total miles
   */
  const calculateMiles = (origin, destination) => {
    // Implementation
  };
};
```

### React/JSX

```jsx
// Use functional components with hooks
const MyComponent = ({ prop1, prop2 }) => {
  const [state, setState] = useState(initialValue);
  
  useEffect(() => {
    // Side effects here
  }, [dependencies]);
  
  return (
    <div className="container">
      <h1>{prop1}</h1>
      <p>{prop2}</p>
    </div>
  );
};

// PropTypes or TypeScript for type checking
MyComponent.propTypes = {
  prop1: PropTypes.string.isRequired,
  prop2: PropTypes.number
};
```

### SQL

```sql
-- Use uppercase for SQL keywords
SELECT u.id, u.email, u.first_name
FROM users u
JOIN companies c ON u.company_id = c.id
WHERE u.status = 'active'
ORDER BY u.created_at DESC;

-- Use meaningful table and column names
-- Add comments for complex queries
```

## Testing Guidelines

### Unit Tests

```javascript
describe('EntraAuthService', () => {
  test('should generate authorization URL', () => {
    const service = new EntraAuthService(mockPool);
    const url = service.getAuthorizationUrl('test-state');
    
    expect(url).toContain('login.microsoftonline.com');
    expect(url).toContain('state=test-state');
  });
});
```

### Integration Tests

```javascript
describe('API Endpoints', () => {
  test('GET /api/vehicles returns vehicle list', async () => {
    const response = await request(app)
      .get('/api/vehicles')
      .set('Authorization', `Bearer ${testToken}`);
    
    expect(response.status).toBe(200);
    expect(response.body).toBeInstanceOf(Array);
  });
});
```

## Documentation

* Update README.md if you change functionality
* Add JSDoc comments to new functions
* Update API documentation for new endpoints
* Include code examples where helpful
* Keep documentation clear and concise

## Database Migrations

When making database changes:

1. Create a migration file in `database/migrations/`
2. Use descriptive names: `YYYYMMDD_description.sql`
3. Include both UP and DOWN migrations
4. Test migrations on a copy of production data
5. Document any data transformations

Example migration:

```sql
-- Migration: Add entra_id column to users table
-- Date: 2026-01-16

-- UP
ALTER TABLE users ADD COLUMN entra_id VARCHAR(255) UNIQUE;
CREATE INDEX idx_users_entra_id ON users(entra_id);

-- DOWN
DROP INDEX IF EXISTS idx_users_entra_id;
ALTER TABLE users DROP COLUMN IF EXISTS entra_id;
```

## Versioning

We use [Semantic Versioning](https://semver.org/):

* **MAJOR** version for incompatible API changes
* **MINOR** version for backwards-compatible functionality
* **PATCH** version for backwards-compatible bug fixes

## Release Process

1. Update version in `package.json`
2. Update CHANGELOG.md
3. Create a git tag: `git tag -a v1.2.3 -m "Release version 1.2.3"`
4. Push tag: `git push origin v1.2.3`
5. GitHub Actions will automatically build and deploy

## Getting Help

* 💬 Join our [Discord community](https://discord.gg/freightops)
* 📧 Email: dev@freightops.io
* 📖 Read the [documentation](https://docs.freightops.io)
* 🐛 Check [existing issues](https://github.com/yourusername/freightops/issues)

## Recognition

Contributors will be recognized in:
* README.md Contributors section
* Release notes
* Annual contributor spotlight

Thank you for contributing to FreightOps! 🚚✨