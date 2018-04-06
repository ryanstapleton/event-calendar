# README

Reworked the app-in-a-day assigned by Bottega at 6 weeks. 

## User Stories
- Types of users
&nbsp; - Admin
&nbsp; - User
&nbsp; - Casual user

### Casual User Story
- Purpose: Onsite to view upcoming events and calendar
- No login necessary
- Can't create/edit/delete/rsvp/favorite events
- Pages accessible: Home (index), Register/login

### User Story
- Purpose: Onsite to view upcoming events and calendar, and CRUD events, rsvp/favorite events
- Login is necessary
- Can create/edit/delete/rsvp/favorite events
- Events are submitted as pending, must be approved before listed on index
- Event can be edited until approved
- Pages accessible: Home (index), Register/login, Dashboard, CRUD pages

### Admin Story
- Purpose: Onsite to view upcoming events and calendar, and CRUD events, rsvp/favorite events, approve/reject pending events
- Inherits all characteristics from a normal User
- Events are approved/rejected on admin page
- Pages accessible: Home (index), Register/login, Dashboard, CRUD pages, Admin dashboard

## Pages
- Home
- User Dashboard
- Admin Dashboard
- Login
- Register
- Show
- Edit/New

Feature REQs:
- [ ] Google Calender (possibly google maps API)
- [x] Login/logout (Devise)
- [x] CRUD events (Rails)
- [x] RSVP and Favorites CRUD (Rails)
- [x] Users can mark event as favorite (Rails)
- [x] Users can mark event as RSVP (Rails)
- [x] Users dashboard page (Rails)
- [x] Design layouts (Bootsrap)
- [x] My upcoming events (Rails)
- [x] An event must be approved by admin to be published (Petergate)
- [x] Styling ala "devcamp" (Bootstrap)
- [ ] Reminder of event (SMS - Twilio)
- [ ] RSVP reminder (email, sms) - mailgun, twilio

TODOs:
- [ ] Add phone number to users
- [ ] Check Google API for needed parameters on events table
- [ ] Remove edit functionality for users when event is approved
- [ ] Decide what to do with rejected events
