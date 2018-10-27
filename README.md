# Cluster Config Repo

>This repository holds all the `yaml` files used to configure the Kubernetes cluster all the SRTSignIn services run in.

### How to Update the Cluster

This is fairly easy. Once you have the `yaml` files updated as you see fit, make sure you have `kubectl` installed and using the `kubeconfig` file associated with the cluster, then run the command:
```shell
./configure.sh
```
This will run a bunch of `kubectl` commands that apply the new updated configs and mount secret files.

### How secret files are handled

Our project is using the [git-secret](http://git-secret.io/) tool, which allows our team to commit the files we mount as secrets in our cluster to version control. The files are encrypted. We were running into the issue of each team member have different versions of the secret files on their local machines and whenever they would make an update to the cluster there was the possibility of adding an outdated or incorrect secret file to the cluster. Now, using GPG keys we can encrypt our secrets before committing them, and only those with access to the repository and with gpg keys added to the key-ring will be able to decrypt the files locally.

### How to use `git-secret`

#### Install `git-secret`

- For those on `Mac OS X >= 10.9`, `Ubuntu >= 14.04`, `Debian >= 8.3`, and `Fedora` you may install `git-secret` by following the instructions [here](http://git-secret.io/installation)
- For those of you on `Windows`, you will need to build the tool on your machine. Follow the *Manual* instructions on the [instruction page](http://git-secret.io/installation). I recommend the commands in `Git Bash`.

#### Add a new secret file

- We are currently storing secrets in the `secrets` and `stage-secrets` folders of this repository.
- Ensure the new secret has been added to the `.gitignore` file, `git-secret` requires this.
- Run the command 
    ```shell
    git secret add <filename>
    ```
    in order to add the new secret.
- To verify the correct file was added run 
    ```shell
    git secret list
    ```
    and the output will show all the secrets currently being handled by `git-secret`

#### Hiding/Revealing Secrets

- In order to reveal the files run the command
    ```shell
    git secret reveal
    ```
    which may prompt you to overwrite the secrets you may already have locally, do so to get the most up to date secrets.
    >NOTE: using the `-f` flag will force the overwrite step so that you do not have to answer all the prompts