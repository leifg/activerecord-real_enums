# Activerecord::RealEnums

Supporting enumerations in Rails has up to now always been done on the application layer.

The [symbolize](https://github.com/nofxx/symbolize) gem allows storing a limited set of different string values to a field. On a database level it is still possible to store abritrary strings.

Rails 4.1 introduced [enums](http://api.rubyonrails.org/v4.1.0/classes/ActiveRecord/Enum.html) which fulfils the same purpose but stores the different types as integers. The mapping, validation is also handled on the application layer. And even worse in order to query for a specific enum it is necessary to lookup the according values for each query:

    Conversation.where(status: Conversation.statuses[:archived])

This gem takes advantage of the [PostgreSQL enum type](http://www.postgresql.org/docs/9.1/static/datatype-enum.html) that will handle all the validations:

    Conversation.where(status: :archived)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-real_enums'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-real_enums

## Usage

### Migrations

To be able to use PostgreSQL enums, I suggest to create the according type in a separate migration:

    class CreateConversationStatusEnum < ActiveRecord::Migration
      def up
        execute "CREATE TYPE conversation_status AS ENUM ("active", "archived");"
      end

      def down
        execute "DROP TYPE conversation_status;"
      end
    end

from then on, the type `conversation_status` can be used as a regular type:

    class AddColumnsToTeam < ActiveRecord::Migration
      def change
        add_column :conversations, :status, :conversation_status
      end
    end

### Model

To reference the type correctly (e.g. for queries) the enum needs to be added to the model:


    class Converation < ActiveRecord::Base
      real_enum :status, type: :conversation_status
    end

`real_enums` will add the necessary validations in the background.

From then on, it is possible to query all conversations by status:

    Conversation.where(status: :archived) # strings and symbols, both work


## Caveats

This is a first draft. Completely usable but not feature complete:

  - no posibility to query all available values for enum
  - currently only support for PostgreSQL (although [MySQL](http://dev.mysql.com/doc/refman/5.0/en/enum.html) also has an enum type)
  - no helper methods for migration (AFAIK not officically supported to write own migration methods (that are reversible))

## Contributing

1. Fork it ( https://github.com/[my-github-username]/activerecord-real_enums/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
