# Windsurf Rules for Plate Project

Always start responses with "Got it, chief" and everytime you apply a rule(s), explicitly state the rule(s) in the response. You can abbreviate the rule(s) to a single word or phrase.

## Task Management Rules

1. **Task First Approach**: Before implementing any code changes, always check the task management system in the `tasks/` directory to understand:
   - Current project phase and priorities
   - Task dependencies and relationships
   - Implementation status tracking

2. **Task Status Updates**: Whenever progress is made on a task:
   - Update the task status in the appropriate kanban file
   - Move the task between backlog → in-progress → review → completed as needed
   - Update completion percentages in the phase README files

3. **Task Creation**: When new work is identified:
   - Create a new task using the template in `tasks/templates/task-template.md`
   - Assign proper phase, ID, and dependencies
   - Add to the backlog with appropriate priority

4. **Phase Alignment**: All development work must align with:
   - Current implementation phase from the PRD
   - Task priorities within that phase
   - Dependencies between tasks

## Development Process Rules

1. **Phase-Based Development**:
   - Focus on completing Phase 1 tasks before moving to Phase 2
   - Complete Phase 2 before Phase 3, and so on
   - Only work on lower priority tasks when blockers exist for higher ones

2. **Project Structure**:
   - All source code must reside within a single root `src` folder
   - Follow feature-based modular architecture as outlined in PRD
   - Create new features using the code generation tools once implemented

3. **Component and State Management**:
   - Components should be small, isolated, and stateless whenever possible
   - Follow naming conventions: PascalCase for components, camelCase for utilities
   - Always check for existing components before creating new ones

4. **Development Workflow**:
   - Generate and propose detailed plans before implementation (refer to task board)
   - Get approval for plans before starting implementation
   - Update task status when moving between workflow stages

## Implementation Guidelines

1. **Server-First Approach**:
   - Prioritize server components over client components
   - Utilize Payload's local API for zero-latency data operations
   - Implement progressive enhancement ensuring functionality without JS

2. **Authentication Systems**:
   - Maintain clear separation between admin and application user authentication
   - Implement proper security practices (HTTP-only cookies, CSRF protection)
   - Follow task dependencies for authentication features

3. **Feature Development**:
   - Follow the standardized feature module structure from the PRD
   - Implement automatic registration systems for all features
   - Ensure proper permissions and access control for all features

4. **Docker and Deployment**:
   - Follow the deployment tasks in order of dependency
   - Test Docker configurations thoroughly before marking related tasks complete
   - Document all deployment steps as per documentation tasks

## Task Prioritization

1. **Priority Levels**:
   - P0 (Critical): Must be completed immediately, blocks project progress
   - P1 (High): Essential for the current milestone
   - P2 (Medium): Important but not blocking
   - P3 (Low): Nice-to-have, can be deferred

2. **Dependency Management**:
   - Never begin a task when a dependency is incomplete
   - Mark blockers clearly in the task board
   - Communicate dependency issues promptly

## Documentation Requirements

1. **Task Documentation**:
   - Document all implementation details in the task files
   - Update acceptance criteria as requirements evolve
   - Add review comments when tasks are completed

2. **Code Documentation**:
   - Follow documentation tasks as specified in Phase 4
   - Document APIs and extension points thoroughly
   - Include setup guides and examples
