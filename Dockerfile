RUN git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
#      nvim -esc "call minpac#update()" && \
      git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && \
      mkdir -p /Users/b/.oh-my-zsh/custom/themes/agkozak && \
      git clone https://github.com/agkozak/agkozak-zsh-prompt /Users/b/.oh-my-zsh/custom/themes/agkozak && \
      ln -s /Users/b/.oh-my-zsh/custom/themes/agkozak/agkozak-zsh-prompt.plugin.zsh /Users/b/.oh-my-zsh/custom/themes/agkozak.zsh-theme && \
      touch /Users/b/.z

COPY --chown=b .zshrc /home/b/.zshrc

USER 0

# startup ssh
CMD /usr/sbin/sshd -D
