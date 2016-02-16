user = User.create(email: 'test@email.com', password: 'password', password_confirmation: 'password')

# root
#   child 1
#     child 1
#   child 2

notecard = Notecard.create(title: 'root notecard', body: 'this is an example body', user: user)

notecard2 = Notecard.create(title: 'child 1 of root', body: 'this is an example body', user: user)
notecard2.move_to_child_of(notecard)

notecard3 = Notecard.create(title: 'child 1 of child 1', body: 'this is an example body', user: user)
notecard3.move_to_child_of(notecard2)

notecard4 = Notecard.create(title: 'child 2 of root', body: 'this is an example body', user: user)
notecard4.move_to_child_of(notecard)

