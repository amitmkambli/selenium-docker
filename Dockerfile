FROM bellsoft/liberica-openjdk-alpine:17.0.11
# install utilities culr, jq to check if the socker selenium hub status 'ready' = true
RUN apk add curl jq

# workspace
WORKDIR /home/selenium-docker
# add required fiels form project to workspace in docker
# we can also write 'ADD target/docker-resources ./' as we have set the workspace
ADD target/docker-resources /home/selenium-docker

ADD runner.sh       runner.sh

# If you are on windows, sometimes, the docker container you have built might NOT work after adding runner.sh!
# The issue happens because of windows specific characters which docker container does NOT understand.
# The issue can be fixed by adding this RUN dos2unix runner.sh

# Fix for windows
RUN dos2unix runner.sh

# we are going to use env variables instead of hard coding
# in unix we can use '\' to continue in next line
# ENTRYPOINT java -cp 'libs/*' \
#             -Dselenium.grid.enabled=true \
#             -Dselenium.grid.hubHost=${HUB_HOST} \
#             -Dbrowser=${BROWSER} \
#             org.testng.TestNG \
#             -threadcount ${THREAD_COUNT} \
#             test-suites/${TEST_SUITE}

# the older entry point is now being executed in the runner.sh script which will check if hub is up
ENTRYPOINT sh runner.sh