# Changelog

## 2.0
- Removed options: `tube_enable_shortcuts`, `tube_run_command_background`.
- Removed commands: `ToggleBufnameExp`, `ToggleFunctionExp`, `ToggleSelectionExp`, `RemoveAlias`, `AddAlias`, `RemoveAllAliases`, `ReloadAliases`, `TubeToggleClearScreen`. 
* Renamed commands: `TubeClear` to `TubeClr`, `TubeAliasClear` to `TubeAliasClr`, `TubeLastCommand` to `TubeLastCmd`, `TubeInterruptCommand` to `TubeInterrupt`.

## 1.2
* Fix issues with commas when passing arguments to injected function. Now to separate arguments is required the special sequence '^^'.
+ New options: `tube_funargs_separator`.

## 1.1
+ New feature: selection injection into the command with the `@` character.
+ New feature: injected functions now can accept arguments.
+ New options: `tube_enable_shortcuts`, `tube_selection_expansion`.
+ New commands: `TubeToggleSelectionExp`.
+ Added shortcuts for most important commands (disabled by default).
* Renamed options: `tube_at_character_expansion` to `tube_bufname_expansion`.
* Renamed commands: `TubeToggleExpandPercent` to `TubeToggleBufnameExp`, `TubeToggleExpandFunction` to `TubeToggleFunctionExp`.
* Fix issues with backslash escaping in commands.
* Minor fixes.

## 1.1.1
* Fix issues with plugin feedback.

## 1.1
+ New feature: the result of a custom vim function can be injected into the command with the special notation `#{CustomFunction}`.
* Minor fixes.

## 1.0
* First release.
