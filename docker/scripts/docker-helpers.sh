#!/bin/bash
# Helper scripts for Docker development and deployment operations

# Colors for terminal output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Development environment functions
dev_up() {
  echo -e "${GREEN}Starting development environment...${NC}"
  docker-compose up -d
  echo -e "${GREEN}Development environment started!${NC}"
  echo -e "Access the application at: http://localhost:3000"
  echo -e "Access the admin panel at: http://localhost:3000/admin"
}

dev_down() {
  echo -e "${YELLOW}Shutting down development environment...${NC}"
  docker-compose down
  echo -e "${GREEN}Development environment stopped!${NC}"
}

dev_logs() {
  echo -e "${GREEN}Showing logs from development environment...${NC}"
  docker-compose logs -f
}

# Production environment functions
prod_up() {
  echo -e "${GREEN}Starting production environment...${NC}"
  docker-compose -f docker-compose.prod.yml up -d
  echo -e "${GREEN}Production environment started!${NC}"
  echo -e "Access the application at: http://localhost:3000"
  echo -e "Access the admin panel at: http://localhost:3000/admin"
}

prod_down() {
  echo -e "${YELLOW}Shutting down production environment...${NC}"
  docker-compose -f docker-compose.prod.yml down
  echo -e "${GREEN}Production environment stopped!${NC}"
}

prod_logs() {
  echo -e "${GREEN}Showing logs from production environment...${NC}"
  docker-compose -f docker-compose.prod.yml logs -f
}

# Utility functions
db_backup() {
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  BACKUP_PATH="./docker/backups"
  mkdir -p $BACKUP_PATH
  
  echo -e "${GREEN}Creating database backup...${NC}"
  docker-compose exec mongo mongodump --archive=$BACKUP_PATH/mongodb_$TIMESTAMP.gz --gzip --db plate
  echo -e "${GREEN}Backup created at $BACKUP_PATH/mongodb_$TIMESTAMP.gz${NC}"
}

db_restore() {
  if [ -z "$1" ]; then
    echo -e "${RED}Error: Backup file path required${NC}"
    echo -e "Usage: ./docker/scripts/docker-helpers.sh db_restore ./docker/backups/mongodb_20250607.gz"
    return 1
  fi

  echo -e "${YELLOW}Restoring database from $1...${NC}"
  docker-compose exec mongo mongorestore --archive=$1 --gzip
  echo -e "${GREEN}Database restored!${NC}"
}

clean_volumes() {
  echo -e "${YELLOW}WARNING: This will remove all Docker volumes for this project!${NC}"
  read -p "Are you sure you want to continue? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Removing Docker volumes...${NC}"
    docker-compose down -v
    echo -e "${GREEN}Docker volumes removed!${NC}"
  fi
}

# Helper function
show_help() {
  echo -e "${GREEN}Plate Docker Helper Scripts${NC}"
  echo -e "Usage: ./docker/scripts/docker-helpers.sh [command]"
  echo
  echo -e "Development Commands:"
  echo -e "  dev_up          Start development environment"
  echo -e "  dev_down        Stop development environment"
  echo -e "  dev_logs        Show development logs"
  echo
  echo -e "Production Commands:"
  echo -e "  prod_up         Start production environment"
  echo -e "  prod_down       Stop production environment"
  echo -e "  prod_logs       Show production logs"
  echo
  echo -e "Utility Commands:"
  echo -e "  db_backup       Create MongoDB backup"
  echo -e "  db_restore      Restore MongoDB backup (requires path)"
  echo -e "  clean_volumes   Remove Docker volumes (caution!)"
}

# Main command dispatcher
case "$1" in
  dev_up) dev_up ;;
  dev_down) dev_down ;;
  dev_logs) dev_logs ;;
  prod_up) prod_up ;;
  prod_down) prod_down ;;
  prod_logs) prod_logs ;;
  db_backup) db_backup ;;
  db_restore) db_restore $2 ;;
  clean_volumes) clean_volumes ;;
  *) show_help ;;
esac
