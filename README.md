![Logo](./packages/app/assets/icon.png)

# pjatka
[![Android Beta](https://github.com/hdbg/pjatka/actions/workflows/android-pre-release.yml/badge.svg?branch=main)](https://github.com/hdbg/pjatka/actions/workflows/android-pre-release.yml)
[![Web](https://github.com/hdbg/pjatka/actions/workflows/web-deploy.yml/badge.svg)](https://github.com/hdbg/pjatka/actions/workflows/web-deploy.yml)

Student companion app optimized for better UX.

Current features include:
- Based only on PJATK server: there is no backend
- Day / Week / Month timetable

Planned features:
- Cancelled classes detection (based on stored - parsed delta of classes)
- Classes reminders
- Absences tracker
- Homework reminders

## Background
I decided that I would like native mobile experience with additional features for timetable.
There exists a feature to export into calendar, however it's not dynamic: meaning that if class is cancelled, calendar won't reflect it.

Currently, it scrapes timetable website. It based on fairly old ASP.NET WebForms technology, so it's a pain. In particular:
- A part of client form controls state get's transmitted in every request. In result, each request is at least a few Kb in size
- There is no API per se –– client javascript modifies local state, which triggers "full rebuild" (or "delta", doesn't matter)
- Details are fragmented. To get important data for class, such as room, instructor and groups I have to make a separate request. Since there is no possibility to filter by groups, AFAIK. In the end, this means that app has to get details of each class (there is ≈300 classes per day). That's why parsing is so slow

I have limited concurrency for scrapper so as not to overwhelm server. 

> I am NOT affiliated with PJATK. There is no guarantees or liability. Use at your own risk.


