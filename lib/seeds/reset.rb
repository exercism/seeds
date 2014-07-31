module Reset
  def self.hard
    system("dropdb exercism_seeds")
    system("createdb -O exercism exercism_seeds")

    # schema
    system("pg_dump -U exercism exercism_development --no-acl --schema-only -f db/schema.sql")
    system("psql -U exercism -d exercism_seeds -f db/schema.sql")

    # migration history
    system("pg_dump -U exercism exercism_development -t schema_migrations --data-only -f db/migrations.sql")
    system("psql -U exercism -d exercism_seeds -f db/migrations.sql")
  end
end
