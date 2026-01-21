# QBR-Core Improvement Roadmap

This document provides a prioritized list of actionable improvements for the qbr-core repository.

## 🔴 Critical Priority (Immediate Action)

### 1. Fix Recursive Random String Generation Bug
**File:** `shared/main.lua` (lines 10-13, 16-19)  
**Issue:** Stack overflow risk for large string lengths  
**Effort:** 15 minutes  
**Impact:** Prevents potential crashes

```lua
-- Current (problematic):
QBShared.RandomStr = function(length)
    if length <= 0 then return '' end
    return QBShared.RandomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
end

-- Recommended fix:
QBShared.RandomStr = function(length)
    if length <= 0 then return '' end
    local result = {}
    for i = 1, length do
        result[i] = StringCharset[math.random(1, #StringCharset)]
    end
    return table.concat(result)
end
```

### 2. Remove Dead Code
**File:** `shared/main.lua` (lines 81-109)  
**Issue:** Large commented-out code blocks  
**Effort:** 5 minutes  
**Impact:** Reduces confusion, improves maintainability

### 3. Add Database Error Handling
**Files:** `server/player.lua`, `server/events.lua`  
**Issue:** No error handling for database operations  
**Effort:** 2 hours  
**Impact:** Prevents data loss and improves reliability

## 🟡 High Priority (This Week)

### 4. Enhance README.md
**File:** `README.md`  
**Current State:** Only 23 lines, minimal information  
**Effort:** 2-3 hours  
**Impact:** Critical for onboarding and usage

**Required Sections:**
- [ ] Installation instructions
- [ ] Prerequisites and dependencies
- [ ] Configuration guide
- [ ] Basic usage examples
- [ ] Feature overview
- [ ] Contributing guidelines link
- [ ] Support/contact information
- [ ] Credits and acknowledgments

### 5. Refactor Skill Level Configuration
**File:** `config.lua` (lines 36-128)  
**Issue:** 92 lines of repetitive code  
**Effort:** 30 minutes  
**Impact:** Reduces configuration from 92 to ~15 lines

### 6. Add Input Validation
**Files:** `server/commands.lua`, `server/player.lua`  
**Issue:** Missing validation for user inputs  
**Effort:** 3-4 hours  
**Impact:** Prevents errors and exploits

### 7. Create .editorconfig Enforcement
**Current State:** .editorconfig exists but not enforced  
**Effort:** 1 hour  
**Impact:** Consistent code style

**Actions:**
- [ ] Fix mixed tabs/spaces in existing files
- [ ] Add pre-commit hook (optional)
- [ ] Document in CONTRIBUTING.md

## 🟢 Medium Priority (This Month)

### 8. Add Basic Test Suite
**Effort:** 1-2 days  
**Impact:** Prevents regressions, improves confidence

**Test Coverage Needed:**
- [ ] Player creation (`CreateCitizenId`)
- [ ] Inventory management functions
- [ ] Money operations
- [ ] Permission system
- [ ] Random string generation utilities

**Recommended Framework:** busted (Lua testing framework)

### 9. Database Schema Improvements
**File:** `qbcore.sql`  
**Effort:** 2-3 hours  
**Impact:** Better performance and data integrity

**Improvements:**
- [ ] Add indexes on frequently queried columns
- [ ] Consider JSON column type for structured data
- [ ] Add foreign key constraints
- [ ] Document schema with ERD

### 10. Add Inline Documentation
**All Files**  
**Effort:** 4-5 hours  
**Impact:** Easier maintenance and contribution

**Focus Areas:**
- [ ] Function parameter descriptions
- [ ] Return value documentation
- [ ] Complex logic explanations
- [ ] Export functions (all 40+ of them)

### 11. Create CHANGELOG.md
**Effort:** 1 hour  
**Impact:** Track changes, inform users

**Format:** Keep a Changelog standard
- [ ] Document version 1.0.3 changes
- [ ] Set up template for future releases

### 12. Expand .gitignore
**File:** `.gitignore`  
**Effort:** 10 minutes  
**Impact:** Prevents unwanted files in repo

```
# IDE
.idea
.vscode
*.code-workspace

# OS
.DS_Store
Thumbs.db

# Logs
*.log

# Backup files
*.bak
*~

# Dependencies (if any)
node_modules/
vendor/
```

## 🔵 Low Priority (Future)

### 13. CI/CD Pipeline
**Effort:** 1 day  
**Impact:** Automated testing and deployment

**Recommended Actions:**
- [ ] Set up GitHub Actions
- [ ] Add linting workflow
- [ ] Add test workflow (once tests exist)
- [ ] Add release workflow

### 14. Performance Optimization
**Effort:** 2-3 days  
**Impact:** Better server performance with many players

**Focus Areas:**
- [ ] Profile player data loops
- [ ] Implement caching for static data
- [ ] Optimize database queries
- [ ] Review UpdateInterval setting

### 15. Rate Limiting for Commands
**Effort:** 1 day  
**Impact:** Prevents command spam/abuse

### 16. Audit Logging System
**Effort:** 2 days  
**Impact:** Track admin actions for accountability

### 17. Create Contributing Guidelines
**File:** `CONTRIBUTING.md`  
**Effort:** 2 hours  
**Impact:** Easier for others to contribute

**Include:**
- [ ] Code style guide
- [ ] Commit message format
- [ ] PR process
- [ ] Issue reporting guidelines

### 18. Issue and PR Templates
**Effort:** 1 hour  
**Impact:** Better issue/PR quality

**Templates Needed:**
- [ ] Bug report template
- [ ] Feature request template
- [ ] Pull request template

### 19. RedM-Specific Documentation Site
**Effort:** 1-2 weeks  
**Impact:** Comprehensive resource for users

**Could Include:**
- [ ] API reference
- [ ] Tutorials
- [ ] Best practices
- [ ] Migration guide from FiveM QBCore

## 📊 Progress Tracking

| Priority | Total Items | Completed | In Progress | Not Started |
|----------|-------------|-----------|-------------|-------------|
| Critical | 3 | 0 | 0 | 3 |
| High | 5 | 0 | 0 | 5 |
| Medium | 7 | 0 | 0 | 7 |
| Low | 7 | 0 | 0 | 7 |
| **Total** | **22** | **0** | **0** | **22** |

## 📅 Suggested Timeline

### Week 1
- Fix recursive random string bug ✓
- Remove dead code ✓
- Enhance README ✓

### Week 2
- Refactor skill configuration ✓
- Add input validation ✓
- Enforce .editorconfig ✓

### Month 1
- Add basic test suite ✓
- Database improvements ✓
- Add inline documentation ✓

### Month 2-3
- CI/CD setup ✓
- Performance optimization ✓
- Documentation site ✓

## 🎯 Success Metrics

- **Code Quality:** 0 critical bugs, consistent style
- **Documentation:** 100% of exports documented
- **Testing:** >70% code coverage for core functions
- **Performance:** <100ms response time for player operations
- **Community:** >5 external contributors

## 📝 Notes

- This roadmap is flexible and should be adjusted based on community feedback
- Priority levels can change based on user needs and bug reports
- Each item should be tracked as a separate GitHub issue
- Regular review (monthly) recommended to assess progress

---

**Last Updated:** January 21, 2026  
**Next Review:** February 21, 2026
