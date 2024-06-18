FROM fedora:39

# Run commands as root user
USER root

# Set working directory to /root
WORKDIR /root/

# Uncomment if you want to upgrade the system
# RUN dnf upgrade -y 
# Update the dnf cache and install git
RUN dnf makecache && \
    dnf install -y git 


# Add a build argument for cache busting
ARG CACHEBUST=1

# Clone the dotfiles repository
RUN git clone https://github.com/AshutoshPatole18/dotfiles.git /root/dotfiles

# Create the .config directory and copy the necessary files
RUN mkdir -pv /root/.config/ && \
    cp -rv /root/dotfiles/nvim /root/.config/

RUN /root/dotfiles/install.sh


RUN dnf clean all 
# Set the default command to bash
CMD ["/bin/bash"]

