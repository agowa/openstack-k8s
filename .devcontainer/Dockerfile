FROM archlinux/base:latest

RUN (yes | pacman -Syu) && \
    (yes | pacman -S python-pip terraform bash-completion man openssh tar xz libfido2 git git-lfs gcc awk) && \
    (yes | pacman -Scc) && \
    rm -rf /var/cache/pacman/pkg/ /var/lib/pacman/ && \
    groupadd -g 1000 user && \
    useradd -u 1000 -m -g 1000 user

USER 1000
