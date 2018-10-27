# Cluster Config Repo

>This repository holds all the yaml files used to configure the Kubernetes cluster all the SRTSignIn services run in.

#### How to Update the Cluster

#### How to change the secret files

Our project is using the [git-secret](http://git-secret.io/) tool, which allows our team to commit the files we mount as secrets in our cluster to version control. The files are encrypted. We were running into the issue of each team member have different versions of the secret files on their local machines and whenever they would make an update to the cluster there was the possibility of adding an outdated or incorrect secret file to the cluster. Now, using GPG keys we can encrypt our secrets before committing them, and only those with access to the repository and with gpg keys added to the key-ring will be able to view the unencrypted versions of the files locally.