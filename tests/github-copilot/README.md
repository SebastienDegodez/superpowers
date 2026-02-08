# GitHub Copilot Skills Tests

Automated tests for superpowers skills using GitHub Copilot (adapted from Copilot Code tests).

## Overview

This test suite is designed to verify that skills are loaded correctly and GitHub Copilot follows them as expected.
*Note: This is currently based on the Copilot Code test suite and needs adaptation for Copilot's specific interface.*

## Requirements

- GitHub Copilot CLI or integration (TBD)
- Local superpowers plugin installed

## Running Tests

### Run all fast tests (recommended):
```bash
./run-skill-tests.sh
```

### Run integration tests (slow, 10-30 minutes):
```bash
./run-skill-tests.sh --integration
```

### Run specific test:
```bash
./run-skill-tests.sh --test test-subagent-driven-development.sh
```

### Run with verbose output:
```bash
./run-skill-tests.sh --verbose
```

## Test Structure

See `test-helpers.sh` for common functions. The structure mirrors the Copilot Code tests but targets the `tests/github-copilot` directory.
