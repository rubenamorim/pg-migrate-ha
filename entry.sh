#!/bin/bash

source ./logging.sh

main() {
  section "Starting the PostgreSQL Migration Orchestration"

  if [ -z "$STANDALONE_URL" ]; then
    error_exit "STANDALONE_URL environment variable is not set."
  fi

  if [ -z "$PRIMARY_URL" ]; then
    error_exit "PRIMARY_URL environment variable is not set."
  fi

#   section "Syncing Data"
#   ./sync_data.sh
#   if [ $? -ne 0 ]; then
#     error_exit "Data sync failed!"
#   fi
#   write_ok "Data sync completed successfully"

  section "Setting Up Replication"
  ./setup_replication.sh
  if [ $? -ne 0 ]; then
    error_exit "Replication setup failed!"
  fi
  write_ok "Replication setup completed successfully"

  section "PostgreSQL Migration Completed"
}

main "$@"
