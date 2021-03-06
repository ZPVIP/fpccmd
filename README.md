# fpccmd

Easy compile FPC projects.

- - -

### compile

Use [CodeTyphon](http://www.pilotlogic.com/) (above 6.00) to compile ```fpccmd```.

- - -

### usage

Change working directory to your FPC project and run:

```
$ fpccmd init
```

A ```fpccmd.cfg``` will be created and contains basic compile options.

You may edit the ```fpccmd.cfg``` for any new options you want.

Run ```fpccmd``` within project path to compile the project.

```
$ fpccmd <platform> <main file>
```

```fpccmd``` will found and add the search path and no necessary for you to add the path manually.

- - -

### Source & Update

The ```Source``` can be set for speed-up the file downloading. Run:

```
$ fpccmd set-source <repo url>
```

And this command for reviewing current source:

```
$ fpccmd source
```

You may use the update command for updating ```fpccmd```

```
$ fpccmd update
```

- - -

### iOS Compile Environment

If you want to cross compile the project to iOS, you must have iOS Environment installed.

```fpccmd``` will help the installation, just run:

```
$ sudo fpccmd install-ios
```

