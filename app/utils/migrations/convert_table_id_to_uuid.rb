class Migrations::ConvertTableIdToUuid

  attr_reader :table, :primary_key_column

  def initialize(table)
    @table = table
    @primary_key_column = ActiveRecord::Base.connection.primary_key(table)
  end

  def self.up(table)
    new(table).up
  end

  def self.down(table)
    new(table).down
  end

  def up
    ActiveRecord::Base.connection.execute(convert_id_to_uuid_query)
    ActiveRecord::Base.connection.execute(drop_sequence_query)
  end

  def down
    ActiveRecord::Base.connection.execute(create_sequence_for_id_query)
    ActiveRecord::Base.connection.execute(convert_uuid_to_id_query)
  end

  private

  def convert_id_to_uuid_query
    %Q{ALTER TABLE #{table}
      ALTER COLUMN #{primary_key_column} DROP DEFAULT,
      ALTER COLUMN #{primary_key_column} SET DATA TYPE UUID USING gen_random_uuid(),
      ALTER COLUMN #{primary_key_column} SET DEFAULT gen_random_uuid()
    }
  end

  def drop_sequence_query
    %Q{DROP SEQUENCE IF EXISTS #{table}_#{primary_key_column}_seq}
  end

  def create_sequence_for_id_query
    %Q{CREATE SEQUENCE IF NOT EXISTS #{table}_#{primary_key_column}_seq
      MINVALUE 1 START 1 OWNED BY #{table}.id
    }
  end

  def convert_uuid_to_id_query
    %Q{ALTER TABLE #{table}
      ALTER COLUMN #{primary_key_column} DROP DEFAULT,
      ALTER COLUMN #{primary_key_column} SET DATA TYPE INTEGER USING nextval('#{table}_id_seq'),
      ALTER COLUMN ID SET DEFAULT nextval('#{table}_id_seq')
    }
  end
end
