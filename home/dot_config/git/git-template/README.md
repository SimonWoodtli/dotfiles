# Git Templates

Hooks can be very powerful to customize your workflow. Here are some ideas of how to use hooks and some example code.

## Hooks I currently use

* pre-commit that checks if the user is on the main branch and gives him a warning and an option to proceed anyways.

## Idea: Encryption with hooks

> 🧐 There is also a VS-Code plugin for `sops`, if you prefer that over vim. It would also handle the encryption/decryption part for you.

I've recently discovered `sops` and `age` for encryption. So when you just use `age` encrypting files can be a bit cumbersome. Now `sops` in combination can be awesome, because it allows you too automatically edit encrypted files (decrypt), write and save out of vim (encrypt).

### Workflow `age` with hook:

If you just want to use `age` hooks can actually be very useful. So you don't need to manually decrypt and encrypt them all the time. But a bit inconvenient, because you would still need to adjust the hooks script for every encrypted file you add, rename or move. Hence I prefer to use `sops`.

Example of a pre-commit hook:

> ⚠️ Don't add this hook. I never tested it out. (Because I find `sops` to be the simpler approach)

```
#!/bin/bash

# Decrypt the file
age -d -i secrets.yaml.age -o secrets.yaml

# Add the decrypted file to the staging area
git add secrets.yaml

# Encrypt the file
age -o secrets.yaml.age -r <recipient-public-key> secrets.yaml

# Add the encrypted file to the staging area
git add secrets.yaml.age
```

Example of a post-checkout hook:

```
#!/bin/bash

# Decrypt the file
age -d -i secrets.yaml.age -o secrets.yaml
```
