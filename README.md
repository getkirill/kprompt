# kprompt

A very cursed implementation of prompt modules in ZSH shell configured with a shell function. The shell function prints prompt expansions, and all of it is collected into PROMPT. For example:

```zsh
# plug "getkirill/kprompt" # or however you enable plugins
function myprompt() {
    # bashlike
    kp_color_push green
    kpmod_user
    print -n @
    kpmod_machine
    kp_color_pop
    print -n :
    kp_color blue default kpmod_pwd
    kpmod_superuser
    print -n ' '
}
kprompt myprompt
```

This will produce a prompt similar to standard bash prompts.

## Available modules

- `kpmod_pwd [segments]` - shows pwd or `~` when home, optionally limiting segment count.
- `kpmod_user` - user
- `kpmod_machine` - hostname
- `kpmod_superuser [fg] [bg]` - prints `#` with passed colors if root, plain `$` otherwise (color inherited from stack)
- `kp_color_push [fg] [bg]` - pushes color onto stack and prints it out. if `default` is passed it is equivalent to %k or %f
- `kp_color_pop` - pops color off stack and prints it out
- `kp_color_peek` - prints stack top
- `kp_color <fg> <bg> <command> [args...]` - executes module with given colors
- `kpmod_git <commit | branch | has-repo>` - outputs commit, branch, or returns presence of repo (0 if present, 1 if not)
- `$KPROMPT_EXIT_CODE` - variable that saves $? before executing any code.

## Custom modules

Any function (or even executable) is a module so long as it outputs prompt into stdout.
