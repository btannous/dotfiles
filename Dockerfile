FROM registry.fedoraproject.org/fedora:32

# install and clean up packages
RUN sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf
COPY missing-docs /
RUN dnf -y reinstall $(<missing-docs)
COPY extra-packages /
RUN dnf -y install $(<extra-packages)
RUN rm /missing-docs /extra-packages
RUN dnf clean all

# add my user
RUN cd /etc/ssh && ssh-keygen -A && groupadd admin && \
       echo "%admin  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
       useradd b && usermod -a -G admin b
COPY --chown=b id_rsa.pub /home/b/.ssh/authorized_keys

COPY --chown=b .config /home/b/.config
RUN chmod 600 /home/b/.ssh/authorized_keys

USER b

RUN git clone https://github.com/k-takata/minpac.git /home/b/.config/nvim/pack/minpac/opt/minpac && \
#      nvim -esc "call minpac#update()" && \
      git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && \
      mkdir -p /home/b/.oh-my-zsh/custom/themes/agkozak && \
      git clone https://github.com/agkozak/agkozak-zsh-prompt /home/b/.oh-my-zsh/custom/themes/agkozak && \
      ln -s /home/b/.oh-my-zsh/custom/themes/agkozak/agkozak-zsh-prompt.plugin.zsh /home/b/.oh-my-zsh/custom/themes/agkozak.zsh-theme && \
      touch /home/b/.z

COPY --chown=b .zshrc /home/b/.zshrc

USER 0

# startup ssh
CMD /usr/sbin/sshd -D
