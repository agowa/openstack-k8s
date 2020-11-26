FROM archlinux/base:latest AS base

RUN \
    (rm -rf /etc/pacman.d/gnupg && pacman-key --init && pacman-key --populate archlinux) && \
    (yes | pacman -Sy) && \
    (yes | pacman -S pacman-contrib coreutils awk archlinux-keyring) && \
    (curl -s "https://www.archlinux.org/mirrorlist/?country=DE&country=FR&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - | tee /etc/pacman.d/mirrorlist) && \
    (yes | pacman -R pacman-contrib) && \
    (yes | pacman -Syyu) && \
    (yes | pacman -S python-pip terraform bash-completion man openssh tar xz libfido2 git git-lfs gcc awk vim aria2 wget iputils iproute2 bind-utils base-devel) && \
    (yes | pacman -Scc) && \
    rm -rf /var/cache/pacman/pkg/ /var/lib/pacman/sync

FROM base
RUN groupadd -g 1000 user && \
    useradd -u 1000 -m -g 1000 user

USER 1000
