FROM quay.io/fedora-ostree-desktops/silverblue:42
ENV VERSION=42
# NFC
LABEL summary="Customized Fedora Silverblue containerized ostree image" \
      maintainer="Hanspeter Gosteli <hanspeter.gosteli@gmail.com>"

COPY extra-packages /

RUN rpm -Uhv https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${VERSION}.noarch.rpm && \
    rpm -Uhv https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${VERSION}.noarch.rpm && \
#    (cd /etc/yum.repos.d; curl -LO https://repo.ivpn.net/stable/fedora/generic/ivpn.repo) && \
    (cd /etc/yum.repos.d; curl -LO https://pkgs.tailscale.com/stable/fedora/tailscale.repo) && \
#    rpm -e noopenh264 && \
    rpm-ostree install -y $(< extra-packages) && \
    rm /extra-packages && \
    ostree container commit

# TODO: Add timer for regular updates
# https://docs.fedoraproject.org/en-US/bootc/building-containers/
# TODO:
# FIX: ERROR! couldn't resolve module/action 'ansible.posix.authorized_key'. This often indicates a misspelling, missing collection, or incorrect module path.

COPY ansible-pull.service /etc/systemd/system/ansible-pull.service
