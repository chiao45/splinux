FROM unifem/coupler-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

ADD image/home $DOCKER_HOME/

RUN \
  add-apt-repository ppa:webupd8team/atom && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
    clang-5.0 \
    clang-format-5.0 \
    libboost-all-dev \
    libeigen3-dev \
    atom \
    texlive-full \
    doxygen \
    git \
    vim \
    calculix-cgx \
    python-dev \
    python3-netcdf4 \
    octave \
    liboctave-dev \
    octave-info \
    octave-symbolic \
    octave-parallel \
    octave-struct \
    lyx \
    lyx-common \
    libcgal-dev \
    libcgal-demo && \
  apt-get clean && \
  git clone https://github.com/VundleVim/Vundle.vim.git $DOCKER_HOME/.vim/bundle/Vundle.vim && \
  vim -c "PluginInstall" -c "quitall" && \
  $DOCKER_HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer --system-boost --system-libclang && \
  pip3 install --no-cache-dir \
    flake8 \
    autopep8 \
    h5py \
    meshio \
    pylint && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
  apm install \
    language-fortran \
    language-docker \
    autocomplete-python \
    autocomplete-fortran \
    autocomplete-clang \
    git-plus \
    merge-conflicts \
    platformio-ide-terminal \
    intentions \
    busy-signal \
    linter-ui-default \
    linter \
    linter-clang \
    linter-gfortran \
    dbg \
    output-panel \
    dbg-gdb \
    atom-beautify \
    file-icons \
    fonts \
    linter-flake8 \
    minimap \
    atom-latex \
    atom-material-ui \
    atom-material-syntax-dark \
    markdown-preview-plus && \
  rm -rf /tmp/* && \
  chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

ADD image/applications /usr/share/applications/

WORKDIR $DOCKER_HOME
USER root
