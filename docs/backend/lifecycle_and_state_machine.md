## Lifecycle and state machine

Both `Task` and `Project` models are lifecycle-based. A lifecycle is a simple
[state machine](https://en.wikipedia.org/wiki/Finite-state_machine). It is
quite basic to develop but we need to add validations for each state and make
sure transitions are correct.

Since describing a lifecycle can quickly increase number of lines, we moved
corresponding code in dedicated `concerns`. If you take a look to
`app/models/project.rb` file, you'll notice the following line:

```ruby
class Project < ApplicationRecord
  include ProjectLifecycle

  ...
end
```

Project's lifecycle is described in `app/models/concerns/project_lifecycle.rb`:

```ruby
module ProjectLifecycle
  ...

  init_state_machine do
    # First, we describe different states
    state :newed
    state :started
    state :paused
    state :finished

    # Then, we describe transitions
    transition :start, from: :newed, to: :started
    transition :pause, from: :started, to: :paused
    transition :restart, from: :paused, to: :started
    transition :finish, from: :started, to: :finished
  end

  ...
end
```

The state machine provides a method to models in order to update the `state`:
`update_with_transition!`.

```ruby
project = Project.create!(name: 'My project', state: 'newed')
project.update_with_transition! state: 'started'
```

This method makes sure the transition is valid (e.g. `newed` to `finished`
would fail since there is no corresponding transition). It also executes
potential handlers such as `on_start` or `on_pause`:

```ruby
module ProjectLifecycle
  ...

protected

  def on_start(params)
    check_transition_no_limit_started_projects
    params[:started_at] = Time.current
    params
  end

  def on_pause(params)
    params[:paused_at] = Time.current
    params
  end

  ...
end
```

Finally, the state machine defines a bunch of useful methods based on events'
names:

```ruby
project.newed?    # returns true if project.state == 'newed'
Project.newed     # returns all projects with 'newed' state
Project.not_newed # returns all projects with a state different form 'newed'
...
```

The state machine system is described in the `app/models/concerns/state_machine.rb`
file.

Also, lifecycle files add different validations for each state such as
`started_at` attribute cannot be set if project is `newed`.
