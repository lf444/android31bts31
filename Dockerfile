FROM openjdk:8


ENV ANDROID_SDK_URL https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip
ENV ANDROID_API_LEVEL android-31
ENV ANDROID_BUILD_TOOLS_VERSION 31.0.0
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_VERSION 31
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/bin

RUN mkdir "$ANDROID_HOME" .android && \
    cd "$ANDROID_HOME" && \
    curl -o sdk.zip $ANDROID_SDK_URL && \
    unzip sdk.zip && \
    rm sdk.zip && \
# Download Android SDK
yes | sdkmanager --licenses --sdk_root=$ANDROID_HOME && \
sdkmanager --update --sdk_root=$ANDROID_HOME && \
sdkmanager --sdk_root=$ANDROID_HOME "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools" \
    "extras;android;m2repository" \
    "extras;google;m2repository" && \
    cd ${ANDROID_HOME}/build-tools/31.0.0 && mv d8 dx && cd lib && mv d8.jar dx.jar && \
    curl -sL https://deb.nodesource.com/setup_12.x  | bash -  && \
    apt-get install -y nodejs && curl -L https://www.npmjs.com/install.sh | sh


