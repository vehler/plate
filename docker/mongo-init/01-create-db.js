// MongoDB initialization script for development environment
print('Start MongoDB initialization script');

// Create plate database if it doesn't exist
db = db.getSiblingDB('plate');

// Create an initial admin user for development (not for production)
if (db.getUser('dev_admin') == null) {
  db.createUser({
    user: 'dev_admin',
    pwd: 'dev_password',
    roles: [
      { role: 'readWrite', db: 'plate' },
      { role: 'dbAdmin', db: 'plate' }
    ]
  });
  print('Dev admin user created');
}

print('MongoDB initialization completed');
