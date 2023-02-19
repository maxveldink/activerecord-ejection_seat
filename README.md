# ActiveRecord::EjectionSeat

[![IMAGE ALT TEXT](https://img.youtube.com/vi/HfCY-bkVJKM/0.jpg)](http://www.youtube.com/watch?v=HfCY-bkVJKM "Introduction to activerecord-ejection_seat")

## ActiveRecord <=> T::Struct

Sometimes, you want to convert from an `ActiveRecord` model to something more akin to a simple data class. Enter [Sorbet's `T::Struct`](https://sorbet.org/docs/tstruct). This gem helps to eject out of bulky `ActiveRecord` models (or buckle into them) and work with simple `T::Struct`'s in the rest of your app.

For more information about the "why" behind this gem, check out [this post](https://maxveld.ink/ejecting-out-of-an-orm/).

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add activerecord-ejection_seat

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install activerecord-ejection_seat

## Usage

Let's say you have an `ActiveRecord` model for a `User` with a string `name` column, an integer `age` column, a `role` enum column and a belongs to association with a `Location` model. Another way to express this would be a `User` type that is a simple, typed struct with other supporting structs.

```ruby
module Types
  class UserRoles < T::Enum
    enums do
      Admin = new("admin")
      Member = new("member")
    end
  end

  class Location < T::Struct
    const :name, String
  end

  class User < T::Struct
    const :name, String
    const :age, Integer
    const :role, UserRoles
    const :location, Location
  end
end
```

In our model, we can specify an ejection to this type.

```ruby
class User
  belongs_to :location
  enum :role, { admin: "admin", member: "member" }

  ejects_to Types::User
end
```

Now, we have two new methods available on `User`. First, we can eject from a `User` instance to a `Types::User`.

```ruby
location = Location.new(name: "Florida")
User.new(name: "Max", age: 28, role: "admin", location: location).eject
# => Types::User(name: "Max", age: 28, role: Types::UserRoles::Admin, location: Types::Location.new(name: "Florida))
User.new(name: "Max", age: 28, role: "admin", location: location).to_struct # alias
```

Second, we can buckle into the `User` model with a `Types::User`.

```ruby
user_struct = Types::User.new(name: "Max", age: 28, role: Types::UserRoles::Admin, location: Types::Location.new(name: "Florida"))
User.buckle(user_struct)
# => User(name: "Max", age: 28, role: "admin", location: Location(name: "Florida"))
User.from_struct(user_struct) # alias
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run Rubocop and the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. You'll need a schema to test `ActiveRecord` against. Check out `spec/spec_helper.rb` for an example setup.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/maxveldink/activerecord-ejection_seat. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/maxveldink/activerecord-ejection_seat/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this project's codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/maxveldink/activerecord-ejection_seat/blob/master/CODE_OF_CONDUCT.md).

## Sponsorships

I love creating in the open. If you find this or any other [maxveld.ink](https://maxveld.ink) content useful, please consider sponsoring me on [GitHub](https://github.com/sponsors/maxveldink).
