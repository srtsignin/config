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
    >Using the `-f` flag will force the overwrite step so that you do not have to answer all the prompts
    
    >Be sure to run this command after pulling in order to update your local versions before editing.

- In order to update secrets in the repository you will need to re-encrypt them. The command to update the encrypted files is
    ```shell
    git secret hide
    ```
    which will re-encrypt all the secret files.
    >IMPORTANT: Make sure to specify in your commit messages which secret files you change because the tool will re-encrypt all binaries. It will make everyone's lives easier.

#### Adding or Removing contributors from the key-ring

- To add a new user to the key-ring all you need is their public GPG key. Add their public key to your gpg key list using the command `gpg --import <KEY_NAME>`.
- Then to add the new key to the key-ring simply run
    ```shell
    git secret tell <EMAIL_ASSOCIATED_WITH_KEY>
    ```
    >If you forget the email address run `gpg --list-keys`
- To remove a contributor from the key-ring run the command
    ```shell
    git secret killperson <EMAIL_ASSOCIATED_WITH_KEY>
    ```
>IMPORTANT: Since we are using the free version of GitHub we cannot use the git pre-receive hook to prevent contributors who are not part of the key-ring from adding themselves to the key-ring. They would not be able to decrypt the secrets immediately but if they commit the new ring and someone pulls that commit, makes changes, and commits updated secrets using the ring, then they will be able to call `git secret reveal` and it work. So security lies in the careful handling of who is a contributor to the repository.

#### Other Commands

To list all commands run
```shell
git secret help
```
Then to get specific documentation on each command add the `-h` flag when calling the command. For example
```shell
git secret hide -h
```