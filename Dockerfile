FROM  ubuntu:latest
SHELL ["/bin/bash", "-c"]

ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade
# install build toolchains
RUN apt install -y build-essential libbz2-dev libdb-dev \
	libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
	libncursesw5-dev libsqlite3-dev libssl-dev \
	zlib1g-dev uuid-dev tk-dev cmake ninja-build \
	gettext libtool libtool-bin autoconf automake cmake g++ pkg-config \
	zip unzip curl wget git sudo
# install utilities
RUN apt install -y zsh zoxide tmux

WORKDIR /root
RUN git clone https://github.com/pqppq/dotfiles

# install omz
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install asdf
RUN git clone https://github.com/asdf-vm/asdf.git .asdf --branch v0.13.1
RUN mv ~/dotfiles/.zshrc .
RUN mv ~/dotfiles/.zshenv .
RUN mv ~/dotfiles/.tmux.conf .

# install omz plugins
RUN git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/z-shell/H-S-MW.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/H-S-MW


# setup asdf
# activate asdf
RUN echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
RUN echo ". $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc
RUN source ~/.bashrc
ENV PATH="/root/.asdf/shims:/root/.asdf/bin:${PATH}"
# add asdf plugins
RUN source ~/.bashrc \
	&& asdf plugin-add python \
	&& asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git \
	&& asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# install and set up runtimes
RUN source ~/.bashrc \
	&& asdf install python 3.10.13 \
	&& asdf global python 3.10.13 \
	&& asdf install lua 5.4.6 \
	&& asdf global lua 5.4.6 \
	&& asdf install nodejs 20.7.0 \
	&& asdf global nodejs 20.7.0

# build neovim from source
RUN git clone https://github.com/neovim/neovim --depth=1
RUN cd neovim \
	&& make CMAKE_BUILD_TYPE=RelWithDebInfo \
	&& cd build && cpack -G DEB \
	&& dpkg -i nvim-linux64.deb

# install poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# misc
# psycopg2 dependency
RUN apt install -y libpq-dev
RUN npm install -g tldr
RUN apt install -y silversearcher-ag ripgrep fd-find

ENTRYPOINT ["/bin/zsh"]
