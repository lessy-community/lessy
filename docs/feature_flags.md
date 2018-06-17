# Feature flags

Feature flags are an important part of Lessy. They are used to bring piece of
code even if feature is not complete. A feature flag gives the possibility to
disable or enable a feature for given users, a certain percentage of users or
for everyone.

First, you need to know that feature flags are handled by [Flipper](https://github.com/jnunemaker/flipper)
and we make use of the [ActiveRecord adapter](https://github.com/jnunemaker/flipper/tree/master/docs/active_record).

Here is a simple example to help you to start: imagine that you want to ship a
new statistics feature which is not stable yet. Let's create it in a new
migration and call this feature flag `stats`:

```rb
class AddStatsFeatureFlag < ActiveRecord::Migration[5.1]
  include FlipperMigration

  def up
    create_flag :stats, enabled: false
  end

  def down
    destroy_flag :stats
  end
end
```

Now, you can check if your users have access to this new feature:

```console
irb> User.first.flipper_enabled? :stats
=> false
```

Obviously, none of your users have access to it since it has not been enabled
for any of them yet. To enable a feature flag, there are several possibilities
but we will cover only two of them.

The first is to enable the feature only for specific users:

```console
irb> Flipper.enable_actor :stats, User.first
irb> User.first.flipper_enabled? :stats
=> true
irb> User.second.flipper_enabled? :stats
=> false
```

The second is to enable the feature for all or none of them based on a boolean
system:

```console
irb> Flipper.enable :stats
irb> User.first.flipper_enabled? :stats
=> true
irb> User.second.flipper_enabled? :stats
=> true
irb> Flipper.disable :stats
irb> User.first.flipper_enabled? :stats
=> false
irb> User.second.flipper_enabled? :stats
=> false
```

Once the feature has been shipped for everybody and you don't make any use of
it anymore, you can remove the flag based on the same migration system than for
creation (just inverse `up` and `down`!)

Note this system is quite new so we'll probably need to improve it.
