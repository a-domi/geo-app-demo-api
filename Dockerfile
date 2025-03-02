FROM eclipse-temurin:21-jdk

SHELL ["/bin/bash", "-c"]

# 必要なツールのインストール
RUN apt-get update \
    && apt-get install -y sudo unzip zip vim tar less iputils-ping curl jq git maven \
    && rm -rf /var/lib/apt/lists/*

# ユーザー設定
ARG USER_NAME=generaluser
ARG USER_GROUP_NAME=generaluser
ARG USER_UID=1001
ARG USER_GID=1001

# ユーザーとグループの作成
RUN groupadd --gid ${USER_GID} ${USER_GROUP_NAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} --shell /bin/bash --create-home -m ${USER_NAME} \
    && echo "${USER_GROUP_NAME}	ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_GROUP_NAME} \
    && chmod 0440 /etc/sudoers.d/${USER_GROUP_NAME}

# ユーザーの切り替え
USER ${USER_NAME}

# 作業ディレクトリの設定
WORKDIR /home/${USER_NAME}

# Mavenのキャッシュディレクトリを作成
RUN mkdir -p /home/${USER_NAME}/.m2

# Mavenのキャッシュをボリュームとしてマウント用の設定
VOLUME /home/${USER_NAME}/.m2