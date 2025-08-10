# CLAUDE.md

This file provides guidance to Claude Code when working with code in this project.

## Project Overview
<!-- Describe your project here - what it does, its main purpose, and key technologies used -->

## Project Structure
<!-- Describe the organization of your codebase -->
```
project-root/
├── src/           # Source code
├── tests/         # Test files
├── docs/          # Documentation
└── ...
```

## Development Guidelines

### Task Management
Focus on getting tasks done efficiently. Only use TodoWrite for genuinely complex tasks that require breaking down into multiple steps.

### Code Style
<!-- Define your preferred code style and conventions -->
- Use consistent indentation (spaces/tabs)
- Follow naming conventions for your language
- Keep functions small and focused
- Write descriptive comments for complex logic

### Testing
<!-- Describe your testing approach -->
- Write tests for new features
- Ensure all tests pass before committing
- Test edge cases and error conditions

### Git Workflow
<!-- Define your git workflow preferences -->
- Use descriptive commit messages
- Keep commits atomic and focused
- Create feature branches for new work

## Key Commands
<!-- List important commands for development -->
```bash
# Install dependencies
npm install  # or yarn, pip install, etc.

# Run tests
npm test

# Build the project
npm run build

# Start development server
npm run dev
```

## Architecture Decisions
<!-- Document important architectural decisions and patterns used -->

## Security Considerations
<!-- Note any security concerns or sensitive areas -->
- Never commit secrets or API keys
- Validate all user inputs
- Follow security best practices for your framework

## Performance Considerations
<!-- Note any performance-critical areas -->

## Additional Context
<!-- Any other important information Claude should know -->

### TodoWrite Tool Usage
**Default approach**: Just get tasks done. Don't use TodoWrite unless absolutely necessary.

**Only use TodoWrite when**:
- Task genuinely requires 5+ distinct steps
- Working across many files simultaneously  
- User explicitly requests task breakdown

**Never use TodoWrite for**:
- Single edits or fixes
- Simple questions/answers
- Routine coding tasks
- Any task that can be completed directly

   
---
*This CLAUDE.md file helps Claude Code understand your project better. Update it as your project evolves!*
