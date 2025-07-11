# kprompt

A very cursed implementation of modules in ZSH shell configured with a shell function. The shell function prints prompt expansions, and all of it is collected into PROMPT. For example:

```zsh
function myprompt() {
    kp_color green default kpmod_user
    print -n @
    kp_color blue default kpmod_machine
    kpmod_superuser
    print -n ' '
}
kprompt myprompt
```

This will produce a prompt similar to standard bash prompts.